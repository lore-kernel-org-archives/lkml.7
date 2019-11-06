Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56D4C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B475521882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L6xaRbUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfKFIjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:39:41 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:34842 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfKFIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=+JzU+esi7fl0h4YK8N
        PHkxPWloJ5wIl06K/wPnc/A2k=; b=L6xaRbUAJMTvsW09nge/+GKrTTCh43e6VO
        OSswfOX+OhhilUA4bHqozbqprvxu7fxm7mTUpPgGFyqG2f+1jzHNCdrDBuDY9ZXg
        aiCUKSIZSw9UTB4Jy1CcGxULHabKQP3rG/Ttoavt0yEO/D1/C4ALXy0Azd31k+py
        373MrR5Mg=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp4 (Coremail) with SMTP id HNxpCgDHZtOBhsJdCHKDBQ--.289S3;
        Wed, 06 Nov 2019 16:38:35 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] usb: gadget: pch_udc: fix use after free
Date:   Wed,  6 Nov 2019 16:38:23 +0800
Message-Id: <1573029503-18369-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HNxpCgDHZtOBhsJdCHKDBQ--.289S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWUXr43Wr1UuF1kKF13twb_yoWfurcEk3
        yjgFnrWryYq3Z8Kr4fJry3Ar4293ZYqan3uFnaqrZ3Z3y5Way5Xr18ZF9Y93y7uw47GF93
        u3yqqFyYgF4S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1jNt3UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDgtlclXluaTJ2AAAsu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next field of the DMA descriptor is written after releasing the
descriptor, which may result in a use-after-free issue. Set the value of
the field before it is released to fix the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 265dab2bbfac..c5b8ec908aab 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -1518,8 +1518,8 @@ static void pch_udc_free_dma_chain(struct pch_udc_dev *dev,
 		/* do not free first desc., will be done by free for request */
 		td = phys_to_virt(addr);
 		addr2 = (dma_addr_t)td->next;
-		dma_pool_free(dev->data_requests, td, addr);
 		td->next = 0x00;
+		dma_pool_free(dev->data_requests, td, addr);
 		addr = addr2;
 	}
 	req->chain_len = 1;
-- 
2.7.4

