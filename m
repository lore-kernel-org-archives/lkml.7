Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D5C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5523C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZLKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:10:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:54032 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfFZLKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:10:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 04:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="184831100"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2019 04:10:44 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hg5p5-0006Qp-Ec; Wed, 26 Jun 2019 14:10:43 +0300
Date:   Wed, 26 Jun 2019 14:10:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190626111043.GJ9224@smile.fi.intel.com>
References: <20190612101945.55065-1-andriy.shevchenko@linux.intel.com>
 <20190624161348.GB21119@dell>
 <20190626092601.GH9224@smile.fi.intel.com>
 <20190626101727.GN21119@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626101727.GN21119@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:17:27AM +0100, Lee Jones wrote:
> On Wed, 26 Jun 2019, Andy Shevchenko wrote:
> > On Mon, Jun 24, 2019 at 05:13:48PM +0100, Lee Jones wrote:
> > > On Wed, 12 Jun 2019, Andy Shevchenko wrote:

> > > > Add an MFD driver for Intel Merrifield Basin Cove PMIC.

> > > > +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> > > > +		ret = platform_get_irq(pdev, i);
> > > 
> > > If you already know the order, define the children's device IDs in the
> > > parent's shared header ('intel_soc_pmic_mrfld.h'?) and retreive them
> > > like:
> > > 
> > >   platform_get_irq(pdev->parent, <SUITABLE_DEFINED_ID>);
> > > 
> > > Then you can skip all of this platform device -> platform device hoop
> > > jumping.
> > 
> > The idea of MFD is to get children to be parent agnostic
> > (at least to some extent). What you are proposing here
> > seems like disadvantage from MFD philosophy. No?
> 
> Not at all.  The idea of MFD is to split up support for monolithic h/w
> such that they can be handled properly by their appropriate
> subsystems, and by extension, maintained by the associated subject
> matter experts.
> 
> Children are often aware of their parents (some siblings are even
> aware of each other!), and many expect and depend on the data-sets
> provided by their parents.

Yes, that's true and that's why I put wording "to some extent" above.

> For instance (this example may come to bite me in the behind, but),
> taken from this very patch, where is this consumed?
> 
>  platform_set_drvdata(pdev, pmic);

Yes. It's used in children. BUT. This structure covers several PMIC chips and
the children driver doesn't know which generation / version of PMIC is serving.

What you are proposing with the change is to strictly link the children driver
to PMIC gen X ver Y, while above example doesn't do that.

So, I'm not convinced it's a good change to have.

-- 
With Best Regards,
Andy Shevchenko


