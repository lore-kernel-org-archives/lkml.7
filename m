Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C2CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BAD2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1A4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:56:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:45889 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfH1A4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:56:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 17:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="197430994"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2019 17:56:30 -0700
Date:   Tue, 27 Aug 2019 17:56:30 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        kanth.ghatraju@oracle.com, Jon.Grimm@amd.com,
        Thomas.Lendacky@amd.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190828005630.GB47494@otc-nc-03>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085300.GB16813@zn.tnic>
 <20190826202339.GA49895@otc-nc-03>
 <20190827122501.GD29752@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827122501.GD29752@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:25:01PM +0200, Borislav Petkov wrote:
> On Mon, Aug 26, 2019 at 01:23:39PM -0700, Raj, Ashok wrote:
> > > Cloud customers have expressed discontent as services disappear for a
> > > prolonged time. The restriction is that only one core goes through the
> > s/one core/one thread of a core/
> > 
> > > update while other cores are quiesced.
> > s/cores/other thread(s) of the core
> 
> Changed it to:
> 
> "Cloud customers have expressed discontent as services disappear for
> a prolonged time. The restriction is that only one core (or only one
> thread of a core in the case of an SMT system) goes through the update
> while other cores (or respectively, SMT threads) are quiesced."

the last line seems to imply that only one core can be updated at a time.
But the only requirement is on a per-core basis, the HT thread sharing
a core must be quiesced while the microcode update is performed. 

for ex. if you have 2 cores, you can update microcode on both cores
at the same time. 

C0T0, C0T1 - If you are updating on C0T0, C0T1 must be waiting for the update
to complete

But You can initiate the microcode update on C1T0 simultaneously. 


> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
