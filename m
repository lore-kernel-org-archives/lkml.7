Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6049C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EE2233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392357AbfHVUxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:53:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:3232 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731775AbfHVUxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:53:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 13:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,418,1559545200"; 
   d="scan'208";a="178974922"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2019 13:53:12 -0700
Date:   Thu, 22 Aug 2019 13:53:12 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Further sanitize INTEL_FAM6 naming
Message-ID: <20190822205312.GA10757@agluck-desk2.amr.corp.intel.com>
References: <20190822102306.109718810@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822102306.109718810@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 12:23:06PM +0200, Peter Zijlstra wrote:
> Lots of variation has crept in; time to collapse the lot again.

Conceptually good.  But I applied the series on top of tip/master
and got a build error:

  CC      arch/x86/kernel/cpu/common.o
arch/x86/kernel/cpu/common.c:1031:19: error: ‘INTEL_FAM6_ATOM_SILVERMONT_X’ undeclared here (not in a function); did you mean ‘INTEL_FAM6_ATOM_SILVERMONT_D’?
  VULNWL(INTEL, 6, INTEL_FAM6_##model, whitelist)
                   ^~~~~~~~~~~
arch/x86/kernel/cpu/common.c:1028:35: note: in definition of macro ‘VULNWL’
  { X86_VENDOR_##_vendor, _family, _model, X86_FEATURE_ANY, _whitelist }
                                   ^~~~~~
arch/x86/kernel/cpu/common.c:1053:2: note: in expansion of macro ‘VULNWL_INTEL’
  VULNWL_INTEL(ATOM_SILVERMONT_X,  NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
  ^~~~~~~~~~~~
arch/x86/kernel/cpu/common.c:1031:19: error: ‘INTEL_FAM6_ATOM_GOLDMONT_X’ undeclared here (not in a function); did you mean ‘INTEL_FAM6_ATOM_GOLDMONT_D’?
  VULNWL(INTEL, 6, INTEL_FAM6_##model, whitelist)
                   ^~~~~~~~~~~
arch/x86/kernel/cpu/common.c:1028:35: note: in definition of macro ‘VULNWL’
  { X86_VENDOR_##_vendor, _family, _model, X86_FEATURE_ANY, _whitelist }
                                   ^~~~~~
arch/x86/kernel/cpu/common.c:1064:2: note: in expansion of macro ‘VULNWL_INTEL’
  VULNWL_INTEL(ATOM_GOLDMONT_X,  NO_MDS | NO_L1TF | NO_SWAPGS),
  ^~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:281: arch/x86/kernel/cpu/common.o] Error 1


Looks like your scripts didn't anticipate the CPP gymnastics like:

#define VULNWL_INTEL(model, whitelist)          \
        VULNWL(INTEL, 6, INTEL_FAM6_##model, whitelist)

-Tony
