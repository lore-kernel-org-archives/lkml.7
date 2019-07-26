Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E836EC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC0D22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfGZUB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:01:58 -0400
Received: from mail.sssup.it ([193.205.80.98]:21994 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbfGZUB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:01:57 -0400
Received: from [151.41.39.6] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 141127218; Fri, 26 Jul 2019 22:01:55 +0200
Date:   Fri, 26 Jul 2019 22:01:49 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 00/13] SCHED_DEADLINE server infrastructure
Message-ID: <20190726220149.6f05f8df@sweethome>
In-Reply-To: <20190726145409.947503076@infradead.org>
References: <20190726145409.947503076@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, 26 Jul 2019 16:54:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Hi,
> 
> So recently syzcaller ran into the big deadline/period issue (again),
> and I figured I should at least propose a patch that puts limits on
> that -- see Patch 1.
> 
> During that discussion; SCHED_OTHER servers got mentioned (also
> again), and I figured I should have a poke at that too. So I took
> some inspiration from patches Alessio Balsini send a while back and
> cobbled something together for that too.

I think Patch 1 is a very good idea!

The server patches look interesting (and they seem to be much simpler
than our patchset :). I need to have a better look at them, but this
seems to be very promising.



			Thanks,
				Luca



> 
> Included are also a bunch of patches I did for core scheduling (2-8),
> which I'm probably going to just merge as they're generic cleanups.
> They're included here because they make pick_next_task() simpler and
> thereby thinking about the nested pick_next_task() logic inherent in
> servers was less of a head-ache. (I think it can work fine without
> them, but its easier with them on)
> 
> Anyway; after it all compiled it booted a kvm image all the way to
> userspace on the first run, so clearly this code isn't to be trusted
> at all.
> 
> There's still lots of missing bits and pieces -- like changelogs and
> the fair server isn't configurable or hooked into the bandwidth
> accounting, but the foundation is there I think.
> 
> Enjoy!
> 

