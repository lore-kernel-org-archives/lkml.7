Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EB6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDDA206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DT5flpFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCKKvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:51:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34073 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfCKKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:51:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id f14so4525791wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/qPZJ9y7I83wmDLxVKAEdGxN22MAvtf/M0ZxQoUgaFI=;
        b=DT5flpFw57egQ5UUul7uBSZaXmDq28HIBP+nnDSeL6yfseI8bJNPZl9lUN/husao6i
         TMKWFhosDHAUsVtLZalThSjSXd23rFwsIfw1sgmFdn+0Qdj6cKIXlIvO2IC/UPk3t5eE
         6fPsZZf0ZUN/uFNoXAZbR19iI2XcFAzFvojs0EzGzxIFrM5xTfAz8ZZggqmntDwIDG1t
         aw6TlCBkMv12Uqh+uo5ZN7BwoDcJKnqqRbH4TCYpr62Kz9WZsnQ5sPBltfrTzT05q88K
         ueiNN1+GXG9mlV/if5YnBnA22AQLFyagfo7hh7uHSs4E//TqbRyQwaXgnfU8ns6cyRfj
         m9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qPZJ9y7I83wmDLxVKAEdGxN22MAvtf/M0ZxQoUgaFI=;
        b=nVhg/YySKGr2bUOlBCU+TI4/Lx6+YksmxLWNSCzy7qySScMYmATW/LfCdZDUmrbb8z
         R7OLXkj7HX01yQ/gV92T1rSopB4UDnomg7dfebaT7V2zYdTeXM7hSXcKDls5O6vGa7DB
         YslNRoJOS10vceQl/AjouEJg4qAH9dmCvIrcl5ZpX/fDAHoZ5gpb696gb8iuhe3dN31u
         gUxnrAXZSonWcytU0ybIB4ivC7E4oFuc6iAE+96yckQC9DHY8Hu7q79m2/tr+I4fr8IC
         X08MimS5aoAuQvtYfy5y4TIFLAHOACycMWQlut0u0LJoRkAwuwtQILCwUI/j5Az/p7Ws
         YvIw==
X-Gm-Message-State: APjAAAXPLvrGBZlbHUJqp8yqiLIsajoBg1rfVwn6F4HDHfOWIhB6o/rG
        fCETGVx0+TMfE2aFOZavPZQ9sg==
X-Google-Smtp-Source: APXvYqxFU9h0O2eocnzVNl5VKam3j7xcr9ndLKPHrimBVP7g+5gE7CP8S0LRSCDuJXHWaTiW+qYg/g==
X-Received: by 2002:adf:db44:: with SMTP id f4mr2841183wrj.31.1552301511727;
        Mon, 11 Mar 2019 03:51:51 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id c21sm6902640wre.35.2019.03.11.03.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 03:51:51 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] dt-bindings: display: amlogic, meson-vpu: exclusively use amlogic,canvas
Date:   Mon, 11 Mar 2019 11:51:43 +0100
Message-Id: <20190311105144.7276-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190311105144.7276-1-mjourdan@baylibre.com>
References: <20190311105144.7276-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the DRM driver for the meson platform was created, the bindings
required that the DMC register region was provided.

Through those DMC registers, the display driver could configure an IP
called "canvas", a video lookup table used by the display IP.

It was later discovered that "canvas" is actually an IP shared by other
components than display: video decoder, 2D engine.. and that it wasn't
possible to keep the canvas code in DRM.

Over the past few months, incremental efforts have been deployed to
create a standalone meson-canvas driver [1], and the DRM driver was
patched to optionally use it if present [2].

This is the final step of those efforts where we simply remove any
control over DMC that the meson DRM driver has.

Please note that this breaks compatibility with older DTs that only
provide the DMC register range but not the amlogic,canvas node.

[1] https://patchwork.kernel.org/cover/10573771/
[2] https://patchwork.freedesktop.org/series/52076/

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../devicetree/bindings/display/amlogic,meson-vpu.txt        | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
index c65fd7a7467c..419444e2b4d3 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
@@ -60,15 +60,14 @@ Required properties:
 - reg: base address and size of he following memory-mapped regions :
 	- vpu
 	- hhi
-	- dmc
 - reg-names: should contain the names of the previous memory regions
 - interrupts: should contain the VENC Vsync interrupt number
+- amlogic,canvas: phandle to canvas provider node as described in the file
+	../soc/amlogic/amlogic,canvas.txt
 
 Optional properties:
 - power-domains: Optional phandle to associated power domain as described in
 	the file ../power/power_domain.txt
-- amlogic,canvas: phandle to canvas provider node as described in the file
-	../soc/amlogic/amlogic,canvas.txt
 
 Required nodes:
 
-- 
2.21.0

