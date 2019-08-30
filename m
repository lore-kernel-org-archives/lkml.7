Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C466C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E058E2342F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfH3RAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:00:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:43516 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfH3RAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:00:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 10:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="356846778"
Received: from floriank-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.77])
  by orsmga005.jf.intel.com with ESMTP; 30 Aug 2019 10:00:04 -0700
Date:   Fri, 30 Aug 2019 20:00:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Fix interrupt probing
Message-ID: <20190830170001.ii3r2sugwl2iogjt@linux.intel.com>
References: <20190820122517.2086223-1-stefanb@linux.vnet.ibm.com>
 <20190827131400.qchcwa2act24c47b@linux.intel.com>
 <20190827151915.hb4xwr2vik2i5ryb@linux.intel.com>
 <797ff54e-dceb-21d2-dd74-e5244f9c6dfd@linux.ibm.com>
 <20190829132021.6vfc535ecb62jokf@linux.intel.com>
 <20190829161057.22l72j55jy3dyib7@linux.intel.com>
 <039601c6-e22a-d113-0eb2-ee2a206f5b73@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039601c6-e22a-d113-0eb2-ee2a206f5b73@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 08:11:27PM -0400, Stefan Berger wrote:
> On 8/29/19 12:10 PM, Jarkko Sakkinen wrote:
> > On Thu, Aug 29, 2019 at 04:20:21PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Aug 27, 2019 at 03:34:36PM -0400, Stefan Berger wrote:
> > > > On 8/27/19 11:19 AM, Jarkko Sakkinen wrote:
> > > > > On Tue, Aug 27, 2019 at 04:14:00PM +0300, Jarkko Sakkinen wrote:
> > > > > > On Tue, Aug 20, 2019 at 08:25:17AM -0400, Stefan Berger wrote:
> > > > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > > 
> > > > > > > The interrupt probing of the TPM TIS was broken since we are trying to
> > > > > > > run it without an active locality and without the TPM_CHIP_FLAG_IRQ set.
> > > > > > > 
> > > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > Need these:
> > > > > > 
> > > > > > Cc: linux-stable@vger.kernel.org
> > > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > > > > > 
> > > > > > Thank you. I'll apply this to my tree.
> > > > > > 
> > > > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > The commit went in the following form:
> > > > > 
> > > > > http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/9b558deab2c5d7dc23d5f7a4064892ede482ad32
> > > > I saw you dropped the stetting of the IRQ flag - I needed it, otherwise it
> > > > wouldn't execute certain code paths.
> > > I explained why I removed that part. There was no any reasoning for
> > > it. Also, it cannot be in the same commit if it fixes a diffent
> > > issue.
> > AFAIK they go with different fixes-tags.
> 
> I sent a separate patch for this. It looks like this bug goes back to when
> the TPM_CHIP_FLAG_IRQ was introduced in March 2019?!

Thank you!

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
