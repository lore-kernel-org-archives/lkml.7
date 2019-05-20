Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C6C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6358120815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="r7FvqZFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbfETJH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:07:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40383 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfETJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:07:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so6485607pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RhhbywtZgL9mTL+/aS2gTie5gz+AOsOECX4GcmEvNm8=;
        b=r7FvqZFw/gu/2n+1603wdn3ygdOPws+IPKmHzr+7ytlLH74FqNbxJXLgMSH0OHamIK
         1GA+Ua3+oxWE9TzHS9ArZ45MeQ3PutdmMb9mtkP1VwHF58tBHnNJdJzASpUAarmrwcbt
         hejMLtxkulq1eWgonL7tep/ehNu3uSZ2CB6PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RhhbywtZgL9mTL+/aS2gTie5gz+AOsOECX4GcmEvNm8=;
        b=FRbMjBoUYX/dDXPTUCK6cphbne65fnFeGyrUDotIewC5NUTZdhrgguw6dR1WRBcYRk
         16nzphyQqGbXO+X0irtezjeIjziGdshXHsHbkwfAvGGgQ8TvyEnX9sN/SpzuZGC5C7k2
         6qA7K9eeA0+I64oKCdsWwTbtEaniZ3HjjV32Bn16FQvyBSBsmnqtPRPgoljbYEhE5pDM
         sJ1kHgxdFq4r40HCql0Ybu3wTWXJV+279CLFyPdm55ZGe6fl7iuKhxIStDuHD57La9Xx
         IVG9/lDkwztwrqiABn12i3p6Oj+NFPqtay/2QjL11UdHsIfy6HK1KUrmVvP2MZNVFYSv
         +Czg==
X-Gm-Message-State: APjAAAWrh90dVC2M8Ob5Zldq9pJSmKFbxdyOkX5PIDuh5lPYVpoOMhtg
        sx369v6WNslz0GKgMgWdu+g9oA==
X-Google-Smtp-Source: APXvYqz34UXPxRhzfdNer7tUP6i29zQxwtYM7NMLCp3pv/rNH5nWYiFi2u+2vMjGcD+MakpaE3MtkA==
X-Received: by 2002:a63:1150:: with SMTP id 16mr74722565pgr.40.1558343274409;
        Mon, 20 May 2019 02:07:54 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:07:53 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 08/11] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
Date:   Mon, 20 May 2019 14:33:15 +0530
Message-Id: <20190520090318.27570-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner MIPI DSI controllers are supplied with SoC DSI
power rails via VCC-DSI pin.

Some board still work without supplying this but give more
faith on datasheet and hardware schematics and document this
supply property in required property list.

Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 6a6cf5de08b0..1cc40663b7a2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -21,6 +21,7 @@ Required properties:
   - phys: phandle to the D-PHY
   - phy-names: must be "dphy"
   - resets: phandle to the reset controller driving the encoder
+  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
 
   - ports: A ports node with endpoint definitions as defined in
     Documentation/devicetree/bindings/media/video-interfaces.txt. The
-- 
2.18.0.321.gffc6fa0e3

