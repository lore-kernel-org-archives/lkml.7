Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1780214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq1t8QPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfDHPZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:25:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35415 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfDHPYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:24:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so15221147wmd.0;
        Mon, 08 Apr 2019 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gehye2PBes+2WkveZsU+3KMZWypo81Tcgj6ag1K6XNQ=;
        b=Hq1t8QPw5OTbadRhohueQvEkpfuwBU4fXsW/4+MF9KzPsY9RRP16nevSiy/cnZcaL3
         0iX+e9j/4S6ZK94Cn5u9ju7Fo2yU/bhA6GWW58GVbbdTzgIW3cRbNCndRBV8YkdzXtf+
         4x3VFeB44d3DNCXbPIQc9B677LPQzfAov5/CyvRJM7vB1A3Yg09efRuDmuO7UXTTI3wV
         X5dXOig/lzS+rDzc97HY//zFSJMqJtrbdm0OM5usilWZHI6kEmhISxYRVklzNN7Th9a4
         sKg3zIsMJpZv0/Gx4i88Ryisyl0flhL23/oulFw9TmDKOyJ6HEQkFbFV/hVKwzePNm7l
         7hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gehye2PBes+2WkveZsU+3KMZWypo81Tcgj6ag1K6XNQ=;
        b=Yfzk02UAuDxYsBrYY2pbx5mrIu+NskFExF0dgAvpN0AbMnl0AJ1shrzpPgkRxh0Tju
         BTyK0ixclVKQhnLm49CAmNZfqnS6lPwEuryixyd4SAOeV8mVMzTpSVOcyznp/gKbGEGT
         ut6usVBoTENk7BqxBHEGhDxeWdzup6NaA3ktQ+dGrR6hwxZXln62IPxUDRuRjJ5+iemZ
         VwQtdcUYc7ygNiUHK//WqcoWbPmnv9TRHDfvKR1vutIyms8Cx0qXX0I2zn2bNyPuo0ya
         mDvxqKv44dlOZl1MsFvC8EStY8SZig6IX7Vh1+GaMLAESfs/O4QrSVPAULAIedTHHaC+
         dBJQ==
X-Gm-Message-State: APjAAAUukRJkZID/boSJp6UU+ntI5ryHIZVwVi1t78YcdG9W39hLhWrf
        /DPhL24g5viNKnAbcq2dC5wCHlx+y48=
X-Google-Smtp-Source: APXvYqy+pi9dHPevnmkiy9tcEFLNRbMG3iEodHYjBeNF7+9evll2XnjJbWSsV8/r1AkadoUpEAw3MA==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr17760643wmc.98.1554737076825;
        Mon, 08 Apr 2019 08:24:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id o12sm32137298wrx.92.2019.04.08.08.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:24:36 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 4/6] dt-bindings: arm: sunxi: Add Beelink GS1 board
Date:   Mon,  8 Apr 2019 17:27:53 +0200
Message-Id: <20190408152755.17405-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408152755.17405-1-peron.clem@gmail.com>
References: <20190408152755.17405-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 device-tree has been introduced.

Add it to the sunxi yaml documentation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 11563d3f7c65..9ab9b266881d 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -136,6 +136,11 @@ properties:
           - const: lemaker,bananapro
           - const: allwinner,sun7i-a20
 
+      - description: Beelink GS1
+        items:
+          - const: azw,beelink-gs1
+          - const: allwinner,sun50i-h6
+
       - description: Beelink X2
         items:
           - const: roofull,beelink-x2
-- 
2.17.1

