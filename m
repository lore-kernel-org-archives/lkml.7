Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9278C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4F721655
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHUSWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:22:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfHUSWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:22:33 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0VFb-00030J-3e; Wed, 21 Aug 2019 20:22:27 +0200
Date:   Wed, 21 Aug 2019 20:22:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bandan Das <bsd@redhat.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: reset LDR in clear_local_APIC
In-Reply-To: <jpgwof6plkv.fsf@linux.bootlegged.copy>
Message-ID: <alpine.DEB.2.21.1908212008500.1983@nanos.tec.linutronix.de>
References: <jpga7ccl7la.fsf@linux.bootlegged.copy> <alpine.DEB.2.21.1908192259390.4008@nanos.tec.linutronix.de> <jpgk1b8g69t.fsf@linux.bootlegged.copy> <alpine.DEB.2.21.1908200052281.4008@nanos.tec.linutronix.de> <jpgwof6plkv.fsf@linux.bootlegged.copy>
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

Bandan,

On Wed, 21 Aug 2019, Bandan Das wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> So, in KVM: if we make sure that the logical destination map isn't filled up if the virtual
> apic is not enabled by software, it really doesn't matter whether the LDR for an inactive CPU
> has a stale value.
>
> In x86/apic: if we make sure that the LDR is 0 or reset,
> recalculate_apic_map() will never consider including this cpu in the
> logical map.
?
> In short, as I mentioned in the patch description, this is really a KVM
> bug but it doesn't hurt to clear out the LDR in the guest and then, it
> wouldn't need a hypervisor fix.

I still needs a hypervisor fix. Taking disabled APICs into account is a bug
which has also other consequeces than that particular one. So please don't
claim that. It's wrong.

If that prevents the APIC bug from triggering on unfixed hypervisors, then
this is a nice side effect, but not a solution.

> Is this better ?

That's way better.

So can you please create two patches:

   1) Make that bogus bigsmp ldr init empty

      That one wants a changelog along these lines:

      - Setting LDR for physical destination mode is pointless
      - Setting multiple bits in the LDR is wrong

      Mention how this was discovered and caused the KVM APIC bug to be
      triggered. Also mention that the change is not there to paper over
      the KVM APIC bug. The change fixes a bug in the bigsmp APIC code.

   2) Clear LDR in in that apic reset function

      That one wants a changelog along these lines:

      - Except for x2apic the LDR should be cleared as any other APIC
      	register

      Mention how this was discovered. Again the change is not there to
      paper over the KVM APIC bug. It's for correctness sake and valid on
      its own.

Thanks,

	tglx

	
