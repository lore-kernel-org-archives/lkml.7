Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0477AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D776921841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfGXRGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:06:15 -0400
Received: from foss.arm.com ([217.140.110.172]:44042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGXRGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:06:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464CE28;
        Wed, 24 Jul 2019 10:06:14 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 769E73F71F;
        Wed, 24 Jul 2019 10:06:12 -0700 (PDT)
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
 DMA masks
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
 <20190724155530.hlingpcirjcf2ljg@box>
 <acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a89e7574-096d-9105-45ff-34bbb74918a5@arm.com>
Date:   Wed, 24 Jul 2019 18:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2019 17:42, Lendacky, Thomas wrote:
> On 7/24/19 10:55 AM, Kirill A. Shutemov wrote:
>> On Wed, Jul 10, 2019 at 07:01:19PM +0000, Lendacky, Thomas wrote:
>>> @@ -351,6 +355,32 @@ bool sev_active(void)
>>>   }
>>>   EXPORT_SYMBOL(sev_active);
>>>   
>>> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>>> +bool force_dma_unencrypted(struct device *dev)
>>> +{
>>> +	/*
>>> +	 * For SEV, all DMA must be to unencrypted addresses.
>>> +	 */
>>> +	if (sev_active())
>>> +		return true;
>>> +
>>> +	/*
>>> +	 * For SME, all DMA must be to unencrypted addresses if the
>>> +	 * device does not support DMA to addresses that include the
>>> +	 * encryption mask.
>>> +	 */
>>> +	if (sme_active()) {
>>> +		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>>> +		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>>> +						dev->bus_dma_mask);
>>> +
>>> +		if (dma_dev_mask <= dma_enc_mask)
>>> +			return true;
>>
>> Hm. What is wrong with the dev mask being equal to enc mask? IIUC, it
>> means that device mask is wide enough to cover encryption bit, doesn't it?
> 
> Not really...  it's the way DMA_BIT_MASK works vs bit numbering. Let's say
> that sme_me_mask has bit 47 set. __ffs64 returns 47 and DMA_BIT_MASK(47)
> will generate a mask without bit 47 set (0x7fffffffffff). So the check
> will catch anything that does not support at least 48-bit DMA.

Couldn't that be expressed as just:

	if (sme_me_mask & dma_dev_mask == sme_me_mask)

?

Robin.
