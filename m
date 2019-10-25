Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFC72070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409701AbfJYKoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:44:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:8776 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404578AbfJYKob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:44:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 03:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="400070770"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2019 03:44:29 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNx52-00044K-HO; Fri, 25 Oct 2019 13:44:28 +0300
Date:   Fri, 25 Oct 2019 13:44:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andrey Zhizhikin <andrey.z@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
Message-ID: <20191025104428.GP32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:38:52AM +0200, Hans de Goede wrote:
> On 25-10-2019 09:53, Andy Shevchenko wrote:
> > On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
> > > This patchset introduces additional regulator driver for Intel Cherry
> > > Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
> > > PMIC, which is used to instantiate this regulator.
> > > 
> > > Regulator support for this PMIC was present in kernel release from Intel
> > > targeted Aero platform, but was not entirely ported upstream and has
> > > been omitted in mainline kernel releases. Consecutively, absence of
> > > regulator caused the SD Card interface not to be provided with Vqcc
> > > voltage source needed to operate with UHS-I cards.
> > > 
> > > Following patches are addessing this issue and making sd card interface
> > > to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
> > > of the SD Card interface in consumers and exposes optional "vqmmc"
> > > voltage source, which mmc driver uses to switch signalling voltages
> > > between 1.8V and 3.3V.
> > > 
> > > This set contains of 2 patches: one is implementing the regulator driver
> > > (based on a non upstreamed version from Intel Aero), and another patch
> > > registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
> > 
> > Thank you.
> > Hans, Cc'ed, has quite interested in these kind of patches.
> > Am I right, Hans?
> 
> Yes since I do a lot of work on Bay and Cherry Trail hw enablement I'm
> always interested in CHT specific patches.
> 
> Overall this series looks good (from a high level view I did not
> do a detailed review) but I wonder if we really want to export all the
> regulators when we just need the vsdio one?
> 
> Most regulators are controlled by either the P-Unit inside the CHT SoC
> or through ACPI OpRegion accesses.  Luckily the regulator subsys does not
> expose a sysfs interface for users to directly poke regulators, but this will
> still make it somewhat easier for users to poke regulators which they should
> leave alone.
> 
> Note I'm not saying this is wrong, having support for all regulators in place
> in case we need it in the future is also kinda nice. OTOH if we just need the
> one now, maybe we should just support the one for now ?
> 
> Andy do you have an opinion on this?

Usually on such patches I have two (a bit contradicted) wishes:
- be as little as needed
- for sake of documentation purposes keep as many definitions as we can

But you know the dangling code / definitions not accepted by all maintainers.

So, that said, I have no strong opinion here, basically rely on maintainer's
point of view.

Perhaps also good idea is to put a reference as URL to the published code from
which this has been derived.

> 
> Andrey, may I ask which device you are testing this on?
> 
> Anyways overall good work, thank you for doing this!

+1 to the cheering up!

-- 
With Best Regards,
Andy Shevchenko


