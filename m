Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A3EC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657CA2196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404999AbfIINyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:54:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404954AbfIINyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:54:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7DF418CCF0F;
        Mon,  9 Sep 2019 13:54:14 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F80B620DC;
        Mon,  9 Sep 2019 13:54:14 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc7
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
        <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
        <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
        <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
        <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de>
        <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com>
        <CAHk-=wimjeOCi4k7+nhzx3XWzvQUbMtNpcKNo8ZteodQ5c5APg@mail.gmail.com>
Date:   Mon, 09 Sep 2019 09:54:13 -0400
Message-ID: <jpga7bdpoca.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Mon, 09 Sep 2019 13:54:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Sep 7, 2019 at 12:17 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I'm really not clear on why it's a good idea to clear the LDR bits on
>> shutdown, and commit 558682b52919 ("x86/apic: Include the LDR when
>> clearing out APIC registers") just looks pointless. And now it has
>> proven to break some machines.
>>
>> So why wouldn't we just revert it?
>
> Side note: looking around for the discussion about this patch, at
> least one version of the patch from Bandan had
>
> +       if (!x2apic_enabled) {
>
> rather than
>
> +       if (!x2apic_enabled()) {
>

I believe this crept up by accident when I was preparing the series, my testing
was with x2apic_enabled() but I didn't test CPU hotplug - only the kdump path
with 32 bit guest. In hindsight, I should have been more careful with testing,
sorry about that.

Bandan

> which meant that whatever Bandan tested at that point was actually a
> complete no-op, since "!x2apic_enabled" is never true (it tests a
> function pointer against NULL, which it won't be).
>
> Then that was fixed by the time it hit -tip (and eventually my tree),
> but it kind of shows how the patch history of this is all
> questionable. Further strengthened by a quote from that discussion:
>
>  "this is really a KVM bug but it doesn't hurt to clear out the LDR in
> the guest and then, it wouldn't need a hypervisor fix"
>
> and clearly it *does* hurt to clear the LDR in the guest, making the
> whole thinking behind the patch wrong and broken. The kernel clearly
> _does_ depend on LDR having the right contents.
>
> Now, I still suspect the boot problem then comes from our
> cpu0_logical_apicid use mentioned in that previous email, but at this
> point I think the proper fix is "revert for now, and we can look at
> this as a cleanup with the cpu0_logical_apicid thing for 5.4 instead".
>
> Hmm?
>
>                    Linus
