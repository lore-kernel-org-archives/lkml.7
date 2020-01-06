Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B9BC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE9720848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYACJWe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFQj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:39:59 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35422 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:39:58 -0500
Received: by mail-ot1-f50.google.com with SMTP id i15so4759266oto.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 08:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BYX+ysDLixguPL9U7dTnnMHsyuHIKDFw1NJsrezq400=;
        b=HYACJWe7iC1JO54rLjWk/PavmoaeeOJJuzQRDOcsQWfJO67/UJxQhZOj7/OHKg/L8x
         0ysV6fkDOhztER0XKzJ1PwzCjL7zapiZoZqwysTAVMsry+duaYK1I/j8cVw89/qWN1r6
         UKsTgFexVIq0TbVZLxEB3tkuHabjQfhsLR3ofgyqxSs7IUCTmAzkXf6nOd3RPT2IK3L9
         JGZolBaGH0slMOBbYeUGag+MGi9wLIYV0cPaFGRfYnXb89/8N/O6iDI2kvoC3HOJI1Eb
         b2V4RqWKPrfLMpvyjWnsj8D+l+sTzgtEBRw9PsQ0WjFYkjT20hVMrzI9S9bm+pGII2yf
         EvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BYX+ysDLixguPL9U7dTnnMHsyuHIKDFw1NJsrezq400=;
        b=nuJ0yh6wnMUYJhh8pUbFKJ060338w7r2kQKA+MKkG7U95yhgb/dex7trB5qbQsk/fJ
         7ltm8+l7KMzizuCcGNslTeyyZyEqAjahHds5Pe8+ymTokUf8LAMyIK0Tf7RrK6ulKDmq
         kOSPdyJZuuYTyCJgMB2xbep47JIEbBqkpx8dUIly5TkQi0XX6QEPRiaLlkKOFDvLCcBm
         lTAD3+v9iVwT+9wBSl0m3mhDtEH2kooH7G64cJ28sRvgtq89gkYXm/X0R0g95R266Ei0
         t4QGoxP3cSxDZILxVSMwYuEw6PzYxf9GyPWbAZbGGNoC+lNfdHmVRMbRsuNEa4aHbwkN
         aTGA==
X-Gm-Message-State: APjAAAXKzOJhfAPuQeP0tS1RKV6ldn+qx8GNwLz9u58hiktxR8dlfPGY
        5ZjeflB+hRjxwggoi37qq7mxJfhXQti+QPYOOrD3qA==
X-Google-Smtp-Source: APXvYqyzJZgS9aC7Sd3hjVODNTRsj55lXa5LHChcNvYlVMoVjaqF3LKL0u3oYBiod7r1Yv6oUpSmScmSEqnX9/uI01k=
X-Received: by 2002:a9d:c02:: with SMTP id 2mr119359452otr.183.1578328797486;
 Mon, 06 Jan 2020 08:39:57 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 6 Jan 2020 17:39:30 +0100
Message-ID: <CAG48ez2gDDRtKaOcGdKLREd7RGtVzCypXiBMHBguOGSpxQFk3w@mail.gmail.com>
Subject: BPF tracing trampoline synchronization between update/freeing and execution?
To:     bpf@vger.kernel.org, live-patching@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     KP Singh <kpsingh@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was chatting with kpsingh about BPF trampolines, and I noticed that
it looks like BPF trampolines (as of current bpf-next/master) seem to
be missing synchronization between trampoline code updates and
trampoline execution. Or maybe I'm missing something?

If I understand correctly, trampolines are executed directly from the
fentry placeholders at the start of arbitrary kernel functions, so
they can run without any locks held. So for example, if task A starts
executing a trampoline on entry to sys_open(), then gets preempted in
the middle of the trampoline, and then task B quickly calls
BPF_RAW_TRACEPOINT_OPEN twice, and then task A continues execution,
task A will end up executing the middle of newly-written machine code,
which can probably end up crashing the kernel somehow?

I think that at least to synchronize trampoline text freeing with
concurrent trampoline execution, it is necessary to do something
similar to what the livepatching code does with klp_check_stack(), and
then either use a callback from the scheduler to periodically re-check
tasks that were in the trampoline or let the trampoline tail-call into
a cleanup helper that is part of normal kernel text. And you'd
probably have to gate BPF trampolines on
CONFIG_HAVE_RELIABLE_STACKTRACE.

[Trampoline *updates* could probably be handled more easily if a
trampoline consisted of an immutable header that increments something
like a percpu refcount followed by a mutable body, but given that that
doesn't solve freeing trampolines, I'm not sure if it'd be worth the
effort. Unless you just never free trampoline memory, but that's
probably not a great idea.]
