Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC3C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B281220836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGBIfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:35:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:56562 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfGBIfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:35:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 01:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,442,1557212400"; 
   d="scan'208";a="163948244"
Received: from xpf-desktop.sh.intel.com (HELO xpf-desktop) ([10.239.13.102])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jul 2019 01:35:14 -0700
Date:   Tue, 2 Jul 2019 16:40:18 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Li Wang <liwang@redhat.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
        kernellwp@gmail.com, ricardo.neri@intel.com,
        LTP List <ltp@lists.linux.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ping Fang <pifang@redhat.com>
Subject: Re: [Kernel BUG?] SMSW operation get success on UMIP KVM guest
Message-ID: <20190702084018.tnwefzqzar3xiaww@xpf-desktop>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
 <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
 <CAEemH2fqMpoiBo+asyawHsOWgdXy-ggV0mwQs9A9EJ1kh=uhAA@mail.gmail.com>
 <20190701160352.GA19921@ranerica-svr.sc.intel.com>
 <CAEemH2fR98TBHaOM37aGmzbgdZ_XPokJeUNN6dU1r=1WhOSmEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2fR98TBHaOM37aGmzbgdZ_XPokJeUNN6dU1r=1WhOSmEw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems no issue now.

Thanks all.

On 2019-07-02 at 09:52:39 +0800, Li Wang wrote:
> On Tue, Jul 2, 2019 at 12:04 AM Ricardo Neri <
> ricardo.neri-calderon@linux.intel.com> wrote:
> 
> > On Mon, Jul 01, 2019 at 08:57:28PM +0800, Li Wang wrote:
> > > On Mon, Jul 1, 2019 at 8:02 PM Paolo Bonzini <pbonzini@redhat.com>
> > wrote:
> > >
> > > > On 01/07/19 09:50, Li Wang wrote:
> > > > > Hello there,
> > > > >
> > > > > LTP/umip_basic_test get failed on KVM UMIP
> > > > > system(kernel-v5.2-rc4.x86_64). The test is only trying to do
> > > > >      asm volatile("smsw %0\n" : "=m" (val));
> > > > > and expect to get SIGSEGV in this SMSW operation, but it exits with 0
> > > > > unexpectedly.
> > > >
> > > > In addition to what Thomas said, perhaps you are using a host that does
> > > > *not* have UMIP, and configuring KVM to emulate it(*).  In that case,
> > it
> > > > is not possible to intercept SMSW, and therefore it will incorrectly
> > > > succeed.
> > > >
> > >
> > > Right, I checked the host system, and confirmed that CPU doesn't support
> > > UMIP.
> > >
> > > >
> > > > Paolo
> > > >
> > > > (*) before the x86 people jump at me, this won't happen unless you
> > > > explicitly pass an option to QEMU, such as "-cpu host,+umip". :)  The
> > > > incorrect emulation of SMSW when CR4.UMIP=1 is why.
> > > >
> > > Good to know this, is there any document for that declaration? It seems
> > > neither LTP issue nor kernel bug here. But anyway we'd better do
> > something
> > > to avoid the error in the test.
> >
> > The test case already checks for umip in /proc/cpuinfo, right? And in
> > long mode it always expects a SIGSEGV signal. If you did not add -cpu
> > host,+umip,
> > how come umip was present in /proc/cpuinfo?
> >
> 
> Yes, right.
> 
> But the KVM guest is not customized in manual, I reserved that system for
> automation test and did not aware of the '-cpu host,+umip,' parameter until
> Paolo points it out. In the last email, I was hoping to find a way to
> recognize this situation for the LTP test intelligently.
> 
> Thank you all for a reply to this.
> 
> -- 
> Regards,
> Li Wang
