Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96297C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C0B2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+nSwUgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfLQVRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:17:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59470 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726764AbfLQVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576617473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8EUwU0NKx9PEFE1/mdJWHDaQT2bQr/AQjmCTI7nYuTs=;
        b=L+nSwUgxt3Xrkoic9Pscn4t94KKjj0vn6SSdeMSyR2CuXh1gl9MJyjIn+xjkJG5CvLU/Bk
        AtT4AgmiImcfz27DbUWCVJdHTKpg/VihzmG8F16XSo+9+/WPZNdn9p23YZmxfGZYb2K9zB
        /A0rSU74CLjwzOIlp7OP4ozbr8eWMz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-eALN0hAEOJKXe1snJGl-4A-1; Tue, 17 Dec 2019 16:17:49 -0500
X-MC-Unique: eALN0hAEOJKXe1snJGl-4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4ACB800D41;
        Tue, 17 Dec 2019 21:17:47 +0000 (UTC)
Received: from redhat.com (ovpn-126-8.rdu2.redhat.com [10.10.126.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E55935D9E1;
        Tue, 17 Dec 2019 21:17:46 +0000 (UTC)
Date:   Tue, 17 Dec 2019 18:17:45 -0300
From:   "Herton R. Krzesinski" <herton@redhat.com>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
        akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        malat@debian.org, joel@joelfernandes.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, jay.vosburgh@canonical.com,
        ioanna.alifieraki@gmail.com
Subject: Re: [PATCH] Revert "ipc,sem: remove uneeded sem_undo_list lock usage
 in exit_sem()"
Message-ID: <20191217211745.GT7463@unknown>
References: <20191211191318.11860-1-ioanna-maria.alifieraki@canonical.com>
 <d66d41fe-212f-effd-905a-5966a96ddb6e@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66d41fe-212f-effd-905a-5966a96ddb6e@colorfullife.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 08:04:53PM +0100, Manfred Spraul wrote:
> Hi Ioanna,
> 
> On 12/11/19 8:13 PM, Ioanna Alifieraki wrote:
> > This reverts commit a97955844807e327df11aa33869009d14d6b7de0.
> > 
> > Commit a97955844807 ("ipc,sem: remove uneeded sem_undo_list lock usage
> > in exit_sem()") removes a lock that is needed.
> 
> Yes, you are right, the lock is needed.
> 
> The documentation is already correct:
> 
> sem_undo_list.list_proc: undo_list->lock for write.
> 
> [...]
> > Removing elements from list_id is safe for both exit_sem() and freeary()
> > due to sem_lock().  Removing elements from list_proc is not safe;
> 
> Correct, removing elements is not safe.
> 
> Removing one element would be ok, as we hold sem_lock.
> 
> But if there are two elements, then we don't hold sem_lock for the 2nd
> element, and thus the list is corrupted.

I think that's what I overlooked/missed back then, sorry for the bug.

> 
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=1694779
> > 
> > Fixes: a97955844807 ("ipc,sem: remove uneeded sem_undo_list lock usage in exit_sem()")
> > Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
> Acked-by: Manfred Spraul <manfred@colorfullife.com>

Acked-by: Herton R. Krzesinski <herton@redhat.com>

> > ---
> >   ipc/sem.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/ipc/sem.c b/ipc/sem.c
> > index ec97a7072413..fe12ea8dd2b3 100644
> > --- a/ipc/sem.c
> > +++ b/ipc/sem.c
> > @@ -2368,11 +2368,9 @@ void exit_sem(struct task_struct *tsk)
> >   		ipc_assert_locked_object(&sma->sem_perm);
> >   		list_del(&un->list_id);
> > -		/* we are the last process using this ulp, acquiring ulp->lock
> > -		 * isn't required. Besides that, we are also protected against
> > -		 * IPC_RMID as we hold sma->sem_perm lock now
> > -		 */
> > +		spin_lock(&ulp->lock);
> >   		list_del_rcu(&un->list_proc);
> > +		spin_unlock(&ulp->lock);
> >   		/* perform adjustments registered in un */
> >   		for (i = 0; i < sma->sem_nsems; i++) {
> 
> 

-- 
[]'s
Herton

