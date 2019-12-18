Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B25DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E3B206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfLRPk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:40:26 -0500
Received: from ns.iliad.fr ([212.27.33.1]:60876 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfLRPkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:40:25 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1A7FE20425;
        Wed, 18 Dec 2019 16:40:23 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id F3C5D202EC;
        Wed, 18 Dec 2019 16:40:22 +0100 (CET)
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <CY4PR1201MB012059FF6735C3EDB7E1F8E9A1530@CY4PR1201MB0120.namprd12.prod.outlook.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <bff4c4ad-de8f-7229-1d16-7ea67e066f65@free.fr>
Date:   Wed, 18 Dec 2019 16:40:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CY4PR1201MB012059FF6735C3EDB7E1F8E9A1530@CY4PR1201MB0120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Dec 18 16:40:23 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 15:20, Alexey Brodkin wrote:

> On 17/12/2019 16:30, Marc Gonzalez wrote:
> 
>> Commit a66d972465d15 ("devres: Align data[] to ARCH_KMALLOC_MINALIGN")
>> increased the alignment of devres.data unconditionally.
>>
>> Some platforms have very strict alignment requirements for DMA-safe
>> addresses, e.g. 128 bytes on arm64. There, struct devres amounts to:
>> 	3 pointers + pad_to_128 + data + pad_to_256
>> i.e. ~220 bytes of padding.
> 
> Could you please elaborate a bit on mentioned paddings?
> I may understand the first one for 128 bytes but where does the
> second one for 256 bytes come from?

Sure thing.

struct devres {
	struct devres_node node;
	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
};

struct devres_node = 3 pointers
kmalloc dishes out memory in multiples of ARCH_KMALLOC_MINALIGN bytes.
On arm64, ARCH_KMALLOC_MINALIGN = 128
(Everything written below assumes ARCH_KMALLOC_MINALIGN = 128)

In alloc_dr() we request sizeof(struct devres) + sizeof(data) from kmalloc.
sizeof(struct devres) = 128 because of the alignment directive.
I.e. the 'data' field is automatically padded to 128 by the compiler.

For most devm allocs (non-devm_kmalloc allocs), data is just 1 or 2 pointers.
So kmalloc(128 + 16) allocates 256 bytes.

>> Let's enforce the alignment only for devm_kmalloc().
> 
> Ok so for devm_kmalloc() we don't change anything, right?
> We still add the same padding before real data array.

(My commit message probably requires improvement & refining.)

Yes, the objective of my patch is to keep the same behavior for
devm_kmalloc() while reverting to the old behavior for all other
uses of struct devres.


>> I had not been aware that dynamic allocation granularity on arm64 was
>> 128 bytes. This means there's a lot of waste on small allocations.
> 
> Now probably I'm missing something but when do you expect to save something?
> If those smaller allocations are done with devm_kmalloc() you aren't
> saving anything.

With my patch, a "non-kmalloc" struct devres would take 128 bytes, instead
of 256.

>> I suppose there's no easy solution, though.
> 
> Right! It took a while till I was able to propose something
> people [almost silently] agreed with.

I meant the wider subject of dynamic allocation granularity.

The 128-byte requirement is only for DMA. Some (most?) uses of kmalloc
are not for DMA. If the user could provide a flag ("this is to be used
for DMA") we could save lots of memory for small non-DMA allocs.


>> +#define DEVM_KMALLOC_PADDING_SIZE \
>> +	(ARCH_KMALLOC_MINALIGN - sizeof(struct devres) % ARCH_KMALLOC_MINALIGN)
> 
> Even given your update with:
> ------------------------------->8--------------------------------
> #define DEVM_KMALLOC_PADDING_SIZE \
>   ((ARCH_KMALLOC_MINALIGN - sizeof(struct devres)) % ARCH_KMALLOC_MINALIGN)
> ------------------------------->8--------------------------------
> I don't think I understand why do you need that "% ARCH_KMALLOC_MINALIGN" part?

To handle the case where sizeof(struct devres) > ARCH_KMALLOC_MINALIGN

e.g ARCH_KMALLOC_MINALIGN = 8 and sizeof(struct devres) = 12


>> +	/* Add enough padding to provide a DMA-safe address */
>> +	size += DEVM_KMALLOC_PADDING_SIZE;
> 
> This implementation gets ugly and potentially will lead to problems later
> when people will start changing code here. Compared to that initially aligned by
> the compiler dr->data looks much more foolproof.

Yes, it's better to let the compiler handle the padding... But, we don't
want any padding in the non-devm_kmalloc use-case.

We could add a pointer to the data field, but arches with small ARCH_KMALLOC_MINALIGN
will have to pay the size increase, which doesn't seem fair to them (x86, amd64).


>> @@ -822,7 +825,7 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
>>  	 */
>>  	set_node_dbginfo(&dr->node, "devm_kzalloc_release", size);
>>  	devres_add(dev, dr->data);
>> -	return dr->data;
>> +	return dr->data + DEVM_KMALLOC_PADDING_SIZE;
> 
> Ditto. But first I'd like to understand what are you trying to really do
> with your change and then we'll see if there could be any better implementation.

Basically, every call to devres_alloc() or devm_add_action() allocates
256 bytes instead of 128. A typical arm64 system will call these
thousands of times during driver probe.

Regards.
