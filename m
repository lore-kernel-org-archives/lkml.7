Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4543C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EC0206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfIPJMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:12:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:57221 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfIPJMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:12:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 02:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="201561380"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 16 Sep 2019 02:11:58 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 16 Sep 2019 12:11:57 +0300
Date:   Mon, 16 Sep 2019 12:11:57 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Message-ID: <20190916091157.GR28281@lahna.fi.intel.com>
References: <69f4a8e8-7889-8b00-0adc-7faaef6b42e4@fortanix.com>
 <32ab6570-c3b7-4eec-7a0b-69bc2f7f76dc@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ab6570-c3b7-4eec-7a0b-69bc2f7f76dc@fortanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 15, 2019 at 08:41:55PM +0000, Jethro Beekman wrote:
> Could someone please review this?
> 
> On 2019-09-04 03:15, Jethro Beekman wrote:
> > Some flash controllers don't have a software sequencer. Avoid
> > configuring the register addresses for it, and double check
> > everywhere that its not accidentally trying to be used.

All the supported types in intel_spi_init() set ->sregs so I don't see
how we could end up calling functions with that not set properly. Which
controller we are talking about here? CNL?
