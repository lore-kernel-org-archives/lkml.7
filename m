Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B7AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3336722CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu8rI1Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfIDPhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:37:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34461 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731360AbfIDPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:37:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id z21so16344603lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Ye9YWn7/omSBzztqXrART/0Y1Y+95q9ms0+sQVUL6s=;
        b=Tu8rI1Kuamg9Y649dTRy6XriM1ep1WSj4qoLBaUx7TjgzUtiI/VEEby+la8mEBB+PG
         Xob6GPod8Ha5e3Ql6YmSLrIt0VPwwW5obmWhP4XmSFp6kBz55UhtazRKHVcLIhVxZ//7
         1BPVanhCbQj82kRCTkiF0rX2mWpspkpCTlkh/dXJa0rrJBOulWhJ6SKVbtcJo2Bz8wBs
         SW0JMWKmqtd74JWL921q4RgUWsjLjeTu/4LlLiIjKU+vdznmtuaGqFQe8FYG2sYFDDHF
         o4sug+VflmpMgVuiPzwZZ3/hMP9mTRTeuLpolRv5BEMEf7pbBoz9okuIWD5yjYdqyjiB
         s/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Ye9YWn7/omSBzztqXrART/0Y1Y+95q9ms0+sQVUL6s=;
        b=C3410y6FVNdCKaWsZno9PYaIuJ6Hs+7m+8i177KEwK+MdXoqFMCBSojoJLneNIrQpa
         Hb4TySesnxecT6eNnBA8m9Am29sL26VTtiSOwo8BKIWMHZ9bkYpho+LtSPAA3fvzLme+
         xpNq37jJtEVFeKCCR+eq3lD3FktnwkiFh1rBf8oWQhGtZZKluwbCAqx3+H/XJKmJwE2t
         6jQr79DtWKxrrksIytESnVaxmWErDXpLvB00mL9OUm3ZWRKgc+2uE1waGrxGkGyEbNkh
         ppZqiK3N2nlTuFwIHcm/L1/LFmmhM4EKpJr0lPumDuaKD3hUTwKl1l5qmVzkbGsH0mVx
         UqJQ==
X-Gm-Message-State: APjAAAWCh4QQd6rvlcRu53bM9OTY7pFleS9JzyU3t0zYan3qLehtk3cc
        0nahkmi+vdBuNA1pUIxSLBljGWRpNh6w6lkAZIE=
X-Google-Smtp-Source: APXvYqxVMjCIJsj8a0ahcD1Ttkk6UogqOJ9pBT3H31FXsfLdy0wTZNjRvPRuriAaSVEmYEHYFc/9ssoPjOp9pmWdrC8=
X-Received: by 2002:ac2:558a:: with SMTP id v10mr3132487lfg.162.1567611453657;
 Wed, 04 Sep 2019 08:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190903154340.860299-1-rkrcmar@redhat.com> <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com> <20190904042310.GA159235@google.com>
 <20190904081448.GZ2349@hirez.programming.kicks-ass.net> <20190904131154.GF144846@google.com>
 <CAADnVQL3CsB6z98BFWd8wn7WKk+W4UVH2NbzrhJgeaU-D-n3ug@mail.gmail.com> <20190904153330.GI240514@google.com>
In-Reply-To: <20190904153330.GI240514@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Sep 2019 08:37:22 -0700
Message-ID: <CAADnVQ+Cwe27pwTwJ3TNiatKe8dXAwXBf_2jJDqxB0RFUbr7_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jirka_Hladk=C3=BD?= <jhladky@redhat.com>,
        =?UTF-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        X86 ML <x86@kernel.org>, Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:33 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Sep 04, 2019 at 08:26:52AM -0700, Alexei Starovoitov wrote:
> > On Wed, Sep 4, 2019 at 6:14 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > True. However, for kprobes-based BPF program - it does check for kernel
> > > version to ensure that the BPF program is built against the right kernel
> > > version (in order to ensure the program is built against the right set of
> > > kernel headers). If it is not, then BPF refuses to load the program.
> >
> > This is not true anymore. Users found few ways to workaround that check
> > in practice. It became useless and it was deleted some time ago.
>
> Wow, Ok! Interesting!

the other part of your email says about kernel header requirement.
This is not true any more as well :)
BTF relocations are already supported by the kernel, llvm, libbpf,
bpftool, pahole.
We'll be posting sample code soon.
