Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19BDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB3E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHldEZZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393018AbfIJL4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:56:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35648 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbfIJL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id g7so19677429wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=goHxQO5WE56PjZrElqp9mWD4UyL0ez4HVWRIM6UzU3c=;
        b=CHldEZZfNkVRxXOpA/ZEWOkGHLNYox5M0eQi+ih3ANNwJcZssMhLi1RvrKo6pFLpIu
         O0krOoKt/DkqNYVlPOFbFJ/LCVr2AyI88WBCpVC/zADylr9USKLI3of2dqtzmKkjm1EM
         AkCKEJMXkpFGE+nb6HJM6DAYeR0LzGOGEhFgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=goHxQO5WE56PjZrElqp9mWD4UyL0ez4HVWRIM6UzU3c=;
        b=W1wYPboGaUHhBkIj1E3WOcACLYJzjTXwzg5z1HTdBaKKnaJr40z63T5sqT8wZCwumi
         1GRhNKOfCSlvPPeNX+NYJpekd3npL4cR7Vo8VpuKn1CA+tyL19BqU/ebl7Hf+HyjVhgg
         1cC/v1GmnPmBx3Q9MhJVUQWoDOBNJ31/TRVlH6u5Fb8ylbgkPRPOk1nHuGKQyES/YF/+
         8AxHjXLtbEhtyE86urCdgb7MXpGt81HY+8oQUzHEIIOsYMcf7IMRTyEGnL+XAwJRYirx
         OIv43s4y/hsBWoibvtIpjoPbqBecHwMMnSUUNGvOwyCIAM+IMMgiAVzpHd4eT67AiDRz
         6x8g==
X-Gm-Message-State: APjAAAU6+PjBE5sPqbO7+7ur81nYiOOkpifZvpw185WIaPB0yp8IK3xX
        7Z+ta2a2/ZzXusd/hw2zKk4vK3RloBM=
X-Google-Smtp-Source: APXvYqy41deBTxwWe2+aWhU+4LiCXFDvi6WI4YCLje4OsKhs9MTrTG1c6KpCz0h80p4KZoQRWYOFwg==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr25996339wrw.237.1568116602133;
        Tue, 10 Sep 2019 04:56:42 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:41 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 11/14] krsi: Pin argument pages in bprm_check_security hook
Date:   Tue, 10 Sep 2019 13:55:24 +0200
Message-Id: <20190910115527.5235-12-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Pin the memory allocated to the the argv + envv for the new
process and passes it in the context to the eBPF programs attached to
the hook.

The get_user_pages_remote cannot be called from an eBPF helper because
the helpers run in atomic context and the get_user_pages_remote function
can sleep.

The following heuristics can be added as an optimization:

- Don't pin the pages if no eBPF programs are attached.
- Don't pin the pages if none of the eBPF programs depend on the
  information. This would require introspection of the byte-code and
  checking if certain helpers are called.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/krsi/include/krsi_init.h |  3 ++
 security/krsi/krsi.c              | 56 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/security/krsi/include/krsi_init.h b/security/krsi/include/krsi_init.h
index 4e17ecacd4ed..6152847c3b08 100644
--- a/security/krsi/include/krsi_init.h
+++ b/security/krsi/include/krsi_init.h
@@ -16,6 +16,9 @@ extern int krsi_fs_initialized;
 
 struct krsi_bprm_ctx {
 	struct linux_binprm *bprm;
+	char *arg_pages;
+	unsigned long num_arg_pages;
+	unsigned long max_arg_offset;
 };
 
 /*
diff --git a/security/krsi/krsi.c b/security/krsi/krsi.c
index d3a4a361c192..00a7150c1b22 100644
--- a/security/krsi/krsi.c
+++ b/security/krsi/krsi.c
@@ -4,6 +4,8 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/binfmts.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
 
 #include "krsi_init.h"
 
@@ -17,6 +19,53 @@ struct krsi_hook krsi_hooks_list[] = {
 	#undef KRSI_HOOK_INIT
 };
 
+static int pin_arg_pages(struct krsi_bprm_ctx *ctx)
+{
+	int ret = 0;
+	char *kaddr;
+	struct page *page;
+	unsigned long i, pos, num_arg_pages;
+	struct linux_binprm *bprm = ctx->bprm;
+	char *buf;
+
+	/*
+	 * The bprm->vma_pages does not have the correct count
+	 * for execution that is done by a kernel thread using the UMH.
+	 * vm_pages is updated in acct_arg_size and bails
+	 * out if current->mm is NULL (which is the case for a kernel thread).
+	 * It's safer to use vma_pages(struct linux_binprm*) to get the
+	 * actual number
+	 */
+	num_arg_pages = vma_pages(bprm->vma);
+	if (!num_arg_pages)
+		return -ENOMEM;
+
+	buf = kmalloc_array(num_arg_pages, PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < num_arg_pages; i++) {
+		pos = ALIGN_DOWN(bprm->p, PAGE_SIZE) + i * PAGE_SIZE;
+		ret = get_user_pages_remote(current, bprm->mm, pos, 1,
+					    FOLL_FORCE, &page, NULL, NULL);
+		if (ret <= 0) {
+			kfree(buf);
+			return -ENOMEM;
+		}
+
+		kaddr = kmap(page);
+		memcpy(buf + i * PAGE_SIZE, kaddr, PAGE_SIZE);
+		kunmap(page);
+		put_page(page);
+	}
+
+	ctx->arg_pages = buf;
+	ctx->num_arg_pages = num_arg_pages;
+	ctx->max_arg_offset = num_arg_pages * PAGE_SIZE;
+
+	return 0;
+}
+
 static int krsi_process_execution(struct linux_binprm *bprm)
 {
 	int ret;
@@ -26,7 +75,14 @@ static int krsi_process_execution(struct linux_binprm *bprm)
 		.bprm = bprm,
 	};
 
+	ret = pin_arg_pages(&ctx.bprm_ctx);
+	if (ret < 0)
+		goto out_arg_pages;
+
 	ret = krsi_run_progs(PROCESS_EXECUTION, &ctx);
+	kfree(ctx.bprm_ctx.arg_pages);
+
+out_arg_pages:
 	return ret;
 }
 
-- 
2.20.1

