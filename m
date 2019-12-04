Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCDBC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E73206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KSg12ndI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfLDOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:54:57 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34786 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfLDOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:54:57 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so3152039qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VhtN6w8f3pAFcQOPcFVj26+n4AG9pW+AqI+0CrhF1WY=;
        b=KSg12ndIh9E3OIht1yFvbbmEtc8FFzzewpaSfmPIqXwlXeWvOymL97PMX/XzdfRlbr
         ssdo3mdWSCre7Rqcf8zB/S3lc82MUW0i10UrOzZfpSihfkcr7DVTzTjLhllcQ5HN3FnS
         dx+zGEpPHgYZJnR+ZbJfru1Id/k9igxNsd1qA0yR+IRtskJsNtJvXJJqcT22f+dhHTWr
         u4wDmt+y3OzqPWEWKthpgKnqNqm9wyekNxyc/zNRKT+l3fYxPdx2qa2gq2MbBHQPvU75
         LSmG0P16brd+GiDYbaaytEyTd/UMlJ+ro7/Qc0V5eATPEi7JH1FqZZ7Qp/b2oN6hpmL9
         8xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VhtN6w8f3pAFcQOPcFVj26+n4AG9pW+AqI+0CrhF1WY=;
        b=NjcqpyfutF96f+K2ZXyk0h7yPUUgiKJ3V3OJ/O+Hi6tu/LSLFhNexyviyMJuWEBNN/
         X2CNwk7rUQwHTpiNWRKDoVI2vr1aYKq49cBvdt+IN75y4ym3MBKeCFePQzXDbkgYgBbs
         zW8rJlC5Nhz1K+2w07Ce9caETGWaD8gmx7OPrcjNhFGUA2cWaM/hEIvX7GrMtmBqfzA0
         kdVwTYmbABx5S+bVgxlDARHu9ZaOr9S7+/VZkZ+ElqhBvEpo8dM/yz/c32Y4Uu7P87Ua
         TWquBFcD9qrKtqe7YY0GU108JC5tI/fTOoY0OG4gBvjHNRDHk//ImCT2oD7tTwOLJrW3
         LzAQ==
X-Gm-Message-State: APjAAAXnAbDcVJhPB5pj4dxLLyCEQGpIFWUM4jqZg33samUroLn3nhPy
        2dHd8MGnhfZtkoF09K5yi/bs8A==
X-Google-Smtp-Source: APXvYqzbyvSvXC4KIUt2KO2kzgGROo0QY8Fmwq3x8ulH4VJBTtydvOViz6rnhzz4/LfQ4aet+tQNiw==
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr2886839qvn.79.1575471296051;
        Wed, 04 Dec 2019 06:54:56 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y184sm3732454qkd.128.2019.12.04.06.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 06:54:55 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v15 00/23] Generic page walk and ptdump
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <911fac4a-2204-f994-a101-16a60fba12e8@redhat.com>
Date:   Wed, 4 Dec 2019 09:54:53 -0500
Cc:     Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FA196FD-3FCD-431A-AA3E-21BF00EA07DC@lca.pw>
References: <20191101140942.51554-1-steven.price@arm.com>
 <1572896147.5937.116.camel@lca.pw>
 <7B040741-EC8A-4CC0-964B-4046AE2E617A@lca.pw>
 <16da6118-ac4d-a165-6202-0731a776ac72@arm.com>
 <911fac4a-2204-f994-a101-16a60fba12e8@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 3, 2019, at 6:02 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 06.11.19 16:05, Steven Price wrote:
>> On 06/11/2019 13:31, Qian Cai wrote:
>>>=20
>>>=20
>>>> On Nov 4, 2019, at 2:35 PM, Qian Cai <cai@lca.pw> wrote:
>>>>=20
>>>> On Fri, 2019-11-01 at 14:09 +0000, Steven Price wrote:
>> [...]
>>>>> Changes since v14:
>>>>> =
https://lore.kernel.org/lkml/20191028135910.33253-1-steven.price@arm.com/
>>>>> * Switch walk_page_range() into two functions, the existing
>>>>>   walk_page_range() now still requires VMAs (and treats areas =
without a
>>>>>   VMA as a 'hole'). The new walk_page_range_novma() ignores VMAs =
and
>>>>>   will report the actual page table layout. This fixes the =
previous
>>>>>   breakage of /proc/<pid>/pagemap
>>>>> * New patch at the end of the series which reduces the 'level' =
numbers
>>>>>   by 1 to simplify the code slightly
>>>>> * Added tags
>>>>=20
>>>> Does this new version also take care of this boot crash seen with =
v14? Suppose
>>>> it is now breaking CONFIG_EFI_PGT_DUMP=3Dy? The full config is,
>>>>=20
>>>> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
>>>>=20
>>>=20
>>> V15 is indeed DOA here.
>>=20
>> Thanks for finding this, it looks like EFI causes issues here. The =
below fixes
>> this for me (booting in QEMU).
>>=20
>> Andrew: do you want me to send out the entire series again for this =
fix, or
>> can you squash this into mm-pagewalk-allow-walking-without-vma.patch?
>>=20
>> Thanks,
>>=20
>> Steve
>>=20
>> ---8<---
>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>> index c7529dc4f82b..70dcaa23598f 100644
>> --- a/mm/pagewalk.c
>> +++ b/mm/pagewalk.c
>> @@ -90,7 +90,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long =
addr, unsigned long end,
>>  			split_huge_pmd(walk->vma, pmd, addr);
>>  			if (pmd_trans_unstable(pmd))
>>  				goto again;
>> -		} else if (pmd_leaf(*pmd)) {
>> +		} else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {
>>  			continue;
>>  		}
>>=20
>> @@ -141,7 +141,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned =
long addr, unsigned long end,
>>  			split_huge_pud(walk->vma, pud, addr);
>>  			if (pud_none(*pud))
>>  				goto again;
>> -		} else if (pud_leaf(*pud)) {
>> +		} else if (pud_leaf(*pud) || !pud_present(*pud)) {
>>  			continue;
>>  		}
>>=20
>>=20
>=20
> Even with this fix, booting for me under QEMU fails. See
>=20
> =
https://lore.kernel.org/linux-mm/b7ce62f2-9a48-6e48-6685-003431e521aa@redh=
at.com/
>=20

Yes, for some reasons, this starts to crash on almost all arches here, =
so it might be worth
for Andrew to revert those in the meantime while allowing Steven to =
rework.

