Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF9CFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDE220854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405541AbfJPPlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:41:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:33013 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfJPPlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:41:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 08:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="370834587"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2019 08:41:16 -0700
Date:   Wed, 16 Oct 2019 08:41:16 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
Message-ID: <20191016154116.GA5866@linux.intel.com>
References: <20190626203637.GC245468@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906262338220.32342@nanos.tec.linutronix.de>
 <20190925180931.GG31852@linux.intel.com>
 <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com>
 <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
 <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
 <alpine.DEB.2.21.1910161244060.2046@nanos.tec.linutronix.de>
 <3a12810b-1196-b70a-aa2e-9fe17dc7341a@redhat.com>
 <b2c42a64-eb42-1f18-f609-42eec3faef18@intel.com>
 <d2fc3cbe-1506-94fc-73a4-8ed55dc9337d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2fc3cbe-1506-94fc-73a4-8ed55dc9337d@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:08:14PM +0200, Paolo Bonzini wrote:
> SIGBUS (actually a new KVM_EXIT_INTERNAL_ERROR result from KVM_RUN is
> better, but that's the idea) is for when you're debugging guests.
> Global disable (or alternatively, disable SMT) is for production use.

Alternatively, for guests without split-lock #AC enabled, what if KVM were
to emulate the faulting instruction with split-lock detection temporarily
disabled?

The emulator can presumably handle all such lock instructions, and an
unhandled instruction would naturally exit to userspace.

The latency of VM-Enter+VM-Exit should be enough to guard against DoS from
a malicious guest.  KVM could also artificially rate-limit a guest that is
generating copious amounts of split-lock #ACs.
