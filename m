Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3688C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735EC22CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567614813;
	bh=uT+zUrKTqBOhThqy5vYGxCDBdsj46DFexxnMteSFboU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E9s9fhEriKGxHT5gg/U4K7DeTqvsjJJPDqg6hfvZY8qr4jdREm8MeXdYGjjcm4P0Z
	 1E2IOEEeusRS6XWkbWVlkvVCbG8Ms/3NdkMjeknIcfDIDiP/XWVnHX/aOm2MSej7fm
	 vms4oHS4P9cgNtvQzOgbaoDaqhzxRjeaspHylN6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfIDQdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbfIDQdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:33:32 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2076421881;
        Wed,  4 Sep 2019 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567614811;
        bh=uT+zUrKTqBOhThqy5vYGxCDBdsj46DFexxnMteSFboU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJXodasdv/n5F5EkrhDzmG6BtON4YrTNN4uqVWUc2iWqRGnlgiwb3EyX5Lmg3lk7z
         G2tjfpBhvB4nmCGgHDsBbLhXPEliyqqXXfwJdr3Iv+aAZBmacauMvF/zPKh+7i/+Au
         w18N3iU92Aqv0qfdEZXJlUvbACro84qPxZpCqcgc=
Date:   Wed, 4 Sep 2019 18:33:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 1/3] task: Add a count of task rcu users
Message-ID: <20190904163325.GA22421@lenoir>
References: <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87ef0yt221.fsf_-_@x220.int.ebiederm.org>
 <20190904144415.GB20391@lenoir>
 <20190904153245.GF24568@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904153245.GF24568@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 05:32:46PM +0200, Oleg Nesterov wrote:
> On 09/04, Frederic Weisbecker wrote:
> >
> > So what happens if, say:
> >
> >
> >            CPU 1                         CPU 2
> >    --------------------------------------------------------------
> >    rcu_read_lock()
> >    p = rcu_dereference(rq->task)
> >    if (refcount_inc_not_zero(p->rcu_users)) {
> >        .....
> >                                          release_task() {
> >                                              put_task_struct_rcu_user() {
> >                                                  call_rcu() {
> >                                                      queue rcu_head
> 
> in this particular case call_rcu() won't be called, so

Yeah I confused myself in finding the scenario but like you say below, release_task()
can simply happen between the p = rcu_dereference() and the refcount_inc to break things.

I thought the point of these rcu_users was to be able to do:

rcu_read_lock()
p = rcu_dereference(task)
if (!refcount_inc_not_zero(p->rcu_users)) {
    rcu_read_unlock();
    return -1;
}
rcu_read_unlock();

//do stuff with task

put_task_struct_rcu_user(p);

Thanks.

> 
> >                                                  }
> >                                              }
> >                                          }
> >        put_task_struct_rcu_user(); //here rcu_users has been overwritten
> 
> rcu_users won't be overwritten.
> 
> But nobody should try to increment ->rcu_users,
> 
> 	rcu_read_lock();
> 	p = rcu_dereference(rq->task);
> 	refcount_inc_not_zero(p->rcu_users);
> 
> is already wrong because both release_task/last-schedule can happen in
> between, before refcount_inc_not_zero().
> 
> Oleg.
> 
