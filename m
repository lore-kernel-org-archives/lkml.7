Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6335C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD67C2241E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B5Aknp7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKSS6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:58:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44391 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfKSS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:58:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so12621933pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9nqNj4GquRt57X05X0WfujOjp8Op8DDDIt0VSOi728=;
        b=B5Aknp7zhIjV0TcCd1gLIqTsG/ZVJD82Lg7Z/gRutcByoB8/oqLjqupp9e6X2p5Jxf
         aB0E8gdat11VgjQqhbLO67MdbwQMV4wAjmoSxtqFtSwrFk+d4isJg5ifHKdyEEgkz0vA
         h2pt7HFkU7mu2TYP+7VjwgRGlL9lc59AzLURM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9nqNj4GquRt57X05X0WfujOjp8Op8DDDIt0VSOi728=;
        b=fGQrBrBZOV4+Eh95wE7XfHUjle9pof8ouLm2IAYDSqmQRIHBVFTnpXqOWTsqzLcn/M
         8Lj1d9+NSKxOMbWE84X5Ik3gdF7vSHhk2AaZPUekz/GDgoo21krqFlsNQAe+GKysJaYc
         GuD+KnVNqRLGw4nPLEzQbIE4OeOcgEoZL8ojFOUNGRDJcQOvizGFhSDH5cB8H7wUpt2K
         ghVhwTW5uS7lgXyjWbXFWK2Lo1u0DruWbHLgDO7PD7xJ5Fiu4hl/5wX5NYKHFqE+x5P8
         oZDTTYdiXSHueIDBz55OMZ1yLwW/qW2wfV6QBc9lZfanoPAfBc0C9qf1zX+VyguorJ+u
         mmUA==
X-Gm-Message-State: APjAAAUPS26UfuVOY/TknCwQqLHbSM5wzPNMTCge2W8jc6LfJ1AIpTKg
        nQFUDXNJ8AM5+1O+r2yFD2rcBA==
X-Google-Smtp-Source: APXvYqw86InbWs2GTOT0dpGYsI8/Ms3OejAuSyTvrx28igz5AHPOGWioboph+YitaeLi2+JazgTLJw==
X-Received: by 2002:a65:4907:: with SMTP id p7mr7125684pgs.327.1574189910148;
        Tue, 19 Nov 2019 10:58:30 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id y24sm28017581pfr.116.2019.11.19.10.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:58:29 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add libretech for roc-pc binding
Date:   Wed, 20 Nov 2019 00:28:16 +0530
Message-Id: <20191119185817.11216-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though the ROC-PC is manufactured by firefly, it is co-designed
by libretch like other Libretech computer boards from allwinner,
amlogic does.

It is always meaningful to keep maintain those vendors who are
part of design participation, so add libretech roc-pc compatible
with existing binding.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index f7470ed1e17d..45728fd22af8 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -100,6 +100,7 @@ properties:
       - description: Firefly ROC-RK3399-PC
         items:
           - enum:
+              - libretech,roc-rk3399-pc
               - firefly,roc-rk3399-pc
               - firefly,roc-rk3399-pc-mezzanine
           - const: rockchip,rk3399
-- 
2.18.0.321.gffc6fa0e3

