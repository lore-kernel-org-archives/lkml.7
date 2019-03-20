Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAFAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE952184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sefw+LBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfCTOyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:54:22 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:33941 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbfCTOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:52:21 -0400
Received: by mail-qt1-f202.google.com with SMTP id x58so2696904qtc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K4asd4oI0/VXu7bks/7ZozR0oEqYxUgnLBJb7yiErTQ=;
        b=Sefw+LBQD0bYtQOF7Z3/FF5rWl5fnzlahJItvb5ZICgi8f6u4tK/9F6nfzFXPich3o
         EcUn7JVF7lEJYJneqAC0m7D0m73A5VmH620Qfp8NMW21rRutLGEd2Gtg1ILCNwDmdZNZ
         FjIyPxXe0aqGhTuqozDv4invVSFneb5ZIlySFOfmNfdoGDZG5iv4aiillZPkIZFAoy/1
         Op94lqwLg26NfLmDs8/kDtPAlvGhye76V+rDgwQLh/XO9bfB2FGQp9lBXpf3J2QGTDlH
         XxqI4JERIWdF2z3HZogNyJS65SJ4WuJX9kuolmSrlZO9gRMOVvxcsIln5olphRwer6Xd
         nAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K4asd4oI0/VXu7bks/7ZozR0oEqYxUgnLBJb7yiErTQ=;
        b=MSzzr3OVnRZg5gqL2c4TZIXpS2rOJsBY2iOoXxu8tYEWEOZDTfUNaFhmnmReeAjWMj
         KhjmRlFeQjSDIDfZk/LyvBrFkCFIFd2Z3MNMANbxlgcIDR7ljujXwWhYRo79uQ2UGmWN
         GUrbUnoQKtL3zev4lcVxMiEP9Gwe4bEDVRqi153zHAVkEQNaZdxp1yPijFAFSpjp0aS2
         4zPpNWyMq0MydarzP+CzUV+YsvvENlrke77dO4QFEFs+w0az4l+pUnmSbHDse23484+t
         Q66B+mIJCtpYjuRBuWd9Lj6QuhDU2J62PjybtbozlrYtsJubf4nYmIOUs2iR4zncHcno
         8x7A==
X-Gm-Message-State: APjAAAWZ00usBJZbfw1C7JaFfBVI4lPoG4b0KwGGg36Ns0cWKGP3yRJG
        /XBeq1vZbZifgeiAPUdu6JOolAKT3jBaYApS
X-Google-Smtp-Source: APXvYqyQ4NMWwmcD+QNQXwycznUSrQ4ccjdMHmvJTyO2jY+wRoLxkzWub5WBnbxSwYjZ06st+3eMc86w9nXfL0n7
X-Received: by 2002:aed:3b09:: with SMTP id p9mr8634647qte.55.1553093540002;
 Wed, 20 Mar 2019 07:52:20 -0700 (PDT)
Date:   Wed, 20 Mar 2019 15:51:25 +0100
In-Reply-To: <cover.1553093420.git.andreyknvl@google.com>
Message-Id: <c9553c3a4850d43c8af0c00e97850d70428b7de7.1553093421.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1553093420.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v13 11/20] tracing, arm64: untag user pointers in seq_print_user_ip
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
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

seq_print_user_ip() uses provided user pointers for vma lookups, which
can only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/trace/trace_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 54373d93e251..6376bee93c84 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -370,6 +370,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 {
 	struct file *file = NULL;
 	unsigned long vmstart = 0;
+	unsigned long untagged_ip = untagged_addr(ip);
 	int ret = 1;
 
 	if (s->full)
@@ -379,7 +380,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 		const struct vm_area_struct *vma;
 
 		down_read(&mm->mmap_sem);
-		vma = find_vma(mm, ip);
+		vma = find_vma(mm, untagged_ip);
 		if (vma) {
 			file = vma->vm_file;
 			vmstart = vma->vm_start;
@@ -388,7 +389,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 			ret = trace_seq_path(s, &file->f_path);
 			if (ret)
 				trace_seq_printf(s, "[+0x%lx]",
-						 ip - vmstart);
+						 untagged_ip - vmstart);
 		}
 		up_read(&mm->mmap_sem);
 	}
-- 
2.21.0.225.g810b269d1ac-goog

