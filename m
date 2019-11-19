Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09DEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BBC222A9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gP6mxHTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfKSNu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:50:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50547 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbfKSNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574171425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hp7W7RNfhc4fmpQq4Mc6vtf7wCYXA0mzEIx90nGdbd0=;
        b=gP6mxHTpvwuPWEu/sI7Yt8f4TxI5uoD0nN3UXCoMc4PlnUG3wkzKQEP5UO/NUhWMVB/XdT
        66J7D4p0CZ4lBsS+D69NT/1PWf+lYUPsZmEjmVa2Nd1foZwsz5SaHJ+IAQIFR4dHSgEui+
        1LnoQCdT0sn7YNmPHqnPo7ywXh2oMyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-8AEZ8-_sNK-LibEEUlzj0A-1; Tue, 19 Nov 2019 08:50:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06F7B107AD4E;
        Tue, 19 Nov 2019 13:50:21 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F8265037E;
        Tue, 19 Nov 2019 13:50:11 +0000 (UTC)
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, dave@stgolabs.net, jack@suse.com
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ee75fc38-c3c8-3f9e-13ba-5c8312d61325@redhat.com>
Date:   Tue, 19 Nov 2019 08:50:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191113102855.925208237@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8AEZ8-_sNK-LibEEUlzj0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 5:21 AM, Peter Zijlstra wrote:
> +static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
> +=09=09=09=09      unsigned int mode, int wake_flags,
> +=09=09=09=09      void *key)
> +{
> +=09struct task_struct *p =3D get_task_struct(wq_entry->private);
> +=09bool reader =3D wq_entry->flags & WQ_FLAG_CUSTOM;
> +=09struct percpu_rw_semaphore *sem =3D key;
> +
> +=09/* concurrent against percpu_down_write(), can get stolen */
> +=09if (!__percpu_rwsem_trylock(sem, reader))
> +=09=09return 1;
> +
> +=09list_del_init(&wq_entry->entry);
> +=09smp_store_release(&wq_entry->private, NULL);
> +
> +=09wake_up_process(p);
> +=09put_task_struct(p);
> +
> +=09return !reader; /* wake 'all' readers and 1 writer */
> +}
> +
> +static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool read=
er)
> +{
> +=09DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
> +=09bool wait;
> +
> +=09spin_lock_irq(&sem->waiters.lock);
> +=09/*
> +=09 * Serialize against the wakeup in percpu_up_write(), if we fail
> +=09 * the trylock, the wakeup must see us on the list.
> +=09 */
> +=09wait =3D !__percpu_rwsem_trylock(sem, reader);
> +=09if (wait) {
> +=09=09wq_entry.flags |=3D WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
> +=09=09__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
> +=09}
> +=09spin_unlock_irq(&sem->waiters.lock);
> +
> +=09while (wait) {
> +=09=09set_current_state(TASK_UNINTERRUPTIBLE);
> +=09=09if (!smp_load_acquire(&wq_entry.private))
> +=09=09=09break;
> +=09=09schedule();
> +=09}

If I read the function correctly, you are setting the WQ_FLAG_EXCLUSIVE
for both readers and writers and __wake_up() is called with an exclusive
count of one. So only one reader or writer is woken up each time.
However, the comment above said we wake 'all' readers and 1 writer. That
doesn't match the actual code, IMO. To match the comments, you should
have set WQ_FLAG_EXCLUSIVE flag only on writer. In this case, you
probably don't need WQ_FLAG_CUSTOM to differentiate between readers and
writers.

Cheers,
Longman

