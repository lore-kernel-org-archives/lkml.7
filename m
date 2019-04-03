Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A817DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6156320700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDCSMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:12:10 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:60950 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:12:10 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-9-223-nat.elisa-mobile.fi [85.76.9.223])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 27CF7200BD;
        Wed,  3 Apr 2019 21:12:07 +0300 (EEST)
Date:   Wed, 3 Apr 2019 21:12:06 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] drivers: firmware: psci: add support for warm reset
Message-ID: <20190403181206.GA17115@darkstar.musicnaut.iki.fi>
References: <20190401181443.6459-1-aaro.koskinen@iki.fi>
 <20190403033314.k2wqxkm5c7imhtu5@blommer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403033314.k2wqxkm5c7imhtu5@blommer>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 03, 2019 at 04:33:15AM +0100, Mark Rutland wrote:
> On Mon, Apr 01, 2019 at 09:14:43PM +0300, Aaro Koskinen wrote:
> > From: Aaro Koskinen <aaro.koskinen@nokia.com>
> > 
> > Add support for warm reset using SYSTEM_RESET2 introduced in PSCI
> > 1.1 specification.
> 
> For reference, how do you intend to use this?

The reboot mode is set using the kernel command line. One use case for warm
reset is pstore/ramoops.

> > @@ -256,6 +257,14 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> >  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
> >  }
> >  
> > +static void psci_sys_reset2(enum reboot_mode reboot_mode, const char *cmd)
> > +{
> > +	if (reboot_mode == REBOOT_WARM)
> > +		invoke_psci_fn(psci_function_id[PSCI_FN_SYSTEM_RESET2], 0, 0, 0);
> > +	else
> > +		psci_sys_reset(reboot_mode, cmd);
> > +}
> 
> What happens when RESET2 isn't available, but the user requests s REBOOT_WARM
> reset? It looks like we'd invoke a bogus SMC.

This function is only called through arm_pm_restart. If the feature is
not available, then arm_pm_restart points to the default psci_sys_reset.

> Could we please add a preprocessor definition for SYSTEM_RESET_WARM so that
> it's clear that we're passing a parameter here?

OK, will add.

> >  /*
> >   * Probe function for PSCI firmware versions >= 0.2
> >   */
> > @@ -588,6 +611,8 @@ static int __init psci_probe(void)
> >  		psci_init_smccc();
> >  		psci_init_cpu_suspend();
> >  		psci_init_system_suspend();
> > +		if (PSCI_VERSION_MINOR(ver) >= 1)
> > +			psci_1_1_set_functions();
> >  	}
> 
> If we're going to add more things to this chain, can we please refactor this as:
> 
> 	if (ver < PSCI_VERSION(1, 0))
> 		return;
> 
> 	/* PSCI 1.0 setup here */
> 
> 	if (ver < PSCI_VERSION(1,1))
> 		return;
> 
> 	/* PSCI 1.1 setup here */
> 
> ... as that saves on indentation and is easier to extend in future.

OK, makes sense, I will do that.

Thanks,

A.
