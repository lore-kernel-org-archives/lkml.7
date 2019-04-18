Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5424CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235B52183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RHaboNDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbfDRMsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:48:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34529 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388864AbfDRMsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:48:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id w16so2858454wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=itnTRs6GOUwiIdL7618b+jq8vSXb3yV3ONsvpSK/Nck=;
        b=RHaboNDQe5rgnbI1bLOCIU8QzZaMwlk2Q+ynWQDeFz+/osgn+tjSfKin3JoYu6L45A
         avbUVpFISIMI9Kk3VcUsdQgw5EhKsg2VAW7Up4H0T/thdSrEEvV9MnObQLc5/8VH6K42
         1B8aQiv5GP21a++WEqGYFFAWgi194CXjROJVmi1P5lnoj8FW1yQ8M+XtxfhYLZbQ4LPT
         Zgo/t+QkkpJTHhECE+rwMrVNX4XRpODdnbUPbtK/sUFXBFXK7JGY5WOVOrXwmLXDtYMF
         Hab/DAL0qNO66wux0g/sUCsF0J5Dh6fe68k8JqzIfW+iQziqcczV6uYRtnx9p53Z4A1d
         f8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=itnTRs6GOUwiIdL7618b+jq8vSXb3yV3ONsvpSK/Nck=;
        b=bEfeLtmw7Endv3En2hdclC9TMLTPx8NFxMU+Ys+LNXxVgrOhNZ5NKf6ZjLo3yjM93z
         tzdrf0lxfML29F/Ur7XE6EwiOb3wdIFVKCnarwxLlG8ltxWYHIbgQ17D29m5dWthdU20
         3u++z0P6X9dpcd8aVLdSBxaME1kQsunphFyFh6g2SmPmyo8xx5tybn7EOL5eTxIXjc33
         yO9XhtJ9KQtrC8UU3ZNiVbozsc/XumMclz+rXWf5mrBwyNHRqG8fTxP7dyVCNyHetde/
         Z9kkZeRyr0fwI8fMKsm4w8/wLG7Pj0LL/S/0ASBNHOOJ2bBFIk23EGdKlrXDSs5FfYiO
         rNMw==
X-Gm-Message-State: APjAAAVjl9XlFpmTzcVJgeaiEB21x2nJpBYrtat7qPi5R1ED9p+Dx5Yr
        E38ql9XaX/jhWg/NMq+1ROKUFcdPLDI=
X-Google-Smtp-Source: APXvYqwhXjUtW19hcTBd2hTAve3ZXHULXF4D+I/d70Fpfm6nwEj0wAJLBmIIx6XjI9aQx6CHZXEvWA==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr26490937wrs.250.1555591684505;
        Thu, 18 Apr 2019 05:48:04 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17sm1256823wrw.70.2019.04.18.05.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 05:48:03 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: pinctrl: meson: Add drive-strength-uA property
Date:   Thu, 18 Apr 2019 14:47:57 +0200
Message-Id: <20190418124758.24022-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418124758.24022-1-glaroque@baylibre.com>
References: <20190418124758.24022-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional drive-strength-uA property

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index a47dd990a8d3..b3e4be696ddc 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -51,6 +51,9 @@ Configuration nodes support the generic properties "bias-disable",
 "bias-pull-up" and "bias-pull-down", described in file
 pinctrl-bindings.txt
 
+Optional properties :
+ - drive-strength-uA: Drive strength for the specified pins in uA.
+
 === Example ===
 
 	pinctrl: pinctrl@c1109880 {
-- 
2.17.1

