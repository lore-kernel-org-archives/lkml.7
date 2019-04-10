Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3686C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E052077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfDJRi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:38:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:52864 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbfDJRi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:38:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 10:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="141635121"
Received: from jsakkine-mobl.ger.corp.intel.com (HELO localhost) ([10.251.87.38])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2019 10:38:20 -0700
Date:   Wed, 10 Apr 2019 20:38:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@microsoft.com, bryankel@microsoft.com,
        thiruan@microsoft.com, suredd@microsoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ftpm: firmware TPM running in TEE
Message-ID: <20190410173318.GA9052@linux.intel.com>
References: <20190402193316.15144-1-sashal@kernel.org>
 <20190402193316.15144-2-sashal@kernel.org>
 <20190403181827.GB17006@linux.intel.com>
 <20190403182728.GA17451@linux.intel.com>
 <20190406153047.GF2935@sasha-vm>
 <20190410112927.GA6586@linux.intel.com>
 <20190410160432.GB11568@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410160432.GB11568@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:04:32PM -0400, Sasha Levin wrote:
> On Wed, Apr 10, 2019 at 02:29:27PM +0300, Jarkko Sakkinen wrote:
> > On Sat, Apr 06, 2019 at 11:30:47AM -0400, Sasha Levin wrote:
> > > On Wed, Apr 03, 2019 at 09:27:28PM +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Apr 03, 2019 at 09:18:27PM +0300, Jarkko Sakkinen wrote:
> > > > > On Tue, Apr 02, 2019 at 03:33:16PM -0400, Sasha Levin wrote:
> > > > > > This patch adds support for a software-only implementation of a TPM
> > > > > > running in TEE.
> > > > > >
> > > > > > There is extensive documentation of the design here:
> > > > > > https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/ .
> > > > > >
> > > > > > As well as reference code for the firmware available here:
> > > > > > https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM
> > > > > >
> > > > > > Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> > > > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > >
> > > > > What is the context anyway? I mean tpm_crb already supports fTPM running
> > > > > in TZ.
> > > >
> > > > Might take 2-3 weeks before I have time to go through ftpm1.pdf with
> > > > full concentration. I did search through the PDF for CRB and found
> > > > zero hits.
> > > 
> > > The fTPM as described in that paper and implemented in practice does not
> > > use the CRB interface, thus we can't use tpm_crb to interface with the
> > > firmware TPM.
> > 
> > Obviously not but what is the reason of not implementing CRB but instead
> > making yet another interface? I mean CRB supports SMC call.
> > 
> > For me this is taking steps back as to the early days when there was
> > proprietary intefaces to TPM before TCG came along and stardized.
> > 
> > I'm sure that the TPM implementation itself could be reworked to
> > inteface using CRB. It would also be good for ARM as a platform as now
> > this new made up interface causes unwanted divergence. I thought that
> > throwing ad hoc intefaces everywhere is something that ARM Linux
> > community tries to reduce, not increase.
> 
> I'm not sure what the original reasons were for not using the CRB
> interface. Note that the paper is from a few years ago, and
> implementations of this fTPM existed before the paper, so it's very
> possible that it just predates CRB.
> 
> Either way, there is existing hardware that runs this TPM and I'm trying
> to get it out of Microsoft's tree and get it upstream. There's not much
> I could do about existing hardware at this point.

OK, the 2nd paragraph kind of is enough reason to pull it. Thanks for
elaborating this. Just wanted to get a clearer picture where this sits
in the universe. I'll do detailed review as soon as I have time.

I don't need to have the hardware as long as *someone* could give
tested-by for this.

/Jarkko
