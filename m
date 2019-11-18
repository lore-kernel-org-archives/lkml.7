Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB55CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7CB218AE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5JJ+Ws9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKRQ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:28:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35358 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbfKRQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574094532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbgAKR+UZDyd5dRmL+L1xv5GWoM1EVRNJf8t4zbNXts=;
        b=h5JJ+Ws9JZXTIGEpeQefJIAKqY0nN781gtUoeSa3tf0YUqsYndyQ1way0yfQFKXvKkHjRi
        0FOf71NbMEXs34qPzb6LkeJ7Y2HeSrf/UOVPYfnNIT8K+Byl8TImNXZm8Vwso9lCSzRUxR
        9jXyBqO7NSdtauLb4SJqsARz6sBFJNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-YZuYxyFoNkWDRwJZsfaCKQ-1; Mon, 18 Nov 2019 11:28:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9196C8C451C;
        Mon, 18 Nov 2019 16:28:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id F3AC4100EBB8;
        Mon, 18 Nov 2019 16:28:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 18 Nov 2019 17:28:49 +0100 (CET)
Date:   Mon, 18 Nov 2019 17:28:38 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH 4/5] locking/percpu-rwsem: Extract
 __percpu_down_read_trylock()
Message-ID: <20191118162837.GA3025@redhat.com>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.868390100@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20191113102855.868390100@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: YZuYxyFoNkWDRwJZsfaCKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, sorry for delay.

I'll re-read this series tomorrow, but everything looks correct at first
glance...

Except one very minor problem in this patch, see below.

On 11/13, Peter Zijlstra wrote:
>
> -bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
> +static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
>  {
>  =09__this_cpu_inc(*sem->read_count);
> =20
> @@ -70,14 +70,21 @@ bool __percpu_down_read(struct percpu_rw
>  =09 * If !readers_block the critical section starts here, matched by the
>  =09 * release in percpu_up_write().
>  =09 */
> -=09if (likely(!smp_load_acquire(&sem->readers_block)))
> +=09if (likely(!atomic_read_acquire(&sem->readers_block)))

I don't think this can be compiled ;) ->readers_block is "int" until the ne=
xt
patch makes it atomic_t and renames to ->block.

And. I think __percpu_down_read_trylock() should do

=09if (atomic_read(&sem->block))
=09=09return false;

at the start, before __this_cpu_inc(read_count).

Suppose that the pending writer sleeps in rcuwait_wait_event(readers_active=
_check).
If the new reader comes, it is better to not wake up that writer.

Oleg.

