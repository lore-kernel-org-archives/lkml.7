Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC2CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC18F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567695585;
	bh=/KcGnZ0W9ePf2n529zYk4T36+31YiVD5f16S/GVydbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2QqQ4+o88us+Fs+1f7gRxF4u4Bm58ybyNRE2vjmNBdkz18+sbircxFsr4Jn1CQ/XD
	 aITEt4ixrFxbqF7VyhPR08FoiGaldrjEf47iIRYAXGbxvMHbPlZHez0W6pIEig+6cL
	 nWhPcEm3RgXkxoO1NKSjV9o+OdtPjuplLzr0gu+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbfIEO7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389796AbfIEO7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:59:44 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4980E20820;
        Thu,  5 Sep 2019 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567695583;
        bh=/KcGnZ0W9ePf2n529zYk4T36+31YiVD5f16S/GVydbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zzh2nr2j43DmTENgswoUKedjTXThUOtR62M6QSlX7kuzjwq0VTIc43m3XuTkBUXd/
         cgIx+4JNUAvQtQ9Q9b9la0bLgnYMxRgjTjXBcUh7dePSzF3OSErimGWpr0FZ40VU3X
         SIqRLrwaYUPSBDNpLOLft/aUmUj0Gl1JRNyhsA7E=
Date:   Thu, 5 Sep 2019 16:59:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Message-ID: <20190905145939.GB18251@lenoir>
References: <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87ef0yt221.fsf_-_@x220.int.ebiederm.org>
 <20190904144415.GB20391@lenoir>
 <20190904153245.GF24568@redhat.com>
 <20190904163325.GA22421@lenoir>
 <CAHk-=whv60YepBaTUWnDvZ1QMezTyHLvCvzF_QgUQ+6LdrpScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whv60YepBaTUWnDvZ1QMezTyHLvCvzF_QgUQ+6LdrpScw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 11:20:03AM -0700, Linus Torvalds wrote:
> On Wed, Sep 4, 2019 at 9:33 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > I thought the point of these rcu_users was to be able to do:
> >
> > rcu_read_lock()
> > p = rcu_dereference(task)
> > if (!refcount_inc_not_zero(p->rcu_users)) {
> 
> No. Because of the shared state, you can't do that from RCU context.
> 
> But you *could* increase rcu_users from within the process context
> itself (as long as you do it before the exit path, ie during normal
> system call execution), or possibly while holding the tasklist_lock
> and verifying that the task hasn't died yet.
> 
> I'm not sure there is any sensible case for doing that, though. It
> would have to have a similar pattern to the runqueue use, where you
> add a new RCU lookup point for the task. I'm sure something like that
> _could_ exist, I just can't think of any right now.

Yeah indeed, in fact I just hadn't read the patches entirely so I missed
the point. I see now that the purpose of rcu_users is to postpone the RCU
delayed put_task_struct() at least once we are done with both final schedule
out and release_task().

Sorry for the noise :o)
