Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEE0C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AA72082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tb6ptQeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfDBPeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:34:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:44522 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfDBPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:34:09 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 508C9182ECE;
        Tue,  2 Apr 2019 11:34:08 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 5nVrw3w6Xmtl; Tue,  2 Apr 2019 11:34:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E7075182EC7;
        Tue,  2 Apr 2019 11:34:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E7075182EC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554219247;
        bh=7+VWmD43ZhhxkfPwCd9D37efmzVn6YVOFJg0VOODA8I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tb6ptQehk0btdsdCyQ9gZTGK/QF/lK33jSgjV9lcUGHrwzEgC6xOneh2tDQv+35WZ
         frsM48fjcyVKpGzSvPETttMxdJKsPA+norqjQoJQN70C5IolyphOxMy9yfSd32QILG
         qYc3AdFSCRcLNKX00vGfwQvRqLbTofiSMT4ra8936AYCnFi9fM/XnXcXfSWasW+EqW
         TRkaJzIlKvp43jEA0FU5MuftIqqiZ7QSlq9ymBaauCLpwy8oJIvOY+x7WjzRuWJw6S
         HgzaCawbqaBkDAkJmu2Uie3nsiNte5SxAvRJTXUWbjau8aKvIHE1M31zrmo3tqLdHU
         eYzlfW1qU6h4g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id OpaXTqZDysy1; Tue,  2 Apr 2019 11:34:07 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BE223182EBA;
        Tue,  2 Apr 2019 11:34:07 -0400 (EDT)
Date:   Tue, 2 Apr 2019 11:34:07 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Message-ID: <161156422.1435.1554219247444.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190402152334.GC4102@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com> <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com> <20190402152334.GC4102@linux.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF65 (Linux)/8.8.11_GA_3787)
Thread-Topic: Forbid static SRCU use in modules
Thread-Index: ywUP1lCrURB9E62aUdXe3hyxFky+tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 2, 2019, at 11:23 AM, paulmck paulmck@linux.ibm.com wrote:

> On Tue, Apr 02, 2019 at 11:14:40AM -0400, Mathieu Desnoyers wrote:
>> ----- On Apr 2, 2019, at 10:28 AM, paulmck paulmck@linux.ibm.com wrote:
>> 
>> > Hello!
>> > 
>> > This series prohibits use of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
>> > by loadable modules.  The reason for this prohibition is the fact
>> > that using these two macros within modules requires that the size of
>> > the reserved region be increased, which is not something we want to
>> > be doing all that often.  Instead, loadable modules should define an
>> > srcu_struct and invoke init_srcu_struct() from their module_init function
>> > and cleanup_srcu_struct() from their module_exit function.  Note that
>> > modules using call_srcu() will also need to invoke srcu_barrier() from
>> > their module_exit function.
>> 
>> This arbitrary API limitation seems weird.
>> 
>> Isn't there a way to allow modules to use DEFINE_SRCU and DEFINE_STATIC_SRCU
>> while implementing them with dynamic allocation under the hood ?
> 
> Although call_srcu() already has initialization hooks, some would
> also be required in srcu_read_lock(), and I am concerned about adding
> memory allocation at that point, especially given the possibility
> of memory-allocation failure.  And the possibility that the first
> srcu_read_lock() happens in an interrupt handler or similar.
> 
> Or am I missing a trick here?

I was more thinking that under #ifdef MODULE, both DEFINE_SRCU and
DEFINE_STATIC_SRCU could append data in a dedicated section. module.c
would additionally lookup that section on module load, and deal with
those statically defined SRCU entries as if they were dynamically
allocated ones. It would of course cleanup those resources on module
unload.

Am I missing some subtlety there ?

Thanks,

Mathieu


> 
>							Thanx, Paul
> 
>> Thanks,
>> 
>> Mathieu
>> 
>> 
>> > 
>> > This series consist of the following:
>> > 
>> > 1.	Dynamically allocate dax_srcu.
>> > 
>> > 2.	Dynamically allocate drm_unplug_srcu.
>> > 
>> > 3.	Dynamically allocate kfd_processes_srcu.
>> > 
>> > These build and have been subjected to 0day testing, but might also need
>> > testing by someone having the requisite hardware.
>> > 
>> >							Thanx, Paul
>> > 
>> > ------------------------------------------------------------------------
>> > 
>> > drivers/dax/super.c                        |   10 +++++-
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |    5 +++
>> > drivers/gpu/drm/amd/amdkfd/kfd_process.c   |    2 -
>> > drivers/gpu/drm/drm_drv.c                  |    8 ++++
>> > include/linux/srcutree.h                   |   19 +++++++++--
>> > kernel/rcu/rcuperf.c                       |   40 +++++++++++++++++++-----
>> > kernel/rcu/rcutorture.c                    |   48 +++++++++++++++++++++--------
>> >  7 files changed, 105 insertions(+), 27 deletions(-)
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
