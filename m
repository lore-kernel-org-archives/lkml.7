Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE87C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501D02067D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKVBw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:52:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:61190 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfKVBw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:52:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 17:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; 
   d="scan'208";a="205263047"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga008.fm.intel.com with ESMTP; 21 Nov 2019 17:52:25 -0800
Date:   Thu, 21 Nov 2019 17:52:25 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122015225.GG16617@linux.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F4DC167@ORSMSX115.amr.corp.intel.com>
 <B2612A75-BEC8-4FF7-9FDA-A7B55C2E0B4A@amacapital.net>
 <20191121235329.GE199273@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121235329.GE199273@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 03:53:29PM -0800, Fenghua Yu wrote:
> On Thu, Nov 21, 2019 at 03:18:46PM -0800, Andy Lutomirski wrote:
> > 
> > > On Nov 21, 2019, at 2:29 PM, Luck, Tony <tony.luck@intel.com> wrote:
> > > 
> > >> It would be really, really nice if we could pass this feature through to a VM. Can we?
> > > 
> > > It's hard because the MSR is core scoped rather than thread scoped.  So on an HT
> > > enabled system a pair of logical processors gets enabled/disabled together.
> > > 
> > 
> > Well that sucks.
> > 
> > Could we pass it through if the host has no HT?  Debugging is *so* much
> > easier in a VM.  And HT is a bit dubious these days anyway.
> 
> I think it's doable to pass it through to KVM. The difficulty is to disable
> split lock detection in KVM because that will disable split lock on the whole
> core including threads for the host. Without disabling split lock in KVM,
> it's doable to debug split lock in KVM.
> 
> Sean and Xiaoyao are working on split lock for KVM (in separate patch set).
> They may have insight on how to do this.

Yes, with SMT off KVM could allow the guest to enable split lock #AC, but
for the initial implementation we'd want to allow it if and only if split
lock #AC is disabled in the host kernel.  Otherwise we have to pull in the
logic to control whether or not a guest can disable split lock #AC, what
to do if a split lock #AC happens when it's enabled by the host but
disabled by the guest, etc...
