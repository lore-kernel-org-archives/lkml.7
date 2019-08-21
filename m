Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80036C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5111022DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfHUPrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:47:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHUPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:47:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9784F18C8919;
        Wed, 21 Aug 2019 15:47:14 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDF935D6B0;
        Wed, 21 Aug 2019 15:47:12 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: reset LDR in clear_local_APIC
References: <jpga7ccl7la.fsf@linux.bootlegged.copy>
        <alpine.DEB.2.21.1908192259390.4008@nanos.tec.linutronix.de>
        <jpgk1b8g69t.fsf@linux.bootlegged.copy>
        <alpine.DEB.2.21.1908200052281.4008@nanos.tec.linutronix.de>
Date:   Wed, 21 Aug 2019 11:47:12 -0400
In-Reply-To: <alpine.DEB.2.21.1908200052281.4008@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 20 Aug 2019 01:09:55 +0200
        (CEST)")
Message-ID: <jpgwof6plkv.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Wed, 21 Aug 2019 15:47:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Bandan,
>
> On Mon, 19 Aug 2019, Bandan Das wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> > On Wed, 14 Aug 2019, Bandan Das wrote:
>> >> On a 32 bit RHEL6 guest with greater than 8 cpus, the
>> >> kdump kernel hangs when calibrating apic. This happens
>> >> because when apic initializes bigsmp, it also initializes LDR
>> >> even though it probably wouldn't be used.
>> >
>> > 'It probably wouldn't be used' is a not really a useful technical
>> > statement.
>> >
>> > Either it is used, then it needs to be handled. Or it is unused then why is
>> > it written in the first place?
>> >
>> > The bigsmp APIC uses physical destination mode because the logical flat
>> > model only supports 8 APICs. So clearly bigsmp_init_apic_ldr() is bogus and
>> > should be empty.
>> >
>> 
>> Your note above is what I meant by "it probably wouldn't be used" because
>> I don't have much insight into the history behind why LDR is being initialized
>> in the first place. The only evidence I found is a comment in apic.c that states:
>> 	/*
>> 	 * Intel recommends to set DFR, LDR and TPR before enabling
>> 	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
>> 	 * document number 292116).  So here it goes...
>> 	 */
>
> The physflat stuff is documented in the SDM and in the APIC code
> (apic_flat_64.c):
>
> static void physflat_init_apic_ldr(void)
> {
>         /*
>          * LDR and DFR are not involved in physflat mode, rather:
>          * "In physical destination mode, the destination processor is
>          * specified by its local APIC ID [...]." (Intel SDM, 10.6.2.1)
>          */
> }
>
> Why is LDR initialized in the bigsmp code? Probably histerical raisins and
> I'm just too tired to consult the history git trees for an answer.
>
>> That said, not initalizing the ldr in bigsmp_init_apic_ldr() should be
>> enough to fix this. Would you prefer that change instead ?
>
> That's surely something we want to get rid off. But for sanity sake we
> should clear LDR as well after understanding it completely.
>
>> >> When booting into kdump, KVM apic incorrectly reads the stale LDR
>> >> values from the guest while building the logical destination map
>> >> even for inactive vcpus. While KVM apic can be fixed to ignore apics
>> >> that haven't been enabled, a simple guest only change can be to
>> >> just clear out the LDR.
>> >
>> > This does not make much sense either. What has KVM to do with logical
>> > destination maps while booting the kdump kernel? The kdump kernel is not
>> 
>> This is the guest kernel and KVM takes care of injecting the interrupt to
>> the right vcpu (recalculate_apic_map)() in lapic.c).
>
> Yeah. I know that KVM injects interrupts. Still that does not explain the
> issue properly.
>
> The point is that when the kdump kernel boots in the guest and uses logical
> destination mode then it will overwrite LDR _BEFORE_ the local APIC timer
> calibration takes place. So no, I'm not bying this. Just because it makes
It will but only for 1 cpu which is the boot cpu since kdump will usually be run with
nr_cpus=1.

> your problem disappear does not mean it's the proper explanation.
>
Let me try this again -
1. We boot a 16 vcpu guest, the guest kernel writes the LDR for the CPUs but
ofcourse, PhysFlat is always used.

2. We force a kdump crash - the kdump kernel boots with nr_cpus=1 but that does not
make KVM forget about the inactive vcpus. They are still in the vcpu list but not
active.

3. Before jumping into the kdump kernel, the guest kernel does not clear the LDR bits.

4. In the kdump kernel, the guest only overwrites the LDR for the boot cpu i.e from
KVM's point of view, the stale LDR values are still around for the inactive vcpus.

5. recalculate_apic_map() in its previous form (before the kvm patch linked above) did
not check whether the virtual apic is actually enabled; rather, if it finds any value in
the LDR, it will keep the cpu in the mapping table it maintains. However, it makes the
assumption that only one bit in the LDR is set which is not true for bigsmp_init_apic_ldr() -
the way it initializes the LDR, multiple bits can be set! Since recalculate_apic_map uses
ffs() it just checks for the first set bit and assumes that other bits are set and potentially
overwrites and existing entry.

For example, let's assume the kdump kernel boots on CPU 1. So, in recalculate_apic_map(),
mask is 1 and ffs(mask) - 1 is 0 and so, cluster[ffs(mask) - 1] = apic; writes 1 to
cluster[0]. When iterating through all the vcpus, the next in line is vcpu2 which still has
a stale LDR value. So, the function will again incorrectly overwrite cluster[0] = 2. Since 2
is inactive, the timer calibration interrupt ends up nowhere.

So, in KVM: if we make sure that the logical destination map isn't filled up if the virtual
apic is not enabled by software, it really doesn't matter whether the LDR for an inactive CPU
has a stale value.

In x86/apic: if we make sure that the LDR is 0 or reset, recalculate_apic_map() will never consider
including this cpu in the logical map.

In short, as I mentioned in the patch description, this is really a KVM bug but it doesn't hurt
to clear out the LDR in the guest and then, it wouldn't need a hypervisor fix.

Is this better ?


>> For the KVM side change, please take a look at
>> https://lore.kernel.org/kvm/aee50952-144d-78da-9036-045bd3838b59@redhat.com/
>
> That's the same text in diffferent form and not conclusive either.
>  
>> > going through the regular cold/warm boot process, so KVM does not even know
>> > that the crashing kernel jumped into the kdump one.
>> >
>> > What builds the logical destination maps and what has LDR and the KVM APIC
>> > to do with that?
>> >
>> > I'm not opposed to the change per se, but I'm not accepting change logs
>> > which have the fairy tale smell.
>> >
>> Heh, no it's not.
>
> Well, it's not an accurate technical description of the root cause either :)
>
> Thanks,

>
> 	tglx
