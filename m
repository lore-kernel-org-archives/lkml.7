Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CC22173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfH1JhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:37:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:35109 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfH1JhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:37:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 02:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="264592725"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2019 02:37:03 -0700
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8%
 regression
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Feng Tang <feng.tang@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, michel@daenzer.net,
        lkp@01.org, linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <14fdaaed-51c8-b270-b46b-cba7b5c4ba52@suse.de>
 <20190805070200.GA91650@shbuild999.sh.intel.com>
 <c0c3f387-dc93-3146-788c-23258b28a015@intel.com>
 <045a23ab-78f7-f363-4a2e-bf24a7a2f79e@suse.de>
 <37ae41e4-455d-c18d-5c93-7df854abfef9@intel.com>
 <370747ca-4dc9-917b-096c-891dcc2aedf0@suse.de>
 <c6e220fe-230c-265c-f2fc-b0948d1cb898@intel.com>
 <20190812072545.GA63191@shbuild999.sh.intel.com>
 <20190813093616.GA65475@shbuild999.sh.intel.com>
 <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de>
 <20190824051605.GA63850@shbuild999.sh.intel.com>
 <1b897bfe-fd40-3ae3-d867-424d1fc08c44@suse.de>
 <d114b0b6-6b64-406e-6c3f-a8b8d5502413@intel.com>
 <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <90e78ce8-d46a-5154-c324-a05aa1743c98@intel.com>
Date:   Wed, 28 Aug 2019 17:37:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 8/28/19 1:16 AM, Thomas Zimmermann wrote:
> Hi
>
> Am 27.08.19 um 14:33 schrieb Chen, Rong A:
>> Both patches have little impact on the performance from our side.
> Thanks for testing. Too bad they doesn't solve the issue.
>
> There's another patch attached. Could you please tests this as well?
> Thanks a lot!
>
> The patch comes from Daniel Vetter after discussing the problem on IRC.
> The idea of the patch is that the old mgag200 code might display much
> less frames that the generic code, because mgag200 only prints from
> non-atomic context. If we simulate this with the generic code, we should
> see roughly the original performance.
>
>

It's cool, the patch "usecansleep.patch" can fix the issue.

commit:
   f1f8555dfb9 drm/bochs: Use shadow buffer for bochs framebuffer console
   90f479ae51a drm/mgag200: Replace struct mga_fbdev with generic 
framebuffer emulation
   b976b04c2bc only schedule worker from non-atomic context

f1f8555dfb9a70a2  90f479ae51afa45efab97afdde b976b04c2bcf33148d6c7bc1a2  
testcase/testparams/testbox
----------------  -------------------------- --------------------------  
---------------------------
          %stddev      change         %stddev      change %stddev
              \          |                \          | \
      42912             -15%      36517 44093 
vm-scalability/performance-300s-8T-anon-cow-seq-hugetlb/lkp-knm01
      42912             -15%      36517 44093        GEO-MEAN 
vm-scalability.median

Best Regards,
Rong Chen
