Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087462077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfDVRoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:44:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:37642 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfDVRoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:44:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 10:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="339757942"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2019 10:44:15 -0700
Date:   Mon, 22 Apr 2019 10:44:15 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190422174415.GA21890@agluck-desk>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <20190419000745.GA12291@agluck-desk>
 <20190419002911.GB559@zn.tnic>
 <20190419150400.GA12738@agluck-desk>
 <20190420094120.GB29704@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E90A404@ORSMSX104.amr.corp.intel.com>
 <20190422171532.GH21457@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422171532.GH21457@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 07:15:32PM +0200, Borislav Petkov wrote:
> On Mon, Apr 22, 2019 at 03:59:16PM +0000, Luck, Tony wrote:
> > > Err, this all sounds to me like the storm detection code should
> > > *automatically* disable the CEC in such cases, I'd say.
> > 
> > Sounds good. But we should distinguish storms that have many different
> > addresses from storms that just ping a few addresses.  CEC will see counts
> > hit the threshold in the latter case, but it might not be able to take the pages
> > offline (because they are locked, or in-use by kernel).
> > 
> > So I think the change might be to the return value from NOTIFY_STOP to NOTIFY_DONE
> > ... but only if we are in the middle of a storm AND the CEC array is full.
> 
> Well, regardless of this specific use case, isn't that a generic enough
> action that we should do always? I mean, the aspect of falling back to
> logging to external agent.

Yes. Automating this would be a very good idea.

> However, currently we don't signal that the CEC is full - we simply
> remove the LRU element in cec_add_elem() before we insert the new one.
> 
> We can either return a specific retval to say, CEC is full and we had to
> delete an elem or we can add a cec_is_full() accessor...

A lot depends on why the CEC is full, and which entry is being
deleted to make room.

In the case of many errors at different addresses we are deleting
the entry with the lowest count. But all of the entries have low
counts because we are just thrashing the array with many different
addresses. In this situation a warning would be helpful.

But in the case where the system has been up for months and
we very slowly accumlated logs of bit flips. The periodic
spring cleaning means they all have generation "00", but
we never actually drop an old entry because of age. In this
case dropping one entry to make space for a new one is fine
and doesn't need any action.

Perhaps we can distinguish the cases by the generation? If
we are dropping an entry that was recently added, then it
will still have generation "11" (or at least not "00").
Use that to trigger an action?

-Tony
