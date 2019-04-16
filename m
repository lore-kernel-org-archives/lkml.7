Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AD6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EDB205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfDPX2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:28:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:8782 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfDPX2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:28:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 16:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,359,1549958400"; 
   d="scan'208";a="143523469"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga007.fm.intel.com with ESMTP; 16 Apr 2019 16:28:34 -0700
Date:   Tue, 16 Apr 2019 16:28:33 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190416232833.GA17372@agluck-desk>
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic>
 <20190416221852.GA10781@agluck-desk>
 <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:18:57PM -0700, Cong Wang wrote:
> > The problem case occurs when we've seen enough distinct
> > errors that we have filled every entry, then we try to
> > look up a pfn that is larger that any seen before.
> >
> > The loop:
> >
> >         while (min < max) {
> >                 ...
> >         }
> >
> > will terminate with "min" set to MAX_ELEMS. Then we
> > execute:
> >
> >         this_pfn = PFN(ca->array[min]);
> >
> > which references beyond the end of the space allocated
> > for ca->array.
> 
> Exactly.

Hmmm. But can we ever really have this happen?  The call
sequence to get here looks like:


        mutex_lock(&ce_mutex);

        if (ca->n == MAX_ELEMS)
                WARN_ON(!del_lru_elem_unlocked(ca));

        ret = find_elem(ca, pfn, &to);

I.e. if the array was all the way full, we delete one element
before calling find_elem().  So when we get here:

static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
{
        u64 this_pfn;
        int min = 0, max = ca->n;

The biggest value "max" can have is MAX_ELEMS-1


-Tony
