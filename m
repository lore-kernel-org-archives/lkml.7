Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B442DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821C12177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hlUabI8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfCMOKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:10:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42442 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfCMOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:10:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id o9so2159445wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4nXgViyzuKQACrEZaNMM73FqiobqxCzIwcWecm5Iy4=;
        b=hlUabI8gmFDGOfYBqEjnmf4/vk7HjZh4b9io6tE4KhLVywEoHOXMeTa/32P2UacK0O
         xgO07vGi+pPRpk8Oj96cfRr1StIai5DzguUtdGglpFsAh5C5xk4VJvs3NrFx50+Cgx1j
         CJdNaD0gZ9FKnpoM2hbTRI0bJWlQWZZ28wvJ36fy9nctmccWTcgtoKEyFLrjhlgJzZyx
         R0uEM6EA3U5HMuI60HcqpigZuPhlwRDYVaPT1lOpYafH8YCLwch8hBOaqGX307L5n80p
         3ERUfDV48YDajop4s2YDI+UK//HBQ1cxV6fLUvZzU+kSHYjiD94vUTBMiWwG6ogXE17n
         /4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4nXgViyzuKQACrEZaNMM73FqiobqxCzIwcWecm5Iy4=;
        b=A4Vnk0iea2+xS9OMOhMYRh8YpcU25pm7jvqPK/VLvuBLrjCrONYN2lYlkizJGBbjvL
         tSC5jo0Tf5BuemHDWv7e3zWrVxwlVDVGxEl7dwQ/jd40hIqvD21ljbSBv1jCdu+BGV50
         FOA0+Z3TdYNev00yDr0fjLiRom6vg8O9p8QDJbb0Joyu8dd8RSGAuiwm4uAYUAphd/2l
         +oNlfAk38OYIvjNXcjbRbkFhoPNEZ3tbDM5Nu1eZkOTgYt5++hQmrI7f4wNRu0pbaazQ
         B/Yz4Gd/lgGwu9oNMHMC/Uxj9HQKmj3jglJrvYvbqAeX1PxLBq3NA5vcFDvSfB2yj9Lf
         I0OA==
X-Gm-Message-State: APjAAAWqOrd8yEscFNJ3z5AL3dvPv2HHDxu0wdK7N9mUK22UTHZgUt9O
        jL2yB2FflDTqiE0skRR7l7+PkA==
X-Google-Smtp-Source: APXvYqwn1v7HjzKEm6XvEQQ08cgKKDFOkMaSpnkmgH7w7Ji8jS4tP5LEAjU4vb2IZNippocLsUGX7Q==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr28593189wrn.276.1552486235928;
        Wed, 13 Mar 2019 07:10:35 -0700 (PDT)
Received: from localhost.localdomain (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u17sm37300087wrg.71.2019.03.13.07.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 07:10:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: display: amlogic,meson-dw-hdmi: Add G12A compatible and ports
Date:   Wed, 13 Mar 2019 15:10:29 +0100
Message-Id: <20190313141030.5958-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313141030.5958-1-narmstrong@baylibre.com>
References: <20190313141030.5958-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoC has a slighly modified DW-HDMI Glue with
support for HDMI 2.1 and a different DW-HDMI register access.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.txt     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
index bf4a18047309..3a50a7862cf3 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
@@ -37,6 +37,7 @@ Required properties:
 	- GXL (S905X, S905D) : "amlogic,meson-gxl-dw-hdmi"
 	- GXM (S912) : "amlogic,meson-gxm-dw-hdmi"
 	followed by the common "amlogic,meson-gx-dw-hdmi"
+	- G12A (S905X2, S905Y2, S905D2) : "amlogic,meson-g12a-dw-hdmi"
 - reg: Physical base address and length of the controller's registers.
 - interrupts: The HDMI interrupt number
 - clocks, clock-names : must have the phandles to the HDMI iahb and isfr clocks,
@@ -66,6 +67,9 @@ corresponding to each HDMI output and input.
  S905X (GXL)	VENC Input	TMDS Output
  S905D (GXL)	VENC Input	TMDS Output
  S912 (GXM)	VENC Input	TMDS Output
+ S905X2 (G12A)	VENC Input	TMDS Output
+ S905Y2 (G12A)	VENC Input	TMDS Output
+ S905D2 (G12A)	VENC Input	TMDS Output
 
 Example:
 
-- 
2.20.1

