Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29E9C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D6321855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfI3KPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:15:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46105 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfI3KPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:15:05 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iEshl-0001TE-C1; Mon, 30 Sep 2019 04:14:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iEshk-0006yk-6u; Mon, 30 Sep 2019 04:14:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Baoquan He <bhe@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>
References: <20190920035326.27212-1-lijiang@redhat.com>
        <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
        <87r241piqg.fsf@x220.int.ebiederm.org>
        <20190928000505.GJ31919@MiWiFi-R3L-srv>
        <875zldp2vj.fsf@x220.int.ebiederm.org>
        <20190928030910.GA5774@MiWiFi-R3L-srv>
Date:   Mon, 30 Sep 2019 05:14:16 -0500
In-Reply-To: <20190928030910.GA5774@MiWiFi-R3L-srv> (Baoquan He's message of
        "Sat, 28 Sep 2019 11:09:10 +0800")
Message-ID: <87zhimks5j.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iEshk-0006yk-6u;;;mid=<87zhimks5j.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18YFFLyA+N4FL6xpIsFa9lIvrY4S/ueRr0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer when SME was active
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> On 09/27/19 at 09:32pm, Eric W. Biederman wrote:
>> Baoquan He <bhe@redhat.com> writes:
>> 
>> > On 09/27/19 at 03:49pm, Eric W. Biederman wrote:
>> >> Dave Young <dyoung@redhat.com> writes:
>> >> >> In order to avoid such problem, lets occupy the first 640k region when
>> >> >> SME is active, which will ensure that the allocated memory does not fall
>> >> >> into the first 640k area. So, no need to worry about whether kernel can
>> >> >> correctly copy the contents of the first 640K area to a backup region in
>> >> >> purgatory().
>> >> 
>> >> We must occupy part of the first 640k so that we can start up secondary
>> >> cpus unless someone has added another way to do that in recent years on
>> >> SME capable cpus.
>> >> 
>> >> Further there is Fimware/BIOS interaction that happens within those
>> >> first 640K.
>> >> 
>> >> Furthermore the kdump kernel needs to be able to read all of the memory
>> >> that the previous kernel could read.  Otherwise we can't get a crash
>> >> dump.
>> >> 
>> >> So I do not think ignoring the first 640K is the correct resolution
>> >> here.
>> >> 
>> >> > The log is too simple,  I know you did some other tries to fix this, but
>> >> > the patch log does not show why you can not correctly copy the 640k in
>> >> > current kdump code, in purgatory here.
>> >> >
>> >> > Also this patch seems works in your test, but still to see if other
>> >> > people can comment and see if it is safe or not, if any other risks
>> >> > other than waste the small chunk of memory.  If it is safe then kdump
>> >> > can just drop the backup logic and use this in common code instead of
>> >> > only do it for SME.
>> >> 
>> >> Exactly.
>> >> 
>> >> I think at best this avoids the symptoms, but does not give a reliable
>> >> crash dump.
>> >
>> > Sorry, didn't notice this comment at bottom.
>> >
>> > From code, currently the first 640K area is needed in two places.
>> > One is for 5-level trampoline during boot compressing stage, in
>> > find_trampoline_placement(). 
>> >
>> > The other is in reserve_real_mode(), as you mentioned, for application
>> > CPU booting.
>> >
>> > Only allow these two put data inside first 640K, then lock it done. It
>> > should not impact crash dump and parsing. And these two's content
>> > doesn't matter.
>> 
>> Do I understand correctly that the idea is that the kernel
>> that may crash will never touch these pages?  And that the reservation
>
> Thanks a lot for your comments, Eric.
>
> And yes. Except of the reserved real mode trampoline for secondary cpu if
> the trampoline is allocated in this area, it will be reused. We search area
> for real mode under 1M. Otherwise, the kernel that may crash will never
> touch these pages.
>
>> is not in the kernel that recovers from the crash?  That definitely
>
> You mean kdump kernel? Only the e820 reserved regions which are inserted
> into io_resource will be passed to kdump kernel, memblock reserved
> region is only seen by the present kernel.
>
> But for the content in first 640K, it's not erased, kdump kernel will
> ignore it and take it as a available memory resource into memory
> allocator.
>
>
>> needs a little better description.  I know it is not a lot on modern
>> systems but reserving an extra 1M of memory to avoid having to special
>> case it later seems in need of calling out.
>> 
>> I have an old system around that I think that 640K is about 25% of
>> memory.
>
> Understood. Basically 640K is wasted in this case. But we only do like
> this in SME case, a condition checking is added. And system with SME is
> pretty new model, it may not impact the old system.

The conditional really should be based on if we are reserving memory
for a kdump kernel.  AKA if crash_kernel=XXX is specified on the kernel
command line.

At which point I think it would be very reasonable to unconditionally
reserve the low 640k, and make the whole thing a non-issue.  This would
allow the kdump code to just not do anything special for any of the
weird special case.

It isn't perfect because we need a page or so used in the first kernel
for bootstrapping the secondary cpus, but that seems like the least of
evils.  Especially as no one will DMA to that memory.

So please let's just change what memory we reserve when crash_kernel is
specified.

>> How we interact with BIOS tables in the first 640k needs some
>> explanation.  Both in the first kernel and in the crash kernel.
>
> Yes, totally agree.
>
> Those BIOS tables have been reserved as e820 reserved regions and will
> be passed to kdump kernel for reusing. Memblock reserved 640K doesn't
> mean it will cover the whole [0, 640K) region, it only searches for
> available system RAM from memblock allocator.

Careful with that assumption.  My memory is that the e820 memory map
frequently fails to cover areas like the real mode interrupt descriptor
table at address 0.

Eric
