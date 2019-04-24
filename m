Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1686C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEF4218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfDXInF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:43:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:26484 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfDXInE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:43:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 01:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="167427388"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Apr 2019 01:43:00 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 24 Apr 2019 11:42:59 +0300
Date:   Wed, 24 Apr 2019 11:42:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Message-ID: <20190424084259.GW2654@lahna.fi.intel.com>
References: <cover.1555579429.git.jan.kiszka@siemens.com>
 <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
 <20190424075816.GU2654@lahna.fi.intel.com>
 <8999d3f8-d169-eb85-bd2f-08c99d184ea2@siemens.com>
 <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:25:40AM +0200, Jan Kiszka wrote:
> On 24.04.19 10:18, Mika Westerberg wrote:
> > On Wed, Apr 24, 2019 at 10:12:42AM +0200, Jan Kiszka wrote:
> > > On 24.04.19 09:58, Mika Westerberg wrote:
> > > > +Rafael and linux-acpi.
> > > > 
> > > > On Thu, Apr 18, 2019 at 11:23:49AM +0200, Jan Kiszka wrote:
> > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > 
> > > > > Validated on the Quark platform, this adds interrupt support on rising
> > > > > and/or falling edges.
> > > > 
> > > > The irqchip parts look good to me but but the ACPI SCI handling seems
> > > > weird. This is typically handled by ACPI core based on the values read
> > > > from FADT ACPI table. What does it contain on this Quark platform?
> > > 
> > > There is no FADT on the original Quark firmware, nor did we add one. As we
> > > are talking about existing devices, possibly not only Quarks, I was going
> > > down the ACPI-independent way to hook into the interrupt. But I'm open to
> > > learn about better alternatives.
> > 
> > Hmm, if it does not have FADT table why would you need SCI then? Is this
> > implementing some real use case?
> > 
> 
> Maybe I'm looking at the wrong place: Where would I find it? There is
> definitely no separate entry under /sys/firmware/acpi/tables - but that's
> also true for my workstation.

The table signature and name is FACP for historical reasons.
