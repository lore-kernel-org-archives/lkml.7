Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79CC0030B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452B12178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395089AbfIGREX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:04:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:9392 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395025AbfIGREX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:04:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 10:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="186081125"
Received: from perezfra-mobl.ger.corp.intel.com ([10.249.34.186])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2019 10:04:17 -0700
Message-ID: <8a6f05b76c37968d494fce9e555f9c21cca83003.camel@linux.intel.com>
Subject: Re: [PATCH v6 4/4] tpm: tpm_tis_spi: Support cr50 devices
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Date:   Sat, 07 Sep 2019 20:04:15 +0300
In-Reply-To: <5d6e9a38.1c69fb81.ad03c.cb4c@mx.google.com>
References: <20190829224110.91103-1-swboyd@chromium.org>
         <20190829224110.91103-5-swboyd@chromium.org>
         <a950f3986375ee4893dff156dc2f9554338c27d8.camel@linux.intel.com>
         <5d6e9a38.1c69fb81.ad03c.cb4c@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 09:52 -0700, Stephen Boyd wrote:
> That's fair. I'll put the Kconfig option back. There's still the small
> issue of what to do about the module name. Should I rename the
> tpm_tis_spi.c file to something else so that the module can keep the
> same name? Or was the tpm_tis_spi_mod.ko trick from v5 good enough?

Not sure I understood the question correctly but how I think
this should be deployed is:

- A boolean CONFIG_TCG_TIS_SPI_CR50.
- tpm_tis_spi_cr50.c that gets compiled in as part of tpm_tis_spi
  when the config option is selected.

I think this would best follow the conventions that are in place
already. Please tell if I got something wrong or if there is some
bottleneck in this framework but this is anyway what I would prefer
with the knowledge I have...

/Jarkko

