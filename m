Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB25C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5061220828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BBvH8ue6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfCYQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:20:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34520 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCYQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:20:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so6851688pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Cunm/QpM76+PLJTVX2L3BlkDvwE2VI9DIfbNvqLEsM=;
        b=BBvH8ue6liBQRlrODmD5S91YjVaYYc+d41v95P5uvoZbpDbqDsTAtpprSD9QPKqjbY
         yqEKm2H3SPudByIoq9tf/BCf2Tb6eRHyqxhem7YTd6YI0g/EPR1IyPNnF8ltN7cFLJ52
         9K7SjXdSrKwNlo/qjY2l7MrHCZWfkU2rxR3Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Cunm/QpM76+PLJTVX2L3BlkDvwE2VI9DIfbNvqLEsM=;
        b=DJWadq8Z0WYCgz6dzD4bqkQZWqJVZuqEFHcL8UEE68VeKJekqZxMlwDrJyc5y5B5nQ
         A3nQgrpyBTcNDbGwsterIUMaJP3zR2R/Urw0m+m0lQEQjqnWIAHmEiyOWr/DmyUzuGqt
         nCtsI+BWh4UUcREnpQrQuHeh65GZw6IWIbFkcy3dSy2a+5d1OSM0cQFbFWaasqG0QYd9
         omCfa3dsfEPIiSHrWa1GCwZcc3WGiTL0yvqdurvYgxowbexw786eSqdaylzDqV9G3l18
         1o+Ln35FNT2AL1StmmkkwPHf4V6JEBjc/RHHpBxudTBDQnvpAWHzMDEyMn+pcfhde4u6
         kNBg==
X-Gm-Message-State: APjAAAXtEhMbag1vseGxABaIYsf5g02rivVFc7QtlSBZNdQK4lNjDQCj
        t/p9kTQND1QboTUWRuglb7+muw==
X-Google-Smtp-Source: APXvYqx5gANiYRqfpIsqHPNGup+7SbgIxuovdYVeLhsgCnLrCCthvQQqGt07bRQctvsZcirIkYvGyA==
X-Received: by 2002:a62:4481:: with SMTP id m1mr25274223pfi.253.1553530834146;
        Mon, 25 Mar 2019 09:20:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d12sm25879790pfh.168.2019.03.25.09.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:20:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Alexis Ballier <aballier@gentoo.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: ARM: dts: rockchip: Add bindings for rk3288-veyron-mighty
Date:   Mon, 25 Mar 2019 09:20:04 -0700
Message-Id: <20190325162005.99391-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mighty is basically the same Chromebook as Jaq but it has a full-sized
SD slot and some different (slightly more rugged) plastics around it.
Like Jaq, Mighty may show up with various different brandings but all
of them have the same board inside.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v2:
- Add Rob Rerring's Reviewed-by tag.

 Documentation/devicetree/bindings/arm/rockchip.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 864ee1fddcb0..5c6bbf10abc9 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -147,7 +147,7 @@ properties:
           - const: google,gru
           - const: rockchip,rk3399
 
-      - description: Google Jaq (Haier Chromebook 11 and more)
+      - description: Google Jaq (Haier Chromebook 11 and more w/ uSD)
         items:
           - const: google,veyron-jaq-rev5
           - const: google,veyron-jaq-rev4
@@ -206,6 +206,17 @@ properties:
           - const: google,veyron
           - const: rockchip,rk3288
 
+      - description: Google Mighty (Haier Chromebook 11 and more w/ SD)
+        items:
+          - const: google,veyron-mighty-rev5
+          - const: google,veyron-mighty-rev4
+          - const: google,veyron-mighty-rev3
+          - const: google,veyron-mighty-rev2
+          - const: google,veyron-mighty-rev1
+          - const: google,veyron-mighty
+          - const: google,veyron
+          - const: rockchip,rk3288
+
       - description: Google Minnie (Asus Chromebook Flip C100P)
         items:
           - const: google,veyron-minnie-rev4
-- 
2.21.0.392.gf8f6787159e-goog

