Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6619CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D78720652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfDSS0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:26:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:9990 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfDSS0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:26:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 08:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,370,1549958400"; 
   d="scan'208";a="163063881"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga002.fm.intel.com with ESMTP; 19 Apr 2019 08:04:01 -0700
Date:   Fri, 19 Apr 2019 08:04:01 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190419150400.GA12738@agluck-desk>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <20190419000745.GA12291@agluck-desk>
 <20190419002911.GB559@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419002911.GB559@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 02:29:11AM +0200, Borislav Petkov wrote:
> On Thu, Apr 18, 2019 at 05:07:45PM -0700, Luck, Tony wrote:
> > On Fri, Apr 19, 2019 at 01:29:10AM +0200, Borislav Petkov wrote:
> > > Which reminds me, Tony, I think all those debugging files "pfn"
> > > and "array" and the one you add now, should all be under a
> > > CONFIG_RAS_CEC_DEBUG which is default off and used only for development.
> > > Mind adding that too pls?
> > 
> > Patch below, on top of previous patch.  Note that I didn't move "enable"
> > into the RAS_CEC_DEBUG code. I think it has some value even on
> > production systems.
> 
> And that value is? Usecase?

Suppose that an entire device on a DIMM fails. Systems with the
right type of DIMM (X4) and a memory controller that implements
https://en.wikipedia.org/wiki/Chipkill (Intel calls this "SDDC")
can continue running ... but there will be a lot of corrected
errors from a vast range of different pages.

After fifteen or so errors Linux will trigger storm mode and
the user will see:

 mce: CMCI storm detected: switching to poll mode

on the console.  As we poll we'll find errors and hand them
to CEC. But because the errors come from far more than 512
distinct pages CEC will never manage to get a count above 1
before it drops the entry to make space for a new log.

So the only indication that the user sees that something is
wrong is that storm warning (and the lack of a following
"storm subsided" message) tells them that errors are still
happening.

This amounts to a serviceability failure ... lack of useful
diagnostics about a problem.

Now there isn't really anything better that CEC can do in
this situation. It won't help to have a bigger array. Taking
pages offline wouldn't solve the problem (though if that
did happen at least it would break the silence).

Same situation for other DRAM failure modes that affect a
wide range of pages (rank, bank, perhaps row ... though all
the errors from a single row failure might fit in the CEC array).

Allowing the user to bypass CEC (without a reboot ... cloud folks
hate to reboot their systems) would allow the sysadmin to see
what is happening (either via /dev/mcelog, or via EDAC driver).

-Tony
