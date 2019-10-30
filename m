Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C20CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659A320656
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEBALLbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfJ3OVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:21:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46241 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3OVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572445291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joBUg/8LLvLAx6tJ+C+Ow4ZMZTAOPeKx8j+cSlr0+Rc=;
        b=UEBALLbJbODzpX9laanNwmRJbPaqkJ8eF7LFBKEWOP8tUr6DI6FcORQpb8O3x9+o7tAIJF
        UoJgGZpwD4z/2eI6mzQMbDxnftwu1cFcvxu32AOuo8D8o0Z9dRYKq2oisKv+ahUE+II3V+
        DpCFZ7SZELvQKAt55gbV4xAjss8S9Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-UkCuo7D2PL-i8Nnb9m9KVw-1; Wed, 30 Oct 2019 10:21:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 248762EDD;
        Wed, 30 Oct 2019 14:21:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.206.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6289760876;
        Wed, 30 Oct 2019 14:21:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 30 Oct 2019 15:21:25 +0100 (CET)
Date:   Wed, 30 Oct 2019 15:21:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191030142110.GA17800@redhat.com>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190806161741.GC21454@redhat.com>
 <20190806171515.GR2349@hirez.programming.kicks-ass.net>
 <20190807095657.GA24112@redhat.com>
 <20191029184739.GA3079@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191029184739.GA3079@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UkCuo7D2PL-i8Nnb9m9KVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29, Peter Zijlstra wrote:
>
> I like that symmetry, but see below ...

...

> > void __percpu_up_read(struct percpu_rw_semaphore *sem)
> > {
> > =09smp_mb();
> >
> > =09__this_cpu_dec(*sem->read_count);
> >
> =09preempt_enable();
> > =09wake_up(&sem->waiters);
> =09preempt_disable()
>
> and this (sadly) means there's a bunch of back-to-back
> preempt_disable()+preempt_enable() calls.

Hmm. Where did these enable+disable come from?

=09void __percpu_up_read(struct percpu_rw_semaphore *sem)
=09{
=09=09smp_mb();

=09=09__this_cpu_dec(*sem->read_count);

=09=09wake_up(&sem->waiters);
=09}

should work just fine?

Oleg.

