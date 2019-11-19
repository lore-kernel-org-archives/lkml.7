Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8782F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIrx3VSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfKSP6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:58:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31551 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727591AbfKSP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574179124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYuT05bQRH1TDY+TH4L5voF9XhTBnlMPUL3L+VxlLhk=;
        b=NIrx3VSpR+2z71347mpCIptJwpfl3U7EgteqeE6rwtodnMuxDivjxxg6d9rO9BysQQtFSw
        TRW7yX0N1+iZEs2wNaCNm7RJmWUCVncVMeJ22TS5veqlaN+VVgJylGf5fADjCiv9XsVQOt
        hihd8LWBcPgIrz8h4JsQpqHQYhZUkW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-FPZIHhWjMtCcDYIFUQk-0g-1; Tue, 19 Nov 2019 10:58:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7C9C8DDCD6;
        Tue, 19 Nov 2019 15:58:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id D528360255;
        Tue, 19 Nov 2019 15:58:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 19 Nov 2019 16:58:37 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:58:26 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        will@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20191119155826.GA4739@redhat.com>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
 <ee75fc38-c3c8-3f9e-13ba-5c8312d61325@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ee75fc38-c3c8-3f9e-13ba-5c8312d61325@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FPZIHhWjMtCcDYIFUQk-0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19, Waiman Long wrote:
>
> On 11/13/19 5:21 AM, Peter Zijlstra wrote:
> > +static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entr=
y,
> > +=09=09=09=09      unsigned int mode, int wake_flags,
> > +=09=09=09=09      void *key)
> > +{
> > +=09struct task_struct *p =3D get_task_struct(wq_entry->private);
> > +=09bool reader =3D wq_entry->flags & WQ_FLAG_CUSTOM;
> > +=09struct percpu_rw_semaphore *sem =3D key;
> > +
> > +=09/* concurrent against percpu_down_write(), can get stolen */
> > +=09if (!__percpu_rwsem_trylock(sem, reader))
> > +=09=09return 1;
> > +
> > +=09list_del_init(&wq_entry->entry);
> > +=09smp_store_release(&wq_entry->private, NULL);
> > +
> > +=09wake_up_process(p);
> > +=09put_task_struct(p);
> > +
> > +=09return !reader; /* wake 'all' readers and 1 writer */
> > +}
> > +
>
> If I read the function correctly, you are setting the WQ_FLAG_EXCLUSIVE
> for both readers and writers and __wake_up() is called with an exclusive
> count of one. So only one reader or writer is woken up each time.

This depends on what percpu_rwsem_wake_function() returns. If it returns 1,
__wake_up_common() stops, exactly because all waiters have WQ_FLAG_EXCLUSIV=
E.

> However, the comment above said we wake 'all' readers and 1 writer. That
> doesn't match the actual code, IMO.

Well, "'all' readers" probably means "all readers before writer",

> To match the comments, you should
> have set WQ_FLAG_EXCLUSIVE flag only on writer. In this case, you
> probably don't need WQ_FLAG_CUSTOM to differentiate between readers and
> writers.

See above...

note also the

=09if (!__percpu_rwsem_trylock(sem, reader))
=09=09return 1;

at the start of percpu_rwsem_wake_function(). We want to stop wake_up_commo=
n()
as soon as percpu_rwsem_trylock() fails. Because we know that if it fails o=
nce
it can't succeed later. Although iiuc this can only happen if another (new)
writer races with __wake_up(&sem->waiters).


I guess WQ_FLAG_CUSTOM can be avoided, percpu_rwsem_wait() could do

=09if (read)
=09=09__add_wait_queue_entry_tail(...);
=09else {
=09=09wq_entry.flags |=3D WQ_FLAG_EXCLUSIVE;
=09=09__add_wait_queue(...);
=09}

but this is "unfair".

Oleg.

