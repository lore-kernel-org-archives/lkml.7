Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11032C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDF62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfCYOXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:23:41 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:26019 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfCYOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:23:41 -0400
X-IronPort-AV: E=Sophos;i="5.60,269,1549929600"; 
   d="scan'208";a="81726615"
Subject: Re: [Xen-devel] [PATCH] xen/pv: Add PV specific legacy_pic struct to
 expose legacy IRQs.
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
References: <1553025739-92245-1-git-send-email-jennifer.herbert@citrix.com>
 <2eb1fdec-6cc0-7f62-3d4f-adc5dba9971e@oracle.com>
 <5C93CEB7.9030701@citrix.com>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Jennifer Herbert <Jennifer.Herbert@citrix.com>
Message-ID: <5C98E468.1050502@citrix.com>
Date:   Mon, 25 Mar 2019 14:23:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <5C93CEB7.9030701@citrix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/19 17:49, Jennifer Herbert wrote:
>
>
> On 19/03/19 23:06, Boris Ostrovsky wrote:
>> On 3/19/19 4:02 PM, Jennifer Herbert wrote:
>>> The ACPI tables doesn't always contain all IRQs for legacy devices
>>> such as RTC.  Since no PIC controller is visible for a PV linux guest,
>>> under Xen, legacy_pic currently defaults to the null_legacy_pic - with
>>> reports no legacy IRQs.  Since the commit "rtc: cmos: Do not assume
>>> irq 8 for rtc when there are no legacy irqs" by Hans de Goede
>>> (commit id: a1e23a42f1bdc00e32fc4869caef12e4e6272f26), the rtc now
>>> incorrectly decides it has no irq it can use, for some hardware.
>>>
>>> This patch rectifies the problem by providing a xen legacy_pic
>>> struct, which is much like the null_legacy_pic except that it
>>> reports NR_IRQS_LEGACY irqs.
>> I assume this is for dom0?
>>
>> Could there be the same problem with PVH dom0? (and if yes then this
>> should probably go into arch/x86/xen/enlighten.c).
>>
>> -boris
>>
>
> I am doing this to fix a problem with dom0.  DomU doesn't seem to have 
> an RTC, and so it is unaffected.
>
> I'm not familiar with PVH, but have now done some experiments. The RTC 
> on PVH seems broken - but not quite in the same way as PV. More 
> research is needed, however simply doing the same trick I did with PV 
> will not fix the issue.
>
> I'll look further into it.
>

The same problem does exist with PVH - however its worse with the 
presence of the IO-APIC, as with my patch it tries to set up with IRQ, 
and fails.  I'm not sure how would be best to deal with this.
However, the RTC seems broken even for machines without the ACPI omission.
I can see fixing it for just PV doesn't seem too nice, but unsure how to 
fix this for PVH.  I'm open to suggestions, but otherwise I'll put this 
on hold.



