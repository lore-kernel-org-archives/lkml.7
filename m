Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12202C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDD0206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDZCAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:00:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfDZCAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:00:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9895C050003;
        Fri, 26 Apr 2019 02:00:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F02D1001DC7;
        Fri, 26 Apr 2019 01:59:58 +0000 (UTC)
From:   lijiang <lijiang@redhat.com>
Subject: Re: [PATCH 1/3 v2] x86/kexec: Do not map the kexec area as decrypted
 when SEV is active
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
References: <20190327053629.17935-1-lijiang@redhat.com>
 <20190327053629.17935-2-lijiang@redhat.com> <20190402103201.GF6826@zn.tnic>
Message-ID: <c25502b9-15bc-6ca3-f0d4-c0df5498e676@redhat.com>
Date:   Fri, 26 Apr 2019 09:59:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190402103201.GF6826@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 26 Apr 2019 02:00:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年04月02日 18:32, Borislav Petkov 写道:
> On Wed, Mar 27, 2019 at 01:36:27PM +0800, Lianbo Jiang wrote:
>> Currently, the arch_kexec_post_{alloc,free}_pages() unconditionally
>> maps the kexec area as decrypted. This works fine when SME is active.
>> Because in SME, the first kernel is loaded in decrypted area by the
>> BIOS, so the second kernel must be also loaded into the decrypted
>> memory.
>>
>> When SEV is active, the first kernel is loaded into the encrypted
>> area, so the second kernel must be also loaded into the encrypted
>> memory. Lets make sure that arch_kexec_post_{alloc,free}_pages()
>> does not clear the memory encryption mask from the kexec area when
>> SEV is active.
> 
> This commit message still doesn't explain the big picture why you want
> this change.
> 

When a virtual machine panic, we also need to dump its memory for analysis.
But, for the SEV virtual machine, the memory is encrypted. To support the
SEV kdump, these changes would be necessary, otherwise, it will not work.

Lets consider the following situations:

[1] How to load the images(kernel and initrd) when SEV is enabled in the
    first kernel?

    Based on the amd-memory-encryption.txt and SEV's patch series, the boot
    images must be encrypted before guest(VM) can be booted(Please see Secure
    Encrypted Virutualization Key Management 'Launching a guest(usage flow)').
    Naturally use the similar way to load the images(kernel and initrd) to the
    crash reserved areas, and these areas are encrypted when SEV is active.

    That is to say, when SEV is active in the first kernel, need to load the
    kernel and initrd to the encrypted areas, so i did the following changes:

    [a] Do not map the kexec area as decrypted when SEV is active.
        Currently, the arch_kexec_post_{alloc,free}_pages() unconditionally
        maps the kexec areas as decrypted. Obviously, for the SEV case, it can
        not work well, need to improve them. Please refer to the first patch
        in this patch series.

    [b] Set the C-bit in the identity map page table when SEV is active.
        Because the second kernel images(kernel and initrd) are loaded to the
        encrypted areas, in order to correctly access these encrypted memory(
        pages), need to set the C-bit in the identity mapping page table when
        kexec builds the identity mapping page table.

[2] How to dump the old memory in the second kernel?

    Here, it is similar to the SME kdump, if SEV was enabled in the first kernel,
    the old memory is also encrypted, the old memory has to be remapped with
    memory encryption mask in order to access it properly.

    [a] The ioremap_encrypted() is still necessary.
        Used to remap the old memory with memory encryption mask.

    [b] Enable dumping encrypted memory when SEV was active.
        Because the whole memory is encrypted in the first kernel when SEV is
        enabled, that is to say, the notes and elfcorehdr are also encrypted,
        and they are also saved to the encrypted memory. Following commit
        992b649a3f01 ("kdump, proc/vmcore: Enable kdumping encrypted memory with
        SME enabled"), both SME and SEV cases need to be considered and modified
        correctly. Please refer to the third patch in this patch series.


Hope this help. Thanks.

> And it must explain it because it might be all clear in your head now
> but months from now, you, we, all would've forgotten why this change was
> needed.
> 
> So pls add blurb that this whole effort is being done so that SEV VMs
> can kdump too. I.e., the 10000ft picture.
> 
> Anyone must be able to figure out *why* a change has been done just by
> doing git archeology. So make sure you explain it properly.
> 
> If unsure, try to put yourself in the shoes of some future kernel
> developer who is trying to find out why this change has been done. Now
> read the commit message you've written. Does it make any sense to him? I
> think not.
> 
> Do you catch my drift?
> 

Yes, understood, thank you.

So sorry for the delay, i am trying my best to explain it in detail.

Thanks.
Lianbo
