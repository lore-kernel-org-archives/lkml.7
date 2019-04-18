Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6A6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9BB2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hOoLMfpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbfDRMsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:48:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45471 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbfDRMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:48:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so2793726wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hZGFnloPIH8uy+TOBn2bOgOK6HgyyxeBU1/SBUWxaZc=;
        b=hOoLMfpx0yeg1FfPGBfiYewmRrfWJidgOoNqRCHRADoA6GtzmZS48XTLqZj2QAPGC7
         TymJQMT7ulXf8zK58pGU5lQVzdR8OmuOZ85/NVzReIBUswOswL7WSxyAl10bbyzB8jDM
         c7BZcbPjIW5BONtfSFJtfBiwD5VCpEsx08ABmvpuqSQNq3gMP2KAKBth1Fy2Nq92EKlN
         SgLKs+DsNUtSSo1W7vfSKdreNR7Xbm57uIxafhmdxrJ0NhyCzg52yO6c+fRXyr7amEIF
         g3NmXx51eirV0dnZsDl2fmghb0Oh+ZFMq0IE0yt3hB1NMzT+hxxbpz2UcNys4FC96sHH
         s6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hZGFnloPIH8uy+TOBn2bOgOK6HgyyxeBU1/SBUWxaZc=;
        b=Cn9Bs147tTHv4vTW+G9UCGCj0SrAPn3ok+csP3WAlAH/n1Kt0KcGuOGvEGj0nPAlCd
         4+UmYPl1hiCfo/2o8ji+17KkkqsQuaZ721JV8RbTgRD/vxyrtps0eMn7VJcc0x6st4gd
         tGNmUeRzTLIdjRdL2Ob8YJUZR8zJn3zCq2n2x6uA6/6qRQOiQKYLjrYjxn7kcL3NCYOi
         gWz/AHgEiIihseVyILRPiFOup+wVsYg1PqpbimCRrYkOSq7wg42RAeTlWFOzGmaf8nhb
         MhgWzc1SCZkOIqXFG34ozfdVtV2PPzSnsgpQ6c+n0cy5xPOxi7ADJNEJPDOTjaXir2bH
         l/MA==
X-Gm-Message-State: APjAAAUOvnbG7MBdZEiNMqLOolLNH70igziYMqQudBKlGAkyyxK5pkTo
        Js9XPLZCJH/2PkcQmphpB9ggfg==
X-Google-Smtp-Source: APXvYqxGUCY08Z6Tc1/uCiTaylzocswOa9Lvzn8FINRBhnCIAIdqJ42re1mtEpGC+kNREKbbLt+GXg==
X-Received: by 2002:adf:e449:: with SMTP id t9mr59193645wrm.204.1555591682108;
        Thu, 18 Apr 2019 05:48:02 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17sm1256823wrw.70.2019.04.18.05.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 05:48:01 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: pinctrl: add a 'drive-strength-uA' property
Date:   Thu, 18 Apr 2019 14:47:55 +0200
Message-Id: <20190418124758.24022-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418124758.24022-1-glaroque@baylibre.com>
References: <20190418124758.24022-1-glaroque@baylibre.com>
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
index cef2b5855d60..fc7018459aa2 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -258,6 +258,7 @@ drive-push-pull		- drive actively high and low
 drive-open-drain	- drive with open drain
 drive-open-source	- drive with open source
 drive-strength		- sink or source at most X mA
+drive-strength-uA	- sink or source at most X uA
 input-enable		- enable input on pin (no effect on output, such as
 			  enabling an input buffer)
 input-disable		- disable input on pin (no effect on output, such as
@@ -326,6 +327,8 @@ arguments are described below.
 
 - drive-strength takes as argument the target strength in mA.
 
+- drive-strength-uA takes as argument the target strength in uA.
+
 - input-debounce takes the debounce time in usec as argument
   or 0 to disable debouncing
 
-- 
2.17.1

