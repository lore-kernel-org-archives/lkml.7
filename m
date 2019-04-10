Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11B1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C5220830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfDJQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:55:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfDJQzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:55:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6754B2D80C;
        Wed, 10 Apr 2019 16:55:11 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA0DC608A5;
        Wed, 10 Apr 2019 16:55:01 +0000 (UTC)
Date:   Wed, 10 Apr 2019 12:54:58 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>, omosnace@redhat.com,
        eparis@parisplace.org, oleg@redhat.com
Subject: Re: [PATCH ghak111 V1] audit: deliver siginfo regarless of syscall
Message-ID: <20190410165458.ox5l6ccbu7vjw5v5@madcap2.tricolour.ca>
References: <c7b092894ac6d611f8c5083e712da41e6685f94a.1554781852.git.rgb@redhat.com>
 <20190409080138.745d18a1@ivy-bridge>
 <20190409140259.n4t6rxb24eu3uzvp@madcap2.tricolour.ca>
 <20190409173716.1a0308fb@ivy-bridge>
 <20190409155728.dfp4qwseo6jxdmqr@madcap2.tricolour.ca>
 <875zrmaepj.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zrmaepj.fsf@xmission.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 10 Apr 2019 16:55:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-09 19:25, Eric W. Biederman wrote:
> Minor nit about the description of this patch (as I presume it will need
> to respun).
> 
> You are talking about audit signal information.  You are not talking
> about struct siginfo (aka siginfo_t).  The structure siginfo_t is part
> of posix and userspace ABI and is part of the stack frame for a
> delivered signal.
> 
> The summary had me thinking you were messing with when siginfo is
> collected and delivered to userspace.

Got it.  I'll switch it to at least sig_info if not something even a bit
more descriptive and less confusing.

> Richard Guy Briggs <rgb@redhat.com> writes:
> > On 2019-04-09 17:37, Steve Grubb wrote:
> >> On Tue, 9 Apr 2019 10:02:59 -0400
> >> Richard Guy Briggs <rgb@redhat.com> wrote:
> >> 
> >> > On 2019-04-09 08:01, Steve Grubb wrote:
> >> > > On Mon,  8 Apr 2019 23:52:29 -0400 Richard Guy Briggs
> >> > > <rgb@redhat.com> wrote:  
> >> > > > When a process signals the audit daemon (shutdown, rotate, resume,
> >> > > > reconfig) but syscall auditing is not enabled, we still want to
> >> > > > know the identity of the process sending the signal to the audit
> >> > > > daemon.  
> >> > > 
> >> > > Why? If syscall auditing is disabled, then there is no requirement
> >> > > to provide anything. What is the real problem that you are seeing?  
> >> > 
> >> > Shutdown messages with -1 in them rather than the real values.
> >> 
> >> OK. We can fix that by patching auditd to see if auditing is enabled
> >> before requesting signal info. If auditing is disabled, the proper
> >> action is for the kernel to ignore any audit userspace messages except
> >> the configuration commands.
> >
> > If auditing is disabled in the kernel, none of this is trackable.  It is
> > for those as yet unsupported arches that can run audit enabled but
> > without auditsyscall support.
> >
> > Here's a current sample with CONFIG_AUDIT and ~CONFIG_AUDITSYSCALL
> > configured, note "auid=" and "pid=":
> >
> > 	killall -HUP auditd
> > 	type=DAEMON_CONFIG msg=audit(2019-04-09 11:37:04.508:3266) op=reconfigure state=changed auid=unset pid=-1 subj=? res=success
> >
> > 	killall -TERM auditd
> > 	type=DAEMON_END msg=audit(2019-04-09 11:51:50.441:5709) : op=terminate auid=unset pid=-1 subj=? res=success 
> > 	
> > and the same with the patch applied:
> >
> > 	killall -HUP auditd
> > 	type=DAEMON_CONFIG msg=audit(2019-04-09 11:42:40.851:8924) op=reconfigure state=changed auid=root pid=652 subj=? res=success
> >
> > 	killall -TERM auditd
> > 	type=DAEMON_END msg=audit(2019-04-09 11:51:50.441:5709) : op=terminate auid=root pid=652 subj=? res=success 
> >
> > The USR1 "rotate" and USR2 "resume" log messages need to be fixed in
> > userspace.
> 
> Hmm.  You mention -1 as beeing a problem.  You don't say if auid is a
> concern.

Ok, -1 can be a real value if it isn't actually set, but in this case,
there is information available that isn't being used.

> It looks like all you care about is the sending processes pid.  That
> information is saved in the sending processes siginfo.  As such you may
> be able to remove some of the magic from the code by looking at the
> siginfo of the signal.

We need the sending process' pid, auid and ses, as well as its security
context label and the reason I noticed all this is that soon we'll also
want the audit container identifier as well.

So some of this information is available in siginfo, but I don't know if
all of it is.

> Why it appears the kernel is logging when userspace receives a signal is
> beyond me so I don't know using siginfo makes sense.  I just figure I
> will toss it out there in case it shakes some ideas loose.

That is worth checking to see if it is all available.

Thanks, Eric.

> Eric

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
