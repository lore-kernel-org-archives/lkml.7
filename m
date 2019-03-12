Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C927C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6017C206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411450;
	bh=DjyFoXYNzMfSVOoQdVE9t6tBdBMpJuVX7X3gkhxgPrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JjmIWtbJJVPrVdP0lwoKk1QCQCkiEu2RR4UGUPkQe+I1/L8091mVhkTpYyUUXMrC8
	 TCLVhq+BO+jit6uR/wLKOeQOaIMpEWJ5RfljceExv/OEq5Yg4FtO1wUHSQojyVR5WE
	 FrYZWZTevRKhWtOvzkRgj8gRKw9xPZdC2dRyj5AE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfCLRYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbfCLRR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:56 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B73D2184C;
        Tue, 12 Mar 2019 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411076;
        bh=DjyFoXYNzMfSVOoQdVE9t6tBdBMpJuVX7X3gkhxgPrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEFSqTtA1KzitIy1oJsxYl7Wch5uLYrWtNQW0PH0nT8pwDGX9ZpmsUpTQ/t1tLjk2
         nHN2T6cRrJstOwP0TAdVYE2nHS/+MCffuIln9RUttyEDI6uulJoEGIsLLb4WSavAAe
         uslesA2oBl/TU1t8E7+A7Zd4SkQz0VqKE95xKBIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 70/96] drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init
Date:   Tue, 12 Mar 2019 10:10:28 -0700
Message-Id: <20190312171039.900578732@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b14e945bda8ae227d1bf2b1837c0c4a61721cd1a ]

When initializing clocks, a reference to the TCON channel 0 clock is
obtained. However, the clock is never prepared and enabled later.
Switching from simplefb to DRM actually disables the clock (that was
usually configured by U-Boot) because of that.

On the V3s, this results in a hang when writing to some mixer registers
when switching over to DRM from simplefb.

Fix this by preparing and enabling the clock when initializing other
clocks. Waiting for sun4i_tcon_channel_enable to enable the clock is
apparently too late and results in the same mixer register access hang.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190131132550.26355-1-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index f2975a1525be..2796fea70a42 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -327,6 +327,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
 		return PTR_ERR(tcon->sclk0);
 	}
+	clk_prepare_enable(tcon->sclk0);
 
 	if (tcon->quirks->has_channel_1) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
@@ -341,6 +342,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
+	clk_disable_unprepare(tcon->sclk0);
 	clk_disable_unprepare(tcon->clk);
 }
 
-- 
2.19.1



