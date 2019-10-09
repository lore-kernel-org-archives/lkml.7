Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1EFC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D98B20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfJISFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:05:44 -0400
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:56538 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728804AbfJISFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:05:44 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id B8C771801C507;
        Wed,  9 Oct 2019 18:05:42 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CCA2B18225B16;
        Wed,  9 Oct 2019 18:05:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: month49_316db865c1a40
X-Filterd-Recvd-Size: 3205
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Oct 2019 18:05:39 +0000 (UTC)
Message-ID: <1dfc2bf57335b7eb9f130cc791db76655fb5b8f4.camel@perches.com>
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>, Benjamin Berg <bberg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Date:   Wed, 09 Oct 2019 11:05:37 -0700
In-Reply-To: <20191009175608.GK10395@zn.tnic>
References: <20191009155424.249277-1-bberg@redhat.com>
         <20191009175608.GK10395@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 19:56 +0200, Borislav Petkov wrote:
> On Wed, Oct 09, 2019 at 05:54:24PM +0200, Benjamin Berg wrote:
> > On modern CPUs it is quite normal that the temperature limits are
> > reached and the CPU is throttled. In fact, often the thermal design is
> > not sufficient to cool the CPU at full load and limits can quickly be
> > reached when a burst in load happens. This will even happen with
> > technologies like RAPL limitting the long term power consumption of
> > the package.
> > 
> > So these messages do not usually indicate a hardware issue (e.g.
> > insufficient cooling). Log them as warnings to avoid confusion about
> > their severity.
[]
> > diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
[]
> > @@ -188,7 +188,7 @@ static void therm_throt_process(bool new_event, int event, int level)
> >  	/* if we just entered the thermal event */
> >  	if (new_event) {
> >  		if (event == THERMAL_THROTTLING_EVENT)
> > -			pr_crit("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> > +			pr_warn("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> >  				this_cpu,
> >  				level == CORE_LEVEL ? "Core" : "Package",
> >  				state->count);
> > -- 
> 
> This has carried over since its very first addition in
> 
> commit 3867eb75b9279c7b0f6840d2ad9f27694ba6c4e4
> Author: Dave Jones <davej@suse.de>
> Date:   Tue Apr 2 20:02:27 2002 -0800
> 
>     [PATCH] x86 bluesmoke update.
>     
>     o  Make MCE compile time optional       (Paul Gortmaker)
>     o  P4 thermal trip monitoring.          (Zwane Mwaikambo)
>     o  Non-fatal MCE logging.               (Me)
> 
> 
> It used to be KERN_EMERG back then, though.
> 
> And yes, this issue has come up in the past already so I think I'll take
> it. I'll just give Intel folks a couple of days to object should there
> be anything to object to.

Perhaps this should be

	pr_warn_ratelimited(...)

as the temperature changes can be relatively quick.


