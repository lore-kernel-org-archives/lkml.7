Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11DCC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D10217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbfDRIVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:21:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:29362 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfDRIVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:21:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 01:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,365,1549958400"; 
   d="scan'208";a="143718973"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.238.129.23]) ([10.238.129.23])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2019 01:20:57 -0700
Subject: Re: [tip:x86/cache] x86/resctrl: Initialize a new resource group with
 default MBA values
To:     Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, x86@kernel.org, mingo@redhat.com, bp@suse.de,
        reinette.chatre@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, linux-tip-commits@vger.kernel.org,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <1555499329-1170-3-git-send-email-xiaochen.shen@intel.com>
 <tip-47820e73f5b3a1fdb8ebd1219191edc96e0c85c1@git.kernel.org>
 <0ab6a79f-d1ae-1c99-1447-722f18405309@intel.com>
 <20190418072845.GA27160@zn.tnic>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <27c69929-58ee-0a96-0953-e7cfa8976e78@intel.com>
Date:   Thu, 18 Apr 2019 16:20:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190418072845.GA27160@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 4/18/2019 15:28, Borislav Petkov wrote:
> On Thu, Apr 18, 2019 at 03:03:35PM +0800, Xiaochen Shen wrote:
>> In my opinion, this newline is unnecessary. Thank you.
> 
> See commit message:
> 
>>    [ bp: Add newlines between code blocks for better readability. ]
> 

I got this commit message and the code changes.
Really appreciated that you helped add several newlines between code
blocks. The newlines really make the readability of the code better.

 >	for_each_alloc_enabled_rdt_resource(r) {
 >		...;
 >   		ret = update_domains(r, rdtgrp->closid);
 >   		if (ret < 0) {
 >   			rdt_last_cmd_puts("Failed to initialize allocations\n");
 >   			return ret;
 >   		}
 > +
 >   	}

But is this newline an exception?
This newline is in the middle of two "}"s - the first "}" is the end of
if condition, and the second "}" is the end of
"for_each_alloc_enabled_rdt_resource" loop. I don't think the newline is
necessary.

> And I didn't add enough. That code is too crammed.
> 
> For example, the new __init_one_rdt_domain() could use some newlines
> too, to separate code blocks for better readability. At least before
> each comment so that one can visually distinguish code groups
> better/faster.
> 
> Here the whole function pasted with newlines added where I think they
> make sense. This way you have visual separation between the code blocks
> and not one big fat clump of code which one has to painstakingly pick
> apart.

Thank you very much for pointing this out and helping make the changes.

Should I submit a separate fixing patch for __init_one_rdt_domain()?
Thank you.

> 
> static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
>                                   u32 closid)
> {
>          struct rdt_resource *r_cdp = NULL;
>          struct rdt_domain *d_cdp = NULL;
>          u32 used_b = 0, unused_b = 0;
>          unsigned long tmp_cbm;
>          enum rdtgrp_mode mode;
>          u32 peer_ctl, *ctrl;
>          int i;
> 
>          rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
>          d->have_new_ctrl = false;
>          d->new_ctrl = r->cache.shareable_bits;
>          used_b = r->cache.shareable_bits;
>          ctrl = d->ctrl_val;
> 
>          for (i = 0; i < closids_supported(); i++, ctrl++) {
>                  if (closid_allocated(i) && i != closid) {
>                          mode = rdtgroup_mode_by_closid(i);
>                          if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
>                                  break;
> 
>                          /*
>                           * If CDP is active include peer domain's
>                           * usage to ensure there is no overlap
>                           * with an exclusive group.
>                           */
>                          if (d_cdp)
>                                  peer_ctl = d_cdp->ctrl_val[i];
>                          else
>                                  peer_ctl = 0;
> 
>                          used_b |= *ctrl | peer_ctl;
>                          if (mode == RDT_MODE_SHAREABLE)
>                                  d->new_ctrl |= *ctrl | peer_ctl;
>                  }
>          }
> 
>          if (d->plr && d->plr->cbm > 0)
>                  used_b |= d->plr->cbm;
> 
>          unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
>          unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
>          d->new_ctrl |= unused_b;
> 
>          /*
>           * Force the initial CBM to be valid, user can
>           * modify the CBM based on system availability.
>           */
>          cbm_ensure_valid(&d->new_ctrl, r);
> 
>          /*
>           * Assign the u32 CBM to an unsigned long to ensure that
>           * bitmap_weight() does not access out-of-bound memory.
>           */
>          tmp_cbm = d->new_ctrl;
> 
>          if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
>                  rdt_last_cmd_printf("No space on %s:%d\n", r->name, d->id);
>                  return -ENOSPC;
>          }
>          d->have_new_ctrl = true;
> 
>          return 0;
> }
> 

-- 
Best regards,
Xiaochen
