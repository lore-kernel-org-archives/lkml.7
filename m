Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B01C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E5C2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3pOoCaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfEPRZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:25:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45881 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfEPRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:25:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so1872739pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVl8ZXN8JPcw2xaHO9ZTYh60UwjcOeEd2LUYV6FNZrQ=;
        b=L3pOoCaQskb2Fga/dNWke/VSFUUQxbe+nfTUcxUrOmVHH+LzrUUfkyRywEz99Q4nL2
         m2F69hUS3UQsU1/UYxwbVPnwDiHlZv7R4hJ4RU5sRHW+Kb3kXCOs/SWFZz57Bb7K9hiQ
         cvV1dfJXk2iCJVks9ckJo5aM/Ys5drogaQYgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVl8ZXN8JPcw2xaHO9ZTYh60UwjcOeEd2LUYV6FNZrQ=;
        b=AXpDBzGhxeySHyD0Q/6eKR7iuoCMjzV53O73Q50J0SpVWtoIeoGBlo6IdL8/KN1obE
         D1mXqqjLUjGaveJjhQQ+oe5JjvDyFNqHpnU2YjNTFLiohLBQeeCon4hIsM0kiE/vN2NT
         VhnGfKNkwH2ChJQhYl1HGJqiCGXY25Rjc/cN2l7GTV+EXIf+FbOPbJeXeWjaes2pAT1C
         4PV4gBfJM5KTLVwNt+NHYtDYQN05GMc2C0Kcf9nZ+VDKe7CGQy5ikRoFPapd3CA0nYVX
         FdZCS9uADftIJHChX+tOKgyxxzI/9SZo0BULh7+lmVjJj/2kQA9lafBzGG2HjSbbqHn0
         YqJA==
X-Gm-Message-State: APjAAAVv6Bz81+3ZZrFZgoIQO6vjncO0QIkFDdFNuVebyYtX8AvyRbd1
        W94hqc1YNNqirSpdx2VYHz9tow==
X-Google-Smtp-Source: APXvYqwpj3INjdyCcYF7eLRtYgUqjMn2YOU0j2bY43pkolET6jRmQIrQb00jKgHVpRrRAInlDPe5xQ==
X-Received: by 2002:aa7:9afc:: with SMTP id y28mr55797961pfp.101.1558027515393;
        Thu, 16 May 2019 10:25:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k63sm9651260pfb.108.2019.05.16.10.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:25:14 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/3] dt-bindings: gpu: add #cooling-cells property to the ARM Mali Midgard GPU binding
Date:   Thu, 16 May 2019 10:25:08 -0700
Message-Id: <20190516172510.181473-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU can be used as a thermal cooling device, add an optional
'#cooling-cells' property.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to the series
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 18a2cde2e5f3..61fd41a20f99 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -37,6 +37,8 @@ Optional properties:
 - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
   for details.
 
+- #cooling-cells: Refer to Documentation/devicetree/bindings/thermal/thermal.txt
+  for details.
 
 Example for a Mali-T760:
 
@@ -51,6 +53,7 @@ gpu@ffa30000 {
 	mali-supply = <&vdd_gpu>;
 	operating-points-v2 = <&gpu_opp_table>;
 	power-domains = <&power RK3288_PD_GPU>;
+	#cooling-cells = <2>;
 };
 
 gpu_opp_table: opp_table0 {
-- 
2.21.0.1020.gf2820cf01a-goog

