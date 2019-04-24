Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7C5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583B321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfDXPdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:33:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:19837 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbfDXPdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:33:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 08:33:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="167523084"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Apr 2019 08:33:18 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 24 Apr 2019 18:33:17 +0300
Date:   Wed, 24 Apr 2019 18:33:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Message-ID: <20190424153317.GN2654@lahna.fi.intel.com>
References: <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190424104613.GD2654@lahna.fi.intel.com>
 <761ed823-58f4-d166-c415-6b100b1fe615@siemens.com>
 <20190424131357.GJ2654@lahna.fi.intel.com>
 <0bb42b3e-58cc-a11c-b8ad-fec67da477b4@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb42b3e-58cc-a11c-b8ad-fec67da477b4@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:24:16PM +0200, Jan Kiszka wrote:
> > I'm trying to say that for the sysfs access (well or char dev) you
> > should not need the sch_sci_handler() thing that is in your current
> > patch.
> 
> Then I'm still missing the black magic where - in my case - CGTS or RGTS are
> read, evaluated and written back.
> 
> And we would still need the gpio-sch driver to handle GGPE, GTNE, GTPE when
> edge events are requested? Is the a reference for /such/ a case? The newer
> Intels must be different then.

I realized the patch does not get an IRQ resource for the device so the
sch_sci_handler() is used to circumvent that. Yeah, if you don't have
IRQ resource available from the device ACPI description then I guess
hooking into ACPI SCI might be sensible thing to do after all...
