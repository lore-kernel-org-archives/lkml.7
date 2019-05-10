Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA592217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xtx6Zvf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfEJIYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:24:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43800 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfEJIX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:23:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so6651181wro.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U4s1dss+n9Xva15zT8mISpfSr/mUjsA3fFxCGFPn9B0=;
        b=xtx6Zvf7rGsnmGj2NGzV3BEOMtTMORT+mlenmWD+IPsFijXjJ2Tyr0VK0hp/Al3hXD
         S0VtCRtxdkVjUc6Jxl51HYWMQSpq9UGG5EB/J/yCHaRwZjGMmDlHt3HGYWKaUz6MTgB2
         CsmQEb8aQN58qPcvt00IWI9hu7S/8/4aGzMrHlRt6QI5szH9UeOmnxpSb1/NCA8Q/7TL
         /pn7HOE8kyu30H7AUMMR8lIsDgKkNX8bZ9wCfpWiaIcRnX1Kh8QZS8hx4hGABewbyqI7
         bibzUxPIZaovtc0sEBhW61/zgzaX40H6uFd0NrMrDrvlxzRE7yyvXcDPAlt4eOAhDCaY
         18zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U4s1dss+n9Xva15zT8mISpfSr/mUjsA3fFxCGFPn9B0=;
        b=feZNhz55YlaJ9bMA/cRUVyAhwjDruzltKeG/+y4K/W0+P+qOZF6MvsdSILr7+GF+lM
         DSAS3nE5KXIJS7UIWSMJezdZ9yQDmrnvtrgtWXAJGAJicCxFHYZPT6ItEso/iGis9pBh
         mMoZ3QpVLTjcJyKbLMadtAJtwKYEKhuYoMFvBrqCCKH6+sJdo3kJQmGHIJxMqDaJGc8z
         8ViNJZHKcAvz2TekQW7PyyaItm2jdTHH58IHhqsZTKzcJUxkjbmupFGz6pq7URS0SkVk
         /DEyfUY7qoDuEKcFMFQzTI80QKffPY3tIGDpnA1lSgExQKPckXyShcjM8dUtWn3L0Ov6
         NZsg==
X-Gm-Message-State: APjAAAV/Tc6G44Atpamldb7art53jCjDf1y8EXAypYL3mWgNQpEX6dpm
        P51Lh4wI1VNW4vjVI9ok/y6nuQ==
X-Google-Smtp-Source: APXvYqy+BhXehiD7cbWFg775OPA4oSa5FmjSz+D1MtxqQQz2jWqz6EddyK8OpD1zRsJf7GXvsYXq0Q==
X-Received: by 2002:adf:d850:: with SMTP id k16mr6636198wrl.57.1557476607654;
        Fri, 10 May 2019 01:23:27 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z4sm3790285wmk.5.2019.05.10.01.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 01:23:27 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] dt-bindings: pinctrl: add a 'drive-strength-microamp' property
Date:   Fri, 10 May 2019 10:23:19 +0200
Message-Id: <20190510082324.21181-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510082324.21181-1-glaroque@baylibre.com>
References: <20190510082324.21181-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allow drive-strength parameter in uA instead of mA.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
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

