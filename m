Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB7BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DBE2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDIP5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:57:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDIP5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 974F530A9CE1;
        Tue,  9 Apr 2019 15:57:39 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FE181001E7B;
        Tue,  9 Apr 2019 15:57:31 +0000 (UTC)
Date:   Tue, 9 Apr 2019 11:57:28 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>, omosnace@redhat.com,
        eparis@parisplace.org, ebiederm@xmission.com, oleg@redhat.com
Subject: Re: [PATCH ghak111 V1] audit: deliver siginfo regarless of syscall
Message-ID: <20190409155728.dfp4qwseo6jxdmqr@madcap2.tricolour.ca>
References: <c7b092894ac6d611f8c5083e712da41e6685f94a.1554781852.git.rgb@redhat.com>
 <20190409080138.745d18a1@ivy-bridge>
 <20190409140259.n4t6rxb24eu3uzvp@madcap2.tricolour.ca>
 <20190409173716.1a0308fb@ivy-bridge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409173716.1a0308fb@ivy-bridge>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 09 Apr 2019 15:57:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-09 17:37, Steve Grubb wrote:
> On Tue, 9 Apr 2019 10:02:59 -0400
> Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> > On 2019-04-09 08:01, Steve Grubb wrote:
> > > On Mon,  8 Apr 2019 23:52:29 -0400 Richard Guy Briggs
> > > <rgb@redhat.com> wrote:  
> > > > When a process signals the audit daemon (shutdown, rotate, resume,
> > > > reconfig) but syscall auditing is not enabled, we still want to
> > > > know the identity of the process sending the signal to the audit
> > > > daemon.  
> > > 
> > > Why? If syscall auditing is disabled, then there is no requirement
> > > to provide anything. What is the real problem that you are seeing?  
> > 
> > Shutdown messages with -1 in them rather than the real values.
> 
> OK. We can fix that by patching auditd to see if auditing is enabled
> before requesting signal info. If auditing is disabled, the proper
> action is for the kernel to ignore any audit userspace messages except
> the configuration commands.

If auditing is disabled in the kernel, none of this is trackable.  It is
for those as yet unsupported arches that can run audit enabled but
without auditsyscall support.

Here's a current sample with CONFIG_AUDIT and ~CONFIG_AUDITSYSCALL
configured, note "auid=" and "pid=":

	killall -HUP auditd
	type=DAEMON_CONFIG msg=audit(2019-04-09 11:37:04.508:3266) op=reconfigure state=changed auid=unset pid=-1 subj=? res=success

	killall -TERM auditd
	type=DAEMON_END msg=audit(2019-04-09 11:51:50.441:5709) : op=terminate auid=unset pid=-1 subj=? res=success 
	
and the same with the patch applied:

	killall -HUP auditd
	type=DAEMON_CONFIG msg=audit(2019-04-09 11:42:40.851:8924) op=reconfigure state=changed auid=root pid=652 subj=? res=success

	killall -TERM auditd
	type=DAEMON_END msg=audit(2019-04-09 11:51:50.441:5709) : op=terminate auid=root pid=652 subj=? res=success 

The USR1 "rotate" and USR2 "resume" log messages need to be fixed in
userspace.

> -Steve

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
