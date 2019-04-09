Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7472DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC2F2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDINl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:41:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:55665 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfDINl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:41:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 06:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="335177220"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.55.112])
  by fmsmga006.fm.intel.com with ESMTP; 09 Apr 2019 06:41:42 -0700
Date:   Tue, 9 Apr 2019 16:41:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Paul Zimmerman <pauldzim@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression in suspend-to-ram (TPM related) with 5.1-rc1
 (BISECTED)
Message-ID: <20190409134141.GB9759@linux.intel.com>
References: <CADBGO7_WUoA53gM8EDFy6Q36SDEZPU9V=OUBA0QM20FOko51Rg@mail.gmail.com>
 <CADBGO7-UkQMxSPdSX9bGVPxSRROj75FA16FuXeFrVmcKVQ_Qdg@mail.gmail.com>
 <CADBGO7_XnbXiWHB=O1B_+b+CUA9g-bYJHN37VJ2SsxXMNHcPOQ@mail.gmail.com>
 <20190321134140.GA4603@linux.intel.com>
 <31f75727-d2c3-1afa-ab14-1dbc62a6315b@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31f75727-d2c3-1afa-ab14-1dbc62a6315b@ginzinger.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 07:53:34AM +0200, Martin Kepplinger wrote:
> On 21.03.19 14:41, Jarkko Sakkinen wrote:
> > On Tue, Mar 19, 2019 at 04:03:37PM -0700, Paul Zimmerman wrote:
> >> So I bisected this down to:
> >>
> >> # first bad commit: [a3fbfae82b4cb3ff9928e29f34c64d0507cad874] tpm:
> >> take TPM chip power gating out of tpm_transmit()
> >>
> >> but this doesn't revert cleanly on Linus' HEAD. Anyone have an idea what
> >> could be wrong here?
> > 
> > Sorry I've been in flu for the early week. I spotted the bug
> > immediately.  When I did these patches I did not have TPM 1.x at my
> > hand. I used fTPM 2.0 and dTPM 2.0. Stefan did TPM 1.x testing but I
> > probably forgot to ask him to try out suspend.
> > 
> > Anyway, the bug is obvious and I'll send you a patch to try out.
> > Thanks a lot for bisecting this!
> > 
> > /Jarkko
> > 
> 
> 
> Hi,
> 
> Any news on this? It seems not to be fixed in -rc4. I'd happily test a
> patch too.
> 
> thanks a lot,
> 
>                             martin

I sent a PR to James last week with the fix. Probably has not landed
yet.

https://lore.kernel.org/linux-integrity/20190329115544.GA27351@linux.intel.com/

/Jarkko
