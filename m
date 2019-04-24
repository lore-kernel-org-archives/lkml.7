Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E6EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770AF21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfDXKdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:33:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:9654 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfDXKdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:33:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 03:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="167451936"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Apr 2019 03:33:07 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 24 Apr 2019 13:33:06 +0300
Date:   Wed, 24 Apr 2019 13:33:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Message-ID: <20190424103306.GC2654@lahna.fi.intel.com>
References: <20190424075816.GU2654@lahna.fi.intel.com>
 <8999d3f8-d169-eb85-bd2f-08c99d184ea2@siemens.com>
 <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:19:02PM +0200, Jan Kiszka wrote:
> > I think what you want is "GPIO signaled ACPI event". It works so that
> > you declare _AEI method below the GPIO controller listing the GPIOs you
> > want to trigger events for and then either _Lxx, _Exx or _EVT method for
> > each of them under the same controller. GPIO core then handles it
> > automatically when you register the GPIO chip. See also
> > acpi_gpiochip_request_interrupts().
> 
> Right, that is was I read as well. Let's assume I would be able to patch the
> tables: Would I describe all the logic of this patch in ACPI terms? Where to
> enable interrupts, how to dispatch the SCI event, how to acknowledge it
> etc.? Will it also take care of locking? (BTW, my locking seems to have some
> remaining inconsistency, on second look.)

The GPIO core would then take care of it by requesting the GPIO in
question and dispatching to the correct event handler. In this patch you
just leave out the SCI part and only implement the irqchip like you did
already.

> And even if that were possible, we would be back to the square of existing
> devices without those definitions. If this were a recent chipset, I would
> say, "go, fix future firmware versions". But this one is legacy.

Is it fixing some real issue with these legacy platforms? I mean without
the patch some GPE event is not handled properly? It was not clear to me
from the commit message.
