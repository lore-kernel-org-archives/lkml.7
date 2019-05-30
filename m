Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D5BC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C60224408
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfE3ByU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:54:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54155 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3ByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:54:20 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWAGm-0003tx-S1; Wed, 29 May 2019 19:54:16 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWAGl-0003zx-2c; Wed, 29 May 2019 19:54:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, dbueso@suse.de,
        Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>, e@80x24.org,
        Jason Baron <jbaron@akamai.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "# 3.4.x" <stable@vger.kernel.org>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <CAK8P3a1fsrz6kAB1z-mqcaNvXL4Hf3XMiN=Q5rzAJ3rLGPK_Yg@mail.gmail.com>
Date:   Wed, 29 May 2019 20:54:09 -0500
In-Reply-To: <CAK8P3a1fsrz6kAB1z-mqcaNvXL4Hf3XMiN=Q5rzAJ3rLGPK_Yg@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 30 May 2019 00:32:32 +0200")
Message-ID: <874l5czozi.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hWAGl-0003zx-2c;;;mid=<874l5czozi.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+sYXiM8eraUyZMQcF4BEIK0Zqv4Ek0euE=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: pselect/etc semantics
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, May 29, 2019 at 6:12 PM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> Al, Linus, Eric, please help.
>>
>> The previous discussion was very confusing, we simply can not understand each
>> other.
>>
>> To me everything looks very simple and clear, but perhaps I missed something
>> obvious? Please correct me.
>
> Thanks for the elaborate explanation in this patch, it all starts making sense
> to me now. I also looked at your patch in detail and thought I had found
> a few mistakes at first but those all turned out to be mistakes in my reading.
>
>> See the compile-tested patch at the end. Of course, the new _xxx() helpers
>> should be renamed somehow. fs/aio.c doesn't look right with or without this
>> patch, but iiuc this is what it did before 854a6ed56839a.
>
> I think this is a nice simplification, but it would help not to mix up the
> minimal regression fix with the rewrite of those functions. For the stable
> kernels, I think we want just the addition of the 'bool interrupted' argument
> to restore_user_sigmask() to close the race that was introduced
> 854a6ed56839a. Following up on that for future kernels, your patch
> improves the readability, but we can probably take it even further.
>
>> -       ret = set_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
>> +       ret = set_xxx(ksig.sigmask, ksig.sigsetsize);
>>         if (ret)
>>                 return ret;
>>
>>         ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
>> -       restore_user_sigmask(ksig.sigmask, &sigsaved);
>> -       if (signal_pending(current) && !ret)
>> +
>> +       interrupted = signal_pending(current);
>> +       update_xxx(interrupted);
>
> Maybe name this
>
>            restore_saved_sigmask_if(!interrupted);
>
> and make restore_saved_sigmask_if() an inline function
> next to restore_saved_sigmask()?
>
>> @@ -2201,13 +2205,15 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
>>         if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
>>                 return -EFAULT;
>>
>> -       ret = set_compat_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
>> +       ret = set_compat_xxx(ksig.sigmask, ksig.sigsetsize);
>>         if (ret)
>>                 return ret;
>
> With some of the recent discussions about compat syscall handling,
> I now think that we want to just fold set_compat_user_sigmask()
> into set_user_sigmask() (whatever they get called in the end)
> with an in_compat_syscall() conditional inside it, and completely get
> rid of the COMPAT_SYSCALL_DEFINEx() definitions for those
> system calls for which this is the only difference.
>
> Unfortunately we still need the time32/time64 distinction, but removing
> syscall handlers is a significant cleanup here already, and we can
> move most of the function body of sys_io_pgetevents() into
> do_io_getevents() in the process. Same for some of the other calls.
>
> Not sure about the order of the cleanups, but probably something like
> this would work:
>
> 1. fix the race (to be backported)
> 2. unify set_compat_user_sigmask/set_user_sigmask
> 3. remove unneeded compat handlers
> 4. replace restore_user_sigmask with restore_saved_sigmask_if()
> 5. also unify compat_get_fd_set()/get_fd_set() and kill off
>     compat select() variants.

Are new system calls added preventing a revert of the patch in question
for stable kernels?

Eric
