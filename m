Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3A8C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1BB20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439322AbfFLM4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:56:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40469 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438421AbfFLM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:56:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb2nR-0004sb-Km; Wed, 12 Jun 2019 06:56:09 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb2nQ-0004am-Lf; Wed, 12 Jun 2019 06:56:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Oleg Nesterov' <oleg@redhat.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Deepa Dinamani' <deepa.kernel@gmail.com>,
        "'linux-kernel\@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'arnd\@arndb.de'" <arnd@arndb.de>,
        "'dbueso\@suse.de'" <dbueso@suse.de>,
        "'axboe\@kernel.dk'" <axboe@kernel.dk>,
        "'dave\@stgolabs.net'" <dave@stgolabs.net>,
        "'e\@80x24.org'" <e@80x24.org>,
        "'jbaron\@akamai.com'" <jbaron@akamai.com>,
        "'linux-fsdevel\@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-aio\@kvack.org'" <linux-aio@kvack.org>,
        "'omar.kilani\@gmail.com'" <omar.kilani@gmail.com>,
        "'tglx\@linutronix.de'" <tglx@linutronix.de>,
        'Al Viro' <viro@ZenIV.linux.org.uk>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        "'linux-arch\@vger.kernel.org'" <linux-arch@vger.kernel.org>
In-Reply-To: <95decc6904754004af8a5546aca0468a@AcuMS.aculab.com> (David
        Laight's message of "Tue, 11 Jun 2019 11:14:57 +0000")
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
        <87lfy96sta.fsf@xmission.com>
        <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
        <95decc6904754004af8a5546aca0468a@AcuMS.aculab.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Wed, 12 Jun 2019 07:55:51 -0500
Message-ID: <87pnnj2ca0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hb2nQ-0004am-Lf;;;mid=<87pnnj2ca0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+N5PFr7zlZ/a3x2KGDitcGaQi9MJxANlc=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: David Laight
>> Sent: 11 June 2019 10:52
> ...
>> If I have an application that has a loop with a pselect call that
>> enables SIGINT (without a handler) and, for whatever reason,
>> one of the fd is always 'ready' then I'd expect a SIGINT
>> (from ^C) to terminate the program.
>> 
>> A quick test program:
>> 
>> #include <sys/time.h>
>> #include <sys/types.h>
>> #include <unistd.h>
>> 
>> #include <sys/select.h>
>> #include <signal.h>
>> 
>> int main(int argc, char **argv)
>> {
>>         fd_set readfds;
>>         sigset_t sig_int;
>>         struct timespec delay = {1, 0};
>> 
>>         sigfillset(&sig_int);
>>         sigdelset(&sig_int, SIGINT);
>> 
>>         sighold(SIGINT);
>> 
>>         for (;;) {
>>                 FD_ZERO(&readfds);
>>                 FD_SET(0, &readfds);
>>                 pselect(1, &readfds, NULL, NULL, &delay, &sig_int);
>> 
>>                 poll(0,0,1000);
>>         }
>> }
>> 
>> Run under strace to see what is happening and send SIGINT from a different terminal.
>> The program sleeps for a second in each of the pselect() and poll() calls.
>> Send a SIGINT and in terminates after pselect() returns ERESTARTNOHAND.
>> 
>> Run again, this time press enter - making fd 0 readable.
>> pselect() returns 1, but the program still exits.
>> (Tested on a 5.1.0-rc5 kernel.)
>> 
>> If a signal handler were defined it should be called instead.
>
> If I add a signal handler for SIGINT it is called when pselect()
> returns regardless of the return value.

That is odd.  Is this with Oleg's fix applied?

Eric
