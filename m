Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF2A213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfCZISv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:18:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:6215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfCZISv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:18:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 01:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="130215663"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.108])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2019 01:18:48 -0700
Date:   Tue, 26 Mar 2019 16:15:29 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     x86@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        kys@microsoft.com, haiyangz@microsoft.com
Subject: Re: [PATCH 15/17] x86/hyperv: Make hv_vcpu_is_preempted visible
Message-ID: <20190326081529.GF5182@yi.y.sun>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-16-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321220009.29334-16-andi@firstfloor.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-03-21 15:00:07, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> This function is referrenced from assembler, so need to be marked
> visible for LTO.
> 
> Cc: yi.y.sun@linux.intel.com
> Cc: kys@microsoft.com
> Cc: haiyangz@microsoft.com
> Fixes: 3a025de64bf8 x86/hyperv: Enable PV qspinlock for Hyper-V
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/hyperv/hv_spinlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> index a861b0456b1a..07f21a06392f 100644
> --- a/arch/x86/hyperv/hv_spinlock.c
> +++ b/arch/x86/hyperv/hv_spinlock.c
> @@ -56,7 +56,7 @@ static void hv_qlock_wait(u8 *byte, u8 val)
>  /*
>   * Hyper-V does not support this so far.
>   */
> -bool hv_vcpu_is_preempted(int vcpu)
> +__visible bool hv_vcpu_is_preempted(int vcpu)
>  {
>  	return false;
>  }

Reviewed-by: Yi Sun <yi.y.sun@linux.intel.com>

> -- 
> 2.20.1
