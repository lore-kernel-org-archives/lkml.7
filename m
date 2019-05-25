Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1ECC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BB621851
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4J/SBNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfEYSJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:09:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34992 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfEYSJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:09:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so12958065wrv.2;
        Sat, 25 May 2019 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5dpLWzLTGHqoLzmEuuyzv0j7B4AjJYpWV0u2Vp/+l8=;
        b=m4J/SBNV++wPUP3Q2lfu4OcIQeafT8464+M72Ciw2geBym5L3IlPlC8/D4TSyf11+v
         8qDLPoYnhoCt86us0EuV6B09dA+LoFeHFSkAHtigcOaZjjd3YIdHOc1q8oM4m3v9Cai4
         jM5oK7DxKpyU0SDL8l66OvkSczHDixYd69YcFbpulIbMMN99z4HJeFpE5GSzLrvISXQR
         Qf4+54HQxcsTwRqQznwUQHqeZxz4ZQeVinJORTp7oLgNzYHwc6gLUHryxmHNlFydhTMg
         U1Qm3f+KNb5uq4QEQwgU1oQA6kD4J2R40Ehl+yYYU12BYJ8cW8qrKccV3Ri1tVvsPUXs
         DQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5dpLWzLTGHqoLzmEuuyzv0j7B4AjJYpWV0u2Vp/+l8=;
        b=f1Kpg6uDw8gr8fcSVZelRZY9N0btbkON1Gs0ZbLHXRy1cuvkYVeM69NBgDGEHloX3D
         DVDWhpz5d0L2G9oqKf9bsXaW+rRmzqwnp/wiR569DDKuy3B0xw3i8Y97+DzFawcH8I3J
         7OQfm6o3kVQTSfNwzN/e2ZUFPcvH97zCNPcEH7JkNj3u0d/NzZQSAPVtAMQWhyl8yu8B
         8iVUgvgalYucCSkXnWjsXm/YFIJHqOQesL8bLC9woaLNAWE123mM19eNfZTNvBM85A0X
         HXetDy3ViIboS6Oyv4w/2gaf5jepDt/Gl+hFJS3XbalazPJPFOLIwt/O5d51LP3OqFoS
         39EQ==
X-Gm-Message-State: APjAAAUo0jMaUszFMjwdzgY6fQyq/BxBq0riYEvW9mc58Elm2LDAm0bZ
        Qb4n4FoLR4KgToRDlZ2fW4c=
X-Google-Smtp-Source: APXvYqy2yHnmPQd3zV1hveiQKrxBwBy4jQr1o0cCgEEz1aZsNV3dnft83FH/coWeqnUW6441OpZDGw==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr21043667wro.81.1558807770617;
        Sat, 25 May 2019 11:09:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm5656914wmf.48.2019.05.25.11.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:09:30 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 01/10] dt-bindings: media: A31 compatible
Date:   Sat, 25 May 2019 20:09:14 +0200
Message-Id: <20190525180923.6105-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525180923.6105-1-peron.clem@gmail.com>
References: <20190525180923.6105-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Allwiner A31 all the SoC have a differente memory mapping.

Introduce this bindings to make a difference since this generation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/media/sunxi-ir.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
index 278098987edb..53e88ebb53fe 100644
--- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
+++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
@@ -1,7 +1,10 @@
 Device-Tree bindings for SUNXI IR controller found in sunXi SoC family
 
 Required properties:
-- compatible	    : "allwinner,sun4i-a10-ir" or "allwinner,sun5i-a13-ir"
+- compatible	    :
+	"allwinner,sun4i-a10-ir"
+	"allwinner,sun5i-a13-ir"
+	"allwinner,sun6i-a31-ir"
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
 - clock-names	    : should contain "apb" and "ir" entries;
-- 
2.20.1

