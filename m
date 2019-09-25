Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154BFC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90C820640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfIYXBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:01:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48340 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfIYXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:01:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDGHV-0000Wk-OZ; Wed, 25 Sep 2019 17:01:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDGHU-00035i-Ok; Wed, 25 Sep 2019 17:01:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20190922115247.GA2679387@kroah.com>
        <20190923200818.GA116090@gmail.com> <20190924113135.GA82089@gmail.com>
        <874l11u30y.fsf@x220.int.ebiederm.org>
        <20190924184159.GA47127@gmail.com>
Date:   Wed, 25 Sep 2019 18:00:39 -0500
In-Reply-To: <20190924184159.GA47127@gmail.com> (Ingo Molnar's message of
        "Tue, 24 Sep 2019 20:41:59 +0200")
Message-ID: <87sgok3rs8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iDGHU-00035i-Ok;;;mid=<87sgok3rs8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18rghQVtRaShzp5a40Flk4ceYmB9eIJRB0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [Tree, v2] De-clutter the top level directory, move ipc/ => kernel/ipc/, samples/ => Documentation/samples/ and sound/ => drivers/sound/
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Ingo Molnar <mingo@kernel.org> writes:
>> 
>> >  - Split it into finer grained steps (3 instead of 2 patches per 
>> >    movement), for easier review and bisection testing:
>> >
>> >      toplevel: Move ipc/ to kernel/ipc/: move the files
>> >      toplevel: Move ipc/ to kernel/ipc/: adjust the build system
>> >      toplevel: Move ipc/ to kernel/ipc/: adjust comments and documentation
>> 
>> Can we not mess with ipc/ please.
>> 
>> I know that will mess with my muscle memory and I don't see the point.
>> Especially as long as it is named ipc and not sysvipc.
>> 
>> A half cleanup really looks worse than a real cleanup.
>> 
>> SysV IPC really is a side car on the kernel and on unix in general
>> and having the directory structure reflect that seems completely sensible.
>
> While such objections are I think valid for scripts/, the situation is 
> very different for ipc/:
>
>  - ipc/ is a tiny subsystem of just ~9k lines of code, and it's in the 
>    top level directory for historical reasons.
>
>  - ipc/ is an established subsystem of old interfaces with comparatively 
>    very few changes these days: there were just about 16 commits added in 
>    the last 12 months that changed the code and had 'ipc' in the title. 
>    Somewhat ironically, the biggest commit of all was a "system call 
>    renaming" commit:
>
>      275f22148e87: ipc: rename old-style shmctl/semctl/msgctl syscalls
>      14 files changed, 137 insertions(+), 62 deletions(-)
>
>    Many of the remaining 15 commits were simple in nature - and there 
>    were 9 different authors, i.e. the per author frequency of changes for 
>    ipc/ is even lower: around one per year for those 9 developers who are 
>    interested in ipc/ changes. I doubt there's much muscle memory even 
>    for them as a result.
>

*snort*  Given how long some of those changes took to review.  No they
were not all simple.   Maybe the final result was but the amount of work
was not simple.
 
>  - The 'muscle memory' argument has to be weighted by probability of 
>    interest (linecount), probability of change (frequency of commits) and 
>    number of authors. These factors add up to a very low change frequency 
>    for ipc/. We've moved and consolidated much, much bigger and higher 
>    frequency subsystems in the recent past, such as kernel/sched/ or 
>    kernel/locking/.

With I presume with the consent and the input of the developers of those
subsystems.  Quite frankly digging into kernel/sched to understand what
is happening right now is a real mess.  It has not made the code any
easier to understand (from my outside perspective).  But if the
developers of the subsystem are fine with it that is their lookout.

>  - The ipc/ location is arguably random and idiosynchratic - it's a 
>    leftover from old times nobody really bothered to clean up - but that 
>    fact shouldn't be a permanent barrier IMO.

Most of the kernel interfaces are random and idiosyncratic.  Most of the
files and most of their contents as well.  That doesn't make them wrong.
It does mean that changing them for the sake of change just increases
the cognitive load on people who have to look after things like that for
no reason.

I figure I have some say in the matter because I am one of the
developers doing some of that looking after.

>  - While uncluttering the top level directory for aesthethic and 
>    documentation reasons is one technical factor, there's another reason 
>    for my ipc/ movement: I have the secret hope to be able to move init/ 
>    to kernel/init/ as well, in which case there's a big muscle memory 
>    advantage for the future: 'i<tab>' would expand to include/ in a 
>    single step! :-) Now *that* is perhaps the highest frequency muscle 
>    memory location in the kernel. ;-)


> Or looking at it from another angle: if we applied your ipc/ benchmark 
> then basically almost *nothing* could be moved from the toplevel 
> directory or any other location, pretty much *ever*.

Please if it ain't broke don't fix it.


On the other hand we still have a terrible mess from the introduction of
threads into the kernel in the 2.5 era.  The cleanup code for tasks is
in terrible shape.  By terrible shape I mean we have data that should be
in signal_struct sill in task_struct, and we have code in release_task
(called when we reap (aka wait on a zombie)) that can very reasonably be
run much sooner, and free up resources in a timely manner.  The worst
part are zombie thread group leaders that are essentially untested in
practice but are a recurring source of errors in kernel code.

Want to help me clean up that code and get rid of zombie thread group
leaders?

Especially if you aren't interested in helping please stay away from the
code I feel responsible for so I can focus on picking up the messes like
that.

Eric

