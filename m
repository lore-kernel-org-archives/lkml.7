Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A053ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F7320872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="JYU0GE2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfIKIHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:07:18 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:41402 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:07:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 940063F40C;
        Wed, 11 Sep 2019 10:07:10 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=JYU0GE2U;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 84x-f4TQbqt3; Wed, 11 Sep 2019 10:07:09 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id CEA633F226;
        Wed, 11 Sep 2019 10:07:07 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 580ED3600A6;
        Wed, 11 Sep 2019 10:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568189227; bh=u/h97ZxeSEeN+yEKNAxoghUNzv548g//K2qNiA3G/3E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JYU0GE2UbuYtgGD3cjPHNxIXKN1E7kVW5BBDtVrGQKyWC02Hy1mkNKgu9OjqkmueD
         2L2uJ2VLmT+9gtoRVx2yBKDQj8fsBdBHO/l3np7t9Y3Bs1UHxfSR2s9m0DT1MNapHi
         tRR2GXnjArabrzm1C1HVoLBlYWs8uJ8p+LRqZ++Y=
Subject: Re: [PATCH 0/2] Fix SEV user-space mapping of unencrypted coherent
 memory
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20190910133542.64523-1-thomas_os@shipmail.org>
 <20190911055913.GB104115@gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <e50cc9fc-4c3e-90c7-1139-f414766b648f@shipmail.org>
Date:   Wed, 11 Sep 2019 10:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190911055913.GB104115@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 7:59 AM, Ingo Molnar wrote:
> * Thomas Hellström (VMware) <thomas_os@shipmail.org> wrote:
>
>> With SEV and sometimes with SME encryption, The dma api coherent memory is
>> typically unencrypted, meaning the linear kernel map has the encryption
>> bit cleared. However, default page protection returned from vm_get_page_prot()
>> has the encryption bit set. So to compute the correct page protection we need
>> to clear the encryption bit.
>>
>> Also, in order for the encryption bit setting to survive across do_mmap() and
>> mprotect_fixup(), We need to make pgprot_modify() aware of it and not touch it.
>> Therefore make sme_me_mask part of _PAGE_CHG_MASK and make sure
>> pgprot_modify() preserves also cleared bits that are part of _PAGE_CHG_MASK,
>> not just set bits. The use of pgprot_modify() is currently quite limited and
>> easy to audit.
>>
>> (Note that the encryption status is not logically encoded in the pfn but in
>> the page protection even if an address line in the physical address is used).
>>
>> The patchset has seen some sanity testing by exporting dma_pgprot() and
>> using it in the vmwgfx mmap handler with SEV enabled.
>>
>> Changes since:
>> RFC:
>> - Make sme_me_mask port of _PAGE_CHG_MASK rather than using it by its own in
>>    pgprot_modify().
> Could you please add a "why is this patch-set needed", not just describe
> the "what does this patch set do"? I've seen zero discussion in the three
> changelogs of exactly why we'd want this, which drivers and features are
> affected and in what way, etc.
>
> It's called a "fix" but doesn't explain what bad behavior it fixes.
>
> Thanks,
>
> 	Ingo

I'll update the changelog to be more clear about that.

Thanks,

Thomas


