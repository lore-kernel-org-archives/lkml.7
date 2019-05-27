Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB3FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E6B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8S2Cn58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfE0UK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:10:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36699 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfE0UKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:10:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id v22so531818wml.1;
        Mon, 27 May 2019 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlAy4iNnvpXUfWGzbLAVAxpfZU/8XBVjL/0mbqQ077c=;
        b=I8S2Cn58NEVH0hatc3NKO2PFM88gZWXrHjhGHO35q+3Qa0jns1eKsnFDC7jJB5j/EA
         7HXPhqqY5oA8PQyt18mnwaZQ7YtD1a/kvTf5VqGbVd/jwQrplO7Ntzs7xVfjh8Py+MU/
         xUnKfY5ChHv09UtfqppKz/CtZMokuvx0si03JPCJ85oOQxSvKCQJTfn1/9AZpRrFNJaj
         N8Gfja9/sSsqVeTdrMZtXlb6gONUNy57M6mAakH9Klj1aT73Md3TTwRbp39wO9AwrHxZ
         k4GfgAHMhXe2KdMIPP5YEMbt8XNaPVv0OKgnB1cUyhLrUHylD/20xsq0hzm1B1DRMuyw
         dNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlAy4iNnvpXUfWGzbLAVAxpfZU/8XBVjL/0mbqQ077c=;
        b=oZ81XUkwsCm5HSFfPA3JjUKNY63hqxBlQgrWvZ0pFNXFTXZ4fozB46K570aY0MKXlx
         0uxVzcbyoFt92LMc8KcGfVodgGuLPbu61Tuq7N9nHLoQdb3pnAy2XNtOBQY3Gaxdebhi
         AnxoIRO1HBbAVZdypVM5N9+83qdRecdpmXiBVpeXWtc4ZMhpL9hyqeaQ3mGaEVAnuE1c
         lJdF7ZNp76wU27pGkA164zWpoa9Ne2P7wvcY6Zs+h71aAK0B1cqmT8d6tdhOlPsZXvF6
         dsgKdeoD/Howc+fGQVs5H0dq8eC3gy/aNyJtGUeMWhooGUfqRYLKuU+CB1ZDGu1M0mmc
         +XEQ==
X-Gm-Message-State: APjAAAWPKG8f6U1UUIsphgEt8TpzrfIATkdgP83FN+eqXPgIdB8OZ8Pt
        0DVh2TlpGgAzdG0AJ4jkonhbaspuDz0EKw==
X-Google-Smtp-Source: APXvYqzJpzVaaRuhg4r+/YsFaMeeSgvPFOhsrD9RszJD+0NeroZ0mmv17kCSfNxSev62Zwhh4sG18A==
X-Received: by 2002:a1c:98cf:: with SMTP id a198mr510793wme.51.1558987820339;
        Mon, 27 May 2019 13:10:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm308523wmf.48.2019.05.27.13.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:10:19 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 6/7] arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
Date:   Mon, 27 May 2019 22:06:26 +0200
Message-Id: <20190527200627.8635-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527200627.8635-1-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 board has a SPDIF out connector, so enable it in
the device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..76a95ad33dc5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -243,6 +243,10 @@
 	vcc-pm-supply = <&reg_aldo1>;
 };
 
+&spdif {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.20.1

