Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA15C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4187222F1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eG23jh5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfCXPOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:14:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34560 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCXPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:14:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so7333706wrq.1;
        Sun, 24 Mar 2019 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPJWUCkniYvFY+imhTP05E2QTQFEXxZDTbw3Sd6sRqw=;
        b=eG23jh5FN8zbCRuTxemtu0s67vBLk9I3ZZ26vPcJnNQL+onnvAjosnm7iMDnXAYsv6
         LKiDU1jxXIt67Eb+rqN70TPMEqvXl4NKuWme4dsVuwz1/OXcrcF8Gf4ke8uGKIKPlbOI
         iEUIhOhfT7jHJ67xszlDsYqYvptcupAYGLk7sal4MzUyiDBEbwJN/mV2Kvk/W/aTm60B
         I594dAH/H4XJtjtjk0hPCPTwx3CFo/D08hupElZ3fWlCGioq9tpAR0sjz4rB88ZqhERa
         jXfNOeWo8k7byoOSa7jyeJDuTpOSMVfnrrDKyrZODsMcAxbhuVh4Gkw9Ahgsv6BkQ8fH
         4Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPJWUCkniYvFY+imhTP05E2QTQFEXxZDTbw3Sd6sRqw=;
        b=PAqG3cg4OczKHJwgje1aKHh6rcJZK23CIXLVlczsD/YASBonVCo2BQlKd8s6Eon5bU
         xelbnTwj2x/ThKoyRvnd/NFQgST5X5UvoBk4TqBpXrnepDe3b85beJLXFD+OJwyJoNOY
         e1sk1GEjBy1HjH3xYaoaRP9Y7/fHjdxFOK+uE/Yv2D7/v7OxiaAnxjrbdD1CrM0F7jhX
         h7DHGgVgQFmKIk+D68ET52ifpqwMdbCSbktBx3CWE4iZd2o6HxN1uIUsfiCutqlNZ8xD
         SZ711Uad/ydIPqB00PFTNY38rjR7qykIZFOdkGA8qs4NwNNYO3fij2UacurnEI/N1AiY
         HrvQ==
X-Gm-Message-State: APjAAAWf3kvtl6SvVXL+MMWvEbtSSAX53sQQbO8dMxgnr3aDWidA6y1G
        psyIhgGb2VAqVdVaYLv6U2s=
X-Google-Smtp-Source: APXvYqxfbn7sRrbs8v3230Vgv2W8QHN2xDBdqp9ipKSgJQUuoCy93UO5kr0jnt/zoKOTT9qhVnYJ9A==
X-Received: by 2002:adf:b6a3:: with SMTP id j35mr12931383wre.25.1553440481073;
        Sun, 24 Mar 2019 08:14:41 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r16sm376889wrx.37.2019.03.24.08.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 08:14:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, mjourdan@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] dt-bindings: clock: meson8b: export the video decoder clocks
Date:   Sun, 24 Mar 2019 16:14:22 +0100
Message-Id: <20190324151423.19063-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324151423.19063-1-martin.blumenstingl@googlemail.com>
References: <20190324151423.19063-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the four video decoder clocks so they can be used by the video
decoder driver:
- VDEC_1
- VDEC_HCODEC
- VDEC_2
- VDEC_HEVC

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 2ac9469a1c27..47556539f0ee 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -108,5 +108,9 @@
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
 #define CLKID_VPU		190
+#define CLKID_VDEC_1		196
+#define CLKID_VDEC_HCODEC	199
+#define CLKID_VDEC_2		202
+#define CLKID_VDEC_HEVC		206
 
 #endif /* __MESON8B_CLKC_H */
-- 
2.21.0

