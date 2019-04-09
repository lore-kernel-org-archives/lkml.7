Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E1BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FED2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yDrh5wOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDILAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:00:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfDILAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4MNrtPReHgTdlubJ6RA99o6zlc1NcScJp4aN2SxpjRM=; b=yDrh5wOvwNF4zer2WsQ25BTsd
        uaogI5FDdrZHIXd7sRLAqNuz9gDk23hBAbxJWb/VSOjK2AjzGK1OBDT4VK0Vwko+XTJ6NDzN0ZdPV
        bPxehnFnM9Vi0huH31n3thYm5vwmqmU+leo7LaOeTDcz/Yz8BLiSdmAqUFK+52P9YZoKaMQIBAtNW
        KqN6APfWI3StV80XsFcBKPfVrsJDgvYvilOWmCv9FjokT/s+cuVZpPECA3VIY+jRv9t0mluHF88hP
        Apvgfu4CEvW1ZU6ErMObpdjj5xwoB0zi9wESJ4BOWdf1H2pTmV1n8fGHZPS3U1XThCIVDmCzHPelQ
        znFGQd+6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDoTk-0006Zp-Tu; Tue, 09 Apr 2019 10:59:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D90F201F29A4; Tue,  9 Apr 2019 12:59:46 +0200 (CEST)
Date:   Tue, 9 Apr 2019 12:59:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RFC PATCH v2 11/14] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20190409105946.GR4038@hirez.programming.kicks-ass.net>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1903262029310.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262029310.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:49:13PM +0100, Thomas Gleixner wrote:
> So way you should handle this is:
> 
> 	cpumask_set_cpu(cpu, hld_data->cpu_monitored_mask);
> 
> 	if (!hld_data->enabled_cpus++) {
> 		hld_data->handling_cpu = cpu;
> 		kick_timer();
> 		enable_timer();
> 	}
> 
> The cpu mask starts off empty and each CPU sets itself when the function is
> invoked on it.
> 
> data->enabled_cpus keeps track of the enabled cpus so you avoid
> reconfiguration just because a different cpu comes online. And it's
> required for disable as well.
> 
> > +void hardlockup_detector_hpet_disable(void)
> > +{
> > +	struct cpumask *allowed = watchdog_get_allowed_cpumask();
> > +
> > +	if (!hld_data)
> > +		return;
> > +
> > +	/* Only disable the timer if there are no more CPUs to monitor. */
> > +	if (!cpumask_weight(allowed))
> > +		disable_timer(hld_data);
> 
> Again this should be:
> 
> 	cpumask_clear_cpu(cpu, hld_data->cpu_monitored_mask);
> 	hld_data->enabled_cpus--;
> 
> 	if (hld_data->handling_cpu != cpu)
> 		return;
> 
> 	disable_timer();
> 	if (hld_data->enabled_cpus)
> 		return;

	if (!hld_data->enabled_cpus)
		return;

> 
> 	hld_data->handling_cpu = cpumask_first(hld_data->cpu_monitored_mask);
> 	enable_timer();

That said; you can do the above without ->enabled_cpus, by using
->handling_cpu == nr_cpu_ids to indicate 'empty'. But I'm not at all
sure that is worth the effort, it results in less obious code.
