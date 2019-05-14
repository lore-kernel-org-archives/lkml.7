Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC68FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FB620675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sUzajzzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfENI1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:27:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39594 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfENI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:26:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so15687423wrl.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RK97rIPqJ1mZypVshy2AL2Te8nJvkZlZG4fdj01VBV8=;
        b=sUzajzzkQiSy4sPdi9iAqWdKPbA50pOct8MjX3ZvHTi8X0BPfW4FbUJF7hbgySJr+F
         6CJ70MhdP451txHIBSW5QUYtDcSbh2bgsXnP5gwVjppE4jsmWNix7vSUNvUlmHLMhS84
         uWS4JVQbn1jKt3HI3V/R+vuCAD2GAjGUYDQrtmDO0+bAhVgQDcwZkvWy8cbLrp5jKK60
         rvRUyBxyySsgGyfMx5h4ICpyW7l4RWFCzFM3UNVnC5j7j/paEcvOqK7bMx1j1KAc3CAt
         pJuq1VYTgFaV63pfeIbxQfSD/jmpubep6UZURn+BVTchmzmU2icDNBu+26OVemGpQg++
         Sh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RK97rIPqJ1mZypVshy2AL2Te8nJvkZlZG4fdj01VBV8=;
        b=Ux9lE0IkdJXHsrgzvDwh/Gnij+A8+9eBBQMWJvgEkAeZbMmoI8UngJKhIyjLJ/Ugne
         VWXqw8CprBmfZEAlKFKGQRVjkRJHIf+aUCAn0pVadhRjGyDqMND/9w6sjD1C1EbdI6jd
         oigDon8SVEeYr8bYaE+r8AXyAllAf83NP3BGP7l/SHxArdvu9Q/URVSEQ3awPYo0n4dz
         CgDc6zOxzKwvf9HeuH1Io4NP+Y7AvCOY+d5TFzvr600zfo5GnvjtGwPFB2iitMBPdVho
         +MeaGpTVhH09tRced3dMCfQrS+vbwaAJK1JU9pES+toVqw3G0xc9VhC3onpz8DSsrFnq
         5eSQ==
X-Gm-Message-State: APjAAAVoXVq89xwoFZ756OB/gQMjnGpS+7vVUlFufI4oL9wHWGHmv/Vs
        AReTfjfQXe336J8nxLV12uCG4g==
X-Google-Smtp-Source: APXvYqzeS8omztpZAz37W/A3cxE173n7dyzC4UL8ae/t0P+AL5+oSE+n7XEoWFhsP02XFjXF0fd6xw==
X-Received: by 2002:adf:da4a:: with SMTP id r10mr20120761wrl.216.1557822416023;
        Tue, 14 May 2019 01:26:56 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id j190sm2450772wmb.19.2019.05.14.01.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 01:26:55 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/6] dt-bindings: pinctrl: add a 'drive-strength-microamp' property
Date:   Tue, 14 May 2019 10:26:47 +0200
Message-Id: <20190514082652.20686-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514082652.20686-1-glaroque@baylibre.com>
References: <20190514082652.20686-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allow drive-strength parameter in uA instead of mA.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index cef2b5855d60..fcd37e93ed4d 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -258,6 +258,7 @@ drive-push-pull		- drive actively high and low
 drive-open-drain	- drive with open drain
 drive-open-source	- drive with open source
 drive-strength		- sink or source at most X mA
+drive-strength-microamp	- sink or source at most X uA
 input-enable		- enable input on pin (no effect on output, such as
 			  enabling an input buffer)
 input-disable		- disable input on pin (no effect on output, such as
@@ -326,6 +327,8 @@ arguments are described below.
 
 - drive-strength takes as argument the target strength in mA.
 
+- drive-strength-microamp takes as argument the target strength in uA.
+
 - input-debounce takes the debounce time in usec as argument
   or 0 to disable debouncing
 
-- 
2.17.1

