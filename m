Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BCBC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9009A206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9ZNN4wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgAGMYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:24:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgAGMYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578399850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zq5up57K7Pjwufw3MKWfZ0KVwNjIGjwmZL8AfNiaHYY=;
        b=D9ZNN4wzprzQvFtwjLVB+fIoKazSB0DaBGQ1rBc3Jxk8rxbgOrpoHWXrCotxb1VuaZ9kZa
        w0ka66FqxdCQWjmJhiFCb7uSKJD1RZnS6oHIX8MEoi+4YkJ4RHWrr16UDbN3YKw6q09ytv
        IXnevhCfOuZQMBUF4EfLI8887Co6Tk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-nrVIErl4P1yERw_t-1G8cQ-1; Tue, 07 Jan 2020 07:24:09 -0500
X-MC-Unique: nrVIErl4P1yERw_t-1G8cQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1C10911FC;
        Tue,  7 Jan 2020 12:24:06 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-227.str.redhat.com [10.33.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23AF380600;
        Tue,  7 Jan 2020 12:24:01 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH glibc 09/13] glibc: Perform rseq(2) registration at C startup and thread creation (v13)
References: <20200106155713.397-1-mathieu.desnoyers@efficios.com>
        <20200106155713.397-10-mathieu.desnoyers@efficios.com>
Date:   Tue, 07 Jan 2020 13:23:59 +0100
In-Reply-To: <20200106155713.397-10-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 6 Jan 2020 10:57:09 -0500")
Message-ID: <871rsbv4io.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Register rseq(2) TLS for each thread (including main), and unregister
> for each thread (excluding main). "rseq" stands for Restartable
> Sequences.
>
> See the rseq(2) man page proposed here:
>   https://lkml.org/lkml/2018/9/19/647
>
> This patch is based on glibc-2.30. The rseq(2) system call was merged
> into Linux 4.18.

This patch needs to be updated for some be/le abilist splits.
Big-endian ABI lists for arm, microblaze, sh, appear to be missing.
This is something that can be checked with build-many-glibcs.py.

> diff --git a/manual/threads.texi b/manual/threads.texi
> index 0858ef8f92..059f781120 100644
> --- a/manual/threads.texi
> +++ b/manual/threads.texi
> @@ -881,3 +881,20 @@ Behaves like @code{pthread_timedjoin_np} except that the absolute time in
>  @c pthread_spin_unlock
>  @c pthread_testcancel
>  @c pthread_yield
> +
> +@node Restartable Sequences
> +@section Restartable Sequences
> +@cindex rseq
> +
> +This section describes the @glibcadj{} Restartable Sequences integration.
> +
> +The @glibcadj{} implements a __rseq_abi TLS symbol to interact with the
   @Theglibc{}                  @code{__rseq_abi}


> +Restartable Sequences system call (Linux-specific). The layout of this
> +structure is defined by the Linux kernel rseq.h UAPI. Registration of each
> +thread's __rseq_abi is performed by @glibcadj{} at libc initialization and
                                       @theglibc{}
           @code{__rseq_abi}
> +pthread creation.

> +Each supported architecture provide a RSEQ_SIG signature in sys/rseq.h. That
                                         @code{RSEQ_SIG}       @file{sys/rseq.h} 

> +signature is expected to be present in the code before each Restartable
> +Sequences abort handler. Failure to provide the expected signature may
> +terminate the process with a Segmentation fault.


Two spaces at the end of setences, please.

The manual should use @deftypevar to create an index entry etc. for
__rseq_abi.  See argp_program_version for an example of how to do this.

I think current policy is to have documentation for at least the minimum
functionality in the manual.  I understand that it makes it a lot of
work to write patches which add system call wrappers.

Thanks,
Florian

