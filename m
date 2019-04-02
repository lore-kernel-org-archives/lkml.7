Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C93C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8897920830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OwHPeheD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfDBPOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:14:43 -0400
Received: from mail.efficios.com ([167.114.142.138]:42680 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbfDBPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:14:42 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 650DE18290E;
        Tue,  2 Apr 2019 11:14:41 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 2kavt2b2mTVw; Tue,  2 Apr 2019 11:14:40 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CFAE5182900;
        Tue,  2 Apr 2019 11:14:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CFAE5182900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554218080;
        bh=1MCSN9CVZtVSVTEWu0xUJTDuc1sZZRfU9bzK+6KHh9Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OwHPeheDSRuWaVxY2QcMo306MSlw59oShsUbtzfRVhIg+KYfh3Pr0LSNakCvZ5Woz
         8HC96vERYH2Z7M2EmHZ/VCKWll3ukNXIgR/bj7v5eLVv+pQeNjua8X3rcT5H8ooW7N
         V24IjNZg7Zm3YdqF5X6qtx3RzEPwX/JaBRjH0rULK0QQLktO9A4awLZMlWhTVlF8za
         TH03qSLY8X0FjrpId+hBIRznVVzNHcNUTxYHkfvFktMzI9lX7vBpHSqqd0+4dNFRtR
         pLEtHqIm748+p4DacmDtCze12D0BxQjoDgqyNf3fDdR3eo7JL/JfYl1URZutYF3ZVF
         cVkrhM6HbC/UA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 11iw0LvriLyU; Tue,  2 Apr 2019 11:14:40 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id ACED81828F6;
        Tue,  2 Apr 2019 11:14:40 -0400 (EDT)
Date:   Tue, 2 Apr 2019 11:14:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
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
        linux-nvdimm@lists.01.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Message-ID: <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190402142816.GA13084@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF65 (Linux)/8.8.11_GA_3787)
Thread-Topic: Forbid static SRCU use in modules
Thread-Index: oUG6FxPVmetxKAO3+cEe0XvMdbo6Fg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 2, 2019, at 10:28 AM, paulmck paulmck@linux.ibm.com wrote:

> Hello!
> 
> This series prohibits use of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
> by loadable modules.  The reason for this prohibition is the fact
> that using these two macros within modules requires that the size of
> the reserved region be increased, which is not something we want to
> be doing all that often.  Instead, loadable modules should define an
> srcu_struct and invoke init_srcu_struct() from their module_init function
> and cleanup_srcu_struct() from their module_exit function.  Note that
> modules using call_srcu() will also need to invoke srcu_barrier() from
> their module_exit function.

This arbitrary API limitation seems weird.

Isn't there a way to allow modules to use DEFINE_SRCU and DEFINE_STATIC_SRCU
while implementing them with dynamic allocation under the hood ?

Thanks,

Mathieu


> 
> This series consist of the following:
> 
> 1.	Dynamically allocate dax_srcu.
> 
> 2.	Dynamically allocate drm_unplug_srcu.
> 
> 3.	Dynamically allocate kfd_processes_srcu.
> 
> These build and have been subjected to 0day testing, but might also need
> testing by someone having the requisite hardware.
> 
>							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> drivers/dax/super.c                        |   10 +++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |    5 +++
> drivers/gpu/drm/amd/amdkfd/kfd_process.c   |    2 -
> drivers/gpu/drm/drm_drv.c                  |    8 ++++
> include/linux/srcutree.h                   |   19 +++++++++--
> kernel/rcu/rcuperf.c                       |   40 +++++++++++++++++++-----
> kernel/rcu/rcutorture.c                    |   48 +++++++++++++++++++++--------
>  7 files changed, 105 insertions(+), 27 deletions(-)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
