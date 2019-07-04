Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B482DC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4D32085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGDNyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:54:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:9871 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfGDNyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:54:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 06:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="247944715"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2019 06:54:45 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hj2CC-0006dy-GA; Thu, 04 Jul 2019 16:54:44 +0300
Date:   Thu, 4 Jul 2019 16:54:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190704135444.GA9224@smile.fi.intel.com>
References: <20190612101945.55065-1-andriy.shevchenko@linux.intel.com>
 <20190624161348.GB21119@dell>
 <20190626092601.GH9224@smile.fi.intel.com>
 <20190626101727.GN21119@dell>
 <20190626111043.GJ9224@smile.fi.intel.com>
 <20190627134446.GD2000@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627134446.GD2000@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 02:44:46PM +0100, Lee Jones wrote:
> On Wed, 26 Jun 2019, Andy Shevchenko wrote:
> 
> > On Wed, Jun 26, 2019 at 11:17:27AM +0100, Lee Jones wrote:
> > > On Wed, 26 Jun 2019, Andy Shevchenko wrote:
> > > > On Mon, Jun 24, 2019 at 05:13:48PM +0100, Lee Jones wrote:
> > > > > On Wed, 12 Jun 2019, Andy Shevchenko wrote:
> > 
> > > > > > Add an MFD driver for Intel Merrifield Basin Cove PMIC.
> > 
> > > > > > +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> > > > > > +		ret = platform_get_irq(pdev, i);
> > > > > 
> > > > > If you already know the order, define the children's device IDs in the
> > > > > parent's shared header ('intel_soc_pmic_mrfld.h'?) and retreive them
> > > > > like:
> > > > > 
> > > > >   platform_get_irq(pdev->parent, <SUITABLE_DEFINED_ID>);
> > > > > 
> > > > > Then you can skip all of this platform device -> platform device hoop
> > > > > jumping.
> > > > 
> > > > The idea of MFD is to get children to be parent agnostic
> > > > (at least to some extent). What you are proposing here
> > > > seems like disadvantage from MFD philosophy. No?
> > > 
> > > Not at all.  The idea of MFD is to split up support for monolithic h/w
> > > such that they can be handled properly by their appropriate
> > > subsystems, and by extension, maintained by the associated subject
> > > matter experts.
> > > 
> > > Children are often aware of their parents (some siblings are even
> > > aware of each other!), and many expect and depend on the data-sets
> > > provided by their parents.
> > 
> > Yes, that's true and that's why I put wording "to some extent" above.
> > 
> > > For instance (this example may come to bite me in the behind, but),
> > > taken from this very patch, where is this consumed?
> > > 
> > >  platform_set_drvdata(pdev, pmic);
> > 
> > Yes. It's used in children. BUT. This structure covers several PMIC chips and
> > the children driver doesn't know which generation / version of PMIC is serving.
> > 
> > What you are proposing with the change is to strictly link the children driver
> > to PMIC gen X ver Y, while above example doesn't do that.
> 
> Well that is a different argument. :)

> I still don't really like the idea of sucking one set of platform data
> just to place in another.  The implementation even looks hacky.

To me it looks straight forward. We get a description of MFD and split it
accordingly. Look at the rest of Intel PMIC drivers, they are built on the
same principles.

"Thanks" to firmware here, that does more, than on other PMICs, that's why we
have several IRQ resources, but from hardware point of view it's still an MFD.

> What if you were to provide the child driver with its IRQ index?
> Perhaps via platform data?

It seems some people would like to bring up Shady Cove PMIC support in the
future, which seems to behave in a similar way, while the (most of the) drivers
can be re-used.

So, for me it will look like a hack in each of PMIC driver to have additional
platform data for whatever can be passed using well-established facilities,
like device resources.

> > So, I'm not convinced it's a good change to have.

-- 
With Best Regards,
Andy Shevchenko


