Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB1BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1F0205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEClrhOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfEFQcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:32:55 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:36749 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfEFQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:31:39 -0400
Received: by mail-yw1-f73.google.com with SMTP id j62so26228884ywe.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XsLXWNDlsBBI0M98p6y9Vt03OYjBcfLHAOwfOkL6Mk8=;
        b=kEClrhOVjhAItZ8ad4444tIss3a4M0x8Yot0yP0UgDJhkHPz5JJSrKt8hPGcBCGy4k
         n4A8xX+jnj6SxUqb5Teq0gUiCKNzkVcA04YhcbUNwlyz4R1O6RfjMZcPvXzWJ1RdceKB
         oQhTiP7SkvbOtmqbJ2RUuk4j1OYZLTrgQf9mkPglzFxH/VOrmTQ4nsN9RjYlhUC2s+eh
         3RVGdXHQ+PFLeCy7nvUg/hvDRpVltVdy/tgWDjXNd7yymqhFMcWgbq1pcJP1+YPDmRyD
         x5gmgR7lpn+iTAg+S4pO9Zaw/FFLdxShW6UDAYaJnd95g7v5e/84elY+8pkkjOlGa4Nw
         P+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XsLXWNDlsBBI0M98p6y9Vt03OYjBcfLHAOwfOkL6Mk8=;
        b=OS6pzyG5I94H1TmZK7LGxnka7MPZUVK2RQ9pY7hTxcgJ0hukU5NUcxmw6vhgFl1qAw
         qvTI4ZT+QoRI7L0Hv0ycDig4FcdqtN2Qvdxprzyjm8pSGpAt2E8DccTJbaq23M76ao/6
         9tBXIBpArfQRPUALI//JfJ7VizUYDDu8Ef1ukx4ii//o9DKfIwViZAivuXjFmWogsSnl
         nnBi3YyTM0Uo27N1UMepXo5/a+Wv0mtVlOTEgdAby/xvDeIUwvIzcza/kRcQGEY950Rq
         NgsTDVQ4bdVKVQE+hGyd4jIOnt6BY3n6AsIACAIbIfU5fda1brgJXn0diWi9vF+kun32
         bEtQ==
X-Gm-Message-State: APjAAAXt1UWNTS2Bs8qaCN2GM3XEa+FuVUW71AKtbOZvk/2akOQeEN1F
        1iilSYqKabT9XBzXIVtgMYpkP4xrFOUpfnD7
X-Google-Smtp-Source: APXvYqynTJlFStkm7itRuyZbu5fDIV0oTx6a8awLBBeIPofcOk875PcBne7EkMsm55r8chxW1lodIy8g+/aDw2aV
X-Received: by 2002:a81:7903:: with SMTP id u3mr17016403ywc.478.1557160297906;
 Mon, 06 May 2019 09:31:37 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:56 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <30b44d469bb545c608531faf01fb10248ed78887.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 10/17] fs, arm64: untag user pointers in fs/userfaultfd.c
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

userfaultfd code use provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in validate_range().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f5de1e726356..aa47ed0969dd 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1261,21 +1261,23 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 }
 
 static __always_inline int validate_range(struct mm_struct *mm,
-					  __u64 start, __u64 len)
+					  __u64 *start, __u64 len)
 {
 	__u64 task_size = mm->task_size;
 
-	if (start & ~PAGE_MASK)
+	*start = untagged_addr(*start);
+
+	if (*start & ~PAGE_MASK)
 		return -EINVAL;
 	if (len & ~PAGE_MASK)
 		return -EINVAL;
 	if (!len)
 		return -EINVAL;
-	if (start < mmap_min_addr)
+	if (*start < mmap_min_addr)
 		return -EINVAL;
-	if (start >= task_size)
+	if (*start >= task_size)
 		return -EINVAL;
-	if (len > task_size - start)
+	if (len > task_size - *start)
 		return -EINVAL;
 	return 0;
 }
@@ -1325,7 +1327,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
-	ret = validate_range(mm, uffdio_register.range.start,
+	ret = validate_range(mm, &uffdio_register.range.start,
 			     uffdio_register.range.len);
 	if (ret)
 		goto out;
@@ -1514,7 +1516,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
-	ret = validate_range(mm, uffdio_unregister.start,
+	ret = validate_range(mm, &uffdio_unregister.start,
 			     uffdio_unregister.len);
 	if (ret)
 		goto out;
@@ -1665,7 +1667,7 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_wake, buf, sizeof(uffdio_wake)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_wake.start, uffdio_wake.len);
+	ret = validate_range(ctx->mm, &uffdio_wake.start, uffdio_wake.len);
 	if (ret)
 		goto out;
 
@@ -1705,7 +1707,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_copy)-sizeof(__s64)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
+	ret = validate_range(ctx->mm, &uffdio_copy.dst, uffdio_copy.len);
 	if (ret)
 		goto out;
 	/*
@@ -1761,7 +1763,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_zeropage)-sizeof(__s64)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_zeropage.range.start,
+	ret = validate_range(ctx->mm, &uffdio_zeropage.range.start,
 			     uffdio_zeropage.range.len);
 	if (ret)
 		goto out;
-- 
2.21.0.1020.gf2820cf01a-goog

