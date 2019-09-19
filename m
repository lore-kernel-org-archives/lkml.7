Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A422BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7101D21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WLLAVHKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392785AbfISV1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:27:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39982 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390655AbfISV1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:27:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so2188839pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eFwN6VQoIVgZTWyIrMDT1Z2HKm27mGWj9Z/avCv2WM=;
        b=WLLAVHKMkEqkBrDpAUPZfZ4ytCC0Dlr6FMIuwsZ9AN8V0mNiNaW0jkxD95BnZiHMxi
         qarYueI8ei+IBtKxRMpotJ2s/Mu7DyoZMkUqsJ9CNz7GgdKrLBlOwiDogELObnn2UHpR
         CGFCDa9DSeEbBcsNPanhYfWmTWJjwgz29GAMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eFwN6VQoIVgZTWyIrMDT1Z2HKm27mGWj9Z/avCv2WM=;
        b=h+8mgNm6QgcGkFYGis4ieVFyMHSMmCQTEKdWJckvYApvnAcLuH3TvehdzguQfT68Z0
         R3n4Jh4xPbpbKTY3ifbx4pulOTyrruebxwDQ+cHpiFvn6uFtGQ92gjmlCYEZh7LOZf1a
         r00MQ4T89c2OFfmFez4gIYATyI/hAinULJifUFobuvDd9sEINqoJ9gyM58cPnbUqSscq
         87ZI42sfwscJYWRtwSWZHCydMT92n/smID4+YmqYrNOEWfdVKYFfT73hjXt6dS5JUnpv
         6R+rmn0rO5T8L5+9aH6Xgmr1uMzQVxvXuQK+lV62WQaSCr7gyg+kRGlI38sy/GSdif+C
         G36A==
X-Gm-Message-State: APjAAAWUk6HS7j+FN/RcMkXeEEEBUSZUOi/MXpRqWCulA9MoYXs0zMR3
        vBFU7tLWWSNo4rQFioCo9znFww==
X-Google-Smtp-Source: APXvYqzUrqDmlhSeuD997w0UB8kD5+ZRkrKOf7RYGruGWm+SZRArLf5CFPjvg0kYdcqo1SOAwcQ1sQ==
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr12318381plr.277.1568928451427;
        Thu, 19 Sep 2019 14:27:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 197sm28584015pge.39.2019.09.19.14.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 14:27:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: Add cpu id to rk3288 efuse node
Date:   Thu, 19 Sep 2019 14:26:41 -0700
Message-Id: <20190919142611.1.I309434f00a2a9be71e4437991fe08abc12f06e2e@changeid>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just adds in another field of what's stored in the e-fuse on
rk3288.  Though I can't personally promise that every rk3288 out there
has the CPU ID stored in the eFuse at this location, there is some
evidence that it is correct:
- This matches what was in the Chrome OS 3.14 branch (see
  EFUSE_CHIP_UID_OFFSET and EFUSE_CHIP_UID_LEN) for rk3288.
- The upstream rk3399 dts file has this same data at the same offset
  and with the same length, indiciating that this is likely common for
  several modern Rockchip SoCs.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cc893e154fe5..415b48fc3ce8 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1391,6 +1391,9 @@
 		clocks = <&cru PCLK_EFUSE256>;
 		clock-names = "pclk_efuse";
 
+		cpu_id: cpu-id@7 {
+			reg = <0x07 0x10>;
+		};
 		cpu_leakage: cpu_leakage@17 {
 			reg = <0x17 0x1>;
 		};
-- 
2.23.0.351.gc4317032e6-goog

