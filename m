Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477DC46477
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96552084D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfFPUYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 16:24:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfFPUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 16:24:31 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcbhG-0006b9-RQ; Sun, 16 Jun 2019 22:24:15 +0200
Date:   Sun, 16 Jun 2019 22:24:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale directly
 from CPUID instead of cpuinfo_x86
In-Reply-To: <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com> <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2019, Fenghua Yu wrote:

> Although x86_cache_max_rmid and x86_cache_occ_scale are only read once
> during resctrl initialization, they are always stored in cpuinfo_x86 for
> each CPU during run time without usage. Even if resctrl is not
> configured, they still occupy space in cpuinfo_x86.

And that's a problem because?

> To save cpuinfo_x86 space and make CPU and resctrl initialization simpler,
> remove the two fields from cpuinfo_x86 and get max rmid and occupancy

What is simpler? The fact that more code fiddles with CPUID? That's exactly
the wrong direction.

The storage size of struct cpuinfo is largely uninteresting especially as
long as we keep num_online_cpus copies of the same information around.

Just grep for places which invoke CPUID and then look how many of them do
it over and over and even the code in arch/x86/kernel/cpu/ is an
unpenetrable mess for exactly this reason.

The right thing to do is to have one instance of the CPUID information
which is

  - a proper data structure with named fields and named bits

  - a single master instance which can be mapped to all CPUs

This data structure is filled in in one go by reading out all leaves and
not by the maze we have today which puts together selected parts piecewise
and never exposes a full and consistent picture.

This allows to remove all these custom copies of CPUID leaf readouts and
allows proper filtering/disabling at a central place.

Making it a proper data structure with fields and bits gets rid of all that
hex masking/shifting nonsense which is used to decode parts of those
fields.

That's not a performance issue because all performance critical code should
use static_cpu_has() anyway. For non critical code boot_cpu_has() is
sufficient.

Upcoming secondary CPUs would do a sanity check on their CPUID content to
check whether everything is symmetric. We should do that actually today
because not detecting asymetric features early leads to exactly the issue
which was fixed recently with loading the micro code earlier than perf.
But we can't because the information retrieval is done in a gazillion of
places.
  
Now you might argue that the upcoming asymetric processors (SIGH!) will
require per CPU instances of the feature leafs. Sure that needs some
thought, but it needs thought even with the current code and I'm absolutely
not interested to duct tape that stuff into the current code.

The solution for this with the above scheme is to utilize the feature
mismatch detection and have a proper classification which features are
allowed to deviate and which are not. For those which can deviate, we can
provide separate storage as this information needs to be propagated to
other entities (fault handlers, placement code, xsave variants etc.). But
that's a limited amount of information and the bulk will still be the same.

This mismatch detection is essential for dealing with future asymetric
CPUs proper. When the kernel detects it, it can disable mismatching
features which are not yet handled by code which has to be aware of them.

And disabling them means that with that scheme we can actually trap CPUID
in userspace and provide it consistent and filtered information instead
of having the mismatch between kernel view and user space view.

Borislav has experimented with that already, but thanks to the marvelous
security features built into Intel (and other) CPUs this is still mostly a
drawing board exercise.

Just for the record. Before this cleanup takes place, I'm not even looking
at any patches which attempt to support asymetric processors. The current
supply of duct tape engineering horrors is sufficient for bad mood. No need
for more of that.

Thanks,

	tglx

