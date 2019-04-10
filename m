Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4039FC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDBF20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDJA0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:26:06 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37470 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDJA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:26:06 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hE13z-0006Nk-FD; Tue, 09 Apr 2019 18:26:03 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hE13y-0005Fl-JI; Tue, 09 Apr 2019 18:26:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>, omosnace@redhat.com,
        eparis@parisplace.org, oleg@redhat.com
References: <c7b092894ac6d611f8c5083e712da41e6685f94a.1554781852.git.rgb@redhat.com>
        <20190409080138.745d18a1@ivy-bridge>
        <20190409140259.n4t6rxb24eu3uzvp@madcap2.tricolour.ca>
        <20190409173716.1a0308fb@ivy-bridge>
        <20190409155728.dfp4qwseo6jxdmqr@madcap2.tricolour.ca>
Date:   Tue, 09 Apr 2019 19:25:44 -0500
In-Reply-To: <20190409155728.dfp4qwseo6jxdmqr@madcap2.tricolour.ca> (Richard
        Guy Briggs's message of "Tue, 9 Apr 2019 11:57:28 -0400")
Message-ID: <875zrmaepj.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hE13y-0005Fl-JI;;;mid=<875zrmaepj.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+2ZIHWLNdNII0fmfwQ5R+N+v3eGsk8n94=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH ghak111 V1] audit: deliver siginfo regarless of syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Minor nit about the description of this patch (as I presume it will need
to respun).

You are talking about audit signal information.  You are not talking
about struct siginfo (aka siginfo_t).  The structure siginfo_t is part
of posix and userspace ABI and is part of the stack frame for a
delivered signal.

The summary had me thinking you were messing with when siginfo is
collected and delivered to userspace.

Richard Guy Briggs <rgb@redhat.com> writes:

> On 2019-04-09 17:37, Steve Grubb wrote:
>> On Tue, 9 Apr 2019 10:02:59 -0400
>> Richard Guy Briggs <rgb@redhat.com> wrote:
>> 
>> > On 2019-04-09 08:01, Steve Grubb wrote:
>> > > On Mon,  8 Apr 2019 23:52:29 -0400 Richard Guy Briggs
>> > > <rgb@redhat.com> wrote:  
>> > > > When a process signals the audit daemon (shutdown, rotate, resume,
>> > > > reconfig) but syscall auditing is not enabled, we still want to
>> > > > know the identity of the process sending the signal to the audit
>> > > > daemon.  
>> > > 
>> > > Why? If syscall auditing is disabled, then there is no requirement
>> > > to provide anything. What is the real problem that you are seeing?  
>> > 
>> > Shutdown messages with -1 in them rather than the real values.
>> 
>> OK. We can fix that by patching auditd to see if auditing is enabled
>> before requesting signal info. If auditing is disabled, the proper
>> action is for the kernel to ignore any audit userspace messages except
>> the configuration commands.
>
> If auditing is disabled in the kernel, none of this is trackable.  It is
> for those as yet unsupported arches that can run audit enabled but
> without auditsyscall support.
>
> Here's a current sample with CONFIG_AUDIT and ~CONFIG_AUDITSYSCALL
> configured, note "auid=" and "pid=":
>
> 	killall -HUP auditd
> 	type=DAEMON_CONFIG msg=audit(2019-04-09 11:37:04.508:3266) op=reconfigure state=changed auid=unset pid=-1 subj=? res=success
>
> 	killall -TERM auditd
> 	type=DAEMON_END msg=audit(2019-04-09 11:51:50.441:5709) : op=terminate auid=unset pid=-1 subj=? res=success 
> 	
> and the same with the patch applied:
>
> 	killall -HUP auditd
> 	type=DAEMON_CONFIG msg=audit(2019-04-09 11:42:40.851:8924) op=reconfigure state=changed auid=root pid=652 subj=? res=success
>
> 	killall -TERM auditd
> 	type=DAEMON_END msg=audit(2019-04-09 11:51:50.441:5709) : op=terminate auid=root pid=652 subj=? res=success 
>
> The USR1 "rotate" and USR2 "resume" log messages need to be fixed in
> userspace.

Hmm.  You mention -1 as beeing a problem.  You don't say if auid is a
concern.

It looks like all you care about is the sending processes pid.  That
information is saved in the sending processes siginfo.  As such you may
be able to remove some of the magic from the code by looking at the
siginfo of the signal.

Why it appears the kernel is logging when userspace receives a signal is
beyond me so I don't know using siginfo makes sense.  I just figure I
will toss it out there in case it shakes some ideas loose.

Eric
