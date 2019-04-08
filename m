Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757ACC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C18208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW8/33iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDHJWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:22:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54012 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfDHJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:22:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so13459961wmj.3;
        Mon, 08 Apr 2019 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/l3LkI3W5rGWEVlxH7QSopgh6fyIfDuQSQVjTcAbuE=;
        b=MW8/33izhR7O5nt1XxEaHVmFdOJ3TjvmmwrkAk2Xf+ouRTciDNDzAz6taRcIVckOnQ
         8OkuhVEbLTt1F+oTMtKBUnHet4y2+mTcq4oKJOToBwz+vKFQ02cj1iJlXoFe9lvYI5as
         8Rv11IMYg76a+3+TfzF7Gx31Nmpelhh0KJTsEXU60sidMGH83Ndx77oOS/KXCYuBeN2x
         qe2aEbjhBzwHO2fLBp9hEyVeP2wx2V8D+CvmpGSp4ep0NchBAvexw3wIGYjRi4kUigay
         0MW/y8fzn+JbkJomdmctu5pbakARCjjBaPQkdfrbhNKsog4ze+VxfaMG42Cgp/erZ3fr
         gOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/l3LkI3W5rGWEVlxH7QSopgh6fyIfDuQSQVjTcAbuE=;
        b=dyPxgKVC7chJGfQfXP0YeOyuD+CnykjdC98qPu+MEW9jH8FrwiWTTl2Bt8eiJnbfSA
         8ZtuUwx1JS995Ike7mwdByaRCI+Iilb6c+5/tm0EueYVqjgtjy4RUVhAtK7r/TMfHu6X
         62yYJaZQSh67ucO97JK3iVwPlqij8hchnVNXzw97DFnJmISLBOGZAl+iUWzQKWsT+sq4
         ASZcwqMooG/dT87EKiy9ghztqTaNsZs0QbKcG+5u6CO/qLjwCec4j7oTzPCnXddmzGa8
         4grJxpu1AtZ82WcOkWNa4k8suEDn1WQttxnDVk3Kb0W1UMqf5auWZZLZkGiq9wV7ZlTP
         NRCQ==
X-Gm-Message-State: APjAAAVfcTppe/jrsaEATLsNODLlu4EekqJkES7fwDfEWo8ExbOjEsbK
        mkkItqgtL19W0IOdxvky9bw=
X-Google-Smtp-Source: APXvYqykr+dMtPzpIstwc//Gg7krjNBVa4LFvtVOdKmvGqgasAsRbeJobJ1ujsJsShTc1qrUYz3WDA==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr17657679wma.129.1554715353614;
        Mon, 08 Apr 2019 02:22:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id u17sm22671883wmu.36.2019.04.08.02.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:22:32 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 6/6] arm64: dts: allwinner: h6: pine64: Add PIO regulators
Date:   Mon,  8 Apr 2019 11:26:19 +0200
Message-Id: <20190408092619.23152-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408092619.23152-1-peron.clem@gmail.com>
References: <20190408092619.23152-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PIO regulators for Pine64 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 4802902e128f..6f2d9adf4f10 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -127,6 +127,12 @@
 	status = "okay";
 };
 
+&pio {
+	vcc-pc-supply = <&reg_bldo2>;
+	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_bldo2>;
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -247,6 +253,17 @@
 	};
 };
 
+&r_pio {
+	/*
+	 * PL0 and PL1 are used for PMIC I2C
+	 * don't enable the pl-supply else
+	 * it will fail at boot
+	 *
+	 * vcc-pl-supply = <&reg_aldo1>;
+	 */
+	vcc-pm-supply = <&reg_bldo2>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

