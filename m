Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF51217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BAnt22Re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfCNQhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:37:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34564 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfCNQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:37:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so7253840wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyyOz1m96O4p/E0V0P2WXHuhjOVs41Ijnx22pgX7mwI=;
        b=BAnt22RecllUp0V+7xCOYepXPwGttiyuNcJNvDKMMkzz0QqM9GS+pfP2K+/htHQDY+
         RQixqU28hjnQsM3Y/0SH3MGRqcmFlvT+PExX1T40zyhfliqB09ZDuXKAzovTAr3TD4m5
         LJ6vje5losjhjqV/ljE0oJylp1X+7wOynqU/RXwJ9bltp/zMywHpW2VRT/LrZ8XHV89f
         eWSQ4rAokoXGtamaV7oq9ktYo3/Ys/nm3VwhFsXm7ffbmvxujYKYcjYhkyWajcJvSmbi
         61rbR9G/HKDVLWNGE36lLsHTIZKanJ2I9F/+GfXUg75vRRT76rx9vGcoUNYJFpzElY18
         ZffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyyOz1m96O4p/E0V0P2WXHuhjOVs41Ijnx22pgX7mwI=;
        b=gMrdP4J2sPdrdmTvnCrY3EjUO7KGYg0UUocAvjQs+36F/vG+Ze8lkBfUaF7rmW3v/U
         TArLBgV3d4JrCxOYra9A5+PbEyOQucZNT7zx28/O/YrKltvurPdHxCgIo9kmfbUExTXY
         LLkpi3R2Xy+pmsFvXy0St3oHxBj+iB+2Ya0vnFAg2qHtng574ySqANi1rmMduITmEDPL
         R1Z/gk2oYPrZAjNpGvOXUQab7Fsj89584Mg7GTRCimMDlq99xEzdyu9hKmG1hxeOzZaO
         zRkKg2rqQD2EMBVJTEKNQY2Pqed/ixBIyRrlkTXY7x/d3a0jf9D2YCLLPVvYJXooS7qB
         +74w==
X-Gm-Message-State: APjAAAXbqYgANtE288mY0TSA3T/mzyvyC8CQDqZCrP3LnKuLrYg1o7zA
        1UFwnjbauP99XrIq6WHzCS0/yQ==
X-Google-Smtp-Source: APXvYqxijEWMM/0WKUooC5/J8OF4N4uoAkkdb0igMiuO3TJiuY1FHQnIndwsKGAeaUD40SJCv7bPvQ==
X-Received: by 2002:a1c:2283:: with SMTP id i125mr3173986wmi.24.1552581455474;
        Thu, 14 Mar 2019 09:37:35 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id u17sm45003315wrg.71.2019.03.14.09.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 09:37:34 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: meson: Add drive-strength property
Date:   Thu, 14 Mar 2019 17:37:24 +0100
Message-Id: <20190314163725.7918-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314163725.7918-1-jbrunet@baylibre.com>
References: <20190314163725.7918-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

Add optional drive-strength property

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index a47dd990a8d3..4e3d5a27c91c 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -51,6 +51,9 @@ Configuration nodes support the generic properties "bias-disable",
 "bias-pull-up" and "bias-pull-down", described in file
 pinctrl-bindings.txt
 
+Optional properties :
+ - drive-strength: Drive strength for the specified pins in uA.
+
 === Example ===
 
 	pinctrl: pinctrl@c1109880 {
-- 
2.20.1

