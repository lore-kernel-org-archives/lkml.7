Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE109C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A7920863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BiN3c8JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCCUGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:06:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40814 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfCCUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:06:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so1412221pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IP7aU/m/G7YgvbwAtp24E5K5yq9iCPEVn37ukwFmkdg=;
        b=BiN3c8JYo8Ex8gwT60Tk1bB7yDlD12Da7d5GMVDYp3IhaXB7KhQJbvo14R0ipO8L2L
         l3hWRUIH9ci/cuTwloIsPcY+8x8WM74tB9RMW3GYtaAMUks20WjfCc8LcrNqNjcBX+B7
         Ic0uUsOE4Ual+QmRMPA3HKCmZFalvbZwhs37Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IP7aU/m/G7YgvbwAtp24E5K5yq9iCPEVn37ukwFmkdg=;
        b=KIv+4ZPnIAmQ9Ki05Tr/gfPexPtxFlRgjBrZgx5H1qSV2eamNdBkpLixies6gRmqhQ
         kN+9oOrRQjaQYl5MrLmX8Go7exPV7YI1yfOdbA9H3jCIO+9LoITR7f/rIWkiO+WK2Vhm
         ttVYfUHECoZDaz9GVeZb0+kq3EW5g5K9r5KrhYEj9Ol4suN5G7Vdlw7HdeegHVEs7DAM
         Gyx9wXsYo1d1boMGCKwYX6KO7xfeHOJQRl78QTEZw0nvNG2WTTWLhUEKAipVW68inDor
         HByfkmiqc49Bm+7CMbPpUZj2DJwHMKNcNzFrW/6AvoEnqZSlkv/Lphn+ZfLoDLSFQiZv
         FLwA==
X-Gm-Message-State: AHQUAuY0I+JWJAsWjAplqYDa4zYWnIkqUBxD+WDfIazxcoDU07hS6hQ8
        oxingJBV/xwgMqXIeiQKYLaBjw==
X-Google-Smtp-Source: AHgI3Iahpw/IgsZ6IQZOIPjXYt1Z46XYwEJJI6KHxpYSqptB8gyWyn9bHMyiLPx2PFsN3GxbayN/GQ==
X-Received: by 2002:a62:20c9:: with SMTP id m70mr16316893pfj.118.1551643608188;
        Sun, 03 Mar 2019 12:06:48 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id j14sm5654021pfn.77.2019.03.03.12.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:06:47 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/4] dt-bindings: Add vendor prefix for novatek
Date:   Mon,  4 Mar 2019 01:36:15 +0530
Message-Id: <20190303200618.17581-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303200618.17581-1-jagan@amarulasolutions.com>
References: <20190303200618.17581-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for novatek.

Novatek Microelectronics Corp. is a leading fabless chip design
company specializing in the design, development and sales of a
wide range of display driver ICs & SoC solutions.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4f225ce815d8..87d556472729 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -274,6 +274,7 @@ nintendo	Nintendo
 nlt	NLT Technologies, Ltd.
 nokia	Nokia
 nordic	Nordic Semiconductor
+novatek	Novatek Microelectronics Corp.
 nutsboard	NutsBoard
 nuvoton	Nuvoton Technology Corporation
 nvd	New Vision Display
-- 
2.18.0.321.gffc6fa0e3

