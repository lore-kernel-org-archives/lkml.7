Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C234C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFB22070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SkK6EGve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfG2OdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:33:22 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.52]:43439 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbfG2OdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:33:22 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D2DFDD6805
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:33:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id s6iHhArUwdnCes6iHheGIa; Mon, 29 Jul 2019 09:33:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D8hPFGMsTpC6V94P38uAaZCM4mleBY4lZyxHmNsHKuQ=; b=SkK6EGvezVn8CdpjDSHHVfjGpM
        Z6JzVdz7KnTH/z+daCSMJxXhofFyNX+vLZt1MRbJKrA43WTVorgl2Kx6PUOllcFL8m6a0Zkag/cr3
        bkdguVOAbrHGY+huZ/v6jjrU0ntgqgajcF7eUJNTeSg/P6m9X0horfpCnC2+og3dZFNxVqy6qlK1l
        fNncSIMWsL0KtD0+IDZJx8dInaECZZdn+hIKQS7/c5m7k+SJ1mtHE3G5QzHiqjHc9EJ6p5FNhvXom
        ZI6CXOJSrXTd/yljt5hMzcqqx+HGlrvkogBFVaHmewH+dJG3B5ruj9DF102zkFyf4SGLbOdbxrfej
        EBObUz1A==;
Received: from [187.192.11.120] (port=50432 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hs6iG-002MbH-NS; Mon, 29 Jul 2019 09:33:20 -0500
Date:   Mon, 29 Jul 2019 09:33:20 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] sound: dmasound_atari: Mark expected switch fall-through
Message-ID: <20190729143320.GA8212@embeddedor>
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
X-Exim-ID: 1hs6iG-002MbH-NS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:50432
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning:

sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
through [-Wimplicit-fallthrough=]:  => 1449:24

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/oss/dmasound/dmasound_atari.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
index 83653683fd68..b5845e904ba1 100644
--- a/sound/oss/dmasound/dmasound_atari.c
+++ b/sound/oss/dmasound/dmasound_atari.c
@@ -1449,7 +1449,7 @@ static int FalconMixerIoctl(u_int cmd, u_long arg)
 		tt_dmasnd.input_gain =
 			RECLEVEL_VOXWARE_TO_GAIN(data & 0xff) << 4 |
 			RECLEVEL_VOXWARE_TO_GAIN(data >> 8 & 0xff);
-		/* fall thru, return set value */
+		/* fall through - return set value */
 	    case SOUND_MIXER_READ_MIC:
 		return IOCTL_OUT(arg,
 			RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain >> 4 & 0xf) |
-- 
2.22.0

