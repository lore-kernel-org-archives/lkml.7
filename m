Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B1C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C227D22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567606929;
	bh=jWVhgoJBHtb2EGwmals7m5cy/1YyE3LOy9mjAFXslGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=upQLA6RV4S9HMQ5lLUh9QyGDLRxctjwUIoXQI3O8ck+qRIjUj7uZxNo3khA//XXbQ
	 wUe0MhlVEjXEmVpuyPrN2vNUQiWfP2+A6sgUyCopobA6BsW2lRFjaRQvTHk/gdv6Ol
	 dChW8ARkS3cbxdzAIsaVpLUMADmj3iFi5XeAW13I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfIDOWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbfIDOWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:22:08 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59AED22CED;
        Wed,  4 Sep 2019 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567606927;
        bh=jWVhgoJBHtb2EGwmals7m5cy/1YyE3LOy9mjAFXslGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ux8kSma117a/mVBjYQVeu+1eVdOHvG3a1VL7F047nrPpyE20wntkkbU5JvjVMXIrI
         JBoOfXz3lJyXWymhPYA04ymmSof6ia2kxmi+cpkTTAsK4CVCBBqNULhHt6D9hrZQYU
         E3z75a2tG/SH0Ky0xCthJIDjZgik5a/eX+tQPStY=
Date:   Wed, 4 Sep 2019 16:22:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
Message-ID: <20190904142202.GA20391@lenoir>
References: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:52:01PM -0500, Eric W. Biederman wrote:
> 
> In the ordinary case today the rcu grace period of a task comes when a
> task is reaped, well after the task has left the runqueue.  This
> change guarantees that the rcu grace period always happens after a
> task has left the runqueue.  As this is something that usaually happens
> today I do not expect any code correctness problems with this change.
> At most I anticipate timing challenges.

What do you consider as the reaping point here? If this is the call to
release_task(), it can happen way before the task forever leaves the runqueue.

Let alone the RCU call to delayed_put_task_struct() can happen way before
the target leaves the runqueue, either after autoreap or normal reaping.
