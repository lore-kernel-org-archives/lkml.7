Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B3C20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hZmYFnES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfEPPNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:13:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40756 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfEPPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:13:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so3850578wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m99MP6x4cChPdhbIubtpCxGHABkHuAb2m4hPfeMsS4c=;
        b=hZmYFnESuV6VuicUNxJtmgvxqvOU0LIiIjYlEGsI0RkzI5Tk2IzOetocq1Z5UmerbG
         MOXmFIJwhjvbTTU2fuEx0yis/gk3acViM/0yeBRgGO5Ui77w1HmnFdoY9zHTRBblKKwE
         /iYeklpIPxMdpjronphLgx0HWI98eTem+wx5rbVZjX+Rva3dLo2A43odbvzv/cfEdEne
         0+HT9R4H1uACijhqnf8h86PLldxtwYSVKLuBF3FFOf6iPjL/dGBQx55aE0Ugz2uWM2Y/
         nQz02omzLe6ubaQvObP3hjE976/I+4ggSupyrmo96nbBJQjYlHZU0x+BbO9Pa0RZG0uV
         MmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m99MP6x4cChPdhbIubtpCxGHABkHuAb2m4hPfeMsS4c=;
        b=JgYBAtl6MVSDicwAj+F6umdBnYMhZ8d73yOtYizdkHODz8mRvIukav08ub6d3GUDOf
         urDZsBDLO4PXBKRo7QC0q2HDfl7+yuagib83OBdGiUcTjG3G0FwK7zCqq4RoyV5yk0tZ
         y4VhYlBCvIA988bXcwaW4ncn/so9/h7IP11Q13zI49mfKdpaMLqL+krfviOxGU5AyhHj
         eieS2TuIovfdA4J38d3Wxsa6ULA0IvwopvJ1kjnglwkJLynCeH1WUeQ5Xy5ZXucxu7R0
         Fgy/M9OKCKIeCWvMp36RjzZ67hIHDIH3w4Hh0QaNHcGXoqQEtJqb7kJ7peTSR0Y8Iplp
         ppEg==
X-Gm-Message-State: APjAAAXls7JqfLOowrYU0fR7umt2GAximoeWw5xPqO9VyOnkRGQ/N3S0
        pEKztoA8koHpTueS91GDFJqwCw==
X-Google-Smtp-Source: APXvYqz0RBerowQxIC2ARNV37JyqrgGCqaAxT6IWvRGxWQ56B4nchusaxmMXapm+9EOE8RC7Q22Gfw==
X-Received: by 2002:a1c:a745:: with SMTP id q66mr18504974wme.83.1558019627166;
        Thu, 16 May 2019 08:13:47 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 17sm6968126wrk.91.2019.05.16.08.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:13:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: meson: add output support in pinconf
Date:   Thu, 16 May 2019 17:13:38 +0200
Message-Id: <20190516151339.25846-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516151339.25846-1-jbrunet@baylibre.com>
References: <20190516151339.25846-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support for the pinconf DT property output-enable, output-disable,
output-low and output-high in the meson pinctrl driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index a7618605bf1e..10dc4f7176ca 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -47,9 +47,15 @@ Required properties for pinmux nodes are:
 Required properties for configuration nodes:
  - pins: a list of pin names
 
-Configuration nodes support the generic properties "bias-disable",
-"bias-pull-up" and "bias-pull-down", described in file
-pinctrl-bindings.txt
+Configuration nodes support the following generic properties, as
+described in file pinctrl-bindings.txt:
+ - "bias-disable"
+ - "bias-pull-up"
+ - "bias-pull-down"
+ - "output-enable"
+ - "output-disable"
+ - "output-low"
+ - "output-high"
 
 Optional properties :
  - drive-strength-microamp: Drive strength for the specified pins in uA.
-- 
2.20.1

