Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BCFC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7AA205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOc/pTpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfLIUxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:53:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726408AbfLIUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575924780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJBASH3qoTGdWSdB+LrXLR7p2EO5j8Zhq+6mo6vrhH0=;
        b=YOc/pTpISDyGxrj+xe2wlK9aQ4q2aKjtT5OSkNHKYQpVataqJ5Nwg4B8O7oJ7pe06kunRi
        w6+uU+YWfjwFCwsomygSPvGJzCAz8lMwkSqbhEOaGYoMxEGqNGMvfdzm3/7hDvrsa41Z8/
        ZqdXfBBDPo7ARaAjIo6ScBhzjyH17pk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319--6ZnxKI4M3mmFNravhecog-1; Mon, 09 Dec 2019 15:52:58 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so8015679wrt.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NGEL1NSYmJ/OoSlxzf6M70RXjEhwqgGKnWSMvOS+jtM=;
        b=oJKMxMsr22wQzdOq29EFmOJRt00h/E55qxkY/YndQxyBmBpev7nEQplXjNFkFihZ27
         ZvVJGRLdzXbiEPjOJJd9F3+AGMZJgMzL0aSD9JZjlAGloHaoDVl4TmjBC3fAqcUsqYor
         /iBzWT6jw/LTKgYGn67ulYxmxx+JZghzLcUHLliGORnLXGIJlAImA0t7Aeql4raFGtjk
         eiJ/p2Ul2SbOpdf9cgjtlOaLyUb0m3u+B32gquGAFnmgPWw5ZP5iX7P2ciBvyzkZTYHC
         cJ5Tekwp2yBK3f2ifKhCbhLrJC5nweilgedSpZ2XXtwZXg5sgayLgeRCqyIBRF71GIfh
         gGDA==
X-Gm-Message-State: APjAAAWLhZyvBq1Zr6u/0PE1Co/cPxT3GygAlp1FdTxxVOMLdkaZr0IF
        q/Tuqxt3agREhm0in3DUl3G+NM81/SdV5iIK/++FuYcIfYrILFK+F318sy79wAUZ3A9C9Da97Kv
        op8OMhDkpScsQbaWqxgtMQk08
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr1076740wmf.136.1575924775716;
        Mon, 09 Dec 2019 12:52:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZrY86SAs9HX0pRhK9obPbaChosiTAnQWyc7+/5zfbpOwHVpMjKo7v99fnszsIjFo82bF44w==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr1076719wmf.136.1575924775493;
        Mon, 09 Dec 2019 12:52:55 -0800 (PST)
Received: from [192.168.3.122] (p5B0C63FA.dip0.t-ipconnect.de. [91.12.99.250])
        by smtp.gmail.com with ESMTPSA id d8sm726691wre.13.2019.12.09.12.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:52:54 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5/6] mm, memory_hotplug: Provide argument for the pgprot_t in arch_add_memory()
Date:   Mon, 9 Dec 2019 21:52:53 +0100
Message-Id: <F98E5D42-BD24-4A01-95EF-44329DDF8190@redhat.com>
References: <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>
In-Reply-To: <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: -6ZnxKI4M3mmFNravhecog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.12.2019 um 21:43 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Mon, Dec 9, 2019 at 12:24 PM Logan Gunthorpe <logang@deltatee=
.com> wrote:
>>=20
>>=20
>>=20
>>> On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
>>> On 09.12.19 20:13, Logan Gunthorpe wrote:
>>>> devm_memremap_pages() is currently used by the PCI P2PDMA code to crea=
te
>>>> struct page mappings for IO memory. At present, these mappings are cre=
ated
>>>> with PAGE_KERNEL which implies setting the PAT bits to be WB. However,=
 on
>>>> x86, an mtrr register will typically override this and force the cache
>>>> type to be UC-. In the case firmware doesn't set this register it is
>>>> effectively WB and will typically result in a machine check exception
>>>> when it's accessed.
>>>>=20
>>>> Other arches are not currently likely to function correctly seeing the=
y
>>>> don't have any MTRR registers to fall back on.
>>>>=20
>>>> To solve this, add an argument to arch_add_memory() to explicitly
>>>> set the pgprot value to a specific value.
>>>>=20
>>>> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a
>>>> simple change to pass the pgprot_t down to their respective functions
>>>> which set up the page tables. For x86_32, set the page tables explicit=
ly
>>>> using _set_memory_prot() (seeing they are already mapped). For sh, rej=
ect
>>>> anything but PAGE_KERNEL settings -- this should be fine, for now, see=
ing
>>>> sh doesn't support ZONE_DEVICE anyway.
>>>>=20
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>> ---
>>>> arch/arm64/mm/mmu.c            | 4 ++--
>>>> arch/ia64/mm/init.c            | 5 ++++-
>>>> arch/powerpc/mm/mem.c          | 4 ++--
>>>> arch/s390/mm/init.c            | 4 ++--
>>>> arch/sh/mm/init.c              | 5 ++++-
>>>> arch/x86/mm/init_32.c          | 7 ++++++-
>>>> arch/x86/mm/init_64.c          | 4 ++--
>>>> include/linux/memory_hotplug.h | 2 +-
>>>> mm/memory_hotplug.c            | 2 +-
>>>> mm/memremap.c                  | 2 +-
>>>> 10 files changed, 25 insertions(+), 14 deletions(-)
>>>>=20
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index 60c929f3683b..48b65272df15 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1050,7 +1050,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long =
addr)
>>>> }
>>>>=20
>>>> #ifdef CONFIG_MEMORY_HOTPLUG
>>>> -int arch_add_memory(int nid, u64 start, u64 size,
>>>> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
>>>>                     struct mhp_restrictions *restrictions)
>>>=20
>>> Can we fiddle that into "struct mhp_restrictions" instead?
>>=20
>> Yes, if that's what people want, it's pretty trivial to do. I chose not
>> to do it that way because it doesn't get passed down to add_pages() and
>> it's not really a "restriction". If I don't hear any objections, I will
>> do that for v2.
>=20
> +1 to storing this information alongside the altmap in that structure.
> However, I agree struct mhp_restrictions, with the MHP_MEMBLOCK_API
> flag now gone, has lost all of its "restrictions". How about dropping
> the 'flags' property and renaming the struct to 'struct
> mhp_modifiers'?
>=20

I=E2=80=98d prefer that over an arch_add_memory_protected() as suggested by=
 Michal. But if we can change it after adding the memory (as also suggested=
 by Michal), that would also be nice.

Cheers!

