Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CF8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78169213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfDICIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:08:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:4743 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfDICIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:08:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 19:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="221742454"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2019 19:08:36 -0700
Date:   Mon, 8 Apr 2019 19:07:28 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC PATCH v2 13/14] watchdog/hardlockup/hpet: Only enable the
 HPET watchdog via a boot parameter
Message-ID: <20190409020728.GA7259@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-14-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1903262223330.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262223330.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:29:52PM +0100, Thomas Gleixner wrote:
> On Wed, 27 Feb 2019, Ricardo Neri wrote:
> > +			When hpet is specified, the NMI watchdog will be driven
> > +			by an HPET timer, if available in the system. Otherwise,
> > +			the perf-based implementation will be used. Specifying
> > +			hpet implies that nmi_watchdog is on.
> 
> How so?
> 
I meant to say that the user does not need to provide nmi_watchdog=1 and
nmi_watchdog=hpet separately.

I think this is true because watchdog_user_enabled in kernel/watchdog.c is set
to 1 when CONFIG_HARDLOCKUP_DETECTOR is selected. Also, if nmi_watchdog_available
is set to true if watchdog_nmi_probe() is successful.

Perhaps I can add a warning in case nmi_watchdog=hpet and either
CONFIG_HARDLOCKUP_DETECTOR or CONFIG_HARDLOCKUP_DETECTOR_HPET are not
selected?

> > +static int __init hardlockup_detector_hpet_setup(char *str)
> > +{
> > +	if (strstr(str, "hpet"))
> > +		hardlockup_use_hpet = true;
> 
> strstr()? Not really.

Is strncmp(str, "hpet", 5) more acceptable?

> 
> > +
> > +	return 0;
> > +}
> > +__setup("nmi_watchdog=", hardlockup_detector_hpet_setup);
> > +
> >  /**
> >   * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
> >   *
> > @@ -405,6 +422,9 @@ int __init hardlockup_detector_hpet_init(void)
> >  {
> >  	int ret;
> >  
> > +	if (!hardlockup_use_hpet)
> > +		return -ENODEV;
> 
> This should have been there in the patch which introduces
> hardlockup_detector_hpet_init(). And this patch merily adds the command
> line magic which sets that flag.

Sure, I will move this check into the patch that introduces
hardlockup_detector_hpet_init().

> 
> > +
> >  	if (!is_hpet_enabled())
> >  		return -ENODEV;
> >  
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index 367aa81294ef..28cad7310378 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -78,7 +78,7 @@ static int __init hardlockup_panic_setup(char *str)
> >  		nmi_watchdog_user_enabled = 0;
> >  	else if (!strncmp(str, "1", 1))
> >  		nmi_watchdog_user_enabled = 1;
> > -	return 1;
> > +	return 0;
> 
> Why?

My understanding is that this is needed so that other __setup functions that also
want to check "nmi_watchdog" are able to do it. Is this understanding
not correct?

Thanks and BR,
Ricardo
