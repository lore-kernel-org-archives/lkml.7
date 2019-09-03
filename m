Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF573C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BCF23431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfICNdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:33:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:41965 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICNdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:33:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 06:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="198770919"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2019 06:33:20 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Sep 2019 16:33:19 +0300
Date:   Tue, 3 Sep 2019 16:33:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        YehezkelShB@gmail.com
Subject: Re: Thunderbolt DP oddity on v5.2.9 on iMac 12,2
Message-ID: <20190903133319.GG2691@lahna.fi.intel.com>
References: <20190828073302.GO3177@lahna.fi.intel.com>
 <7c9474d2-d948-4d1d-6f7b-94335b8b1f15@fnarfbargle.com>
 <20190828102342.GT3177@lahna.fi.intel.com>
 <e3a8fa91-2cfd-76a4-641c-610c32122833@fnarfbargle.com>
 <20190828131943.GZ3177@lahna.fi.intel.com>
 <be32b369-b013-cca8-5475-9b56acaa3e18@fnarfbargle.com>
 <20190903101325.GC2691@lahna.fi.intel.com>
 <71e34f9e-8e0d-f5f2-bc55-006aeb8a383b@fnarfbargle.com>
 <20190903115527.GE2691@lahna.fi.intel.com>
 <30fe86c0-e4f9-e852-a4d8-7b8263b373ef@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30fe86c0-e4f9-e852-a4d8-7b8263b373ef@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 08:54:02PM +0800, Brad Campbell wrote:
> On 3/9/19 7:55 pm, Mika Westerberg wrote:
> > On Tue, Sep 03, 2019 at 07:11:32PM +0800, Brad Campbell wrote:
> > 
> > I think the problem is that for some reason, probably because this is
> > first generation hardware with all the bugs included, you cannot read
> > the second dword from DP adapter path config space (you can write it
> > though).
> > 
> > I've updated the patch so that it reads only the first dword when it
> > discovers paths and also when it disables them. Can you try it out and
> > see if it makes a difference? This should also get rid of the warnings
> > you get.
> > 
> 
> It would seem so. Now I get 3 heads on a cold or warm boot and no warnings
> in the log, so it looks like that did the job. I've attached the dmesg from
> the last cold boot for reference.

Great, thanks for checking. I will create a proper patch and submit
upstream hopefully later this week or early next.

> I forgot to mention I did try the chained monitors over the weekend, but
> that resulted in some carnage (corrupted displays and some form of hard lock
> when starting X). I've not had a chance to get netconsole configured up to
> catch any wreckage when it explodes as it didn't leave anything on disk.
> 
> I will do that in the next couple of days just for completeness.

Yeah, it would be interesting to see where it blows up. From graphics
perspective the two cases should not make any difference.
