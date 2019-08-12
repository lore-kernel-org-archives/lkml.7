Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF35C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A782075B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHLTex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:34:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60578 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfHLTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:34:53 -0400
Received: from p200300ddd71876867e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7686:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hxG5V-0004X8-7w; Mon, 12 Aug 2019 21:34:37 +0200
Date:   Mon, 12 Aug 2019 21:34:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Hunt <joshhunt00@gmail.com>
cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Liang, Kan" <kan.liang@intel.com>, jolsa@redhat.com,
        bigeasy@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
In-Reply-To: <CAKA=qzY=F-wj8YXhb-B7RahNceeab0rSA=06qBc8+7V-SyY-+Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908122133310.7324@nanos.tec.linutronix.de>
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com> <20180223121456.GZ25201@hirez.programming.kicks-ass.net> <20180226203937.GA21543@tassilo.jf.intel.com> <CAKA=qzYOU-VtEC5p6djRNmVS0xGe=jpTd3ZgUr++1G3Jj1=PTg@mail.gmail.com>
 <alpine.DEB.2.21.1908121933310.7324@nanos.tec.linutronix.de> <CAKA=qzY=F-wj8YXhb-B7RahNceeab0rSA=06qBc8+7V-SyY-+Q@mail.gmail.com>
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

On Mon, 12 Aug 2019, Josh Hunt wrote:
> On Mon, Aug 12, 2019 at 10:55 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, 12 Aug 2019, Josh Hunt wrote:
> > > Was there any progress made on debugging this issue? We are still
> > > seeing it on 4.19.44:
> >
> > I haven't seen anyone looking at this.
> >
> > Can you please try the patch Ingo posted:
> >
> >   https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/
> >
> > and if it fixes the issue decrease the value from 128 to the point where it
> > comes back, i.e. 128 -> 64 -> 32 ...
> >
> > Thanks,
> >
> >         tglx
> 
> I just checked the machines where this problem occurs and they're both
> Nehalem boxes. I think Ingo's patch would only help Haswell machines.
> Please let me know if I misread the patch or if what I'm seeing is a
> different issue than the one Cong originally reported.

Find the NHM hack below.

Thanks,

	tglx
	
8<----------------

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 648260b5f367..93c1a4f0e73e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3572,6 +3572,11 @@ static u64 bdw_limit_period(struct perf_event *event, u64 left)
 	return left;
 }
 
+static u64 nhm_limit_period(struct perf_event *event, u64 left)
+{
+	return max(left, 128ULL);
+}
+
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
 PMU_FORMAT_ATTR(umask,	"config:8-15"	);
 PMU_FORMAT_ATTR(edge,	"config:18"	);
@@ -4606,6 +4611,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
 		x86_pmu.enable_all = intel_pmu_nhm_enable_all;
 		x86_pmu.extra_regs = intel_nehalem_extra_regs;
+		x86_pmu.limit_period = nhm_limit_period;
 
 		mem_attr = nhm_mem_events_attrs;
 
