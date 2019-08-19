Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2DCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED714214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfHSWFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfHSWFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88D5C189DAE5;
        Mon, 19 Aug 2019 22:05:51 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C491D5C21A;
        Mon, 19 Aug 2019 22:05:50 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: reset LDR in clear_local_APIC
References: <jpga7ccl7la.fsf@linux.bootlegged.copy>
        <alpine.DEB.2.21.1908192259390.4008@nanos.tec.linutronix.de>
Date:   Mon, 19 Aug 2019 18:05:50 -0400
In-Reply-To: <alpine.DEB.2.21.1908192259390.4008@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Mon, 19 Aug 2019 23:07:03 +0200
        (CEST)")
Message-ID: <jpgk1b8g69t.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Mon, 19 Aug 2019 22:05:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thomas Gleixner <tglx@linutronix.de> writes:

> Bandan,
>
> On Wed, 14 Aug 2019, Bandan Das wrote:
>> On a 32 bit RHEL6 guest with greater than 8 cpus, the
>> kdump kernel hangs when calibrating apic. This happens
>> because when apic initializes bigsmp, it also initializes LDR
>> even though it probably wouldn't be used.
>
> 'It probably wouldn't be used' is a not really a useful technical
> statement.
>
> Either it is used, then it needs to be handled. Or it is unused then why is
> it written in the first place?
>
> The bigsmp APIC uses physical destination mode because the logical flat
> model only supports 8 APICs. So clearly bigsmp_init_apic_ldr() is bogus and
> should be empty.
>

Your note above is what I meant by "it probably wouldn't be used" because
I don't have much insight into the history behind why LDR is being initialized
in the first place. The only evidence I found is a comment in apic.c that states:
	/*
	 * Intel recommends to set DFR, LDR and TPR before enabling
	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
	 * document number 292116).  So here it goes...
	 */
That said, not initalizing the ldr in bigsmp_init_apic_ldr() should be
enough to fix this. Would you prefer that change instead ?

>> When booting into kdump, KVM apic incorrectly reads the stale LDR
>> values from the guest while building the logical destination map
>> even for inactive vcpus. While KVM apic can be fixed to ignore apics
>> that haven't been enabled, a simple guest only change can be to
>> just clear out the LDR.
>
> This does not make much sense either. What has KVM to do with logical
> destination maps while booting the kdump kernel? The kdump kernel is not

This is the guest kernel and KVM takes care of injecting the interrupt to
the right vcpu (recalculate_apic_map)() in lapic.c). 

For the KVM side change, please take a look at
https://lore.kernel.org/kvm/aee50952-144d-78da-9036-045bd3838b59@redhat.com/

> going through the regular cold/warm boot process, so KVM does not even know
> that the crashing kernel jumped into the kdump one.
>
> What builds the logical destination maps and what has LDR and the KVM APIC
> to do with that?
>
> I'm not opposed to the change per se, but I'm not accepting change logs
> which have the fairy tale smell.
>
Heh, no it's not.

> Thanks,
>
> 	tglx
