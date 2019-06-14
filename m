Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A7DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC8A2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfFNOfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:35:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:15426 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbfFNOfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:35:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 07:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,373,1557212400"; 
   d="scan'208";a="184978464"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2019 07:35:16 -0700
Date:   Fri, 14 Jun 2019 07:25:51 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614142550.GD198207@romley-ivt3.sc.intel.com>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
 <20190614134123.GF2586@zn.tnic>
 <20190614141424.GA12191@linux.intel.com>
 <20190614141519.GC198207@romley-ivt3.sc.intel.com>
 <20190614142611.GI2586@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614142611.GI2586@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:26:11PM +0200, Borislav Petkov wrote:
> On Fri, Jun 14, 2019 at 07:15:20AM -0700, Fenghua Yu wrote:
> > Adding this small patch into patch 0002 will solve the build errors without
> > changing the build checks.
> 
> There's no need for that if you remove the BUILD_BUG_ON checks first.

But without this small patch, CPUID_7_EDX is 17 instead of
NCAPINTS(19)-1=18 in patch 0002. Of course CPUID_7_EDX is 18 correctly
evetually after applying patch 0003 which add the word 12 back.

KVM reports this CPUID_7_EDX is not 18 in bisect (as Sena also pointed
out). I think even native kernel should have some check to report this
error (similar to other checks of NCAPINTS).

Thanks.

-Fenghua
