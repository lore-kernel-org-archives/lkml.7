Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6207AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AF82133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7kZsVyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDIXW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:22:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45887 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfDIXW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:22:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so198935otk.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 16:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSlPGOq/zauzPo8ZTMW6WYMjsDECkRil2hWA3pH0xf8=;
        b=X7kZsVykxx6f+fxzE7DoZ43NbBlos7YO/7prMVYaq0YAUqnLgemyQpBvv4n+SmDDCv
         eafUNTd4icKrYBK4bRXjb+YfbpQl6MKgHOg3733EafDwqyo6Pesse2fQEgqjuhm0TNqW
         jZgnVk+Sv4Fzf1HEBs1MAA9OwjnRjOAvmtPZeH90qsL/t+whP2wcE/FvenRU0988Nk/k
         9zVoGj5Xowrix2wQ00Ollo6R2CPE8LhhxSwTVrk9DeSbHRLAH3nz5R/ePakLbKsMqYBU
         yBLZcENcrBKkirVRRm4g/wYIdFTNgfXB1odVrC2RMKi7YQy2idSXqRUW5X5xqg7ynl4y
         MNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSlPGOq/zauzPo8ZTMW6WYMjsDECkRil2hWA3pH0xf8=;
        b=MK7Ur4jFu9fxAQJwHGvw3XlY+S+rJlt6BEaIs7CCJhwWzsv+G7aufEank0pvaU4d0q
         3jFedSxtawDLHxr/aCGU0SKhDj4Ta0oIb6hQKxsPCs4ZNG3ntOugHcQQZTdruXk0w1/u
         95m0BOhb90wcsb/2Uv5cCNvk/QPhT7W9ooSLxDsKiOMJZW4z1oL1zXjZn6NASW3FuIue
         urq4arVB3Rx0YBAjYMTZ1YRgSNcEFMhP8kx/wLiN7B+3DXcQ5dM0PsJ0LaoaqTl9w6eS
         MK12u5Tb9+7Zevyj75m3LfSUS62zeDaz4FjPeMMVcSertksUajuemxDMyvH0vC9M17e6
         h01Q==
X-Gm-Message-State: APjAAAVEtO7gXPtErKshsO4DQ/WkieTz5IYJIbRsl4oLnaMXZ43znLbR
        nxgiJGRjr3geqUxZP5FoOvyca7H1k+XzO4K20FeLFA==
X-Google-Smtp-Source: APXvYqy3aN0N0AWKfBCGu0f2OMz3VOE3bfWsStoCaT2vfJ1GD6h50uejcT9mBe6XVsfgCQ16RmlTOrPLeAxFb/Pa9MY=
X-Received: by 2002:a9d:5e82:: with SMTP id f2mr26200787otl.217.1554852147059;
 Tue, 09 Apr 2019 16:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554485409.git.rdna@fb.com> <CAG48ez2D=fUX6_MDf5WD39av65FSQ1OF7v7gG5pqZLqgU9RAUw@mail.gmail.com>
 <20190409230432.GA59615@rdna-mbp>
In-Reply-To: <20190409230432.GA59615@rdna-mbp>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Apr 2019 01:22:00 +0200
Message-ID: <CAG48ez0-B_m6ruMiMp+hVgxmw1dZVtiKGqPWtaFP5esOQTjr9A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
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

