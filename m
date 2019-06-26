Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5CCC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381122147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520494;
	bh=CAQlXkAGiWlz4Wzo4ebka0fQJEwXgY0vC62oNT2HpMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TLs3S6kM9zn1C65DsU5Mr4R98KIw9MAoWoolY/ElaWxCyZHNqN2POMyr0Iq1DIovh
	 UWccCVRCncdt72CddBG9HDACFzz1O5qUK+tyhQQeucVyhGlog6b1sTkJu6SraAYSZ8
	 Ds9ks81poDhpE++AvW/bpgLMZ5iFcEQeHYrGGIeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFZDld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfFZDla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:41:30 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C1E2146E;
        Wed, 26 Jun 2019 03:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520490;
        bh=CAQlXkAGiWlz4Wzo4ebka0fQJEwXgY0vC62oNT2HpMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvNyJWc19Ua2JBhTMNw9i+qnXD6YHMpG1jyN0qJZV6us0WV1jxJq9Asqwrjh8DY3v
         cf4TcG4GKMuDM7gWpPiOofJ0kbYwB38UsGKGAebWzM1H1Woj5vdxd2NIc5gaJ6rF/V
         Vr39RzAYzK61BqFw67JPcwFJXTwvcN7nuOpGbhUw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 05/51] ASoC: ak4458: rstn_control - return a non-zero on error only
Date:   Tue, 25 Jun 2019 23:40:21 -0400
Message-Id: <20190626034117.23247-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

[ Upstream commit 176a11834b65ec35e3b7a953f87fb9cc41309497 ]

snd_soc_component_update_bits() may return 1 if operation
was successful and the value of the register changed.
Return a non-zero in ak4458_rstn_control for an error only.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/ak4458.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 4c5c3ec92609..71562154c0b1 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -304,7 +304,10 @@ static int ak4458_rstn_control(struct snd_soc_component *component, int bit)
 					  AK4458_00_CONTROL1,
 					  AK4458_RSTN_MASK,
 					  0x0);
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int ak4458_hw_params(struct snd_pcm_substream *substream,
-- 
2.20.1

