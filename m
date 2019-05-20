Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC00BC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE31206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bsJhe6lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfETToI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:44:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43636 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfETToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:44:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so15888971wro.10;
        Mon, 20 May 2019 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfGgUjPbd31Ss7/rk7zFjMjprcKV+dr6vtdFkBjPbQI=;
        b=bsJhe6lu0EYb7AiOJA9l8BMIFOl5jNy5IyVsIaknO+hu31Fe1Yr1nLSe9QxcSJxC2u
         rbbVXuvcvGdG65k0e82429secn1zvnv8zSjZTTahAInSylnGl0lnvn85EMHzmtQ93xZ1
         kMgmt/n0dWO8zPRN8qheK0OFFgpAn3AJRCqrCObu/5q7zvy8PTkvL5iLx7FGqupIafQV
         TiNq0sowj6PB4ZtsCUgCjg97m80pePy4uZQGnhCeZJXykq41/p/iVD9ntAMw3f9PR4+d
         iJTMgj/Xzrn4YCkUyqPfjrY//r7vpw1z3X0eBjUSqoOv7bAEFlMDGUjkE/0JmiL/3b0/
         0R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfGgUjPbd31Ss7/rk7zFjMjprcKV+dr6vtdFkBjPbQI=;
        b=QeqhSvmEGhjz7G5NpVknAz1v7u7H7XKf5HyZUcbdWMpJuf5WaTbLUuA4Q8eOj2LEif
         DjY26lrU3uc84PmwwjY0Lk5ke0lQtFRpM0aGbYuakJTAC3aQ1FtfSSH0mfjpIkrTA0UU
         RR+pLhaSIEh2UsNDxOB/li/2j8luLqwPxa0eo/OQs/VcpaUtqWlDCpqo3xU0zUs4lPlj
         oHSbZkYPsXN+osqfRX7OMZodKl4MpByf83frlAc3sLgajysbbNgyYbg0THmgZ2VB21cx
         InTOg5CYXLBfI8icn/UhQAYdHiMe8hMO+E9u3H8DEM2DMhvJSXrXCcitEK1Ad8xWH3lH
         N7Sw==
X-Gm-Message-State: APjAAAV7w0s1fARoLSbrYhGDfPpYOkHAwRaGNyoUKZkGB20x8aUeSZ0t
        nXaG4aSn5x3V7dbYhM6RFy8=
X-Google-Smtp-Source: APXvYqwx3+Y8miEK9uW+Hm0SSs+kVKPlWxA+6K/QvYcvrofGjMRU2+ZOFUp1ani97eRcr6KdL3GYOA==
X-Received: by 2002:adf:8385:: with SMTP id 5mr31213005wre.194.1558381444916;
        Mon, 20 May 2019 12:44:04 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id p8sm9135352wro.0.2019.05.20.12.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:44:04 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        mjourdan@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/5] dt-bindings: soc: amlogic: canvas: document support for Meson8/8b/8m2
Date:   Mon, 20 May 2019 21:43:49 +0200
Message-Id: <20190520194353.24445-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
References: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canvas IP on Meson8, Meson8b and Meson8m2 is similar to the one
found on GXBB and newer. The only known difference is that the older
SoCs cannot configure the "endianness".

Add a compatible string for each of the older SoCs to make sure we won't
be using unsupported features on these SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/soc/amlogic/amlogic,canvas.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
index 436d2106e80d..e876f3ce54f6 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
@@ -2,8 +2,8 @@ Amlogic Canvas
 ================================
 
 A canvas is a collection of metadata that describes a pixel buffer.
-Those metadata include: width, height, phyaddr, wrapping, block mode
-and endianness.
+Those metadata include: width, height, phyaddr, wrapping and block mode.
+Starting with GXBB the endianness can also be described.
 
 Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
 rather than use the phy addresses directly. For instance, this is the case for
@@ -18,7 +18,11 @@ Video Lookup Table
 --------------------------
 
 Required properties:
-- compatible: "amlogic,canvas"
+- compatible: has to be one of:
+		- "amlogic,meson8-canvas", "amlogic,canvas" on Meson8
+		- "amlogic,meson8b-canvas", "amlogic,canvas" on Meson8b
+		- "amlogic,meson8m2-canvas", "amlogic,canvas" on Meson8m2
+		- "amlogic,canvas" on GXBB and newer
 - reg: Base physical address and size of the canvas registers.
 
 Example:
-- 
2.21.0

