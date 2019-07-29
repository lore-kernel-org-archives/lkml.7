Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7707C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CC32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="k9oWOIqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbfG2UzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:55:01 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.187]:46459 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388310AbfG2Uy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:54:58 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 8D3D31027D1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:54:57 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sCfZhjEFi3Qi0sCfZhU0I7; Mon, 29 Jul 2019 15:54:57 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2qRqERqNiuX608wUGfvOMeMcVRj/FE6XROb7xahJa7o=; b=k9oWOIqAFg/2nRf4GJb6CvtGDX
        513mCkowh1otHfVo16g46ToXHrguzcFXITXPT4b8aE46vPfJBMn7y0HauqIlru0O839nCt1Ebu68p
        xgME2rRs75418TaFp9gm/ekGuBS8zBrkMfubFUmqzCo73KXX44znu7OH4g8zlwVocX0/DVzBWgwfP
        3ULmMGJ5wIYzwxrtuIzop64Mq4UV3LIO6RM2ntslHURsX0x4Ogvua2Vau6rjiS4Xu3iO+P/oi/xaT
        Nyl9YIDC7viwSlCL3iNQh8zj+1aX9If4fXTLmxz7jIQoDNxoEaSSuvMYkm9PpgLZA3l43qTEwh5Q5
        bz1kG6Rg==;
Received: from [187.192.11.120] (port=59750 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsCfX-001L5i-D7; Mon, 29 Jul 2019 15:54:55 -0500
Date:   Mon, 29 Jul 2019 15:54:54 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] sound: dmasound_atari: Mark expected switch fall-through
Message-ID: <20190729205454.GA5084@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsCfX-001L5i-D7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:59750
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: m68k):

sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
through [-Wimplicit-fallthrough=]:  => 1449:24

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update code so switch and case statements are at the same indent.

 sound/oss/dmasound/dmasound_atari.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
index 83653683fd68..823ccfa089b2 100644
--- a/sound/oss/dmasound/dmasound_atari.c
+++ b/sound/oss/dmasound/dmasound_atari.c
@@ -1432,25 +1432,25 @@ static int FalconMixerIoctl(u_int cmd, u_long arg)
 {
 	int data;
 	switch (cmd) {
-	    case SOUND_MIXER_READ_RECMASK:
+	case SOUND_MIXER_READ_RECMASK:
 		return IOCTL_OUT(arg, SOUND_MASK_MIC);
-	    case SOUND_MIXER_READ_DEVMASK:
+	case SOUND_MIXER_READ_DEVMASK:
 		return IOCTL_OUT(arg, SOUND_MASK_VOLUME | SOUND_MASK_MIC | SOUND_MASK_SPEAKER);
-	    case SOUND_MIXER_READ_STEREODEVS:
+	case SOUND_MIXER_READ_STEREODEVS:
 		return IOCTL_OUT(arg, SOUND_MASK_VOLUME | SOUND_MASK_MIC);
-	    case SOUND_MIXER_READ_VOLUME:
+	case SOUND_MIXER_READ_VOLUME:
 		return IOCTL_OUT(arg,
 			VOLUME_ATT_TO_VOXWARE(dmasound.volume_left) |
 			VOLUME_ATT_TO_VOXWARE(dmasound.volume_right) << 8);
-	    case SOUND_MIXER_READ_CAPS:
+	case SOUND_MIXER_READ_CAPS:
 		return IOCTL_OUT(arg, SOUND_CAP_EXCL_INPUT);
-	    case SOUND_MIXER_WRITE_MIC:
+	case SOUND_MIXER_WRITE_MIC:
 		IOCTL_IN(arg, data);
 		tt_dmasnd.input_gain =
 			RECLEVEL_VOXWARE_TO_GAIN(data & 0xff) << 4 |
 			RECLEVEL_VOXWARE_TO_GAIN(data >> 8 & 0xff);
-		/* fall thru, return set value */
-	    case SOUND_MIXER_READ_MIC:
+		/* fall through - return set value */
+	case SOUND_MIXER_READ_MIC:
 		return IOCTL_OUT(arg,
 			RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain >> 4 & 0xf) |
 			RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain & 0xf) << 8);
-- 
2.22.0

