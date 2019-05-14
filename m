Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE2C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A7220881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RnM/VQ6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfENUlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:41:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45493 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfENUk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:40:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so130171pgi.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNtuY5Z+cYvoyqselos2LWUUlqGVhq3oEuLlC6NFZj4=;
        b=RnM/VQ6mE0T6Xe8fFsgAvxrMJCHhOpkmsjc03a2XttI/CGU4if1QQOm7wM771FpRhO
         0XooNeg9dFS5j+n21e4CEPdUNxw/VK/0lFAwv6bG1z2ez2tVm1+QMK640BiCq4PbsinQ
         vj4kU2bBm7sydIOtsDcnzq3V25Kt/Ep4RXiTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNtuY5Z+cYvoyqselos2LWUUlqGVhq3oEuLlC6NFZj4=;
        b=giKxWOYxx/IdfvJEr3ehOnbBvqJdZxTeQ0s/EUGG2u6nvxFR6ASeo+HZFJPL2C5XTn
         ++CoJeYSh6Oh510VhMVprFP6LB0an21+WhA3oknaIiP4AJ8n2gUujNj5ao1QAAPAFEym
         DQRib6xU7f5buuT/O3qMtR5hvWARwBHqh11COxwF9t45d1DFxZ7INmDqKB3WUEBkgkWh
         b9h3n5ZP2Tcv5Nik5UIuROiqK4reqXNQ9LvyaCS27dHuDiC5s44+qdRgucWRmlaTzO/w
         pqMNLoUqluTfCftvLk6izFkBUpZlo/LL3xbhnsdmLHRiWarMWWnWTuh2pQYgkH+r5+Su
         n5OA==
X-Gm-Message-State: APjAAAW7vpVLxPNDTFY2rAqedEhpPXwlpGUS69UORbVytifLV2LG3Y6e
        KRZdpDCqozLVk+/GTPTFyr+DDg==
X-Google-Smtp-Source: APXvYqz9c4Fas9ZYbM03192T2GnA0wnnUJXeGMcnMrr0nbuGVkx1q0hKUyWdEvtj5DHHEeXpQZ4s4g==
X-Received: by 2002:a63:314a:: with SMTP id x71mr40085284pgx.385.1557866455694;
        Tue, 14 May 2019 13:40:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p2sm2137pfi.73.2019.05.14.13.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 13:40:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2 1/3] dt-bindings: Remove Linuxisms from common-properties binding
Date:   Tue, 14 May 2019 13:40:51 -0700
Message-Id: <20190514204053.124122-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190514204053.124122-1-swboyd@chromium.org>
References: <20190514204053.124122-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't reference Linux kernel functions or Linux itself in proper
bindings. It's OK to reference functions in the kernel when explaining
examples, but otherwise we shouldn't reference functions to describe
what the binding means.

Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../devicetree/bindings/common-properties.txt   | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
index a3448bfa1c82..98a28130e100 100644
--- a/Documentation/devicetree/bindings/common-properties.txt
+++ b/Documentation/devicetree/bindings/common-properties.txt
@@ -5,30 +5,29 @@ Endianness
 ----------
 
 The Devicetree Specification does not define any properties related to hardware
-byteswapping, but endianness issues show up frequently in porting Linux to
+byte swapping, but endianness issues show up frequently in porting drivers to
 different machine types.  This document attempts to provide a consistent
-way of handling byteswapping across drivers.
+way of handling byte swapping across drivers.
 
 Optional properties:
  - big-endian: Boolean; force big endian register accesses
    unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
-   know the peripheral always needs to be accessed in BE mode.
+   know the peripheral always needs to be accessed in big endian (BE) mode.
  - little-endian: Boolean; force little endian register accesses
    unconditionally (e.g. readl/writel).  Use this if you know the
-   peripheral always needs to be accessed in LE mode.
+   peripheral always needs to be accessed in little endian (LE) mode.
  - native-endian: Boolean; always use register accesses matched to the
    endianness of the kernel binary (e.g. LE vmlinux -> readl/writel,
-   BE vmlinux -> ioread32be/iowrite32be).  In this case no byteswaps
+   BE vmlinux -> ioread32be/iowrite32be).  In this case no byte swaps
    will ever be performed.  Use this if the hardware "self-adjusts"
    register endianness based on the CPU's configured endianness.
 
 If a binding supports these properties, then the binding should also
 specify the default behavior if none of these properties are present.
 In such cases, little-endian is the preferred default, but it is not
-a requirement.  The of_device_is_big_endian() and of_fdt_is_big_endian()
-helper functions do assume that little-endian is the default, because
-most existing (PCI-based) drivers implicitly default to LE by using
-readl/writel for MMIO accesses.
+a requirement.  Some implementations assume that little-endian is
+the default, because most existing (PCI-based) drivers implicitly
+default to LE for their MMIO accesses.
 
 Examples:
 Scenario 1 : CPU in LE mode & device in LE mode.
-- 
Sent by a computer through tubes

