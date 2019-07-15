Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB4DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7FD20838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfGORmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:42:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730235AbfGORmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:42:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31FDDAF0D;
        Mon, 15 Jul 2019 17:42:36 +0000 (UTC)
Subject: Re: [PATCH 0/2] Remove 32-bit Xen PV guest support
To:     Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20190715113739.17694-1-jgross@suse.com>
 <87y30zfe9z.fsf@linux.intel.com>
 <CALCETrUn=gho5Oug-yYvF2d1WYCe7gvtx+bXuhJ8LTjb9guvuA@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <35d93381-7517-5741-0b81-0839dd46a1fa@suse.com>
Date:   Mon, 15 Jul 2019 19:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CALCETrUn=gho5Oug-yYvF2d1WYCe7gvtx+bXuhJ8LTjb9guvuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 19:28, Andy Lutomirski wrote:
> On Mon, Jul 15, 2019 at 9:34 AM Andi Kleen <ak@linux.intel.com> wrote:
>>
>> Juergen Gross <jgross@suse.com> writes:
>>
>>> The long term plan has been to replace Xen PV guests by PVH. The first
>>> victim of that plan are now 32-bit PV guests, as those are used only
>>> rather seldom these days. Xen on x86 requires 64-bit support and with
>>> Grub2 now supporting PVH officially since version 2.04 there is no
>>> need to keep 32-bit PV guest support alive in the Linux kernel.
>>> Additionally Meltdown mitigation is not available in the kernel running
>>> as 32-bit PV guest, so dropping this mode makes sense from security
>>> point of view, too.
>>
>> Normally we have a deprecation period for feature removals like this.
>> You would make the kernel print a warning for some releases, and when
>> no user complains you can then remove. If a user complains you can't.
>>
> 
> As I understand it, the kernel rules do allow changes like this even
> if there's a complaint: this is a patch that removes what is
> effectively hardware support.  If the maintenance cost exceeds the
> value, then removal is fair game.  (Obviously we weight the value to
> preserving compatibility quite highly, but in this case, Xen dropped
> 32-bit hardware support a long time ago.  If the Xen hypervisor says
> that 32-bit PV guest support is deprecated, it's deprecated.)
> 
> That being said, a warning might not be a bad idea.  What's the
> current status of this in upstream Xen?

Xen still supports that.

We have asked downstream for their opinion about dropping 32-bit PV
guest support in the kernel about 1 year ago and the common answer was:
no problem, but for users still wanting 32 bit guests we should wait
until PVH support is available in all related products. Grub2 was the
last one missing and as grub2 has released a version with PVH support
I posted this small series now.


Juergen
