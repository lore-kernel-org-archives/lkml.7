Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EE1C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0D721903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127210;
	bh=mMswdJhpUvFDECDF3a5eyU/gytAb3J5JNWXb0aTDIk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cbUNKwGOceTGc9p/MdIPR1zePdCv+iRe4wkfqSMDSYAjB/xThCf2vFgl6LXdEKXoM
	 1ByrOl4g49N/Af8pEC1B7WdExQdNRvBZfTumRrYx4DJxX81sIWzXJU4BFgSx4pTR/f
	 A8+11fsf8vJImklugnP659U1skxDIq6k/qx+T0ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391502AbfDXRd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391134AbfDXRd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:27 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C064C2054F;
        Wed, 24 Apr 2019 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127206;
        bh=mMswdJhpUvFDECDF3a5eyU/gytAb3J5JNWXb0aTDIk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nmho5FtmnPLMSgr1U1jqUqO3YL3zQmYi3uxPjQatI1dgviba3ClSykYO8ysnJVyOQ
         cJiKp9KCeRPBls6RkKogSpWNE+t+gTvL09I4cfB35i0AcltA8qPzoUQYBDbrcRwDvB
         1sfbNC+hSGbsEce3RICo8TQMfRIApp1onoa4WyPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 95/96] ASoC: rockchip: add missing INTERLEAVED PCM attribute
Date:   Wed, 24 Apr 2019 19:10:40 +0200
Message-Id: <20190424170926.226795906@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Katsuhiro Suzuki <katsuhiro@katsuster.net>

commit 24d6638302b48328a58c13439276d4531af4ca7d upstream.

This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/rockchip/rockchip_pcm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/rockchip/rockchip_pcm.c
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -21,7 +21,8 @@ static const struct snd_pcm_hardware snd
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_RESUME,
+				  SNDRV_PCM_INFO_RESUME |
+				  SNDRV_PCM_INFO_INTERLEAVED,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
 	.periods_min		= 1,


