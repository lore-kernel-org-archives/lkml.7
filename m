Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A44C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F19215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfI3KDf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:03:35 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33072 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfI3KDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:03:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iEsWj-0005Os-Ae; Mon, 30 Sep 2019 04:03:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iEsWi-0000T7-Fw; Mon, 30 Sep 2019 04:03:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alun Evans <alun@badgerous.net>
Cc:     linux-kernel@vger.kernel.org
References: <m2o8z7t2w5.fsf@badgerous.net>
        <871rw1yey8.fsf@x220.int.ebiederm.org> <m2d0fkt5pj.fsf@badgerous.net>
Date:   Mon, 30 Sep 2019 05:02:57 -0500
In-Reply-To: <m2d0fkt5pj.fsf@badgerous.net> (Alun Evans's message of "Sat, 28
        Sep 2019 15:29:44 -0700")
Message-ID: <87o8z2m78u.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iEsWi-0000T7-Fw;;;mid=<87o8z2m78u.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/MCGr0BCY4Qrg2t7vhVaPLuralzTmJKys=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH 05/27] containers: Open a socket inside a container
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alun Evans <alun@badgerous.net> writes:

> On Fri 27 Sep '19 at 07:46 ebiederm@xmission.com (Eric W. Biederman) wrote:
>> 
>> Alun Evans <alun@badgerous.net> writes:
>>
>>> Hi Eric,
>>>
>>>
>>> On Tue, 19 Feb 2019, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>>
>>>> David Howells <dhowells@redhat.com> writes:
>>>>
>>>> > Provide a system call to open a socket inside of a container, using that
>>>> > container's network namespace.  This allows netlink to be used to manage
>>>> > the container.
>>>> >
>>>> > 	fd = container_socket(int container_fd,
>>>> > 			      int domain, int type, int protocol);
>>>> >
>>>>
>>>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>>
>>>> Use a namespace file descriptor if you need this.  So far we have not
>>>> added this system call as it is just a performance optimization.  And it
>>>> has been too niche to matter.
>>>>
>>>> If this that has changed we can add this separately from everything else
>>>> you are doing here.
>>>
>>> I think I've found the niche.
>>>
>>>
>>> I'm trying to use network namespaces from Go.
>>
>> Yes. Go sucks for this.
>
> Haha... Neither confirm nor deny.
>
>>> Since setns is thread
>>> specific, I'm forced to use this pattern:
>>>
>>>     runtime.LockOSThread()
>>>     defer runtime.UnlockOSThread()
>>>     …
>>>     err = netns.Set(newns)
>>>
>>>
>>> This is only safe recently:
>>> https://github.com/vishvananda/netns/issues/17#issuecomment-367325770
>>>
>>> - but is still less than ideal performance wise, as it locks out other
>>>   socket operations.
>>>
>>> The socketat() / socketns() would be ideal:
>>>
>>>   https://lwn.net/Articles/406684/
>>>   https://lwn.net/Articles/407495/
>>>   https://lkml.org/lkml/2011/10/3/220
>>>
>>>
>>> One thing that is interesting, the LockOSThread works pretty well for
>>> receiving, since I can wrap it around the socket()/bind()/listen() at
>>> startup. Then accept() can run outside of the lock.
>>>
>>> It's creating new outbound tcp connections via socket()/connect() pairs
>>> that is the issue.
>>
>> As I understand it you should be able to write socketat in go something like:
>>
>>         runtime.LockOSThread()
>>         err = netns.Set(newns);
>>         fd = socket(...);
>>         err = netns.Set(defaultns);
>>         runtime.UnlockOSThread()
>
> Yeah, this is currently what I'm having to do. It's painful because due
> to the Go runtime model of a single OS netpoller thread, locking the OS
> thread to the current goroutine blocks out the other goroutines doing
> network I/O.

Just to be clear you know that only the setns and the socket calls need
to block out switching threads and all of those should be currently
quite fast.

Hmm.  So this is a global Go lock and not simply locking the current go
routine onto it's current kernel thread?  Yes that does sound quite
painful.

It would be very nice if Go could provide an idiom where a series of
calls could be fixed to a single kernel thread.

>> I have no real objections to a kernel system call doing that.  It has
>> just never risen to the level where it was necessary to optimize
>> userspace yet.
>
> Would you be able to accept the patch from this thread with the
> container API?
>
>     fd = container_socket(int container_fd,
>                           int domain, int type, int protocol);
>
> I think that seems more coherent with the rest of the container world
> than a follow up of https://lkml.org/lkml/2011/10/3/220 :
>

Given container_socket implies the need to create a namespace of
namespaces. No.

Given that container_socket can't be used in iptools because it has
a different concept of container.  No.

Given that no one has ever proposed solving the entire migration story
when the have wanted to define a container and thus all of this
implies breaking CRIU.  No.

>     int socketns(int netns_fd, int domain, int type, int protocol)
>

Yes please.

I suspect in the current world where system calls are much more
expensive (because of mitigations for speculative execution bugs) with a
little bit of timing we could come up with a reasonable case even for
non GO runtimes.

To that end I would like to see performance numbers of at least a micro
benchmark in C.  Just so we can quantify the improvement.

Eric
