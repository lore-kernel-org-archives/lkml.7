Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E868C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC892067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QeLmVu2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfGONnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:43:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46381 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfGONnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:43:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so11552765qkm.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=acQPukXBvJBOs+Csp0bFQoolQgtDonf3OOjuV7K26cg=;
        b=QeLmVu2Ec51StMehpBdqKOJcnc6809a0Te+oZDlReyMcQ2425Mn0AOFLE+qo8qe0SH
         pIxNBk0iiouIk9w9HzQDSQZ/hBwn0DaoOA8Og8Ud4c+f7Z52fFP86cGKWR6pUwnF2pWN
         iw09VXz+M4RzW9vAWjUOcR5OMTl8OiQo/ODo2zkGBDDqC0ZQQRQ2Y7HF/+xixGVnyOK9
         qIbyU4jBa+UHKQh0Fze50N9G5ovvFRGlfuUT6AbLFPJTy9XAD/NLGdX5GuALxypgs/Ug
         Nvqbef8NON8FPuaVLwfFj6rRfEL+wwo1gAiuO+2JEs1EE3+nTAO0h0KqQT/ie5lGJ6YP
         /Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=acQPukXBvJBOs+Csp0bFQoolQgtDonf3OOjuV7K26cg=;
        b=tFNRvYcj+I43H4AhKr9Kbag93bogHaBDOpWRkskHr8aJKcOcuM8LVQAM9fwD83mJ/A
         9UOBVfCnwHFXMRrCH1slo2SvcpYDiY79E/HYgjZCu/XMbG76p+ohjeBiUENWuZaoaLrp
         GJVnessgNlmBgmYGdqkjeC+OlbF/zvnfneozhyoO3/xQc+QNP6yCg40nqwvXnJCgeubr
         P0HAmnhhH/aVpFC2o25N/Zr/rBmA8ZrJsE+bt8h6oarP4RtxH3ATakfGhIQm0c+6zZyx
         z9DpuxBs7kDv4cjIqwuWfoKBJ67bEYydKB7H21ngpBxiqHs0dNcMEJK3BRLqxUMnOrbi
         8ZjA==
X-Gm-Message-State: APjAAAVCbEU07SjQHZXVPRhgcjVO+wOBby1bIUFGV3kAleensNzzt9oG
        4z30XyvdtSXsvzpzVL9x0rnx3g==
X-Google-Smtp-Source: APXvYqzvUmAodjBwJQuKPzE2kilUHmZpzOUfF0Z9D+86p7J2KP5R2wAj5e1shFThrzBlDC1/gmrr2g==
X-Received: by 2002:a37:a010:: with SMTP id j16mr17159282qke.152.1563198191721;
        Mon, 15 Jul 2019 06:43:11 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s11sm7571874qkm.51.2019.07.15.06.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 06:43:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     emil.l.velikov@gmail.com
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] gpu/drm: fix a few kernel-doc "/**" mark warnings
Date:   Mon, 15 Jul 2019 09:42:53 -0400
Message-Id: <1563198173-7317-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark "/**" is reserved for kernel-doc comments, so
it will generate warnings for comments that are not kernel-doc with
"make W=1". For example,

drivers/gpu/drm/drm_memory.c:2: warning: Cannot understand  * \file
drm_memory.c

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/gpu/drm/drm_agpsupport.c  | 2 +-
 drivers/gpu/drm/drm_dma.c         | 2 +-
 drivers/gpu/drm/drm_legacy_misc.c | 2 +-
 drivers/gpu/drm/drm_lock.c        | 2 +-
 drivers/gpu/drm/drm_memory.c      | 2 +-
 drivers/gpu/drm/drm_scatter.c     | 2 +-
 drivers/gpu/drm/drm_vm.c          | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_agpsupport.c b/drivers/gpu/drm/drm_agpsupport.c
index 40fba1c04dfc..ef549c95b0b9 100644
--- a/drivers/gpu/drm/drm_agpsupport.c
+++ b/drivers/gpu/drm/drm_agpsupport.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file drm_agpsupport.c
  * DRM support for AGP/GART backend
  *
diff --git a/drivers/gpu/drm/drm_dma.c b/drivers/gpu/drm/drm_dma.c
index 3f83e2ca80ad..cbfaa2eaab00 100644
--- a/drivers/gpu/drm/drm_dma.c
+++ b/drivers/gpu/drm/drm_dma.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file drm_dma.c
  * DMA IOCTL and function support
  *
diff --git a/drivers/gpu/drm/drm_legacy_misc.c b/drivers/gpu/drm/drm_legacy_misc.c
index 2fe786839ca8..745eb9939414 100644
--- a/drivers/gpu/drm/drm_legacy_misc.c
+++ b/drivers/gpu/drm/drm_legacy_misc.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file drm_legacy_misc.c
  * Misc legacy support functions.
  *
diff --git a/drivers/gpu/drm/drm_lock.c b/drivers/gpu/drm/drm_lock.c
index b70058e77a28..2610bff3d539 100644
--- a/drivers/gpu/drm/drm_lock.c
+++ b/drivers/gpu/drm/drm_lock.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file drm_lock.c
  * IOCTLs for locking
  *
diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
index 132fef8ff1b6..d92f24c308a1 100644
--- a/drivers/gpu/drm/drm_memory.c
+++ b/drivers/gpu/drm/drm_memory.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file drm_memory.c
  * Memory management wrappers for DRM
  *
diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
index bb829a115fc6..b6d863699d0f 100644
--- a/drivers/gpu/drm/drm_scatter.c
+++ b/drivers/gpu/drm/drm_scatter.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file drm_scatter.c
  * IOCTLs to manage scatter/gather memory
  *
diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index 10cf83d569e1..6c74c68f192a 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file drm_vm.c
  * Memory mapping for DRM
  *
-- 
1.8.3.1

