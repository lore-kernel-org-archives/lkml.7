Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4A3C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7329025941
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfE3NFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:05:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40444 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfE3NE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:04:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWKjq-0001o6-J4; Thu, 30 May 2019 07:04:58 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWKjp-0006KM-2L; Thu, 30 May 2019 07:04:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Eric Wong <e@80x24.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Oleg Nesterov' <oleg@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd\@arndb.de" <arnd@arndb.de>,
        "dbueso\@suse.de" <dbueso@suse.de>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "dave\@stgolabs.net" <dave@stgolabs.net>,
        "jbaron\@akamai.com" <jbaron@akamai.com>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio\@kvack.org" <linux-aio@kvack.org>,
        "omar.kilani\@gmail.com" <omar.kilani@gmail.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "stable\@vger.kernel.org" <stable@vger.kernel.org>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <b05cec7f9e8f457281e689576a7a360f@AcuMS.aculab.com>
        <20190529185012.qqeqq4fsolprknrz@dcvr>
Date:   Thu, 30 May 2019 08:04:50 -0500
In-Reply-To: <20190529185012.qqeqq4fsolprknrz@dcvr> (Eric Wong's message of
        "Wed, 29 May 2019 18:50:12 +0000")
Message-ID: <87ef4grt3h.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hWKjp-0006KM-2L;;;mid=<87ef4grt3h.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+tK8wFikScRQNziP7B/XxiQEAJ+eiy2zc=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: pselect/etc semantics
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Agreed...  I believe cmogstored has always had a bug in the way
> it uses epoll_pwait because it failed to check interrupts if:
>
> a) an FD is ready + interrupt
> b) epoll_pwait returns 0 on interrupt
>
> The bug remains in userspace for a), which I will fix by adding
> an interrupt check when an FD is ready.  The window is very
> small for a) and difficult to trigger, and also in a rare code
> path.
>
> The b) case is the kernel bug introduced in 854a6ed56839a40f
> ("signal: Add restore_user_sigmask()").
>
> I don't think there's any disagreement that b) is a kernel bug.

See my reply to Oleg.  I think (b) is a regression that needs to be
fixed.  I do not think that (b) is a kernel bug.  Both versions of the
of what sigmask means posix and naive will allow (b).

Because fundamentally the sigmask is restored after the rest of the
system call happens.

Eric
