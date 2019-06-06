Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC884C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27B920866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3f5O+mY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfFFC2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:28:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40211 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfFFC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:28:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so415548pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 19:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=vWAlFHQ/Rrwtr/A4rfYJEqxN6pUodZ8syzv7A3oUv4U=;
        b=W3f5O+mYovybXZ0cWbChvth6/AY3jkzYaOlepyIP9hCfzq6OYLALpA+X9naH7Cze9A
         ggGtfZY7rD6baamWDhRmTjrHdAewf4yosvvRBEXcTizE9uOAW0S6B6wpjI+fm8sSO99o
         neyN+kj46xZ2iNO0Ag1ECTmBpA6EjmeUjRRLBRZxPzPlGv0DPGQPoPCPGyVt/OzGD+Jl
         aCkVtz5D24PwTMCpdbOUxseN9+MJ7cGDGPkFOAXEp8ukMlttTv+M6JmQ1UBphJM+oJbq
         gQ0PUNw+slBhhmOLsrIUocZn+vrCv/neMon1aDQpxxt8NMOEhg+T/CUiyTCTzJi9IPu3
         t/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=vWAlFHQ/Rrwtr/A4rfYJEqxN6pUodZ8syzv7A3oUv4U=;
        b=p6uVMcRGcF7tT7MnE51Zfq5m9WHZWXJ/70MBkZD6bKVMuwSLuJsgbhEfmSDKGcSNdB
         INvNMsss9z2dDgg6Ty4DdCn4DC2Zj3sCx7Bn75aq4CtL0jY3uIFIBbfW0Y9F67ZZEe5j
         l6mYPBPcUFoC9HSfwa18PPdhZ+jsVMfOjI++H4FsoraM9evgtDeLGvsL0rVrNf5g3q7K
         xXzg18YJPleaZL5pUwmN+pNtSrfJkXhHzyokp+mXIpBSqBUWUWffwQz6noMlzG2Y9jVg
         LTtHJMcylf6M8ywR3MRE3B1MQ9vlF9g8Dnv1I0G+LBJwXiHTRIM0wBe9YtLSFkE7VpHW
         AP9A==
X-Gm-Message-State: APjAAAX9JjWaGJIGqcN6Y2mDffGjyhIG7tPCttoSG07xFY00JaTgQCVJ
        g9LPo30WJzdw25OiZv75+i8=
X-Google-Smtp-Source: APXvYqx3xvyhgYWL2BWoGcvR62aeVOfjNKcGFt+gjNY6c0YN6ruFIe+mrxqm/7JN3W/ANWl9JfROlw==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr970348pgi.7.1559788088441;
        Wed, 05 Jun 2019 19:28:08 -0700 (PDT)
Received: from localhost (193-116-78-124.tpgi.com.au. [193.116.78.124])
        by smtp.gmail.com with ESMTPSA id x28sm275357pfo.78.2019.06.05.19.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 19:28:07 -0700 (PDT)
Date:   Thu, 06 Jun 2019 12:27:01 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] mm/large system hash: use vmalloc for size >
 MAX_ORDER when !hashdist
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190605144814.29319-1-npiggin@gmail.com>
        <20190605142209.eb30cd883551a5bd81b09f00@linux-foundation.org>
In-Reply-To: <20190605142209.eb30cd883551a5bd81b09f00@linux-foundation.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1559787457.x4yxr4e2tw.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton's on June 6, 2019 7:22 am:
> On Thu,  6 Jun 2019 00:48:13 +1000 Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> The kernel currently clamps large system hashes to MAX_ORDER when
>> hashdist is not set, which is rather arbitrary.
>>=20
>> vmalloc space is limited on 32-bit machines, but this shouldn't
>> result in much more used because of small physical memory limiting
>> system hash sizes.
>>=20
>> Include "vmalloc" or "linear" in the kernel log message.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>=20
>> This is a better solution than the previous one for the case of !NUMA
>> systems running on CONFIG_NUMA kernels, we can clear the default
>> hashdist early and have everything allocated out of the linear map.
>>=20
>> The hugepage vmap series I will post later, but it's quite
>> independent from this improvement.
>>=20
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7966,6 +7966,7 @@ void *__init alloc_large_system_hash(const char *t=
ablename,
>>  	unsigned long log2qty, size;
>>  	void *table =3D NULL;
>>  	gfp_t gfp_flags;
>> +	bool virt;
>> =20
>>  	/* allow the kernel cmdline to have a say */
>>  	if (!numentries) {
>> @@ -8022,6 +8023,7 @@ void *__init alloc_large_system_hash(const char *t=
ablename,
>> =20
>>  	gfp_flags =3D (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOM=
IC;
>>  	do {
>> +		virt =3D false;
>>  		size =3D bucketsize << log2qty;
>>  		if (flags & HASH_EARLY) {
>>  			if (flags & HASH_ZERO)
>> @@ -8029,26 +8031,26 @@ void *__init alloc_large_system_hash(const char =
*tablename,
>>  			else
>>  				table =3D memblock_alloc_raw(size,
>>  							   SMP_CACHE_BYTES);
>> -		} else if (hashdist) {
>> +		} else if (get_order(size) >=3D MAX_ORDER || hashdist) {
>>  			table =3D __vmalloc(size, gfp_flags, PAGE_KERNEL);
>> +			virt =3D true;
>>  		} else {
>>  			/*
>>  			 * If bucketsize is not a power-of-two, we may free
>>  			 * some pages at the end of hash table which
>>  			 * alloc_pages_exact() automatically does
>>  			 */
>> -			if (get_order(size) < MAX_ORDER) {
>> -				table =3D alloc_pages_exact(size, gfp_flags);
>> -				kmemleak_alloc(table, size, 1, gfp_flags);
>> -			}
>> +			table =3D alloc_pages_exact(size, gfp_flags);
>> +			kmemleak_alloc(table, size, 1, gfp_flags);
>>  		}
>>  	} while (!table && size > PAGE_SIZE && --log2qty);
>> =20
>>  	if (!table)
>>  		panic("Failed to allocate %s hash table\n", tablename);
>> =20
>> -	pr_info("%s hash table entries: %ld (order: %d, %lu bytes)\n",
>> -		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size);
>> +	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
>> +		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
>> +		virt ? "vmalloc" : "linear");
>=20
> Could remove `bool virt' and use is_vmalloc_addr() in the printk?
>=20

It can run before mem_init() and it looks like some archs set
VMALLOC_START/END (high_memory) there (e.g., x86-32, ppc32).

Thanks,
Nick

=
