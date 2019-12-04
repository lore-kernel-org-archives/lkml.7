Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC414205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483726;
	bh=CcGoJg+UihYBaV8Tf12lR+9gsdgjxSjD2C2kvFXqYcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=noGCAmYmVz2+qDQFc850cHmshic9OZ5rPR6/E/ovtgvI8yWLSfOOygo8fgkvkXhFW
	 wrsihiLLj9gaIe1X4NEGiEWOUp1x43geWzThw64ryQ3w8Opupoqj07ceK5//YeIsaA
	 51GXx+LIx5kairAIYvV3CHd9zwsGM77yasZedGmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfLDSWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:22:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbfLDSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:05:46 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC7D20659;
        Wed,  4 Dec 2019 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482745;
        bh=CcGoJg+UihYBaV8Tf12lR+9gsdgjxSjD2C2kvFXqYcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WV0SKNYv7xUHczwgmcrOkJHxPsWG4HMP0JhEVf0AVmyw2QymHqp7oehCQxvfPEOoW
         LlqGqGxEwMl/KXOsAmsNxYHoBmb/i7IabE70bac6xCrCB2K8MCED6mKhLFWv1enUTS
         ydjFxk/okd8fhrgGOumQL0g/Gq4muaFtFWT+a9Do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 118/209] net/wan/fsl_ucc_hdlc: Avoid double free in ucc_hdlc_probe()
Date:   Wed,  4 Dec 2019 18:55:30 +0100
Message-Id: <20191204175331.248253856@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
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
index 18b648648adb2..289dff262948d 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1114,7 +1114,6 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	if (register_hdlc_device(dev)) {
 		ret = -ENOBUFS;
 		pr_err("ucc_hdlc: unable to register hdlc device\n");
-		free_netdev(dev);
 		goto free_dev;
 	}
 
-- 
2.20.1



