Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC3EC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADA1229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfGYXPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:15:50 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:42872 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGYXPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:15:50 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hqmxI-0004Gl-Hn from George_Davis@mentor.com ; Thu, 25 Jul 2019 16:15:24 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 25 Jul
 2019 16:15:22 -0700
Date:   Thu, 25 Jul 2019 19:15:21 -0400
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
Message-ID: <20190725231520.GC29898@mam-gdavis-lt>
References: <1563589976-19004-1-git-send-email-george_davis@mentor.com>
 <20190720123023.GA1330@shell.armlinux.org.uk>
 <20190725213754.GA29898@mam-gdavis-lt>
 <20190725215540.GM1330@shell.armlinux.org.uk>
 <20190725222401.GB29898@mam-gdavis-lt>
 <20190725223248.GO1330@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190725223248.GO1330@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On Thu, Jul 25, 2019 at 11:32:49PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Jul 25, 2019 at 06:24:01PM -0400, George G. Davis wrote:
> > Hello Russell,
> > 
> > On Thu, Jul 25, 2019 at 10:55:40PM +0100, Russell King - ARM Linux admin wrote:
> > > On Thu, Jul 25, 2019 at 05:37:54PM -0400, George G. Davis wrote:
> > > > Hello Russell,
> > > > 
> > > > Thanks for your prompt reply!
> > > > 
> > > > On Sat, Jul 20, 2019 at 01:30:23PM +0100, Russell King - ARM Linux admin wrote:
> > > > > On Fri, Jul 19, 2019 at 10:32:55PM -0400, George G. Davis wrote:
> > > > > > When an unhandled data or prefetch abort occurs, the die() string
> > > > > > is empty resulting in backtrace messages similar to the following:
> > > > > > 
> > > > > > 	Internal error: : 1 [#1] PREEMPT SMP ARM
> > > > > > 
> > > > > > Replace the null string with the name of the abort handler in order
> > > > > > to provide more meaningful hints as to the cause of the fault.
> > > > > 
> > > > > NAK.
> > > > > 
> > > > > We already print the cause of the abort earlier in the dump, and we've
> > > > > also added a "cut here" marker to help people include all the necessary
> > > > > information when reporting a problem.
> > > > 
> > > > For what it's worth, I often receive crash dumps which lack the pr_alert
> > > > messages and only include the pr_emerg messages which this change would at
> > > > least provide extra hints, since the "Internal error" as at EMERG level
> > > > wereas the initial messages are only at ALERT level. It's subtle but for
> > > > cases where the end user has set loglevel such that they only see EMERG
> > > > messages, the change is helpful, to me at least.
> > > > 
> > > > > It's unfortunate that we have the additional colon in the oops dump,
> > > > 
> > > > Agreed, it's rather unfortunate that the string is NULL in these cases.
> > > > 
> > > > > but repeating the information that we've printed on one of the previous
> > > > > two lines is really not necessary.
> > > > 
> > > > It depends on the loglevel the user has set. So perhaps it's not such a
> > > > bad thing to repeat the information?
> > > 
> > > Or maybe we should arrange for consistent usage of the log levels?
> > 
> > Unfortunately, some of the users that I work with have very specific limits
> > and requirements for kernel error message logging which are driven by
> > performance and/or storage limitations. So it's not always possible to "arrange
> > for consistent usage of the log levels" with some users. Meanwhile, these
> > messages do show up in logs without the pre-able headers, lacking the string
> > which is already available. It's hardly a big deal to re-use the same string,
> > especially for the !user_mode(regs) case, where the kernel will oops at
> > EMERG loglevel, leaving the NULL string as the reason. I can assure you that
> > I've tried to convince these users to change the loglevel but they have their
> > reasons for keeping it as they do and I'm unable to convince them otherwise.
> 
> Sorry, but I really don't buy this.
> 
> By your argument, we should get rid of the pre-amble headers because
> they're "not useful" in your eyes...

For user_mode(regs), the system will remain running and logs may be
checked on the running system as usual in conjuction signal handler
exception handling. So no, I don't agree that the pre-amble headers are
"not useful", in fact, they are quite useful for interactive and automated
debugging of user faults, and of course most normal deployment cases which
retain full message logs on disk. It's only for the !user_mode(regs) case,
in some embedded deployment cases, where the change is intended to provide more
insight which may be missing otherwise, in admittedly limited use cases.

My last argument in favor of applying the change is this: the string
pointer is already loaded in a register and so likely costs less instructions
and time to simply pass it onto arm_notify_die() compared to the
cost of loading a NULL string pointer into a register. For the user_mode(regs)
case, the string is not used and cost nothing to pass along. For the !user_mode(regs)
case, it provides information which may be missing otherwise depending on the
loglevel.

Thanks again for your prompt replies and consideration!

-- 
Regards,
George