On Wed, Apr 10, 2019 at 1:04 AM Andrey Ignatov <rdna@fb.com> wrote:
> Jann Horn <jannh@google.com> [Tue, 2019-04-09 13:42 -0700]:
> > On Tue, Apr 9, 2019 at 10:26 PM Andrey Ignatov <rdna@fb.com> wrote:
> > > The patch set introduces new BPF hook for sysctl.
> > >
> > > It adds new program type BPF_PROG_TYPE_CGROUP_SYSCTL and attach type
> > > BPF_CGROUP_SYSCTL.
> > >
> > > BPF_CGROUP_SYSCTL hook is placed before calling to sysctl's proc_handler so
> > > that accesses (read/write) to sysctl can be controlled for specific cgroup
> > > and either allowed or denied, or traced.
> >
> > Don't look at the credentials of "current" in a read or write handler.
> > Consider what happens if, for example, someone inside a cgroup opens a
> > sysctl file and passes the file descriptor to another process outside
> > the cgroup over a unix domain socket, and that other process then
> > writes to it. Either do your access check on open, or use the
> > credentials that were saved during open() in the read/write handler.
>
> This way this someone inside cgroup should already have control over
> something running as root [1] outside of this cgroup, i.e. the game is
> already lost, even without this hook.
>
> [1] Since proc_sys_read() / proc_sys_write() check sysctl_perm() before
>     execution reaches the hook.

You don't need to have _control_ over something running as root. You
only need to be able to communicate with something that expects to be
passed in file descriptors for some purpose.

> This patch set doesn't look at credentials at all and relies on what
> checks were already done at sys_open time or in proc_sys_call_handler()
> before execution reaches the hook.

You're looking at the cgroup though.

> > > The hook has access to sysctl name, current sysctl value and (on write
> > > only) to new sysctl value via corresponding helpers. New sysctl value can
> > > be overridden by program. Both name and values (current/new) are
> > > represented as strings same way they're visible in /proc/sys/. It is up to
> > > program to parse these strings.
> >
> > But even if a filter is installed that prevents all access to a
> > sysctl, you can still read it by installing your own filter that, when
> > a read is attempted the next time, dumps the value into a map or
> > something like that, right?
>
> No. This can be controlled by cgroup hierarchy and appropriate attach
> flags, same way as with any other cgroup-bpf hook.
>
> E.g. imagine there is a cgroup hierarchy:
>   root/slice/container/
>
> and container application runs in root/slice/container/ in a cgroup
> namespace (CLONE_NEWCGROUP) that makes visible only "container/" part of
> the hierarchy, i.e. from inside container application can't even see
> "root/slice/".
>
> Administrator can then attach sysctl hook to "root/slice/" with attach
> flag NONE (bpf_attr.attach_flags = 0) what means nobody down the
> hierarchy can override the program attached by administrator.

Ah, okay.

> > > To help with parsing the most common kind of sysctl value, vector of
> > > integers, two new helpers are provided: bpf_strtol and bpf_strtoul with
> > > semantic similar to user space strtol(3) and strtoul(3).
> > >
> > > The hook also provides bpf_sysctl context with two fields:
> > > * @write indicates whether sysctl is being read (= 0) or written (= 1);
> > > * @file_pos is sysctl file position to read from or write to, can be
> > >   overridden.
> > >
> > > The hook allows to make better isolation for containerized applications
> > > that are run as root so that one container can't change a sysctl and affect
> > > all other containers on a host, make changes to allowed sysctl in a safer
> > > way and simplify sysctl tracing for cgroups.
> >
> > Why can't you use a user namespace and isolate things properly that
> > way? That would be much cleaner, wouldn't it?
>
> I'm not sure I understand how user namespace helps here. From my
> understanding it can only completely deny access to sysctl and can't do
> fine-grained control for specific sysctl knobs. It also can't make
> allow/deny decision based on sysctl value being written.
>
> Basically user namespace is all or nothing. This sysctl hook provides a
> way to implement fine-grained access control for sysctl knobs based on
> sysctl name or value being written or whatever else policy administrator
> can come up with.

But there's a reason why user namespaces are all-or-nothing on these
things. If the kernel does not explicitly make a sysctl available to a
container, the sysctl has global effects, and therefore probably
shouldn't be exposed to anything other than someone with
administrative privileges across the whole system. If the kernel does
make it available to a container, the sysctl's effects are limited to
the container (or otherwise it's a kernel bug).

Can you give examples of sysctls that you want to permit using from
containers, that wouldn't be accessible in a user namespace?
