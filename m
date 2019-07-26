Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B4CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28B42238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mUsF1imL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfGZMqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:46:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46971 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGZMqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:46:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so54295321wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLxaMsYCZ3/jXkIVQkw/a8MrmWzCu04lpfPSyYLHWrs=;
        b=mUsF1imLERCFTkg2/Uzs7hmT38m2Kw7AJTfPDinEzNaaUZiuZV0l7wgIMCBRiIpBLB
         sA2L6wbnAkNjgyxnvt+9CUZas/y2tN3c+yW9Z/i0K7FMw8zz3ahtIQ92Uc0Cq6vWSNLW
         b9iiTR5A8Nj+kKSFXN4cp60DhKL8YPrrTBsjy2J73V2t/u15peL4eIha+TsgPDuiMVqX
         R09H5zAiMSUYAAQp+OJQo5RAcr+JIVtweRBbU5unW8uZIaYHUdvP2ANTxyy3VlJFZ94a
         VPttMRsEIV69Jbf0DBp5gHwDaBz8ET5XSc1LefOqoVZFYXZ3XRW9z1IFjgCVwUcGHSUM
         Rb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLxaMsYCZ3/jXkIVQkw/a8MrmWzCu04lpfPSyYLHWrs=;
        b=kv0HYaY7zh0mzZMrUczB7hqYERGMY0DVySrteOgy5Fxyv6xagvMylm0K/1RkeOYzUU
         PFwJwjdDHnVtUnJkynN+xn8Vf/NZGOk7GdzKL7436zifmcaZjYpMe/xcx6Xmalkn7fzQ
         WSzX9Aw1tglSGlK/qmOWzlcPFUiKZci2JozJq+M6DovMYFJTWYhyL1PtYlWNdgN+hcUP
         V3kSuvngLiUQm81KrGILxKbxe+jhrA8G1QsMdJpECBsGGVge1UWlfOOLxXYAAn0GiHJQ
         bKWrLbrzKHQhx3+DYDbt+2uAJ5QXtQU/0jy3VcwVQxltm4+dx3TFDshi0oRZOHUtaaW0
         m3rg==
X-Gm-Message-State: APjAAAW1LDnP+Rs1WNhDVFVhXUnvLPepRF4Z1Cc5Pbum/V9aaku3H77P
        Zz8Kgyko5lhO0KuhdPuTTjpuzy/tce0=
X-Google-Smtp-Source: APXvYqxm1YKS+4DrGIxchn3QR4y65WJgjEHqXNZSjIdrgVVETjxtNhl4GAnKHur+0BraxsIAcY0zmA==
X-Received: by 2002:adf:fb8e:: with SMTP id a14mr7232715wrr.263.1564145208209;
        Fri, 26 Jul 2019 05:46:48 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id x16sm39090124wmj.4.2019.07.26.05.46.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 05:46:47 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: meson: add the video decoder nodes
Date:   Fri, 26 Jul 2019 14:46:36 +0200
Message-Id: <20190726124639.7713-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the dts nodes for the Amlogic video decoder for the
GXBB (S905), GXL (S905X) and GXM (S912) SoCs.

It also includes two misc. fixes for the bindings documentation:
a missing generic compatible and changing the example node's type
to something more conventional.

Maxime Jourdan (3):
  dt-bindings: media: amlogic,vdec: add default compatible
  arm64: dts: meson-gx: add video decoder entry
  arm64: dts: meson: add video decoder entries

 .../devicetree/bindings/media/amlogic,vdec.txt     |  5 +++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 14 ++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 11 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 11 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |  4 ++++
 5 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.22.0

