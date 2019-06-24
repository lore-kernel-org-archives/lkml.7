Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF89C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DEC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v96EkVK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfFXTKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:10:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33725 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfFXTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:10:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id f80so10634903oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6efmcv3HY90Ho573RNTB0lMwiTQ78McbsH3sWRMqrYk=;
        b=v96EkVK0rNaZLFxkF7opm/k0qR7ZGCW1EEBz6MJCo2tipnxwyTyODH+yLTEszkDcIQ
         NHQcjyr+c+mCBKXqHh0Fil2CcQLb8YFQU/Ksf1c+N61qsIoRjLymFo4BDX1PcblcIznf
         qjMucXWC2ExPQvzYgHNCFcFpiR63f8dr4LJVvRdkX/iHYoc9YrLKT9NClTlMAyb7cmJI
         Zc9EHtzZOXhZSVY1Bv6pTAALVcCCaXT+UXCPqx1dAE+oAS30WbI/r5i9cs3ALUSz5lcs
         lZo2GFSpntTnejnszDUgtV1QuiTqPU1jWyptpkyvyTC99a3417aIPvRonjbeNsbi0Z3d
         +bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6efmcv3HY90Ho573RNTB0lMwiTQ78McbsH3sWRMqrYk=;
        b=GIKe2d8toKi/RCWSzZ1aeSeSv1dd099ZFdcQZvk2bXVNlT2DkbUExN+IdJ7t1ZsX1X
         /GR0DP9rwpJ0VIwKnvrTpZgxWTT0L7a/voT+5AZ+EMkDwq6amBZfFefGtjkUpMSAlRCu
         +6VLnUMRKW4eOpVvhdFB2XHEegABePLhkQmtQP0XAkpeqykn40LCeNEreIcMMQAm3K3w
         hY9ICetBRveyTB+VwGxGh8i3qRd1RvVozMjTRZnPZ76rd8SsFWURRSYXxoGrp9m3HXky
         XLp9HV6y3u1h6Gv3msix54LIZBi7u6dcWcO1V4bAIZ1HG8TW+u1wVDtv0cVcs/KEyzdD
         x2aA==
X-Gm-Message-State: APjAAAVZeRZxPBfhisMUdEmt8Koht4DEetVBnbWqM0VYfQdgWB8zIQj+
        hglvp1SSQn5UhOWdgvkTHF/Ql1E+0zp2QVpBS75JushKkNw=
X-Google-Smtp-Source: APXvYqw0gQqv1j/JCLObxmpgpk4iVhXTcuU7fna2mHaFxbZeb/BskX9xLUo/yKTIqMgCAmVfzWTQUSwP+29xaRRrPr0=
X-Received: by 2002:aca:1b04:: with SMTP id b4mr11524190oib.157.1561403441214;
 Mon, 24 Jun 2019 12:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190624184534.209896-1-joel@joelfernandes.org> <20190624185214.GA211230@google.com>
In-Reply-To: <20190624185214.GA211230@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 24 Jun 2019 21:10:15 +0200
Message-ID: <CAG48ez3maGsRbN3qr8YVb6ZCw0FDq-7GqqiTiA4yEa1mebkubw@mail.gmail.com>
Subject: Re: [PATCH RFC v2] Convert struct pid count to refcount_t
To:     Joel Fernandes <joel@joelfernandes.org>
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

On Mon, Jun 24, 2019 at 8:52 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Mon, Jun 24, 2019 at 02:45:34PM -0400, Joel Fernandes (Google) wrote:
> > struct pid's count is an atomic_t field used as a refcount. Use
> > refcount_t for it which is basically atomic_t but does additional
> > checking to prevent use-after-free bugs.
> >
> > For memory ordering, the only change is with the following:
> >  -    if ((atomic_read(&pid->count) == 1) ||
> >  -         atomic_dec_and_test(&pid->count)) {
> >  +    if (refcount_dec_and_test(&pid->count)) {
> >               kmem_cache_free(ns->pid_cachep, pid);
> >
> > Here the change is from:
> > Fully ordered --> RELEASE + ACQUIRE (as per refcount-vs-atomic.rst)
> > This ACQUIRE should take care of making sure the free happens after the
> > refcount_dec_and_test().
> >
> > The above hunk also removes atomic_read() since it is not needed for the
> > code to work and it is unclear how beneficial it is. The removal lets
> > refcount_dec_and_test() check for cases where get_pid() happened before
> > the object was freed.
[...]
> I had a question about refcount_inc().
>
> As per Documentation/core-api/refcount-vs-atomic.rst , it says:
>
> A control dependency (on success) for refcounters guarantees that
> if a reference for an object was successfully obtained (reference
> counter increment or addition happened, function returned true),
> then further stores are ordered against this operation.
>
> However, in refcount_inc() I don't see any memory barriers (in the case where
> CONFIG_REFCOUNT_FULL=n). Is the documentation wrong?

That part of the documentation only talks about cases where you have a
control dependency on the return value of the refcount operation. But
refcount_inc() does not return a value, so this isn't relevant for
refcount_inc().

Also, AFAIU, the control dependency mentioned in the documentation has
to exist *in the caller* - it's just pointing out that if you write
code like the following, you have a control dependency between the
refcount operation and the write:

    if (refcount_inc_not_zero(&obj->refcount)) {
      WRITE_ONCE(obj->x, y);
    }

For more information on the details of this stuff, try reading the
section "CONTROL DEPENDENCIES" of Documentation/memory-barriers.txt.
