Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4132CC10F0A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197BE21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfC2Ank (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:43:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:11022 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfC2Ank (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:43:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 17:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="331710051"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2019 17:43:38 -0700
Date:   Thu, 28 Mar 2019 09:42:31 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 07/11] mm/hmm: add default fault flags to avoid the
 need to pre-fill pfns arrays.
Message-ID: <20190328164231.GF31324@iweiny-DESK2.sc.intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-8-jglisse@redhat.com>
 <2f790427-ea87-b41e-b386-820ccdb7dd38@nvidia.com>
 <20190328221203.GF13560@redhat.com>
 <555ad864-d1f9-f513-9666-0d3d05dbb85d@nvidia.com>
 <20190328223153.GG13560@redhat.com>
 <768f56f5-8019-06df-2c5a-b4187deaac59@nvidia.com>
 <20190328232125.GJ13560@redhat.com>
 <d2008b88-962f-b7b4-8351-9e1df95ea2cc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2008b88-962f-b7b4-8351-9e1df95ea2cc@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:28:47PM -0700, John Hubbard wrote:
> On 3/28/19 4:21 PM, Jerome Glisse wrote:
> > On Thu, Mar 28, 2019 at 03:40:42PM -0700, John Hubbard wrote:
> >> On 3/28/19 3:31 PM, Jerome Glisse wrote:
> >>> On Thu, Mar 28, 2019 at 03:19:06PM -0700, John Hubbard wrote:
> >>>> On 3/28/19 3:12 PM, Jerome Glisse wrote:
> >>>>> On Thu, Mar 28, 2019 at 02:59:50PM -0700, John Hubbard wrote:
> >>>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> >>>>>>> From: Jérôme Glisse <jglisse@redhat.com>
> [...]
> >> Hi Jerome,
> >>
> >> I think you're talking about flags, but I'm talking about the mask. The 
> >> above link doesn't appear to use the pfn_flags_mask, and the default_flags 
> >> that it uses are still in the same lower 3 bits:
> >>
> >> +static uint64_t odp_hmm_flags[HMM_PFN_FLAG_MAX] = {
> >> +	ODP_READ_BIT,	/* HMM_PFN_VALID */
> >> +	ODP_WRITE_BIT,	/* HMM_PFN_WRITE */
> >> +	ODP_DEVICE_BIT,	/* HMM_PFN_DEVICE_PRIVATE */
> >> +};
> >>
> >> So I still don't see why we need the flexibility of a full 0xFFFFFFFFFFFFFFFF
> >> mask, that is *also* runtime changeable. 
> > 
> > So the pfn array is using a device driver specific format and we have
> > no idea nor do we need to know where the valid, write, ... bit are in
> > that format. Those bits can be in the top 60 bits like 63, 62, 61, ...
> > we do not care. They are device with bit at the top and for those you
> > need a mask that allows you to mask out those bits or not depending on
> > what the user want to do.
> > 
> > The mask here is against an _unknown_ (from HMM POV) format. So we can
> > not presume where the bits will be and thus we can not presume what a
> > proper mask is.
> > 
> > So that's why a full unsigned long mask is use here.
> > 
> > Maybe an example will help let say the device flag are:
> >     VALID (1 << 63)
> >     WRITE (1 << 62)
> > 
> > Now let say that device wants to fault with at least read a range
> > it does set:
> >     range->default_flags = (1 << 63)
> >     range->pfn_flags_mask = 0;
> > 
> > This will fill fault all page in the range with at least read
> > permission.
> > 
> > Now let say it wants to do the same except for one page in the range
> > for which its want to have write. Now driver set:
> >     range->default_flags = (1 << 63);
> >     range->pfn_flags_mask = (1 << 62);
> >     range->pfns[index_of_write] = (1 << 62);
> > 
> > With this HMM will fault in all page with at least read (ie valid)
> > and for the address: range->start + index_of_write << PAGE_SHIFT it
> > will fault with write permission ie if the CPU pte does not have
> > write permission set then handle_mm_fault() will be call asking for
> > write permission.
> > 
> > 
> > Note that in the above HMM will populate the pfns array with write
> > permission for any entry that have write permission within the CPU
> > pte ie the default_flags and pfn_flags_mask is only the minimun
> > requirement but HMM always returns all the flag that are set in the
> > CPU pte.
> > 
> > 
> > Now let say you are an "old" driver like nouveau upstream, then it
> > means that you are setting each individual entry within range->pfns
> > with the exact flags you want for each address hence here what you
> > want is:
> >     range->default_flags = 0;
> >     range->pfn_flags_mask = -1UL;
> > 
> > So that what we do is (for each entry):
> >     (range->pfns[index] & range->pfn_flags_mask) | range->default_flags
> > and we end up with the flags that were set by the driver for each of
> > the individual range->pfns entries.
> > 
> > 
> > Does this help ?
> > 
> 
> Yes, the key point for me was that this is an entirely device driver specific
> format. OK. But then we have HMM setting it. So a comment to the effect that
> this is device-specific might be nice, but I'll leave that up to you whether
> it is useful.

Indeed I did not realize there is an hmm "pfn" until I saw this function:

/*
 * hmm_pfn_from_pfn() - create a valid HMM pfn value from pfn
 * @range: range use to encode HMM pfn value
 * @pfn: pfn value for which to create the HMM pfn
 * Returns: valid HMM pfn for the pfn
 */
static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
                                        unsigned long pfn)

So should this patch contain some sort of helper like this... maybe?

I'm assuming the "hmm_pfn" being returned above is the device pfn being
discussed here?

I'm also thinking calling it pfn is confusing.  I'm not advocating a new type
but calling the "device pfn's" "hmm_pfn" or "device_pfn" seems like it would
have shortened the discussion here.

Ira

> 
> Either way, you can add:
> 
> 	Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
