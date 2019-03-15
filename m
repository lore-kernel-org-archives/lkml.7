Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C5C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F01D218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsZbFgqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfCOTvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:51:51 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:51023 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfCOTvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:51:47 -0400
Received: by mail-io1-f73.google.com with SMTP id s24so4084311ioe.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7EwJOZO2FU3roQl0F5aaHfBG2l97MDWb8Nx8DHL3tHk=;
        b=NsZbFgqg7rNL+MmKx3BQKEQu20uV5j38Y50xV/nkSWdpaI1ml/U6N36zAaOr/fw5UA
         vw0RHRh7TFVUW8EczyoyJgPl2GwQ0O2Y3mdoA35Hyc638cKh6Ou6T8eYWBn4JvcpMD/p
         rAobGvHGGcaX0d5KUxoitmIQyCm1jnvtMKLMyUhfKXJwo6H8C9LXAnbI3Vm9NBlauUvF
         LSPFoGZmvnqqM1DaPRlnN62YYv9Ww/FkPY+qI6Xd7c1DGMrBJfACmaSSGw3vWzqTDpi4
         0fO7tv8nv58nySaGO3aBtIsMUSYoC0bWVWTZpEnNl/6BuoGd6099E0jO7AssN7waL7VF
         i1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7EwJOZO2FU3roQl0F5aaHfBG2l97MDWb8Nx8DHL3tHk=;
        b=ph1gOpJPeltk8gAXRP+WPZfId5yGkgRPvgc1DT7D6b5e6uOWb2bol+HETx6XySYNuW
         M8+blfkUvQVv/WxtPYaiwULXmGhzf9LxarR3y4LHhfHtu7WhNv/3oBCPK7Rsp/vsyOo+
         MEO5gq8sTi1WoJGx/2Lv+XFUl1mHkV87uEmYR07bZ1DvnrdJLBsWkl5fS36t8vejKUyh
         6/dKCL5aZYkbEf9dnotmUWNtbegWoiJb9AOGFYxCb9NzFGopO2vaGoAS9lKV6K52KzV+
         teAFuRO+3vXP8jws8b+YQXZTTbWfcLaeYO1BvvqaRK/moyYg7PPbgnkuOuuwOYVes+j2
         NQOg==
X-Gm-Message-State: APjAAAUzqYUxI59rQUHam3F99xvYAIgWGrwwrwgF6vx/WoCCHZnVBKnK
        1BAHrEz6AUxRu2wB68z70heVw4tQt7UoJHvE
X-Google-Smtp-Source: APXvYqw3EhdS69JFOaj1SqCWxq2uMXIiNWdBlJ3prBk3wjQoeZqkO0NrFGiKQ0BULG0Vahh3MxRaQ9/Jyb5Vnlog
X-Received: by 2002:a24:7bd3:: with SMTP id q202mr100068itc.32.1552679506915;
 Fri, 15 Mar 2019 12:51:46 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:25 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <bee403f76b40f37c6790d144a4142f293e0a7d9f.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 01/14] uaccess: add untagged_addr definition for other arches
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

To allow arm64 syscalls to accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for architectures other than arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 76769749b5a5..4d674518d392 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -99,6 +99,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 #ifndef __pa_symbol
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
-- 
2.21.0.360.g471c308f928-goog

