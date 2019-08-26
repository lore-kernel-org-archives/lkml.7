Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8727CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4DE2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwyfHcpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfHZSHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:07:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35121 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbfHZSHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:07:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id h27so7107561lfp.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/7Ac+4X6tEO+jpy2vLz06LyblKHxTeQKnAx8UL/5B8=;
        b=GwyfHcpHh6oCnOObXxprhf+5ZJySN4hhx4pk0Sfe4JaSQbx2PWs9c+R43Ast0qnzoE
         LcwntTn4M3aJIAuL3KYpk9Od3Dg+XmFowEempsIwPBGnd9R/8B30Vox8n2jrJZgNqdjg
         IeR3b/03SRv4FV10zzkl6pBWJbPoGrM/a5yPavLCDNoQKVXQbtep+q0HCzmTc7/G/M+f
         qwC0oLckmd8bIeU/IDJb0jjeN3i9HBL11iHIynCLwl+3mm0L0kpUsXZ6jugjiZAUgniU
         XC/HioTr/phLLSjNCYaqeaJjc+mdMfvR6IOZ/SM7Rqa4jIb5qpIbYLf4JRd972wjeeFZ
         BRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/7Ac+4X6tEO+jpy2vLz06LyblKHxTeQKnAx8UL/5B8=;
        b=HCoA4v3ksKjK+hlHB0/eTbCJ9iuFIfVRqSuginsiIH2HsxLanQD8fcBwozCzCa6v0r
         +mO3F1FxzV8L9U2TPaHkAX3LV+ye+XYJWh0QvQjty4jNEqC2mta9KGvb4gslY9CFJVYR
         R1wkktO6veAeEC5Cmv6iJd8JbmfQ7/4akTOBjM6pc34Dv1UEsqLoF9r3WmLhQJlGXE+a
         emBslQuTsw+Jfw2Dd9KyIWQ/NwF6h8hT1lHurHpNVyIpq1X0nH+tzK0fro7ZbmBZ+DQr
         LmWhi+uF9eIZZqO/2Ve+d8O2RUp+P6EPU6WD2Pj+EpvIHl8YHHIh/IKbeKQzUCtFPXct
         6k2w==
X-Gm-Message-State: APjAAAX4Ng6YJlwmZTgXnxTDRABUlgYu/nZUleJFUVSwy0TlOoBaDfJ1
        Qvv86tMeJZo0ovdJeLOIos2ovOPv
X-Google-Smtp-Source: APXvYqzMGtg6mqhU7IhdflXEfGSyI6kfm6cUUGMijAWKYBGqX9ttFftleyS3u/IvkUS1sQRh3Ba4Qw==
X-Received: by 2002:ac2:44af:: with SMTP id c15mr12669898lfm.32.1566842860391;
        Mon, 26 Aug 2019 11:07:40 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id u3sm2215564lfm.16.2019.08.26.11.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 11:07:39 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 3/3] ASoC: sun4i-i2s: Adjust LRCLK width
Date:   Mon, 26 Aug 2019 20:07:34 +0200
Message-Id: <20190826180734.15801-4-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826180734.15801-1-codekipper@gmail.com>
References: <20190826180734.15801-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Some codecs such as i2s based HDMI audio and the Pine64 DAC require
a different amount of bit clocks per frame than what is calculated
by the sample width. Use the values obtained by the tdm slot bindings
to adjust the LRCLK width accordingly.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 056a299c03fb..0965a97c96e5 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -455,7 +455,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
-		lrck_period = params_physical_width(params);
+		if (i2s->slot_width)
+			lrck_period = i2s->slot_width;
+		else
+			lrck_period = params_physical_width(params);
 		break;
 
 	default:
-- 
2.23.0

