Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F6EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94E72133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfFNPZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:25:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:44508 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfFNPY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:24:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 08:24:59 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2019 08:24:58 -0700
Date:   Fri, 14 Jun 2019 08:24:58 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614152458.GA22634@linux.intel.com>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
 <20190614134123.GF2586@zn.tnic>
 <20190614141424.GA12191@linux.intel.com>
 <20190614142139.GH2586@zn.tnic>
 <20190614143912.GB12191@linux.intel.com>
 <20190614145734.GJ2586@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614145734.GJ2586@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:57:34PM +0200, Borislav Petkov wrote:
> On Fri, Jun 14, 2019 at 07:39:12AM -0700, Sean Christopherson wrote:
> > KVM can't handle Linux-defined leafs without extra tricks
> 
> and that's what I'm proposing - an extra trick.

It's not a trick, it's bug suppression.

Try running a kernel built with only patches 1/2 and 2/2 applied, along
with KVM's assertions removed.  It'll probably boot fine since most of the
affected features are option things, but Linux's feature reporting will be
all kinds of screwed up.

E.g. this WARN triggers because CPUID_7_EDX is 17, not 18 as expected,
and so the word at c->x86_capability[18] is never written.  Run the kernel
again after applying patch 3/3 and the warning magically disappears...

/* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5b0e9d869ce5..6c30fb244594 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -823,6 +823,8 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
                c->x86_capability[CPUID_7_0_EBX] = ebx;
                c->x86_capability[CPUID_7_ECX] = ecx;
                c->x86_capability[CPUID_7_EDX] = edx;
+
+               WARN_ON((edx & BIT(31)) && !cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD));
        }
 
        /* Extended state features: level 0x0000000d */


[    0.085583] WARNING: CPU: 0 PID: 0 at /home/sean/go/src/kernel.org/sinux/arch/x86/kernel/cpu/common.c:827 get_cpu_cap+0x1c9/0x1d0
[    0.085583] Modules linked in:
[    0.085585] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.2.0-rc2+ #4
[    0.085585] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    0.085586] RIP: 0010:get_cpu_cap+0x1c9/0x1d0
[    0.085587] Code: <0f> 0b e9 7f fe ff ff 48 8b 05 d9 39 fe 00 ba 01 00 00 00 41 54 b9
[    0.085588] RSP: 0000:ffffffff82003e80 EFLAGS: 00010246
[    0.085588] RAX: 0000000000000000 RBX: 00000000009c4fbb RCX: 0000000000000004
[    0.085589] RDX: 0000000084000000 RSI: 0000000000000000 RDI: ffffffff820f71e0
[    0.085589] RBP: ffffffff820f71e0 R08: 0000000000000001 R09: 0000000000000001
[    0.085589] R10: 000000000002c4f8 R11: 0000000000000002 R12: ffffffff82486920
[    0.085590] R13: ffffffff8248d2e0 R14: ffff88827fff73c0 R15: 000000000000010f
[    0.085590] FS:  0000000000000000(0000) GS:ffff888277a00000(0000) knlGS:0000000000000000
[    0.085592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.085592] CR2: 00000000ffffffff CR3: 0000000005009001 CR4: 00000000000606b0
[    0.085592] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.085593] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.085593] Call Trace:
[    0.085595]  identify_cpu+0xbb/0x540
[    0.085597]  identify_boot_cpu+0xc/0x6f
[    0.085598]  check_bugs+0x26/0x852
[    0.085599]  start_kernel+0x47a/0x4ab
[    0.085601]  secondary_startup_64+0xa4/0xb0
[    0.085602] ---[ end trace 33fbe952b06dbb68 ]---
