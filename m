Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA6CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4AB208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441733;
	bh=XhiARO0SF7qEE7Hvfj1tJhp73yqlzo+pFRddRfLi7sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bPcTxu4hP32KBb3btkHgj/K7E/oDai+r6UBDxTNM3XeZftvJZCkFuMEjziT82ILQJ
	 VeQNsOn6lmnWMPC+Zx9fXVWGN7Ruvo4Fx/aBYgrmmstmKnOJJH/NQz6/M0SHDiYGcB
	 jMVq1BaHN4n5+0Uc+PZf7km4PBWMzEBT5ldR49jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbfFMQB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbfFMIsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:48:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C846F2173C;
        Thu, 13 Jun 2019 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415689;
        bh=XhiARO0SF7qEE7Hvfj1tJhp73yqlzo+pFRddRfLi7sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYaq8DTZM1NailC7qntJx/+eA/7+oUEmE9vYhYel8uKsracGSLuC2IKQyYuAp/dqP
         AFXoTq/nyZRKh7+DojEAEi+6rb1lKfLavPhtuK9qvH4QmKEQ9LxB8sEV1JBlVDZHVX
         cimGUlCfCtmMmRFnAg/XW3P4l6rg3XhVpP+QfZlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wesley Sheng <wesley.sheng@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 090/155] switchtec: Fix unintended mask of MRPC event
Date:   Thu, 13 Jun 2019 10:33:22 +0200
Message-Id: <20190613075658.131342524@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 083c1b5e50b701899dc32445efa8b153685260d5 ]

When running application tool switchtec-user's `firmware update` and `event
wait` commands concurrently, sometimes the firmware update speed reduced
significantly.

It is because when the MRPC event happened after MRPC event occurrence
check but before the event mask loop reaches its header register in event
ISR, the MRPC event would be masked unintentionally.  Since there's no
chance to enable it again except for a module reload, all the following
MRPC execution completion checks time out.

Fix this bug by skipping the mask operation for MRPC event in event ISR,
same as what we already do for LINK event.

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e22766c79fe9..c2fa830b8ef5 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1162,7 +1162,8 @@ static int mask_event(struct switchtec_dev *stdev, int eid, int idx)
 	if (!(hdr & SWITCHTEC_EVENT_OCCURRED && hdr & SWITCHTEC_EVENT_EN_IRQ))
 		return 0;
 
-	if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE)
+	if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE ||
+	    eid == SWITCHTEC_IOCTL_EVENT_MRPC_COMP)
 		return 0;
 
 	dev_dbg(&stdev->dev, "%s: %d %d %x\n", __func__, eid, idx, hdr);
-- 
2.20.1



