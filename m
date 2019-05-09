Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203C3C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B79217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VxfFwifN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfEIQ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:29:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42620 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfEIQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:29:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so3900595wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2c6x2f6eeQDgR5pR9v6L40zLzoX5XJYrfYvIkaAjp04=;
        b=VxfFwifNwbqNi2XzCiT6xL1zwC5Abv0LgBZ2PPzyVD5t6T2sMYVCKVkPVeu8S33/Uc
         oDw3/LViauL4eGriZ8a6El5onMLvO0Q3WMu3DQnwnqdBKx4APhMrnNaCl/+m3pPyIKwn
         E05U+8mckVFQ36oriVIhhE2XEqThDMGCzRoPd/otk+V5sVRsGNpBSvlM6JbCc1z1aALV
         +9QkG6oqIs39hJDbq6E2nMiNImliQjj5frZSLPM8PmRYDI0gFw3Io2450Qyl3Na9ApCI
         4lWoaTuNTNfoOuG3Ta8JRgQ4d04USPVuDOsTIP/cQmx+IpKgxxjmAiayrns4BtMwMq8C
         coBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2c6x2f6eeQDgR5pR9v6L40zLzoX5XJYrfYvIkaAjp04=;
        b=fy792eYepC3eefaPnAvRuBpO6FUu64YMGk3a81kmcxDQ8PwQxeiiLFa2pkoMynNcqL
         plpvDlzXcieEeiWkKPibJZdQgcBB2DdUkPAU1OBFU/DQt/EP9j5v3rxgyVCW6fDK4w2t
         FrWHyL4twknYIBXCRjxWoNpqvbU2OCDuLpnFfZkHsuibQZI0Ukz+o+onx1g9QmW81NSW
         rarC6Yqcvy9goLSrAIOIMgh669PBMTqHu39oVBDM0SGXxySWgOgAnciFL/npWnEB3Auf
         kPJ9sgabQsGyQqrTcW8cpF/OvAJu9aVakgEF7qd0rWW1wUnnwrrXRrbpYUXJIgKMWpoK
         udrQ==
X-Gm-Message-State: APjAAAWosOe95bnDtwuLZ+ayz/9wYGsi5uQpSzTlUFeNccKdmn6xsgVR
        1O+vHlXA4b5Y/piU572wLw8uiA==
X-Google-Smtp-Source: APXvYqzVL8+3tvK+pyR0Yf8H/ohoHNF9R/2o0IP5EFUiAuUIeVNuMQCC7AQlvEtrp/uEtg6KXNR2Qg==
X-Received: by 2002:a5d:628d:: with SMTP id k13mr3878033wru.319.1557419363588;
        Thu, 09 May 2019 09:29:23 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id k2sm4116297wrg.22.2019.05.09.09.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:29:23 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] dt-bindings: pinctrl: add a 'drive-strength-microamp' property
Date:   Thu,  9 May 2019 18:29:15 +0200
Message-Id: <20190509162920.7054-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509162920.7054-1-glaroque@baylibre.com>
References: <20190509162920.7054-1-glaroque@baylibre.com>
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

