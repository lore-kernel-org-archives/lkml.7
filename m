Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8092077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfH2SFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:05:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:39199 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2SFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:05:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 11:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="332595922"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2019 11:04:53 -0700
Date:   Thu, 29 Aug 2019 21:04:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v5 4/4] tpm: tpm_tis_spi: Support cr50 devices
Message-ID: <20190829180451.4lfj76tucxcoyik3@linux.intel.com>
References: <20190828082150.42194-1-swboyd@chromium.org>
 <20190828082150.42194-5-swboyd@chromium.org>
 <20190829163221.72njmrixakywqi5z@linux.intel.com>
 <5d6801f3.1c69fb81.58389.32c9@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6801f3.1c69fb81.58389.32c9@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:48:50AM -0700, Stephen Boyd wrote:
> > > +int tpm_tis_spi_resume(struct device *dev)
> > > +{
> > > +     struct tpm_chip *chip = dev_get_drvdata(dev);
> > > +     struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
> > > +     struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> > > +     struct cr50_spi_phy *cr50_phy;
> > > +
> > > +     if (phy->is_cr50) {
> > > +             cr50_phy = to_cr50_spi_phy(phy);
> > > +             /*
> > > +              * Jiffies not increased during suspend, so we need to reset
> > > +              * the time to wake Cr50 after resume.
> > > +              */
> > > +             cr50_phy->wake_after = jiffies;
> > > +     }
> > 
> > To simplify the code I would just put also wake_after to
> > tpm_tis_spi_phy.
> 
> Ok. But keep the other members in cr50_spi_phy as they are?

Yes, just want to get rid of that boolean and branching since the
operations done have insignificant cost.

/Jarkko
