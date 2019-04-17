Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE713C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9475221773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfDQBxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:53:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:20624 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfDQBxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 21:53:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 18:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,360,1549958400"; 
   d="scan'208";a="162257123"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2019 18:53:51 -0700
Date:   Tue, 16 Apr 2019 18:53:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190417015351.GA28490@agluck-desk>
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic>
 <20190416221852.GA10781@agluck-desk>
 <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com>
 <20190416232833.GA17372@agluck-desk>
 <CAM_iQpXBJ2eAz4TW_GmOWRLrkyJcO=u-8VSnmv91ZABG-21Agg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXBJ2eAz4TW_GmOWRLrkyJcO=u-8VSnmv91ZABG-21Agg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:47:55PM -0700, Cong Wang wrote:
> 229 static void del_elem(struct ce_array *ca, int idx)
> 230 {
> 231         /* Save us a function call when deleting the last element. */
> 232         if (ca->n - (idx + 1))
> 233                 memmove((void *)&ca->array[idx],
> 234                         (void *)&ca->array[idx + 1],
> 235                         (ca->n - (idx + 1)) * sizeof(u64));
> 236
> 237         ca->n--;
> 238 }
> 
> idx is ca->n and ca->n is MAX_ELEMS-1, then the above if statement
> becomes true, therefore idx+1 is MAX_ELEMS which is just beyond
> the valid range.

Is that really the memmove() where we die?  It looks like
it has a special case for dealing with the last element.

But this:

296         ret = find_elem(ca, pfn, &to);
297         if (ret < 0) {
298                 /*
299                  * Shift range [to-end] to make room for one more element.
300                  */
301                 memmove((void *)&ca->array[to + 1],
302                         (void *)&ca->array[to],
303                         (ca->n - to) * sizeof(u64));
304

looks like it also needs a special case for when "to ==  MAX_ELEMS-1"
(we don't need to memmove).

-Tony
