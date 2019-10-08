Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B8C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4C12190F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvysIdHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfJHWlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:41:00 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37707 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:41:00 -0400
Received: by mail-pl1-f201.google.com with SMTP id p15so259004plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xk2Hsfrlu+hhUdibwyFYuTiDrQ0899h2wrthFUO6GFs=;
        b=JvysIdHOorpSsjMhNxGu6Z42w2WQBXWtL4xQDM+yZOzDufs7Rbk9jlvQyBeMJK63gd
         b4D0H5A+okhEjUV0xI7PcG7MK0e6BeBk6YCpwOcCoSfCj5gAli/oqUHYvwbLwqQiU4Ve
         SWzFgoR+DV4kovAXfV7UIisMB9H3I0B/OQW5bFsoIw6RZFrtxfgWuDL6SeD56WA2GFfZ
         Z6F3tWSG0MZ1eMndIInp3DnoVoIjBu6V+oUme9Z7WbTu2mIUZK1iAYemNfk2XuCIZC6t
         NO0JJlUptnoCekkxmrVDkOiCoYZ/6of5bK4ru5/UIGnFPR7JtZbvLR+hlykuvLT6ZIs9
         xMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xk2Hsfrlu+hhUdibwyFYuTiDrQ0899h2wrthFUO6GFs=;
        b=QNsZyWBHk7tbayVA6pxkkIdQylOMkXsmM/4KHrkIMBZAtLzCbp+JRtgg9hSGIpTulE
         qRhXhxn9Q2xcHDN7ctaLiVbQkgC6MRcy3JGw1Cm7rF06g2btDbDFA0JjMcJXrgfpLMC6
         AOfj4oG8Py+rxf7/5+90x9OUe5M/0RvBoAnj6tQSSaWl/8F5vy24T5EKQL5HNHY1U1iO
         UyMShe8kBnGkO1Q85DSthYNfi/cJC4Yf9t+/IhE97AZ8eRL19N/VNH9Y12xSLUbERAq+
         DjXOkA9gBlj/n+Tnc/sZkNtQt2CQltYy7USZA4rwGq1JMuTIX9mOX/CE2aiaLfn8jAuo
         HGtg==
X-Gm-Message-State: APjAAAVmMwU0RCrH88DKZpvbLHesTU4S/1T08n91QHCCFXHjCItCX79c
        hWHQwA8HIGhxVcFVNDe66OSBU6RdAz6EELFIm0U=
X-Google-Smtp-Source: APXvYqwBCXI+RDR0uYPOLjfyTSq+cjAhMBOpDwPYiv3a3ag4gvU9118FYArlWEzu6EwyXvkhwAZHs3gPpB5EjVFq0EU=
X-Received: by 2002:a63:c901:: with SMTP id o1mr859499pgg.66.1570574459184;
 Tue, 08 Oct 2019 15:40:59 -0700 (PDT)
Date:   Tue,  8 Oct 2019 15:40:44 -0700
In-Reply-To: <20190913210018.125266-1-samitolvanen@google.com>
Message-Id: <20191008224049.115427-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RESEND PATCH v2 0/5] x86: fix syscall function type mismatches
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set changes x86 syscall wrappers and related functions to
use function types that match sys_call_ptr_t. This fixes indirect call
mismatches with Control-Flow Integrity (CFI) checking.

Changes since v1:
  - Use SYSCALL_DEFINE0 for __x64_sys_ni_syscall.
  - Include Andy's COMPAT_SYSCALL_DEFINE0 patch and use the macro
    for (rt_)sigreturn.

Andy Lutomirski (1):
  x86/syscalls: Wire up COMPAT_SYSCALL_DEFINE0

Sami Tolvanen (4):
  x86: use the correct function type in SYSCALL_DEFINE0
  x86: use COMPAT_SYSCALL_DEFINE0 for IA32 (rt_)sigreturn
  x86: use the correct function type for sys_ni_syscall
  x86: fix function types in COND_SYSCALL

 arch/x86/entry/syscall_32.c            |  8 +--
 arch/x86/entry/syscall_64.c            | 14 +++--
 arch/x86/entry/syscalls/syscall_32.tbl |  8 +--
 arch/x86/ia32/ia32_signal.c            |  5 +-
 arch/x86/include/asm/syscall_wrapper.h | 76 ++++++++++++++++++++------
 5 files changed, 78 insertions(+), 33 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

