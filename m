Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE0DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F6E21744
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDjG+Z8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfHNGJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39810 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfHNGJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so24697353lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xlhGnlcLyXPojY0bRPSDLMcy+hJZFPi39TOyTS/wBU=;
        b=LDjG+Z8mIhS5zgHxWzmnF037zhntmBJl5zKjHirJ7skqEwESZ/9TPssPMun9VHd2gJ
         paoyDg16Hp50SSAZN7dwo2ODWuSrTe3rFjXzjteC4kXfai6KEhoTk5mEPSbXAOmNftnk
         mXGruXqtXay0ByyQKbpWP+ihz0ogwxrIp6ZmEKdCPOwSl0tYSW0pcFhNKIQ8vlbnPl3T
         5W8QHXnGS/Q9C/oSNSp9ON/H+4+u67fPjkyRotDsZDaGrizdtLuzOBuxd2VnHjgEjYrr
         Ovzwa8TmuLte801MqTa06cGHKe8YtzbV1XAPsjES+LYOL3nA7flEEaNGdXfEFp/gY6ws
         Yk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xlhGnlcLyXPojY0bRPSDLMcy+hJZFPi39TOyTS/wBU=;
        b=YIFJLhiiwFDLkzTBFtSPpftZzDluEymYl3CMwuaTgFLLhDXTQILtMBjiPYjeOqjgcb
         FU79TzxlRL0J4dN2t/KGb7K0LIN2tHGlMYarSVHDhZh58umFhkRUirNsS+oREXBLtg5X
         qwT/iZAZrYTgnMXzsaduX3Pi55WCsLwLLLqlLpAss4WTZkDDz/Yfb3OwKytzEaRdfefX
         KC0QNalJaKGL5FWpgnCYvneqMTnEB95Cgi3XDlA7/rSDdaWn8/Giz9R3lcmDkD2S0wVw
         9mzRZ7HrcqA61thORxF/kq9S2VorcgpmOpJeG4Mmd6on8B1Rnj6Xt0H5tBjcFm1UqDrs
         J/EQ==
X-Gm-Message-State: APjAAAUAkteItgQTfE3cQturQD2SwMekcQFwKnAjIKe2gdyKl/iSYtbr
        v7S3Dv4dZKI1bxWy4/BWGkA=
X-Google-Smtp-Source: APXvYqyZgq101jMRdi4NBQz/E+rmMXrIu0bWV/oCYTnoMBDnWs6w3jX6We+jj/pMt68nDXYjRzfYqw==
X-Received: by 2002:ac2:48bc:: with SMTP id u28mr26657795lfg.126.1565762954043;
        Tue, 13 Aug 2019 23:09:14 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:13 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v5 10/15] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Wed, 14 Aug 2019 08:08:49 +0200
Message-Id: <20190814060854.26345-11-codekipper@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814060854.26345-1-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to H3, except that it supports up to 16 channels
and thus few registers have fields on different position.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index eb3992138eec..6928d0a1dcc8 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2s
           - const: allwinner,sun8i-h3-i2s
+      - const: allwinner,sun50i-h6-i2s
 
   reg:
     maxItems: 1
@@ -59,6 +60,7 @@ allOf:
               - allwinner,sun8i-a83t-i2s
               - allwinner,sun8i-h3-i2s
               - allwinner,sun50i-a64-codec-i2s
+              - allwinner,sun50i-h6-i2s
 
     then:
       required:
-- 
2.22.0

