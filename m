Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BCBC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7A521655
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfHUTyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHUTyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D34F63175295;
        Wed, 21 Aug 2019 19:54:35 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4182C194B2;
        Wed, 21 Aug 2019 19:54:35 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: reset LDR in clear_local_APIC
References: <jpga7ccl7la.fsf@linux.bootlegged.copy>
        <alpine.DEB.2.21.1908192259390.4008@nanos.tec.linutronix.de>
        <jpgk1b8g69t.fsf@linux.bootlegged.copy>
        <alpine.DEB.2.21.1908200052281.4008@nanos.tec.linutronix.de>
        <jpgwof6plkv.fsf@linux.bootlegged.copy>
        <alpine.DEB.2.21.1908212008500.1983@nanos.tec.linutronix.de>
Date:   Wed, 21 Aug 2019 15:54:34 -0400
In-Reply-To: <alpine.DEB.2.21.1908212008500.1983@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Wed, 21 Aug 2019 20:22:21 +0200
        (CEST)")
Message-ID: <jpgimqq70qt.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 21 Aug 2019 19:54:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Bandan,
>
> On Wed, 21 Aug 2019, Bandan Das wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> So, in KVM: if we make sure that the logical destination map isn't filled up if the virtual
>> apic is not enabled by software, it really doesn't matter whether the LDR for an inactive CPU
>> has a stale value.
>>
>> In x86/apic: if we make sure that the LDR is 0 or reset,
>> recalculate_apic_map() will never consider including this cpu in the
>> logical map.
> ?
>> In short, as I mentioned in the patch description, this is really a KVM
>> bug but it doesn't hurt to clear out the LDR in the guest and then, it
>> wouldn't need a hypervisor fix.
>
> I still needs a hypervisor fix. Taking disabled APICs into account is a bug
> which has also other consequeces than that particular one. So please don't
> claim that. It's wrong.
>
> If that prevents the APIC bug from triggering on unfixed hypervisors, then
> this is a nice side effect, but not a solution.
>
Agreed and fwiw, the kvm fix has been queued already.

>> Is this better ?
>
> That's way better.
>
> So can you please create two patches:
>
>    1) Make that bogus bigsmp ldr init empty
>
>       That one wants a changelog along these lines:
>
>       - Setting LDR for physical destination mode is pointless
>       - Setting multiple bits in the LDR is wrong
>
>       Mention how this was discovered and caused the KVM APIC bug to be
>       triggered. Also mention that the change is not there to paper over
>       the KVM APIC bug. The change fixes a bug in the bigsmp APIC code.
>
>    2) Clear LDR in in that apic reset function
>
>       That one wants a changelog along these lines:
>
>       - Except for x2apic the LDR should be cleared as any other APIC
>       	register
>
>       Mention how this was discovered. Again the change is not there to
>       paper over the KVM APIC bug. It's for correctness sake and valid on
>       its own.
>
> Thanks,
>
Will do as you suggested. Thank you for the review.

Bandan
> 	tglx
>
> 	
