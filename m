Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77437C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C5522467
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfKTN4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:56:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:54157 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731263AbfKTN4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:56:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 05:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="237738162"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2019 05:56:07 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1D7A330084E; Wed, 20 Nov 2019 05:56:07 -0800 (PST)
Date:   Wed, 20 Nov 2019 05:56:07 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120135607.GA84886@tassilo.jf.intel.com>
References: <20191115191728.87338-1-jannh@google.com>
 <20191115191728.87338-2-jannh@google.com>
 <87lfsbfa2q.fsf@linux.intel.com>
 <CAG48ez2QFz9zEQ65VTc0uGB=s3uwkegR=nrH6+yoW-j4ymtq7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2QFz9zEQ65VTc0uGB=s3uwkegR=nrH6+yoW-j4ymtq7Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a specific concern you have about the instruction decoder? As
> far as I can tell, all the paths of insn_get_addr_ref() only work if
> the instruction has a mod R/M byte according to the instruction
> tables, and then figures out the address based on that. While that
> means that there's a wide variety of cases in which we won't be able
> to figure out the address, I'm not aware of anything specific that is
> likely to lead to false positives.

First there will be a lot of cases you'll just print 0, even
though 0 is canonical if there is no operand.

Then it might be that the address is canonical, but triggers
#GP anyways (e.g. unaligned SSE)

Or it might be the wrong address if there is an operand,
there are many complex instructions that reference something
in memory, and usually do canonical checking there.

And some other odd cases. For example when the instruction length
exceeds 15 bytes. I know there is fuzzing for the instruction
decoder, but it might be worth double checking it handles
all of that correctly. I'm not sure how good the fuzzer's coverage
is.

At a minimum you should probably check if the address is
actually non canonical. Maybe that's simple enough and weeds out
most cases.

-Andi

