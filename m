Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE55C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3207C21902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553193603;
	bh=JXTkUGXPXJNFc8tfPQMYvmPEi+TlCbTvKrvWrNyxzCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E4N93pWCH/Nyea73uqxcygjMEoUIhnStr0nD814rMLyWT0zq9JgRMoX0kA1dO8p/t
	 iBuqtGbKBijLU5vzRdjzH7J21mSADspYySONsUhwyJjo/JLcfqvvMlQ+8S+Oer9P0r
	 /9CGmH2KSkuew4PChtsWiW9u024q8hwdsFOWOdT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfCUSkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbfCUSkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:40:01 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27ABB2190A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553193600;
        bh=JXTkUGXPXJNFc8tfPQMYvmPEi+TlCbTvKrvWrNyxzCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xyXdkEVC6UDZ8NaV92U1oHCFJmx3HN3XpUCac/naOHTaJGkaZdIh7585K2Cd4ZU+0
         U4Xyk+6oXJPIdZs/QywuJuA1CnTVicGZD3aXGNrZkYugKNOmg0cUbqzGao4clT0CMy
         VOlKTRSqA/W8WUeR4JSfYkB1KhARl/16yC9KYekE=
Received: by mail-wm1-f47.google.com with SMTP id a184so3841692wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:40:00 -0700 (PDT)
X-Gm-Message-State: APjAAAV8v+8IBgA0vhIvWW3BKy+1O0WUTDTysZyiJUBc+bSNDlFOQwgk
        c0ZjE5Joap7QxxBjqm471kPOGdVdxQbrM5gSLcf9qQ==
X-Google-Smtp-Source: APXvYqxv3w0ZxWGWi7t4nGWfE8MxkMeH4FGZDfYRwsHn6h2/36Pr3cTA2BA28zLDl514R7PjEeboFw3GLdYS/UJG1D4=
X-Received: by 2002:a1c:9a41:: with SMTP id c62mr440748wme.108.1553193598741;
 Thu, 21 Mar 2019 11:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
 <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com>
 <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com> <20190321183713.GX5996@hirez.programming.kicks-ass.net>
In-Reply-To: <20190321183713.GX5996@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 11:39:47 -0700
X-Gmail-Original-Message-ID: <CALCETrW-Jn=nWOgYUdMhoS_Z6vYNmfYzt6P54FBOaWzp4kPvQQ@mail.gmail.com>
Message-ID: <CALCETrW-Jn=nWOgYUdMhoS_Z6vYNmfYzt6P54FBOaWzp4kPvQQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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

On Thu, Mar 21, 2019 at 11:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 21, 2019 at 11:25:44AM -0700, Linus Torvalds wrote:
> > On Thu, Mar 21, 2019 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > I dunno.  Lots of people at least use to have serious commercial interest in it.
> >
> > Yes, it used to be a big deal. But full virtualization has gotten a
> > lot more common and better.
> >
> > > Hey Xen folks, how close are we to being able to say "if you want to
> > > run a new kernel, you need to switch to PVH or similar"?
> >
> > I'd also like to know if we could perhaps at least limit PV to just
> > the thing that people care most deeply about.
> >
> > For example, maybe people notice that they really deeply care about
> > the PV spinlocks because they help a lot for some loads, but don't
> > care so much about the low-level CPU PV stuff any more because modern
> > CPUs do _those_ things so well these days.
> >
> > So it might not be an all-or-nothing thing, but a gradual "let's stop
> > supporting xyz under PV, because it causes pain and isn't worth it".
>
> So Juergen recently introduced PARAVIRT_XXL, which are exactly those
> bits of PV we can get rid of.
>
> This paravirt-me-harder config does indeed include the CR2 bits.
>
> I recently talked to Andrew Cooper about this, and he said Xen Dom0
> still needs all this :/

There were patches from last year to fix that:

https://lwn.net/Articles/753982/

I have no clue what the status is.
