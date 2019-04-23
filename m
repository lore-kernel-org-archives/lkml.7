Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD5D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfDWN7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:59:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:7591 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfDWN7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:59:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 06:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="153194896"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga002.jf.intel.com with ESMTP; 23 Apr 2019 06:59:34 -0700
Date:   Tue, 23 Apr 2019 06:59:34 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH v2] x86: kvm: hyper-v: deal with buggy TLB flush requests
 from WS2012
Message-ID: <20190423135934.GA10720@linux.intel.com>
References: <20190423131537.9298-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423131537.9298-1-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:15:37PM +0200, Vitaly Kuznetsov wrote:
> It was reported that with some special Multi Processor Group configuration,
> e.g:
>  bcdedit.exe /set groupsize 1
>  bcdedit.exe /set maxgroup on
>  bcdedit.exe /set groupaware on
> for a 16-vCPU guest WS2012 shows BSOD on boot when PV TLB flush mechanism
> is in use.
> 
> Tracing kvm_hv_flush_tlb immediately reveals the issue:
> 
>  kvm_hv_flush_tlb: processor_mask 0x0 address_space 0x0 flags 0x2
> 
> The only flag set in this request is HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES,
> however, processor_mask is 0x0 and no HV_FLUSH_ALL_PROCESSORS is specified.
> We don't flush anything and apparently it's not what Windows expects.
> 
> TLFS doesn't say anything about such requests and newer Windows versions
> seem to be unaffected. This all feels like a WS2012 bug, which is, however,
> easy to workaround in KVM: let's flush everything when we see an empty
> flush request, over-flushing doesn't hurt.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
