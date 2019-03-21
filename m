Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97321C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC5E21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553193520;
	bh=EcEOQDWhm6wdeAevQFNP2w6rDui3fk1jo2Y9l5I1ypo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tBtcanTO9PMBI8HP4D1RdznXRMYcqFksXxRRCj9kfUg1j3fN1Awh7v4wgtDhFrQi8
	 B3OCeFMBxTR2KJktuRj9QenosMpXhCrW8Z8d5UB4G8N8jW3rRaszHli+DnQec1+C31
	 cxNZs00ifXwjTjfOwOtcgmEBC4A2ESCTRX725OPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfCUSij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbfCUSii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:38:38 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C7BD21902
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553193517;
        bh=EcEOQDWhm6wdeAevQFNP2w6rDui3fk1jo2Y9l5I1ypo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eSdKetQZvbHpMYUZkJU60pyu5H2z5JqbwYwzItjUX7grzlIcKD/RB1JZU4igQuBhJ
         H30x/tfH3Jibh9lMewy/6Ivj9g5noWFkBr4+A5DjQdeW7bE5Zklnx9paCo7GCtBrI1
         cNGvVyqmDpsc/Bk4izRPCDx8X+EtEjpXPIRF0bno=
Received: by mail-wr1-f49.google.com with SMTP id j9so7787963wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:38:37 -0700 (PDT)
X-Gm-Message-State: APjAAAXd6wZdmLjltNEjzGSEsDe6IJafenZlAqigG/Zr1g2Q7LeZoPz9
        7W78TpLOI+VQTsABUQR54B0IPZtGKGJumxc9pO7oCA==
X-Google-Smtp-Source: APXvYqxfyMm/86cdKvhxFzIkbFr+IWiXhHBv3SAKIuJIypruekRSbI3kll7F/1EzuUwctcuIMeKUOSfRXND4aOFXGIg=
X-Received: by 2002:adf:f011:: with SMTP id j17mr497755wro.330.1553193516194;
 Thu, 21 Mar 2019 11:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
 <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com> <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 11:38:25 -0700
X-Gmail-Original-Message-ID: <CALCETrVUUbSv_pQyVXUSmKV5Jw9DN1y2ib4zGix5Y-9DXw2nGg@mail.gmail.com>
Message-ID: <CALCETrVUUbSv_pQyVXUSmKV5Jw9DN1y2ib4zGix5Y-9DXw2nGg@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:33 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 21, 2019 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > I dunno.  Lots of people at least use to have serious commercial interest in it.
>
> Yes, it used to be a big deal. But full virtualization has gotten a
> lot more common and better.
>
> > Hey Xen folks, how close are we to being able to say "if you want to
> > run a new kernel, you need to switch to PVH or similar"?
>
> I'd also like to know if we could perhaps at least limit PV to just
> the thing that people care most deeply about.
>
> For example, maybe people notice that they really deeply care about
> the PV spinlocks because they help a lot for some loads, but don't
> care so much about the low-level CPU PV stuff any more because modern
> CPUs do _those_ things so well these days.
>
> So it might not be an all-or-nothing thing, but a gradual "let's stop
> supporting xyz under PV, because it causes pain and isn't worth it".
>

I suspect we'll want PV spinlocks and other goodies like PV TLB
shootdown for a long time.  The stuff I'd like to kill eventually is
the PV "I'm not actually at CPL 0 so I'm faking it" part.
