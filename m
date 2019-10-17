Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2DBECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D7F2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394175AbfJQMaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:30:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfJQMaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:30:02 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iL4uY-0007rm-1f; Thu, 17 Oct 2019 14:29:46 +0200
Date:   Thu, 17 Oct 2019 14:29:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
Subject: [RFD] x86/split_lock: Request to Intel
In-Reply-To: <ba2c0aab-1d7c-5cfd-0054-ac2c266c1df3@redhat.com>
Message-ID: <alpine.DEB.2.21.1910171322530.1824@nanos.tec.linutronix.de>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com> <1560897679-228028-10-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1906262209590.32342@nanos.tec.linutronix.de> <20190626203637.GC245468@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906262338220.32342@nanos.tec.linutronix.de> <20190925180931.GG31852@linux.intel.com> <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com> <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de> <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
 <c3ff2fb3-4380-fb07-1fa3-15896a09e748@intel.com> <d30652bb-89fa-671a-5691-e2c76af231d0@redhat.com> <8808c9ac-0906-5eec-a31f-27cbec778f9c@intel.com> <alpine.DEB.2.21.1910161519260.2046@nanos.tec.linutronix.de>
 <ba2c0aab-1d7c-5cfd-0054-ac2c266c1df3@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The more I look at this trainwreck, the less interested I am in merging any
of this at all.

The fact that it took Intel more than a year to figure out that the MSR is
per core and not per thread is yet another proof that this industry just
works by pure chance.

There is a simple way out of this misery:

  Intel issues a microcode update which does:

    1) Convert the OR logic of the AC enable bit in the TEST_CTRL MSR to
       AND logic, i.e. when one thread disables AC it's automatically
       disabled on the core.

       Alternatively it supresses the #AC when the current thread has it
       disabled.

    2) Provide a separate bit which indicates that the AC enable logic is
       actually AND based or that #AC is supressed when the current thread
       has it disabled.

    Which way I don't really care as long as it makes sense.

If that's not going to happen, then we just bury the whole thing and put it
on hold until a sane implementation of that functionality surfaces in
silicon some day in the not so foreseeable future.

Seriously, this makes only sense when it's by default enabled and not
rendered useless by VIRT. Otherwise we never get any reports and none of
the issues are going to be fixed.

Thanks,

	tglx
