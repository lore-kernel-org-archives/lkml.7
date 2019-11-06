Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A96C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D34A217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfKFLF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:05:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:55516 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfKFLF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:05:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 03:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="212749289"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.132.132]) ([10.249.132.132])
  by fmsmga001.fm.intel.com with ESMTP; 06 Nov 2019 03:05:56 -0800
Subject: Re: [PATCH v2 0/4] misc fixes on halt-poll code both KVM and guest
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, joao.m.martins@oracle.com,
        mtosatti@redhat.com
References: <1573031332-2121-1-git-send-email-zhenzhong.duan@oracle.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <32fce2c2-9056-b4ab-1bfb-3f4b69f30da6@intel.com>
Date:   Wed, 6 Nov 2019 12:05:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573031332-2121-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/2019 10:08 AM, Zhenzhong Duan wrote:
> This patchset tries to fix below issues:
>
> 1. Admin could set halt_poll_ns to 0 at runtime to disable poll and kernel
> behave just like the generic halt driver. Then If guest_halt_poll_grow_start
> is set to 0 and guest_halt_poll_ns set to nonzero later, cpu_halt_poll_us will
> never grow beyond 0. The first two patches fix this issue from both kvm and
> guest side.
>
> 2. guest_halt_poll_grow_start and guest_halt_poll_ns could be adjusted at
> runtime by admin, this could make a window where cpu_halt_poll_us jump out
> of the boundary. the window could be long in some cases(e.g. guest_halt_poll_grow_start
> is bumped and cpu_halt_poll_us is shrinking) The last two patches fix this
> issue from both kvm and guest side.
>
> 3. The 4th patch also simplifies branch check code.
>
> v2:
> Rewrite the patches and drop unnecessory changes
>
> Zhenzhong Duan (4):
>    cpuidle-haltpoll: ensure grow start value is nonzero
>    KVM: ensure grow start value is nonzero
>    cpuidle-haltpoll: ensure cpu_halt_poll_us in right scope
>    KVM: ensure vCPU halt_poll_us in right scope
>
>   drivers/cpuidle/governors/haltpoll.c | 50 ++++++++++++++++++++++++-----------
>   virt/kvm/kvm_main.c                  | 51 ++++++++++++++++++++++++------------
>   2 files changed, 68 insertions(+), 33 deletions(-)
>
Please resend the series with CCs to linux-pm@vger.kernel.org, thanks!


