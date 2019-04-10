Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BC82083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfDJL3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:29:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:38838 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfDJL3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:29:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 04:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="335491297"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2019 04:29:28 -0700
Date:   Wed, 10 Apr 2019 14:29:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@microsoft.com, bryankel@microsoft.com,
        thiruan@microsoft.com, suredd@microsoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ftpm: firmware TPM running in TEE
Message-ID: <20190410112927.GA6586@linux.intel.com>
References: <20190402193316.15144-1-sashal@kernel.org>
 <20190402193316.15144-2-sashal@kernel.org>
 <20190403181827.GB17006@linux.intel.com>
 <20190403182728.GA17451@linux.intel.com>
 <20190406153047.GF2935@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406153047.GF2935@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 11:30:47AM -0400, Sasha Levin wrote:
> On Wed, Apr 03, 2019 at 09:27:28PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Apr 03, 2019 at 09:18:27PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Apr 02, 2019 at 03:33:16PM -0400, Sasha Levin wrote:
> > > > This patch adds support for a software-only implementation of a TPM
> > > > running in TEE.
> > > >
> > > > There is extensive documentation of the design here:
> > > > https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/ .
> > > >
> > > > As well as reference code for the firmware available here:
> > > > https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM
> > > >
> > > > Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > 
> > > What is the context anyway? I mean tpm_crb already supports fTPM running
> > > in TZ.
> > 
> > Might take 2-3 weeks before I have time to go through ftpm1.pdf with
> > full concentration. I did search through the PDF for CRB and found
> > zero hits.
> 
> The fTPM as described in that paper and implemented in practice does not
> use the CRB interface, thus we can't use tpm_crb to interface with the
> firmware TPM.

Obviously not but what is the reason of not implementing CRB but instead
making yet another interface? I mean CRB supports SMC call.

For me this is taking steps back as to the early days when there was
proprietary intefaces to TPM before TCG came along and stardized.

I'm sure that the TPM implementation itself could be reworked to
inteface using CRB. It would also be good for ARM as a platform as now
this new made up interface causes unwanted divergence. I thought that
throwing ad hoc intefaces everywhere is something that ARM Linux
community tries to reduce, not increase.

/Jarkko
