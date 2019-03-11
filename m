Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987722064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfCKUmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:42:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:34403 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKUmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:42:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="124576170"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2019 13:42:18 -0700
Date:   Mon, 11 Mar 2019 13:42:17 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86, mce: Fix machine_check_poll() tests for which
 errors to log
Message-ID: <20190311204217.GA1810@agluck-desk>
References: <20190311185118.32667-1-tony.luck@intel.com>
 <SN6PR12MB26399CBAEFB6C500D456255DF8480@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26399CBAEFB6C500D456255DF8480@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 08:25:53PM +0000, Ghannam, Yazen wrote:
> > +		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
> > +			goto log_it;
> > +
> 
> Can you please include a vendor check with this? MCi_STATUS[56] is
> not defined the same way on AMD systems.

Original code also looked at MCi_STATUS[56] without a vendor
check:

> > -               (m.status & (mca_cfg.ser ? MCI_STATUS_S : MCI_STATUS_UC)))

Was this OK because you don't set mca_cfg.ser?

If so, my new code will also skip out before getting to this test. But
should probably have a better comment. Something like:


		/*
		 * Newer Intel systems that support software error
		 * recovery need to make some extra checks. Other
		 * CPUs should skip over uncorrected errors, but log
		 * everything else
		 */
		if (!mca_cfg.ser) {
			if (m.status & MCI_STATUS_UC)
				continue;
			goto log_it;
		}

-Tony
