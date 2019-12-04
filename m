Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A62DC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667CB20862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483180;
	bh=SeAsYV7SVBrdZa76EEz+x99Xd94q22fntAQUgeEiTRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HIjMxlecxfsfp+4vUC5r1bJG9CqeSnUkOw2IKI8ZK3Yf0arMf1JgUEDvRMr2Hqiz7
	 5a3zZEzLBPIWtlWQSNaYlLE9paWk3iPE8FaI0pIaVGc5wDvcNSj75RZHjsbb1RsNhf
	 +ZNW0/UdSxW71cfdqxBe9FN2VkuMMdfbbh0Y9dzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfLDSM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:12:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731670AbfLDSMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:12:54 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B1E20674;
        Wed,  4 Dec 2019 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483174;
        bh=SeAsYV7SVBrdZa76EEz+x99Xd94q22fntAQUgeEiTRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1sGwgPwK0mJQa7CZp4Iajt0gdpVU8TkmsLoT6ras0HgFsM2nMe5O4zP7F9ayt9t7
         +mlrfSGm3Mkqvk62KDFiSk5YaCnqlfJsgLRdIFQmn9SFgJyzmNa4AgRVKh4jbu7fCO
         oaxIIslenYcc5a/qRZ+gk/n4ErZYEeyxmJzTwDpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 080/125] net/wan/fsl_ucc_hdlc: Avoid double free in ucc_hdlc_probe()
Date:   Wed,  4 Dec 2019 18:56:25 +0100
Message-Id: <20191204175323.901550823@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 40752b3eae29f8ca2378e978a02bd6dbeeb06d16 ]

This patch fixes potential double frees if register_hdlc_device() fails.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
CC: Zhao Qiang <qiang.zhao@nxp.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 7a62316c570d2..b2c1e872d5ed5 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1117,7 +1117,6 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	if (register_hdlc_device(dev)) {
 		ret = -ENOBUFS;
 		pr_err("ucc_hdlc: unable to register hdlc device\n");
-		free_netdev(dev);
 		goto free_dev;
 	}
 
-- 
2.20.1



