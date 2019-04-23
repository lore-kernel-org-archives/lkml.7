Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669ADC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3302E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4u5ppLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfDWMcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:32:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39014 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:32:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so13344080ljg.6;
        Tue, 23 Apr 2019 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y21hx1+ZWcM1GMPqrCOpWwNweQmqFuIM89y/n/Gh9Ow=;
        b=S4u5ppLECCr0x9IXYQD11GdI8OH47geK+mtaxNFDeD3+TEJwR1O+2cwsustuadremf
         +bXUVdIvQbtS0wEj/s/xOyIMEhYABbtHZpa7OVBcH2a5r5sA4sjSo8UkYazSiXWr11yd
         twR/NxaPJE+8k1BPM85J3NrazyKgwzSd1rsc+h4TZswD45nA+GI6LGVL67JdnK+ijgW5
         IusRrv6BCi0XarrxyfJQj+3HeRmnPoX5TtKj/11Lg4o8Dv3YhD+qD2x1d76xvBhPSJUF
         xmyQv8Dl8mmRS4lsdcXWHtuVFA0f3e5AaC5HL13DZUkmCTAHEn8A9rL9lm+0wjPoHuI0
         hz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y21hx1+ZWcM1GMPqrCOpWwNweQmqFuIM89y/n/Gh9Ow=;
        b=aixC45ERMa+596iDFkhcNVsHv1Wim8+kQTihejDVJvUrzthUbMkkZrGarg7lOQkhnP
         XtDtOrADI1a9oPTek1dMLb5Gg5eZQJglhl1iVuh7F6F/bP1CbtHQL2Djs9JLHZXM5vDj
         5W5NuK+UxihyxzZgIcD530K+b2Q0VW/tkqKPLbYuJcN1t5CaZsGFujZ2BE1P++PTdreD
         RTCUkrQDu5xhYsxrzaoioxCAzDeg1xlWqSj3dc3YOUg+pSYUISGHBE+26iiVQu6wN6Hj
         wUo4RMM33bQJ8LdqHPjSg3hJPFvvz41vF6aQCp3BB/xrArF7g7YFVXKES1VqE2+6BV9u
         sbqg==
X-Gm-Message-State: APjAAAWRzKM3A0oL8P6weTB6k6J/CLkhux6FZzY59Tlv2fvHlCJlbk2z
        JRb0sB8/lJTzODDQSL7lSj8=
X-Google-Smtp-Source: APXvYqwT7KYuVtbEI6VGDs8eFTLw6lPj/3oCH6V/sPC5Lzt06f80AVqoaTC2lcP3rnGYgU3y9gmNLw==
X-Received: by 2002:a2e:9915:: with SMTP id v21mr13796464lji.154.1556022736711;
        Tue, 23 Apr 2019 05:32:16 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id l15sm3344379ljh.62.2019.04.23.05.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 05:32:15 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "Vadim V . Vlasov" <vadim.vlasov@t-platforms.ru>
Subject: [PATCH] drm: Permit video-buffers writecombine mapping for MIPS
Date:   Tue, 23 Apr 2019 15:31:22 +0300
Message-Id: <20190423123122.32573-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4b050ba7a66c ("MIPS: pgtable.h: Implement the
pgprot_writecombine function for MIPS") and commit c4687b15a848 ("MIPS: Fix
definition of pgprot_writecombine()") write-combine vma mapping is
available to be used by kernel subsystems for MIPS. In particular the
uncached accelerated attribute is requested to be set by ioremap_wc()
method and by generic PCI memory pages/ranges mapping methods. The same
is done by the drm_io_prot()/ttm_io_prot() functions in case if
write-combine flag is set for vma's passed for mapping. But for some
reason the pgprot_writecombine() method calling is ifdefed to be a
platform-specific with MIPS system being marked as lacking of one. At the
very least it doesn't reflect the current MIPS platform implementation.
So in order to improve the DRM subsystem performance on MIPS with UCA
mapping enabled, we need to have pgprot_writecombine() called for buffers,
which need store operations being combined. In case if particular MIPS
chip doesn't support the UCA attribute, the mapping will fall back to
noncached.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Signed-off-by: Vadim V. Vlasov <vadim.vlasov@t-platforms.ru>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/gpu/drm/drm_vm.c          | 5 +++--
 drivers/gpu/drm/ttm/ttm_bo_util.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index c3301046dfaa..50178dc64060 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -62,7 +62,8 @@ static pgprot_t drm_io_prot(struct drm_local_map *map,
 	/* We don't want graphics memory to be mapped encrypted */
 	tmp = pgprot_decrypted(tmp);
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__) || \
+    defined(__mips__)
 	if (map->type == _DRM_REGISTERS && !(map->flags & _DRM_WRITE_COMBINING))
 		tmp = pgprot_noncached(tmp);
 	else
@@ -73,7 +74,7 @@ static pgprot_t drm_io_prot(struct drm_local_map *map,
 		tmp = pgprot_writecombine(tmp);
 	else
 		tmp = pgprot_noncached(tmp);
-#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
+#elif defined(__sparc__) || defined(__arm__)
 	tmp = pgprot_noncached(tmp);
 #endif
 	return tmp;
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 895d77d799e4..9f918b992f7e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -539,13 +539,13 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
 		tmp = pgprot_noncached(tmp);
 #endif
 #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
-    defined(__powerpc__)
+    defined(__powerpc__) || defined(__mips__)
 	if (caching_flags & TTM_PL_FLAG_WC)
 		tmp = pgprot_writecombine(tmp);
 	else
 		tmp = pgprot_noncached(tmp);
 #endif
-#if defined(__sparc__) || defined(__mips__)
+#if defined(__sparc__)
 	tmp = pgprot_noncached(tmp);
 #endif
 	return tmp;
-- 
2.21.0

