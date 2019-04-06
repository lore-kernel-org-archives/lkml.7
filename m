Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12218C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1D421019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDabefpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDFRDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 13:03:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45539 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDFRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 13:03:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so4747346plb.12;
        Sat, 06 Apr 2019 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8FS7C/boCC+sadJH0/RxFhpWBd+j8euggZZ+WvhES7o=;
        b=GDabefpgaiMUBXf3Q+bf8XS8hn5pbsGGYRaPVg0Uv403JcfPkrLgqlp7YPK3ajcOju
         5cQ2matgbII9OvT4nOOOz0oNQnpb8G7ZOXBFzvV0i1gANpyQFRW8QJu1Xnn/IZjM+S6Y
         HQD+bdoPoFjkmSpVChuKlleUfrWYhtCCWMEVTpQeHHxR5ERcJUbjbLOXB9qhupHF8nyy
         pT++FE1hbtXvH58LpHNs5k9QG73AND/nE2FdPkRCovgeIdV43/7iRIqb7pogXXlaTdrz
         gHmBt0pPu2sCp2iPgddIg6gJixaC7/35H34BLgjYkJjRNC3l9yYYqARn7pWxRtTfxpMS
         eKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8FS7C/boCC+sadJH0/RxFhpWBd+j8euggZZ+WvhES7o=;
        b=GUsr+OhPGkDVijYPW6zcNvVJ/WuUnFn0k/CZIzVDM8wZlgu5QQgUZKFyCSOtrgx3ek
         Y6Y7fcsEJbekkDZNXuE6TdMhQlyjYhgd+KhH2ZdfWeukvYuaXIix2XYgYEUOZ2VpTpBT
         MOxHO65t9rNGoihEZhljTEtbNwoRQjTG39J8+ccMd2tf2ary0LPDt8f7Hn//at28tFRu
         L2Opz66BU9E39np+HHHfDd/DtA5jW8JUq+vSnJegQBWkWHIsV2rLBdf2jnHgF1M5v/RQ
         tefPPHVqo/J71DDnjQC1sQippwkGDShUT9hUNlpeniR0Emrm8mMBo/0J+WN2zr/Llcmr
         nqVw==
X-Gm-Message-State: APjAAAUAnyz7C/VNLOLinZ+URb8w8kKZjXDj3FyxmPOaJT8ozmVgU7Za
        y8Ayl4Aof1bTCdxRyaLAl7Y=
X-Google-Smtp-Source: APXvYqzqc0J3cRGSdYzVMJDr+92sW4VDMDY3jREqwujQX+KQK4ItPNPWbkkM1MnhlDRL1ilyZ2OEtQ==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22mr20213636pll.28.1554570180454;
        Sat, 06 Apr 2019 10:03:00 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1950])
        by smtp.gmail.com with ESMTPSA id j22sm33148756pfn.129.2019.04.06.10.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 10:02:59 -0700 (PDT)
Date:   Sat, 6 Apr 2019 10:02:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Ignatov <rdna@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, kernel-team <kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
Message-ID: <20190406170257.qlptcrfth2rb3rxo@ast-mbp.dhcp.thefacebook.com>
References: <cover.1554485409.git.rdna@fb.com>
 <CAGXu5jJGC1kB-0e3DimBSprcgEBnWRB=i287g-9T5a-RidFqBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJGC1kB-0e3DimBSprcgEBnWRB=i287g-9T5a-RidFqBg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 09:43:50AM -0700, Kees Cook wrote:
> On Fri, Apr 5, 2019 at 12:36 PM Andrey Ignatov <rdna@fb.com> wrote:
> >
> > v2->v3:
> > - simplify C based selftests by relying on variable offset stack access.
> >
> > v1->v2:
> > - add fs/proc/proc_sysctl.c mainteners to Cc:.
> >
> > The patch set introduces new BPF hook for sysctl.
> >
> > It adds new program type BPF_PROG_TYPE_CGROUP_SYSCTL and attach type
> > BPF_CGROUP_SYSCTL.
> >
> > BPF_CGROUP_SYSCTL hook is placed before calling to sysctl's proc_handler so
> > that accesses (read/write) to sysctl can be controlled for specific cgroup
> > and either allowed or denied, or traced.
> >
> > The hook has access to sysctl name, current sysctl value and (on write
> > only) to new sysctl value via corresponding helpers. New sysctl value can
> > be overridden by program. Both name and values (current/new) are
> > represented as strings same way they're visible in /proc/sys/. It is up to
> > program to parse these strings.
> >
> > To help with parsing the most common kind of sysctl value, vector of
> > integers, two new helpers are provided: bpf_strtol and bpf_strtoul with
> > semantic similar to user space strtol(3) and strtoul(3).
> >
> > The hook also provides bpf_sysctl context with two fields:
> > * @write indicates whether sysctl is being read (= 0) or written (= 1);
> > * @file_pos is sysctl file position to read from or write to, can be
> >   overridden.
> >
> > The hook allows to make better isolation for containerized applications
> > that are run as root so that one container can't change a sysctl and affect
> > all other containers on a host, make changes to allowed sysctl in a safer
> > way and simplify sysctl tracing for cgroups.
> 
> This sounds more like an LSM than BPF. 

not at all. the key difference is being cgroup scoped.
essentially for different containers.

> So sysctls can get blocked when
> new BPF is added to a cgroup? 

bpf prog is attached to this hook in a particular cgroup
and executed for sysctls for tasks that belong to that cgroup.

> Can the BPF be removed (or rather,
> what's the lifetime of such BPF?)

same as all other cgroup-bpf hooks.
Do you have a specific concern or just asking how life time of programs
is managed?
High level description of lifetime is here:
https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-lifetime.html

