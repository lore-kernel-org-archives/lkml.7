Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F206BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0883218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfGYViJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:38:09 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:39134 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:38:09 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hqlR0-00033d-8J from George_Davis@mentor.com ; Thu, 25 Jul 2019 14:37:58 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 25 Jul
 2019 14:37:56 -0700
Date:   Thu, 25 Jul 2019 17:37:54 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: Fix null die() string for unhandled data and
 prefetch abort cases
Message-ID: <20190725213754.GA29898@mam-gdavis-lt>
References: <1563589976-19004-1-git-send-email-george_davis@mentor.com>
 <20190720123023.GA1330@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190720123023.GA1330@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

Thanks for your prompt reply!

On Sat, Jul 20, 2019 at 01:30:23PM +0100, Russell King - ARM Linux admin wrote:
> On Fri, Jul 19, 2019 at 10:32:55PM -0400, George G. Davis wrote:
> > When an unhandled data or prefetch abort occurs, the die() string
> > is empty resulting in backtrace messages similar to the following:
> > 
> > 	Internal error: : 1 [#1] PREEMPT SMP ARM
> > 
> > Replace the null string with the name of the abort handler in order
> > to provide more meaningful hints as to the cause of the fault.
> 
> NAK.
> 
> We already print the cause of the abort earlier in the dump, and we've
> also added a "cut here" marker to help people include all the necessary
> information when reporting a problem.

For what it's worth, I often receive crash dumps which lack the pr_alert
messages and only include the pr_emerg messages which this change would at
least provide extra hints, since the "Internal error" as at EMERG level
wereas the initial messages are only at ALERT level. It's subtle but for
cases where the end user has set loglevel such that they only see EMERG
messages, the change is helpful, to me at least.

> It's unfortunate that we have the additional colon in the oops dump,

Agreed, it's rather unfortunate that the string is NULL in these cases.

> but repeating the information that we've printed on one of the previous
> two lines is really not necessary.

It depends on the loglevel the user has set. So perhaps it's not such a
bad thing to repeat the information?

Thanks!

> > 
> > Signed-off-by: George G. Davis <george_davis@mentor.com>
> > ---
> >  arch/arm/mm/fault.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index 0048eadd0681..dddea0a21220 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -557,7 +557,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >  		inf->name, fsr, addr);
> >  	show_pte(current->mm, addr);
> >  
> > -	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
> > +	arm_notify_die(inf->name, regs, inf->sig, inf->code, (void __user *)addr,
> >  		       fsr, 0);
> >  }
> >  
> > @@ -585,7 +585,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
> >  	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
> >  		inf->name, ifsr, addr);
> >  
> > -	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
> > +	arm_notify_die(inf->name, regs, inf->sig, inf->code, (void __user *)addr,
> >  		       ifsr, 0);
> >  }
> >  
> > -- 
> > 2.7.4
> > 
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Regards,
George
