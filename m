Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A04206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKNKsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:48:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40235 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNKsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:48:17 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVCfZ-00087p-3k; Thu, 14 Nov 2019 11:48:09 +0100
Date:   Thu, 14 Nov 2019 11:48:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 21/23] y2038: itimer: change implementation to
 timespec64
In-Reply-To: <20191113210611.515868a4@oasis.local.home>
Message-ID: <alpine.DEB.2.21.1911141147220.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-12-arnd@arndb.de> <alpine.DEB.2.21.1911132306070.2507@nanos.tec.linutronix.de> <20191113210611.515868a4@oasis.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Steven Rostedt wrote:
> On Wed, 13 Nov 2019 23:28:47 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Fri, 8 Nov 2019, Arnd Bergmann wrote:
> > >  TRACE_EVENT(itimer_state,
> > >  
> > > -	TP_PROTO(int which, const struct itimerval *const value,
> > > +	TP_PROTO(int which, const struct itimerspec64 *const value,
> > >  		 unsigned long long expires),
> > >  
> > >  	TP_ARGS(which, value, expires),
> > > @@ -321,12 +321,12 @@ TRACE_EVENT(itimer_state,
> > >  		__entry->which		= which;
> > >  		__entry->expires	= expires;
> > >  		__entry->value_sec	= value->it_value.tv_sec;
> > > -		__entry->value_usec	= value->it_value.tv_usec;
> > > +		__entry->value_usec	= value->it_value.tv_nsec / NSEC_PER_USEC;
> > >  		__entry->interval_sec	= value->it_interval.tv_sec;
> > > -		__entry->interval_usec	= value->it_interval.tv_usec;
> > > +		__entry->interval_usec	= value->it_interval.tv_nsec / NSEC_PER_USEC;  
> > 
> > Hmm, having a division in a tracepoint is clearly suboptimal.
> 
> Right, we should move the division into the TP_printk()
> 
> 		__entry->interval_nsec = alue->it_interval.tv_nsec;
> 
> > 
> > >  	),
> > >  
> > > -	TP_printk("which=%d expires=%llu it_value=%ld.%ld it_interval=%ld.%ld",
> > > +	TP_printk("which=%d expires=%llu it_value=%ld.%06ld it_interval=%ld.%06ld",  
> > 
> > We print only 6 digits after the . so that would be even correct w/o a
> > division. But it probably does not matter much.
> 
> Well, we still need the division in the printk, otherwise it will print
> more than 6. That's just the minimum and it will print the full number.

That's fine. The print is not really timing critical, the tracepoint very
much so.

Thanks,

	tglx
