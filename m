Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37748C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FC92133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfF0Rgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:36:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:4681 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfF0Rgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:36:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 10:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="156307617"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008.jf.intel.com with ESMTP; 27 Jun 2019 10:36:49 -0700
Date:   Thu, 27 Jun 2019 10:36:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     Eiichi Tsukata <devel@etsukata.com>, bp@alien8.de,
        mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: Fix global-out-of-bounds write when setting
 edac_mc_poll_msec
Message-ID: <20190627173649.GA18346@agluck-desk2.amr.corp.intel.com>
References: <20190626054011.30044-1-devel@etsukata.com>
 <ee91dd9d-e9ac-4fee-d7f2-152195995ecb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee91dd9d-e9ac-4fee-d7f2-152195995ecb@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 06:11:18PM +0100, James Morse wrote:
> Hello,
> 
> (CC: +Tony Luck.
>  Original Patch: lore.kernel.org/r/20190626054011.30044-1-devel@etsukata.com )

Heh: My mail agent "helpfully" made that clickable, but as a "mailto:"
URL rather than an https: one!
> 
> On 26/06/2019 06:40, Eiichi Tsukata wrote:
> > Commit 9da21b1509d8 ("EDAC: Poll timeout cannot be zero, p2") assumes
> > edac_mc_poll_msec to be unsigned long, but the type of the variable still
> > remained as int. Setting edac_mc_poll_msec can trigger out-of-bounds
> > write.
> 
> Thanks for catching this!

Ditto & likewise.
> 
> 
> > Fix it by changing the type of edac_mc_poll_msec to unsigned int.
> 
> This means reverting more of 9da21b1509d8, but it also fixes signed/unsigned issues:
> | root@debian-guest:/sys/module/edac_core/parameters# echo 4294967295 >  edac_mc_poll_msec
> | root@debian-guest:/sys/module/edac_core/parameters# cat edac_mc_poll_msec
> | -1
> | root@debian-guest:/sys/module/edac_core/parameters# echo -1 > edac_mc_poll_msec
> | -bash: echo: write error: Invalid argument
> 
> 
> > The reason why this patch adopts unsigned int rather than unsigned long
> > is msecs_to_jiffies() assumes arg to be unsigned int.
> 
> Ah, so the range is limited anyway.
> 
> It looks like it was switched to long to be consistent with edac_mc_workq_setup(), which
> has since been removed in preference to msecs_to_jiffies().
> 
> 
> Reviewed-by: James Morse <james.morse@arm.com>

Applied. (Boris left me in charge of EDAC bits for the
next few weeks). It will show up in the for_5.3 branch
of:
  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
after test builds complete.

-Tony
