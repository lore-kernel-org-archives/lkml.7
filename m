Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4332063F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNIVGISA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCOTwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:52:23 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42905 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfCOTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:52:19 -0400
Received: by mail-qt1-f202.google.com with SMTP id n10so2020675qtk.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=REP9LhKq3azFcE3epBwHjl0z4e4u8qSodB2K6JOUUqY=;
        b=FNIVGISAdAEFbreSsDDijAXV7iz7bJ+nqAbnQIHGv5JyzeZ7lcBCJx59d3veVulKlh
         7jE3udTRD8ZB4FsTnM9RGbtkCH/mbxzWvFL0H4sXjQx4qi2m5t5ro7oy5rhM45nSVVBP
         5ClTpMIvyiu2q1I0rCYKPmV2nRUW01xZpnfJIxUQMHQ44ykxwcrzRx307eckpZorbuN3
         6VEq4E+w7Q2yQVpjsHzE5SdEEFgZlQL/gXacFSIer7uFwLUhfH2E6+fmsaTjr28zvsU3
         LxduxWE/YJsel6dur8r7Ne5zecAEIXKRCQ6ztsVh51aCO/ECwJBztr37RmWaHcFGyfRo
         FPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=REP9LhKq3azFcE3epBwHjl0z4e4u8qSodB2K6JOUUqY=;
        b=Ku33b58mbsgLLZqwVitzNmewY18yIy8C8WMDkwSh/jg7qZEhrvr7pNt9um2tsM6mYJ
         u+yt4ZrOjp2PsEY8GgsX0fw1+MzTDJA6dAKkzVPO08rO+yHVoVk2p60EIvbxG5kNw0qD
         ehvUxv6weA0iYIiVqCU76DlRTK608lJaNjRE7A5Z7kr9Yk6PrfIC7m4epk+R6DaLs5fF
         VFBGfBbD4Og6zmSA/c2ZgGx+TyYhxi9SHgwSQldlc6UO9JbfGbbhwQTW1qbc/GjUML3d
         3ppebQBPFJkj8h6PDI5u8kP2D2XpZ9Xo03FK/RJvW+fnjQhNtVggSsTjJxSHb0CY2wCW
         hczg==
X-Gm-Message-State: APjAAAXf7xXlJfTO1XdZeisRiE24tyCfNZhSewzUvFLuG0ZQyKcA835c
        xmZ/gtXa85FXziVDmsnRjiN6vxR0R4LLg2od
X-Google-Smtp-Source: APXvYqwJcWbE90DsufpIchU1RWZDjZYiH/OdYEaqepbyMZK8dYdaYAIDqIiN21SA2dhnlvcWp5RKO708a/U1e0LV
X-Received: by 2002:ac8:2d7c:: with SMTP id o57mr3149114qta.39.1552679538830;
 Fri, 15 Mar 2019 12:52:18 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:35 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <a5fff68a32941ebce02dbe48f554a76a9c7a36ce.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 11/14] uprobes, arm64: untag user pointers in find_active_uprobe
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
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

find_active_uprobe() uses provided user pointer (obtained via
instruction_pointer(regs)) for vma lookups, which can only by done with
untagged pointers.

Untag the user pointer in this function.

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
2.21.0.360.g471c308f928-goog

