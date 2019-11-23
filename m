Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B7FC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3BE2068F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 19:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkJYM5C8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfKWTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 14:54:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47070 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKWTyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 14:54:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so9150654otr.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBi2Kl2b0LYogSQpnyXzwnLfzkWlslGs6DkAiJ/ff28=;
        b=YkJYM5C8pZQpOQTmbHQItGF438cTOP0Wxu7XuZE3iJCWH1utSuXHYIOmS9Mmxb+jCL
         A97dXlwNujP20TqqWJX3sz83Odhrwmlk3d6CJqRsxeOHc9Uem6OindxVvquqeghrmK4o
         KhwfPCQtEiVpkOfZuIyMmrnb7bTyAEUl6njOmQPqFR6WHZHKWXjNIn+qxnD5ay7hKzik
         Cz70Qse3hfob47U+wEpuz0mwv2O8NBZ1kDum2bB/wuwTYl+TM+18eVsp8DPIw/LWgdeA
         JFGZfmyjoBPUYfbHirI46Dkf3B4FhvxEB/nz28sKKkAr/t78q/x+L0mj6Gk3j3CNroEj
         EISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBi2Kl2b0LYogSQpnyXzwnLfzkWlslGs6DkAiJ/ff28=;
        b=EK1r9pskKldXKwIkeUyV6s9EacmoayzDLun1/ehIA8hXi16rtNVWibOuwH5+teztO4
         T3QzG+Ta/fAL6lAyolPnX4TQf7qRwMqYWNCbcM9VfLYEAyV76sR9ENFyVPVNBLty4JCz
         L2qbnedZncxCmvs0kYUSND0FI2F0RY2d0Eo/GC6IwL4IULDAQiSyfVeauIFG18u15aM3
         VKJXo53pveT9VUBAbVIe2NyxUGR1Nuedmt9L8e2rYL+/spX2VhO4bEI4fnMKjx1+g0zr
         PLJ0AAPeDqrr2nlS3mji6tDhEKIB2bHiC89u9ivHvni7nz2c0WKV/UWvtSyNSqz6rrod
         hNyw==
X-Gm-Message-State: APjAAAUZohb8hHSxwodyQZcZlwPvqSvIZkHuh++PZ6WpVa8A0mrCxCzE
        E0vspfzhGSGL4WI8g70T370=
X-Google-Smtp-Source: APXvYqw6JW+8ls79ZOkf2SzoYXqnRhAFKkJsw0ixPFreStxhWdjEhfjD+sVK9MQap+7EvdpLTrZknw==
X-Received: by 2002:a9d:734a:: with SMTP id l10mr15424321otk.339.1574538877966;
        Sat, 23 Nov 2019 11:54:37 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id t11sm577254otq.18.2019.11.23.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 11:54:37 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/i915: Remove tautological compare in eb_relocate_vma
Date:   Sat, 23 Nov 2019 12:53:22 -0700
Message-Id: <20191123195321.41305-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Wtautological-compare was recently added to -Wall in LLVM, which
exposed an if statement in i915 that is always false:

../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
result of comparison of constant 576460752303423487 with expression of
type 'unsigned int' is always false
[-Wtautological-constant-out-of-range-compare]
        if (unlikely(remain > N_RELOC(ULONG_MAX)))
            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~

Since remain is an unsigned int, it can never be larger than UINT_MAX,
which is less than ULONG_MAX / sizeof(struct drm_i915_gem_relocation_entry).
Remove this statement to fix the warning.

Fixes: 2889caa92321 ("drm/i915: Eliminate lots of iterations over the execobjects array")
Link: https://github.com/ClangBuiltLinux/linux/issues/778
Link: https://github.com/llvm/llvm-project/commit/9740f9f0b6e5d7d5104027aee7edc9c5202dd052
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

NOTE: Another possible fix for this is to change ULONG_MAX to UINT_MAX
      but I am not sure that is what was intended by this check. I'm
      happy to respin if that is the case.

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index f0998f1225af..9ed4379b4bc8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1482,8 +1482,6 @@ static int eb_relocate_vma(struct i915_execbuffer *eb, struct i915_vma *vma)
 
 	urelocs = u64_to_user_ptr(entry->relocs_ptr);
 	remain = entry->relocation_count;
-	if (unlikely(remain > N_RELOC(ULONG_MAX)))
-		return -EINVAL;
 
 	/*
 	 * We must check that the entire relocation array is safe
-- 
2.24.0

