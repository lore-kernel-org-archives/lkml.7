Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C1C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542712084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxS5I0Ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDIUmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:42:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33901 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfDIUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:42:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so16915940otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYqVsWqQSWnGTgrw/VKRGKm9uoHuQiVWv/uRiw5UCoQ=;
        b=PxS5I0UbCAbzgi8wJQRxqK+nG0JjhboHitwK8nsW7DyyRGsMpjNn04uOtMbH4FajOB
         3q23Yu5PdnKSRZo2d2LpoB/xMl+IX1MqD6QuPRYo1JT2sar++WO3ZlbjUTH1LtICeF2N
         Kg6jJiDm1b+BtlYD/3VGuMXsSLSER1E+7tUIXcqByWionKyiKmKDBifsr7YUMMTixP7Z
         sSlxD7dK7cEusMmFgN6EiVYOBEC57kuVfnB0woPARe95FMciwa86CyCH2BGk4Ukw4p72
         bl4yYICbdKil0aSruDHtVBlpk4Rde0lx2fQee3TDW/je/hVjTuX1sg0uPu4PrzG9Idh8
         v62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYqVsWqQSWnGTgrw/VKRGKm9uoHuQiVWv/uRiw5UCoQ=;
        b=aHObBJ2pcHmyIuEu/XZv/dlg0NLamFLoQniDTnHDNkFKLTT57KV2g9ulg8qCXs43Xa
         EJ1rde1N3oLGBpM5t1Tm9ZZrkr8e5kOAmczKhAtlr/J8yWbSNqLfM2bjIistgrceE+kb
         sJJys+mL5NMO4XxMPu/M3MTT4W/M7OhfYVFcEh7aLyxD7AnA4EoXahc7sR41WUWVojPk
         ogbune+NIZ/uRS/xzmOdAtJvy3W5ylvqbDbkxVb8Q/7XDNnAQa4OcbBmwWiqhKqhx6dr
         OHO6LGKTrnYyMei1zRZqCn3rH231G2mW9KyPYg6GqdLi7h7VBI6tEpd6AmKMboh8FKIb
         XcAw==
X-Gm-Message-State: APjAAAW4CmOLTKDB0/cSXvIle4ckXvglS798u2i6toegNtAfsrTb0lZv
        tP37hJU7yH8kqPufD/BVo65vxFkQ4FDje6iksQ91PA==
X-Google-Smtp-Source: APXvYqzB0EI0eAZK4Np0Ct7gHO8FBH+oa5UJr3ScmA+T9La0PQzPNF9S04XKu5pkashErRi58xCwCuvBkKB1r9XJGfA=
X-Received: by 2002:a9d:3b25:: with SMTP id z34mr25365368otb.298.1554842530941;
 Tue, 09 Apr 2019 13:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554485409.git.rdna@fb.com>
In-Reply-To: <cover.1554485409.git.rdna@fb.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Apr 2019 22:41:44 +0200
Message-ID: <CAG48ez2D=fUX6_MDf5WD39av65FSQ1OF7v7gG5pqZLqgU9RAUw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, guro@fb.com,
        kernel-team@fb.com, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 10:26 PM Andrey Ignatov <rdna@fb.com> wrote:
> The patch set introduces new BPF hook for sysctl.
>
> It adds new program type BPF_PROG_TYPE_CGROUP_SYSCTL and attach type
> BPF_CGROUP_SYSCTL.
>
> BPF_CGROUP_SYSCTL hook is placed before calling to sysctl's proc_handler so
> that accesses (read/write) to sysctl can be controlled for specific cgroup
> and either allowed or denied, or traced.

Don't look at the credentials of "current" in a read or write handler.
Consider what happens if, for example, someone inside a cgroup opens a
sysctl file and passes the file descriptor to another process outside
the cgroup over a unix domain socket, and that other process then
writes to it. Either do your access check on open, or use the
credentials that were saved during open() in the read/write handler.

> The hook has access to sysctl name, current sysctl value and (on write
> only) to new sysctl value via corresponding helpers. New sysctl value can
> be overridden by program. Both name and values (current/new) are
> represented as strings same way they're visible in /proc/sys/. It is up to
> program to parse these strings.

But even if a filter is installed that prevents all access to a
sysctl, you can still read it by installing your own filter that, when
a read is attempted the next time, dumps the value into a map or
something like that, right?

> To help with parsing the most common kind of sysctl value, vector of
> integers, two new helpers are provided: bpf_strtol and bpf_strtoul with
> semantic similar to user space strtol(3) and strtoul(3).
>
> The hook also provides bpf_sysctl context with two fields:
> * @write indicates whether sysctl is being read (= 0) or written (= 1);
> * @file_pos is sysctl file position to read from or write to, can be
>   overridden.
>
> The hook allows to make better isolation for containerized applications
> that are run as root so that one container can't change a sysctl and affect
> all other containers on a host, make changes to allowed sysctl in a safer
> way and simplify sysctl tracing for cgroups.

Why can't you use a user namespace and isolate things properly that
way? That would be much cleaner, wouldn't it?
