Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6741FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320C220874
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjFf2ldx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfFFFNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:13:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39020 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:13:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so1416805edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 22:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TB8sS/vN2hoBvG32s7LAFoRj2modDqZ8Vw8VYR421Os=;
        b=MjFf2ldxuuMeQK2ueNysoMCjQ5uKFh8bYW8bd5QRJmBjp0XW72ybPDZ50jMKO/LiSV
         wgh4Z7KeeN2RzBRojIpnBqr/dnP8CiGrpyuCbbQjDXDTnExaiokJE/zfXJ0IDTqCaz9D
         FJMVk+QLuSm/PqCjPGqONXD6twdngAgROD4C5SxKe2qF/9kxBec3iI3PtqPrUyzIEwbC
         900yi3vGFTHpBMUa/30nkasZZ/WPO0YYlmp66kgZbudm+p5n4VwfBWMsOvmDCNIAOZeJ
         n8oajfRGrZciYch4GbP81eTkeDknI7VQ2TdstrYft6tCJb55UaVFmgIEFiL1iLZ9Doi9
         +QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TB8sS/vN2hoBvG32s7LAFoRj2modDqZ8Vw8VYR421Os=;
        b=NPAcDvnvVodoam+WfQDxOARkG2C1W9u/e5UX3g8KIP4i/rDvprnZg6z1CUYdBMplXU
         3xbpb8K9MEJVSz7rwrjL7tm/iw+WdY/SJZW8vdEzYGJTUTlO2IH67LlrZHpMd6/f/OBG
         CHNv8kDXtjNTqAHE91Pl+HXCLXr1+1UL/qjuorCi/sFRzFLxPZz7DbK/8mTF7MG4bMxm
         xkiygzfomu+XA7jVwHZKxpLQQfLWoFzK2TllsoVM/MFZw5Mz7WZKGVvvdU9jqUjn2gg4
         y4jSIBVdq138PjvDd5q+ZzR0xgn/0XTEuNo0h2m8K49ZRlX3d/AIiLzwVPeidlvVTMoL
         /qqw==
X-Gm-Message-State: APjAAAUZ9e1UYzt5H5YLUe4fFqmB11MNEYMvdvtA6z4Top+SMkFMuDR5
        0RlQzkCevYV+1jls7md5xdg=
X-Google-Smtp-Source: APXvYqyUItVGIKxTOm7o1yTUkO+9+3tvHBVATXfJBTetD2HC4spaXlxx/ZTWFbNQ68lfH2yFzqCfwA==
X-Received: by 2002:a17:906:6a97:: with SMTP id p23mr39152490ejr.203.1559797993974;
        Wed, 05 Jun 2019 22:13:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id f3sm141499ejc.15.2019.06.05.22.13.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 22:13:13 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Shuming Fan <shumingf@realtek.com>, Mark Brown <broonie@kernel.org>
Cc:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: rt1011: Mark format integer literals as unsigned
Date:   Wed,  5 Jun 2019 22:12:27 -0700
Message-Id: <20190606051227.90944-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc3
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

sound/soc/codecs/rt1011.c:1291:12: warning: integer literal is too large
to be represented in type 'long', interpreting as 'unsigned long' per
C89; this literal will have type 'long long' in C99 onwards
[-Wc99-compat]
                format = 2147483648; /* 2^24 * 128 */
                         ^
sound/soc/codecs/rt1011.c:2123:13: warning: integer literal is too large
to be represented in type 'long', interpreting as 'unsigned long' per
C89; this literal will have type 'long long' in C99 onwards
[-Wc99-compat]
                        format = 2147483648; /* 2^24 * 128 */
                                 ^
2 warnings generated.

Mark the integer literals as unsigned explicitly so that if the kernel
does ever bump the C standard it uses, the behavior is consitent.

Fixes: d6e65bb7ff0d ("ASoC: rt1011: Add RT1011 amplifier driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/506
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/codecs/rt1011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 349d6db7ecd4..3a0ae80c5ee0 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1288,7 +1288,7 @@ static int rt1011_r0_load_mode_put(struct snd_kcontrol *kcontrol,
 	if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 		rt1011->r0_reg = ucontrol->value.integer.value[0];
 
-		format = 2147483648; /* 2^24 * 128 */
+		format = 2147483648U; /* 2^24 * 128 */
 		r0_integer = format / rt1011->r0_reg / 128;
 		r0_factor = ((format / rt1011->r0_reg * 100) / 128)
 						- (r0_integer * 100);
@@ -2120,7 +2120,7 @@ static int rt1011_calibrate(struct rt1011_priv *rt1011, unsigned char cali_flag)
 			dev_err(dev,	"Calibrate R0 Failure\n");
 			ret = -EAGAIN;
 		} else {
-			format = 2147483648; /* 2^24 * 128 */
+			format = 2147483648U; /* 2^24 * 128 */
 			r0_integer = format / r0[0] / 128;
 			r0_factor = ((format / r0[0] * 100) / 128)
 							- (r0_integer * 100);
-- 
2.22.0.rc3

