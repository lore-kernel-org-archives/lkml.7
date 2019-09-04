Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C25C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCF822CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OFhv/wTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfIDPlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:41:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44716 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbfIDPls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:41:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so8456593pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YkmhvjJ+pgtpfGA/ry21rjZ5udwkyVDS4daj2inyhQ8=;
        b=OFhv/wTfXpSTWbBxwvvpdfxytTFQfdfLwybiAAs8ZI3aeZcSZ14nGa9N0Ck/UxTDre
         nNoAjxYJb2pPTzKLzW5Ymq7uYV8Vw0raPkOvC8FwN9GTH4pkXQUhSIjORduKU0KSkOHk
         C9TuRPBE0HLxwuffjKlcqE00J3oNup4c59V44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YkmhvjJ+pgtpfGA/ry21rjZ5udwkyVDS4daj2inyhQ8=;
        b=iU77W+6BmL4PzwfqOIvFsdHaegiBhygs1hKGPZxREynzi9nNV8deOjj2NHHFtreo7W
         ztceHQw2DkmDZz9WQT0RtpP2/j0x00QhS2wUfbtX7zLeO97+Tj91XCSspo/8MrHeRbhV
         7xMDL0QaVbbA0fqfqDLC5Wyvc+ieN6n35613ipbhRfHITWkj87QZO6tF6wByyHUrv3Vx
         JmeGqCligT27jgeeGMchHLdNjx6h2lnQqWTUE9+IxHK3iY0Jr+VVbsK/EFc7V0YCxD5A
         DlVFdwWEhwzt7Xnv2PbDLChvPDHSpSUCFo6RlGzWbpSlkU0t4ncSOrvskRdT0e7evWtM
         +cDg==
X-Gm-Message-State: APjAAAVHunsYThZ030KGFbAhUfz63ecc4VFJ8oFFWL8dAvZ8OU9FrIx4
        hRf+/tkNmd4bHNwcDljDsq5VdA==
X-Google-Smtp-Source: APXvYqxzKLSHeDd3GxD4h2HrBNmnJjwUJMWD1eNS6BbI6eH4aYU4FofiSiOeVMz3IHyDliJVu6XuWA==
X-Received: by 2002:a65:5342:: with SMTP id w2mr35297459pgr.261.1567611708039;
        Wed, 04 Sep 2019 08:41:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w6sm4952665pfw.84.2019.09.04.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 08:41:47 -0700 (PDT)
Date:   Wed, 4 Sep 2019 11:41:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?iso-8859-1?Q?Hladk=FD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        X86 ML <x86@kernel.org>, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904154146.GK240514@google.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904081448.GZ2349@hirez.programming.kicks-ass.net>
 <20190904131154.GF144846@google.com>
 <CAADnVQL3CsB6z98BFWd8wn7WKk+W4UVH2NbzrhJgeaU-D-n3ug@mail.gmail.com>
 <20190904153330.GI240514@google.com>
 <CAADnVQ+Cwe27pwTwJ3TNiatKe8dXAwXBf_2jJDqxB0RFUbr7_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+Cwe27pwTwJ3TNiatKe8dXAwXBf_2jJDqxB0RFUbr7_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:37:22AM -0700, Alexei Starovoitov wrote:
> On Wed, Sep 4, 2019 at 8:33 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, Sep 04, 2019 at 08:26:52AM -0700, Alexei Starovoitov wrote:
> > > On Wed, Sep 4, 2019 at 6:14 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > True. However, for kprobes-based BPF program - it does check for kernel
> > > > version to ensure that the BPF program is built against the right kernel
> > > > version (in order to ensure the program is built against the right set of
> > > > kernel headers). If it is not, then BPF refuses to load the program.
> > >
> > > This is not true anymore. Users found few ways to workaround that check
> > > in practice. It became useless and it was deleted some time ago.
> >
> > Wow, Ok! Interesting!
> 
> the other part of your email says about kernel header requirement.
> This is not true any more as well :)
> BTF relocations are already supported by the kernel, llvm, libbpf,
> bpftool, pahole.
> We'll be posting sample code soon.

Ok, this landscape seems to be changing quite a bit. I was going by what I
already know... Looking forward to catching up with the latest. Sorry,

thanks,

 - Joel

