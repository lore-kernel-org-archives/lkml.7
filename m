Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EEDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D7F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBRIEAm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfCTOw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:52:27 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46125 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfCTOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:52:24 -0400
Received: by mail-pf1-f201.google.com with SMTP id j10so2745679pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TypqXDoyNXONz2oDo7T8C+4NlePqKxo9jFd/dN9OnUY=;
        b=VBRIEAm79eYl13DjJG/iyvfKJYZY4JaqF0G4F5Q9Tdc02tcv3SWnQ7Xrt3SjBFfGvg
         PcwgciJDQT6onqfPRyqhMrslyXsxz10zdr5FgA2LGaoQc9yos1AyT8UyusDzxef8QaZN
         z/f2pc6v7A54U9tLiW8lNWS179RcuvzfHFAZzepf2J72aR6ktogxURSeTjnVYurpdTa1
         B6f7t3ef6UHMUiBVLuaDIwpdpl0FL6sYq3LH523DSKALKUVOqO0tPAJ4+aeT4zaZmhz+
         IrRrf0UOiKCQsyUUh28eTbRMIsy4aBjzHA3qkBs+V7Ol2Fi+w51237VJCFLw3aI3tuE3
         QzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TypqXDoyNXONz2oDo7T8C+4NlePqKxo9jFd/dN9OnUY=;
        b=eOm0uVff7+n1IeimQGiFQP+rK81I7swQCPzbAovjkWENfhHbkIpTuXPn6l3o9R0gXX
         LjujrX5wARxX+SNG9fSt2wPylozguprdDPFHJ/WdTof63/rAoi/xQMpUNMmsERkfFZQ8
         v5SlY/0/jJ2r+qZMpVFXQoETwIp2+QN6eClahTd0hOuvXxiV5u57q6BlZPOu9vj9RO/J
         fBFHfiEhzlbBDj8Df5HzE8LM/06eaeRMA+/uU+7zCTm7h5FNQnayQ4hrohmFEoE/IagE
         mJvw+cCMhirS1WETPAym/wiB7mVJY45PJR6slm1pYZLIDVyLa8RrOJDAgBYHX2Z9jeQh
         xf6w==
X-Gm-Message-State: APjAAAWWBBmb1MfC4O/ghkCKfrsmq3qb9Gno3l9dqN/guUjUlg4B0x2y
        bZxmh+YZeVAHq0GGPIwqcHFWGNiM+VkI3H2F
X-Google-Smtp-Source: APXvYqzAZyZyGva2EuPoJScM6UyEVyBDQ8rao6oUZ0kApC3+FesuzwO5WKxPmyM+dQi9tBAx2Re+64THdUBgYOfQ
X-Received: by 2002:a17:902:8a98:: with SMTP id p24mr7507223plo.18.1553093543416;
 Wed, 20 Mar 2019 07:52:23 -0700 (PDT)
Date:   Wed, 20 Mar 2019 15:51:26 +0100
In-Reply-To: <cover.1553093420.git.andreyknvl@google.com>
Message-Id: <88d5255400fc6536d6a6895dd2a3aef0f0ecc899.1553093421.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1553093420.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v13 12/20] uprobes, arm64: untag user pointers in find_active_uprobe
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

find_active_uprobe() uses user pointers (obtained via
instruction_pointer(regs)) for vma lookups, which can only by done with
untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c5cde87329c7..d3a2716a813a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1992,6 +1992,8 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
 	struct uprobe *uprobe = NULL;
 	struct vm_area_struct *vma;
 
+	bp_vaddr = untagged_addr(bp_vaddr);
+
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, bp_vaddr);
 	if (vma && vma->vm_start <= bp_vaddr) {
-- 
2.21.0.225.g810b269d1ac-goog

