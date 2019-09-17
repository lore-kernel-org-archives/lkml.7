Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E444C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E57D206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfIQTOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:14:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:16843 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfIQTOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:14:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 12:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="338089320"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2019 12:14:02 -0700
Date:   Tue, 17 Sep 2019 12:14:01 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 3/3] x86/split_lock: Align the x86_capability array to
 size of unsigned long
Message-ID: <20190917191401.GA4721@agluck-desk2.amr.corp.intel.com>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <20190916223958.27048-1-tony.luck@intel.com>
 <20190916223958.27048-4-tony.luck@intel.com>
 <d75c94cf2ca345018ef60880ce6c4aeb@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75c94cf2ca345018ef60880ce6c4aeb@AcuMS.aculab.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 08:29:28AM +0000, David Laight wrote:
> From: Tony Luck
> > Sent: 16 September 2019 23:40
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > The x86_capability array in cpuinfo_x86 is defined as u32 and thus is
> > naturally aligned to 4 bytes. But, set_bit() and clear_bit() require
> > the array to be aligned to size of unsigned long (i.e. 8 bytes in
> > 64-bit).
> > 
> > To fix the alignment issue, align the x86_capability array to size of
> > unsigned long by using unnamed union and 'unsigned long array_align'
> > to force the alignment.
> > 
> > Changing the x86_capability array's type to unsigned long may also fix
> > the issue because the x86_capability array will be naturally aligned
> > to size of unsigned long. But this needs additional code changes.
> > So choose the simpler solution by setting the array's alignment to size
> > of unsigned long.
> > 
> > Suggested-by: David Laight <David.Laight@aculab.com>
> 
> While this is probably the only play where this 'capabilities' array
> has been detected as misaligned, ISTR there are several other places
> where the identical array is defined and used.
> These all need fixing as well.

Agree 100%  These three patches cover the places *detected* so
far. For bisectability reasons they need to be upstream before
the patches that add WARN_ON, or the one that turns on alignment
traps.  As we find other places, we can fix alignments in other
structures too.

If you remember what those other places are, please let us know
so we can push patches to fix those.

If you have a better strategy to find them ... that also would
be very interesting.

-Tony
