Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58690C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3432C20890
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfIPJGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:06:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:12930 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfIPJGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:06:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 02:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="361466380"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga005.jf.intel.com with ESMTP; 16 Sep 2019 02:06:21 -0700
Date:   Mon, 16 Sep 2019 17:06:52 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, michel@daenzer.net,
        lkp@01.org, linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8%
 regression
Message-ID: <20190916090652.GK5541@shbuild999.sh.intel.com>
References: <20190813093616.GA65475@shbuild999.sh.intel.com>
 <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de>
 <20190824051605.GA63850@shbuild999.sh.intel.com>
 <1b897bfe-fd40-3ae3-d867-424d1fc08c44@suse.de>
 <d114b0b6-6b64-406e-6c3f-a8b8d5502413@intel.com>
 <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de>
 <90e78ce8-d46a-5154-c324-a05aa1743c98@intel.com>
 <2e1b4d65-d477-f571-845d-fa0a670859af@suse.de>
 <20190904062716.GC5541@shbuild999.sh.intel.com>
 <6806e973-4cf7-bcac-54b4-4fac21698ece@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6806e973-4cf7-bcac-54b4-4fac21698ece@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Sep 09, 2019 at 04:12:37PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 04.09.19 um 08:27 schrieb Feng Tang:
> > Hi Thomas,
> > 
> > On Wed, Aug 28, 2019 at 12:51:40PM +0200, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 28.08.19 um 11:37 schrieb Rong Chen:
> >>> Hi Thomas,
> >>>
> >>> On 8/28/19 1:16 AM, Thomas Zimmermann wrote:
> >>>> Hi
> >>>>
> >>>> Am 27.08.19 um 14:33 schrieb Chen, Rong A:
> >>>>> Both patches have little impact on the performance from our side.
> >>>> Thanks for testing. Too bad they doesn't solve the issue.
> >>>>
> >>>> There's another patch attached. Could you please tests this as well?
> >>>> Thanks a lot!
> >>>>
> >>>> The patch comes from Daniel Vetter after discussing the problem on IRC.
> >>>> The idea of the patch is that the old mgag200 code might display much
> >>>> less frames that the generic code, because mgag200 only prints from
> >>>> non-atomic context. If we simulate this with the generic code, we should
> >>>> see roughly the original performance.
> >>>>
> >>>>
> >>>
> >>> It's cool, the patch "usecansleep.patch" can fix the issue.
> >>
> >> Thank you for testing. But don't get too excited, because the patch
> >> simulates a bug that was present in the original mgag200 code. A
> >> significant number of frames are simply skipped. That is apparently the
> >> reason why it's faster.
> > 
> > Thanks for the detailed info, so the original code skips time-consuming
> > work inside atomic context on purpose. Is there any space to optmise it?
> > If 2 scheduled update worker are handled at almost same time, can one be
> > skipped?
> 
> We discussed ideas on IRC and decided that screen updates could be
> synchronized with vblank intervals. This may give some rate limiting to
> the output.
> 
> If you like, you could try the patch set at [1]. It adds the respective
> code to console and mgag200.

I just tried the 2 patches, no obvious change (comparing to the
18.8% regression), both in overall benchmark and micro-profiling.

90f479ae51afa45e 04a0983095feaee022cdd65e3e4 
---------------- --------------------------- 
     37236 ±  3%      +2.5%      38167 ±  3%  vm-scalability.median
      0.15 ± 24%     -25.1%       0.11 ± 23%  vm-scalability.median_stddev
      0.15 ± 23%     -25.1%       0.11 ± 22%  vm-scalability.stddev
  12767318 ±  4%      +2.5%   13089177 ±  3%  vm-scalability.throughput
 
Thanks,
Feng

> 
> Best regards
> Thomas
> 
> [1]
> https://lists.freedesktop.org/archives/dri-devel/2019-September/234850.html
> 
> > 
> > Thanks,
> > Feng
> > 
> >>
> >> Best regards
> >> Thomas
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
> 



