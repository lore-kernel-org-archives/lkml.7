Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB2FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C752083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ1MunfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbfJOUJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:09:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38224 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfJOUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:09:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so15486080lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nr7E38S2s3eAbbfCUSywjHEZ4H8fhbZYB2USx6be+tc=;
        b=LJ1MunfEen/5WdeqXuaYfAP+Mh+nhP6YEzWmf5tSN4j9pOg3kLWozDpA4ZFx9S4KLM
         j4S4Qe1TlUoZ/MjuBP0YlV7Yd4yWwSoEvKWNoxcEEEGZORwpYLk7QM/iyRVTCh7KFEV+
         If0rE6YeD27XziCo8oUODUrM2N5SWDT9OKrfyxImYTkevN67rtFIhlV0X4hnr4uBy9yO
         ag/uvka4qAnkwoEusS9ByPKqLrpoEFYze8o/2ylH3nblVhYDK8lVEq3C4wRQqHz9i4Vz
         3XXM3DAf9VqDEOxkDwiil7XC2uL+I1dHEofimY7U6Trb+k0L7xi8XYLEDAKgJF9+OJLj
         3JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nr7E38S2s3eAbbfCUSywjHEZ4H8fhbZYB2USx6be+tc=;
        b=ShXRJ7GUlk1rSvxnPLfsva7Md4bscYlsw0Qd/xwPXoImUGP/3ecPvJqJne5r1KHyTB
         yeRN5JNxq6Rkp3sujBNVHSUePLcNlC5AjZJbshTfdir+hXuGtWQ/03u97fQrcwmKObfu
         RtQiWQ9yUBivGw/YgTv8C6f9q5k6I86r1Lhov+pJSLFAf9Ef7XE1yEbb19riool57xs+
         Rtp+CgqOuZoGWZTByBKo1H5hbevNrInqUtQMD62A4yyDGE38pR/hxkzDCYa1ykNmmhO6
         MNMsEgb8LVKph5SpCH/KJEfnTi+zWnApnpYTeQQLw8EVf1g/Mo4YP3gcFcWo4l33/8Fl
         rP5Q==
X-Gm-Message-State: APjAAAXBTWyU8O4tTDC70CvaQIAKOIlxqIRpGjmWaw4sHI/9NQkPZ1O4
        YGY7bTRPYTuf7GszbDrw9f0=
X-Google-Smtp-Source: APXvYqy6f+ml42eTBF5EHpYvS0lb6p+kxv1I3hYXXpOAPXEeKvhwdtR7+dKPRDqNLQwk6eE/hOn3Sg==
X-Received: by 2002:ac2:5595:: with SMTP id v21mr9864950lfg.168.1571170169683;
        Tue, 15 Oct 2019 13:09:29 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id z1sm5266247ljh.88.2019.10.15.13.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 13:09:28 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     dmurphy@ti.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, navada@ti.com,
        tiwai@suse.com, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: tas2562: Fix misuse of GENMASK macro
Date:   Tue, 15 Oct 2019 22:09:00 +0200
Message-Id: <20191015200900.25798-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008181517.5332-2-dmurphy@ti.com>
References: <20191008181517.5332-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments are supposed to be ordered high then low.

Fixes: c173dba44c2d ("ASoC: tas2562: Introduce the TAS2562 amplifier")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Spotted when trying to introduce compile time checking that the order
of the arguments to GENMASK are correct [0]. I have only compile tested
the patch.

[0]: https://lore.kernel.org/lkml/20191009214502.637875-1-rikard.falkeborn@gmail.com/

 sound/soc/codecs/tas2562.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.h b/sound/soc/codecs/tas2562.h
index 60f2bb1d198b..62e659ab786d 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/sound/soc/codecs/tas2562.h
@@ -62,7 +62,7 @@
 
 #define TAS2562_TDM_CFG2_RIGHT_JUSTIFY	BIT(6)
 
-#define TAS2562_TDM_CFG2_RXLEN_MASK	GENMASK(0, 1)
+#define TAS2562_TDM_CFG2_RXLEN_MASK	GENMASK(1, 0)
 #define TAS2562_TDM_CFG2_RXLEN_16B	0x0
 #define TAS2562_TDM_CFG2_RXLEN_24B	BIT(0)
 #define TAS2562_TDM_CFG2_RXLEN_32B	BIT(1)
-- 
2.23.0

