Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225ADC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED06B20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCGTC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:02:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:34814 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGTC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:02:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 11:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="150256508"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2019 11:02:25 -0800
Date:   Thu, 7 Mar 2019 11:02:25 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFC] x86/kvm/mmu: make mmu->prev_roots cache work for
 NPT case
Message-ID: <20190307190225.GD4986@linux.intel.com>
References: <0c13c94e-3226-8bfd-2dc7-c75aad1c03a2@redhat.com>
 <20190223111552.27221-1-vkuznets@redhat.com>
 <87ftrylqwm.fsf@vitty.brq.redhat.com>
 <20190307160633.GA4986@linux.intel.com>
 <87a7i6ljr0.fsf@vitty.brq.redhat.com>
 <20190307185946.GC4986@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307185946.GC4986@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:59:46AM -0800, Sean Christopherson wrote:
> I think what we could do is repurpose role's nxe, cr0_wp, and
> sm{a,e}p_andnot_wp bits to uniquely identify a nested EPT/NPT entry.

Ignore the "NPT" comment, this would only apply to EPT.

> E.g. cr0_wp=1 and sm{a,e}p_andnot_wp=1 are an impossible combination.
> I'll throw together a patch to see what breaks.  In fact, I think we
> could revamp kvm_calc_shadow_ept_root_page_role() to completely ignore
> all legacy paging bits, i.e. handling changes in L2's configuration is
> L1's problem.
