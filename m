Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A620718
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8EkUU8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfKSQ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:29:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59196 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728212AbfKSQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574180945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIK0+i5q+Lj6zrxj0R2LIAra704J9qSy97urLw0B4Lg=;
        b=i8EkUU8rpLJIV3cD1F9+NZrkwxNV8uLr+pNeGvFiob6Fy9RA36O4MviDc+wluweV/tSVVK
        YDy7esMp70hDc65HR5l/wY6SCIIiQamGvgwZTflwvq8l8/WcCMy0kxvwoTb9lC1ITra4yP
        z7ANTngIiyLVN/tZVEV5qmFsKvEpMS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-frUyA5U1NeOhTQjcufm6dg-1; Tue, 19 Nov 2019 11:29:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D13107ACC5;
        Tue, 19 Nov 2019 16:29:00 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E821B1001925;
        Tue, 19 Nov 2019 16:28:50 +0000 (UTC)
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        will@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, dave@stgolabs.net, jack@suse.com
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
 <ee75fc38-c3c8-3f9e-13ba-5c8312d61325@redhat.com>
 <20191119155826.GA4739@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <efc4ba6b-b113-b37f-c785-b03df1afc860@redhat.com>
Date:   Tue, 19 Nov 2019 11:28:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191119155826.GA4739@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: frUyA5U1NeOhTQjcufm6dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 10:58 AM, Oleg Nesterov wrote:
> On 11/19, Waiman Long wrote:
>> On 11/13/19 5:21 AM, Peter Zijlstra wrote:
>>> +static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entr=
y,
>>> +=09=09=09=09      unsigned int mode, int wake_flags,
>>> +=09=09=09=09      void *key)
>>> +{
>>> +=09struct task_struct *p =3D get_task_struct(wq_entry->private);
>>> +=09bool reader =3D wq_entry->flags & WQ_FLAG_CUSTOM;
>>> +=09struct percpu_rw_semaphore *sem =3D key;
>>> +
>>> +=09/* concurrent against percpu_down_write(), can get stolen */
>>> +=09if (!__percpu_rwsem_trylock(sem, reader))
>>> +=09=09return 1;
>>> +
>>> +=09list_del_init(&wq_entry->entry);
>>> +=09smp_store_release(&wq_entry->private, NULL);
>>> +
>>> +=09wake_up_process(p);
>>> +=09put_task_struct(p);
>>> +
>>> +=09return !reader; /* wake 'all' readers and 1 writer */
>>> +}
>>> +
>> If I read the function correctly, you are setting the WQ_FLAG_EXCLUSIVE
>> for both readers and writers and __wake_up() is called with an exclusive
>> count of one. So only one reader or writer is woken up each time.
> This depends on what percpu_rwsem_wake_function() returns. If it returns =
1,
> __wake_up_common() stops, exactly because all waiters have WQ_FLAG_EXCLUS=
IVE.
>
>> However, the comment above said we wake 'all' readers and 1 writer. That
>> doesn't match the actual code, IMO.
> Well, "'all' readers" probably means "all readers before writer",
>
>> To match the comments, you should
>> have set WQ_FLAG_EXCLUSIVE flag only on writer. In this case, you
>> probably don't need WQ_FLAG_CUSTOM to differentiate between readers and
>> writers.
> See above...
>
> note also the
>
> =09if (!__percpu_rwsem_trylock(sem, reader))
> =09=09return 1;
>
> at the start of percpu_rwsem_wake_function(). We want to stop wake_up_com=
mon()
> as soon as percpu_rwsem_trylock() fails. Because we know that if it fails=
 once
> it can't succeed later. Although iiuc this can only happen if another (ne=
w)
> writer races with __wake_up(&sem->waiters).
>
>
> I guess WQ_FLAG_CUSTOM can be avoided, percpu_rwsem_wait() could do
>
> =09if (read)
> =09=09__add_wait_queue_entry_tail(...);
> =09else {
> =09=09wq_entry.flags |=3D WQ_FLAG_EXCLUSIVE;
> =09=09__add_wait_queue(...);
> =09}
>
> but this is "unfair".

Thanks for the explanation. That clarifies my understanding of the patch.

Cheers,
Longman

