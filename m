Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE59C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA9F206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVAZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:25:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:13408 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKVAZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:25:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 16:25:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="219280751"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2019 16:25:44 -0800
Date:   Thu, 21 Nov 2019 16:37:54 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 4/6] x86/split_lock: Enumerate split lock detection
 if the IA32_CORE_CAPABILITIES MSR is not supported
Message-ID: <20191122003754.GF199273@romley-ivt3.sc.intel.com>
References: <1574297603-198156-5-git-send-email-fenghua.yu@intel.com>
 <D4D6F51D-D791-4B78-8FCA-5D419B1D079C@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D4D6F51D-D791-4B78-8FCA-5D419B1D079C@amacapital.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:07:38PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Nov 20, 2019, at 5:45 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > 
> > ﻿Architecturally the split lock detection feature is enumerated by
> > IA32_CORE_CAPABILITIES MSR and future CPU models will indicate presence
> > of the feature by setting bit 5. But the feature is present in a few
> > older models where split lock detection is enumerated by the CPU models.
> > 
> > Use a "x86_cpu_id" table to list the older CPU models with the feature.
> > 
> 
> This may need to be disabled if the HYPERVISOR bit is set.

How about just keeping this patch set as basic enabling code and
keep HYPERVISOR out of scope as of now? KVM folks will have better
handling of split lock in KVM once this patch set is available in
the kernel.

Thanks.

-Fenghua
