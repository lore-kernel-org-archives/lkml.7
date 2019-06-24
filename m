Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69394C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C2020673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xKiw1Ebn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfFXUng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:43:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46815 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfFXUng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:43:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so13919107ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78Ty9brXQcBAfvxld/f2zy+UAZIXu4cST4SKUNq/ZtE=;
        b=xKiw1EbnAnfUc3KMYQZj1husi/5d7wyoTv61YtaUEGlAk6+Cx6H9nk+XtVFoVu8wol
         rz/1NwN++wuI6Uhe/UEaU6btO6xG82p4eMw84Xv06jebmDuhfsLsYfOQSTCTvKeKTFh5
         eFsNc5HO2n5oLw6Lv9jbXl5F20CICgwhKQhIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78Ty9brXQcBAfvxld/f2zy+UAZIXu4cST4SKUNq/ZtE=;
        b=N3XBDwTwfqG+KmCHmrS/dEr5VAT99k4ICaMYwwymXawAs+2NLuvTJXDFa1+a1DC5ON
         lZqdPSV2xk+NlYxH3XCdM2x5vxLpy/3aEVW8gDFpNMlYTN1WO9U+y4omGXYQXGacEGlo
         GHrVbdsMtpM1MIDfZ8SlatI7GK9IEVHvkU+D0YtIfU3tQAFHrzG3hDki74cBSibkHIDZ
         vc/7LkNiSObDQvopZeV4hGbjKph1mzBKPc5Wh1zPYQhpjF5mN5avb9xX7vy4M/coH07m
         u8g+PGdi19MZ9yI/M0kdv5jYudqN2Rp1wupuRk0m2hawTvPGlh+ClnPnHLxclQJcgRiq
         dX2A==
X-Gm-Message-State: APjAAAXcgtiwPRAcGfnbU9/hUdL+PtLsoNBgzRG+H4u1agx6CBLO3/BY
        kV2tgfCdmCWuaIT76+XH6BxMudaD1q+ZqvYGxZG/7w==
X-Google-Smtp-Source: APXvYqwFKhBC2b2GNzjVuUNDKWP5VikyikO+bWYhlqNLOi9JgXItzjYtroIAYeD1HVZqvuRGFwSJGCZ32ysvJzqvmGI=
X-Received: by 2002:a2e:8583:: with SMTP id b3mr64474038lji.171.1561409013254;
 Mon, 24 Jun 2019 13:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190624184534.209896-1-joel@joelfernandes.org>
 <20190624185214.GA211230@google.com> <CAG48ez3maGsRbN3qr8YVb6ZCw0FDq-7GqqiTiA4yEa1mebkubw@mail.gmail.com>
In-Reply-To: <CAG48ez3maGsRbN3qr8YVb6ZCw0FDq-7GqqiTiA4yEa1mebkubw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 24 Jun 2019 16:43:21 -0400
Message-ID: <CAEXW_YS0YR8Au+1f-sW_BT3xVONXKo9zrcSJMBwGJizyMw0xag@mail.gmail.com>
Subject: Re: [PATCH RFC v2] Convert struct pid count to refcount_t
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 3:10 PM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Jun 24, 2019 at 8:52 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Mon, Jun 24, 2019 at 02:45:34PM -0400, Joel Fernandes (Google) wrote:
> > > struct pid's count is an atomic_t field used as a refcount. Use
> > > refcount_t for it which is basically atomic_t but does additional
> > > checking to prevent use-after-free bugs.
> > >
> > > For memory ordering, the only change is with the following:
> > >  -    if ((atomic_read(&pid->count) == 1) ||
> > >  -         atomic_dec_and_test(&pid->count)) {
> > >  +    if (refcount_dec_and_test(&pid->count)) {
> > >               kmem_cache_free(ns->pid_cachep, pid);
> > >
> > > Here the change is from:
> > > Fully ordered --> RELEASE + ACQUIRE (as per refcount-vs-atomic.rst)
> > > This ACQUIRE should take care of making sure the free happens after the
> > > refcount_dec_and_test().
> > >
> > > The above hunk also removes atomic_read() since it is not needed for the
> > > code to work and it is unclear how beneficial it is. The removal lets
> > > refcount_dec_and_test() check for cases where get_pid() happened before
> > > the object was freed.
> [...]
> > I had a question about refcount_inc().
> >
> > As per Documentation/core-api/refcount-vs-atomic.rst , it says:
> >
> > A control dependency (on success) for refcounters guarantees that
> > if a reference for an object was successfully obtained (reference
> > counter increment or addition happened, function returned true),
> > then further stores are ordered against this operation.
> >
> > However, in refcount_inc() I don't see any memory barriers (in the case where
> > CONFIG_REFCOUNT_FULL=n). Is the documentation wrong?
>
> That part of the documentation only talks about cases where you have a
> control dependency on the return value of the refcount operation. But
> refcount_inc() does not return a value, so this isn't relevant for
> refcount_inc().
>
> Also, AFAIU, the control dependency mentioned in the documentation has
> to exist *in the caller* - it's just pointing out that if you write
> code like the following, you have a control dependency between the
> refcount operation and the write:
>
>     if (refcount_inc_not_zero(&obj->refcount)) {
>       WRITE_ONCE(obj->x, y);
>     }
>
> For more information on the details of this stuff, try reading the
> section "CONTROL DEPENDENCIES" of Documentation/memory-barriers.txt.

Makes sense now, thank you Jann!

 - Joel
