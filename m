Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876052075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfCUNls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:41:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:24000 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbfCUNlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:41:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 06:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="153821280"
Received: from dilu-mobl2.ccr.corp.intel.com (HELO localhost) ([10.249.254.184])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2019 06:41:41 -0700
Date:   Thu, 21 Mar 2019 15:41:40 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Paul Zimmerman <pauldzim@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression in suspend-to-ram (TPM related) with 5.1-rc1
 (BISECTED)
Message-ID: <20190321134140.GA4603@linux.intel.com>
References: <CADBGO7_WUoA53gM8EDFy6Q36SDEZPU9V=OUBA0QM20FOko51Rg@mail.gmail.com>
 <CADBGO7-UkQMxSPdSX9bGVPxSRROj75FA16FuXeFrVmcKVQ_Qdg@mail.gmail.com>
 <CADBGO7_XnbXiWHB=O1B_+b+CUA9g-bYJHN37VJ2SsxXMNHcPOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBGO7_XnbXiWHB=O1B_+b+CUA9g-bYJHN37VJ2SsxXMNHcPOQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:03:37PM -0700, Paul Zimmerman wrote:
> So I bisected this down to:
> 
> # first bad commit: [a3fbfae82b4cb3ff9928e29f34c64d0507cad874] tpm:
> take TPM chip power gating out of tpm_transmit()
> 
> but this doesn't revert cleanly on Linus' HEAD. Anyone have an idea what
> could be wrong here?

Sorry I've been in flu for the early week. I spotted the bug
immediately.  When I did these patches I did not have TPM 1.x at my
hand. I used fTPM 2.0 and dTPM 2.0. Stefan did TPM 1.x testing but I
probably forgot to ask him to try out suspend.

Anyway, the bug is obvious and I'll send you a patch to try out.
Thanks a lot for bisecting this!

/Jarkko
