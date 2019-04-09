Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADCDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4182213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfDICHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:07:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:24019 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDICHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:07:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 19:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="221742173"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2019 19:07:02 -0700
Date:   Mon, 8 Apr 2019 19:05:53 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 10/14] kernel/watchdog: Add a function to obtain
 the watchdog_allowed_mask
Message-ID: <20190409020553.GA7228@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1903262221140.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262221140.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:22:40PM +0100, Thomas Gleixner wrote:
> On Wed, 27 Feb 2019, Ricardo Neri wrote:
> >  
> > -struct cpumask watchdog_allowed_mask __read_mostly;
> > +static struct cpumask watchdog_allowed_mask __read_mostly;
> 
> That hunk is correct.

I'll send a separate patch with this hunk only.
> 
> >  struct cpumask watchdog_cpumask __read_mostly;
> >  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
> > @@ -92,6 +92,11 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
> >  }
> >  __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
> >  # endif /* CONFIG_SMP */
> > +
> > +struct cpumask *watchdog_get_allowed_cpumask(void)
> > +{
> > +	return &watchdog_allowed_mask;
> > +}
> 
> That part is pointless as I showed you in the other reply. You don't need
> that mask in your code at all.

Yes. I'll remove this hunk and follow the approach you suggested in your
reply to patch 11.

Thanks and BR,
Ricardo
> 
> Thanks,
> 
> 	tglx
> 
> 
