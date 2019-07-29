Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD46C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A986D2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="y/VRyy1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfG2WPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:15:38 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.216]:47239 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728089AbfG2WPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:15:37 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id CC41C6940A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 17:15:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sDvchk9m73Qi0sDvchUvCj; Mon, 29 Jul 2019 17:15:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dHkN5Os5jg2cDOrRLTVaMd59XWLTmpmxDcRl9QO0zyU=; b=y/VRyy1BNoX63+u2yIgC1UGmJR
        dbESFrQ68d4/qYDyJ2RVo0mvZ3S0uvMbBTJUY2dAdj07CbPXhEBaM/G52+Ws4xkNDuM0In5EMr5rq
        F+NZZwRqjmMDa1QSA099NduPVmOHem3sNqM2D1F5iAi9JxQ5tdznah0BoMuiF5N9FxR+tnM+epzNk
        GDMP9ku0Ghmniegy1HzE0tBn7vgySxnqYdXNpzbPc9VEbbPK8E+rNZauARNzfsxFaOJPLxfUB642D
        bHEEfVNl84cUlIeU1UamnBWVkiIGjueikfzdiplcuu1Ie5tJ8NklAuaYRylptJ9+Ttgzo44k500to
        LX18KoSw==;
Received: from [187.192.11.120] (port=60834 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsDvb-001z1T-Eq; Mon, 29 Jul 2019 17:15:35 -0500
Date:   Mon, 29 Jul 2019 17:15:34 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ASoC: ti: Mark expected switch fall-throughs
Message-ID: <20190729221534.GA18696@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsDvb-001z1T-Eq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60834
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

sound/soc/ti/n810.c: In function ‘n810_ext_control’:
sound/soc/ti/n810.c:48:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
   line1l = 1;
   ~~~~~~~^~~
sound/soc/ti/n810.c:49:2: note: here
  case N810_JACK_HP:
  ^~~~

sound/soc/ti/rx51.c: In function ‘rx51_ext_control’:
sound/soc/ti/rx51.c:57:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   hs = 1;
   ~~~^~~
sound/soc/ti/rx51.c:58:2: note: here
  case RX51_JACK_HP:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/ti/n810.c | 1 +
 sound/soc/ti/rx51.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/ti/n810.c b/sound/soc/ti/n810.c
index 2c3f2a4c1700..3ad2b6daf31e 100644
--- a/sound/soc/ti/n810.c
+++ b/sound/soc/ti/n810.c
@@ -46,6 +46,7 @@ static void n810_ext_control(struct snd_soc_dapm_context *dapm)
 	switch (n810_jack_func) {
 	case N810_JACK_HS:
 		line1l = 1;
+		/* fall through */
 	case N810_JACK_HP:
 		hp = 1;
 		break;
diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index bc6046534fa5..ccd0e8a07dd1 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -55,6 +55,7 @@ static void rx51_ext_control(struct snd_soc_dapm_context *dapm)
 		break;
 	case RX51_JACK_HS:
 		hs = 1;
+		/* fall through */
 	case RX51_JACK_HP:
 		hp = 1;
 		break;
-- 
2.22.0

