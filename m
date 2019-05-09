Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F9AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E890C217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AceFazVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfEIQ3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:29:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfEIQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:29:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so3884895wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2c6x2f6eeQDgR5pR9v6L40zLzoX5XJYrfYvIkaAjp04=;
        b=AceFazVnmeo70zmUKXtxzROx9A0pF/jf2NP4g67cih0dsIVE8raO2aXjWOpQftWJ16
         K05BKCVSCYOrleouRkKx/3/7zaQ1HY+3/DFwOl9dHfS14JkoW/nI+LwXqANF00YebUuU
         Whw5FvGLzg2U9KHcsoGyT5KzdkwITja11hmwLkgYW0/T4rFrQIoThcUpBa1b/4DfG/zr
         cLsdBVldWwciEpp3dLmJ8dR6d87uilDLaPksoOKNF+/GfrBuXOBmQt67ON4kaQ0OkM26
         qI+idgB9mHmRSHFk6vHJOfM+vqyO+10wKLG3PbPCqPe670JH0hFfrAReSNWAvlndLddi
         2Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2c6x2f6eeQDgR5pR9v6L40zLzoX5XJYrfYvIkaAjp04=;
        b=TdWxnq/woUej7a7bjrGwP+YCOMEeMp4gYElUYOi7iQP8jZO28NVpaB/AbUy20vaKps
         xMBzqksaqNXc73OrYxKaPzwbQgilDmionTr9WFeP46M3tzA7etwO4uLvZmmlTtar6PHB
         neThxzSGpffNKxq73eI2DRrIkKUnjJ8Q1IrH0JXno2rOmnd67JJp5szg8ke24F/ZnAnm
         352zbm/wq+bS14QPCzY5A82bLhrbjxcZ7Z0aExkERkeOcjx0/aESNO/0N7q1juKmrA9N
         TzRtJac3DzcJWToAOTDpDGBcHIXI25l6fFNWS7neEhLhkT7A0mz045kIlporGs4CwrPp
         jGUw==
X-Gm-Message-State: APjAAAWhbHyaOwtrxM53OlHmmLQBSxPYn7U2h6plXedfhT8SsqYygCtE
        AhrZlvd73t2gFy0kKMYYeJkTCQ==
X-Google-Smtp-Source: APXvYqyp+4swpGavdNb86NApkf1sjatdLA1EpEUZb9DAAQXR/gTO708mEf2oPQL5TovnEcFr/6JQ2g==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr3932396wrq.119.1557419342344;
        Thu, 09 May 2019 09:29:02 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id z7sm3649796wme.26.2019.05.09.09.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:29:01 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] dt-bindings: pinctrl: add a 'drive-strength-microamp' property
Date:   Thu,  9 May 2019 18:28:54 +0200
Message-Id: <20190509162859.7001-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509162859.7001-1-glaroque@baylibre.com>
References: <20190509162859.7001-1-glaroque@baylibre.com>
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
index cef2b5855d60..84adce9f2a75 100644
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
 
+- drive-strength-uA takes as argument the target strength in uA.
+
 - input-debounce takes the debounce time in usec as argument
   or 0 to disable debouncing
 
-- 
2.17.1

