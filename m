Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8A6C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5C021537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="X/rImEl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFNB3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 21:29:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38685 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfFNB3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 21:29:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so698097qtl.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 18:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H/vGo7QOX7QpyBvTXnkYe2yXFtuFZ4oDrsLjFnJuZHg=;
        b=X/rImEl35Oahiwt5WAxEWA8Ooo/G4IiYNzGx8xpFy37/bV7Flvr0QAhLOOeL3AIVhe
         1y5BPOVnUXFBusIUYg+P/JgavbyK7hDqOMseShNlrlKt4yCBWBuF7QF2NhCO2fLl7Grp
         XVrPbS7WwMx08WovV2pWAPIELN4ixJE3dAaHd28TpHdjICAU73ZZtl1VaQTSZOZmeCL4
         Wh1LZNu7mpVKSGU/q9ahdI7e+6IdYyWtI0lwXvn1zcFGm6KxDM2Ne4y9PfsdRu1JugCT
         cFKMEZ06sRt1hukQT/dZW0GBtWsbE9sFzkmXFK4x86+/DUWVmixJ+DCO4b1q5L/mVsRr
         PTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H/vGo7QOX7QpyBvTXnkYe2yXFtuFZ4oDrsLjFnJuZHg=;
        b=CAzsBR3DhygUXlQWk/mSjDeeNvFlYjFa2sLiLb3L5Ch25YsNwRc2TuxWAYxN6jC5Im
         rimRfLcybKVH8OqNJ2SJZMgWDOW47QROJJgw048FDzUze7GoMNg3fkkqxWzu8XTjU7Ed
         ucp79/A6plQqXRSbeWS+RLzviIkbe8reHrw1TNHw+wQ+q3ALSAgwBBw+Ngyir/u9Iml8
         327gG3RvLEgKlFTfok9NFGtCsKVij+IVYQc4YhwQOzaTEBj3x3fpCqZ/wrYghyJ1euCe
         K5eGmCPjHrLccwuwpmnPtukmoYElom1gNU4Bpvn3fc5crQU4ZlyPokYt6skNhXZXfRg1
         SkpQ==
X-Gm-Message-State: APjAAAWuU3qjYEBZ70Ol6EHT4/3fLTJM2DcuLFz1i0Uak4eCzJvFxoM6
        vcYhlk+5IuqJK1oLCSTxOwxxGPy5wvo=
X-Google-Smtp-Source: APXvYqzKfvNHJxoWJ3SyH77lNcIGaU1SSr4XDrqiAHxdxp7pu79pATBF5ERe9UWmUqjToIz4L9GqOg==
X-Received: by 2002:ac8:7a73:: with SMTP id w19mr57545290qtt.292.1560475791653;
        Thu, 13 Jun 2019 18:29:51 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g5sm1068845qta.77.2019.06.13.18.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:29:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAPcyv4hYfDtRHF-i0dNzo=ffQk6qnrasRwkVfAVnwgWj0PJ4jg@mail.gmail.com>
Date:   Thu, 13 Jun 2019 21:29:50 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EB9D196-7552-43DF-A273-875EA6729EF9@lca.pw>
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
 <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <1560451362.5154.14.camel@lca.pw>
 <CAPcyv4hYfDtRHF-i0dNzo=ffQk6qnrasRwkVfAVnwgWj0PJ4jg@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 13, 2019, at 9:17 PM, Dan Williams <dan.j.williams@intel.com> =
wrote:
>=20
> On Thu, Jun 13, 2019 at 11:42 AM Qian Cai <cai@lca.pw> wrote:
>>=20
>> On Wed, 2019-06-12 at 12:37 -0700, Dan Williams wrote:
>>> On Wed, Jun 12, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
>>>>=20
>>>> The linux-next commit "mm/sparsemem: Add helpers track active =
portions
>>>> of a section at boot" [1] causes a crash below when the first =
kmemleak
>>>> scan kthread kicks in. This is because kmemleak_scan() calls
>>>> pfn_to_online_page(() which calls pfn_valid_within() instead of
>>>> pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=3Dn.
>>>>=20
>>>> The commit [1] did add an additional check of pfn_section_valid() =
in
>>>> pfn_valid(), but forgot to add it in the above code path.
>>>>=20
>>>> page:ffffea0002748000 is uninitialized and poisoned
>>>> raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff =
ffffffffffffffff
>>>> raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff =
ffffffffffffffff
>>>> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>>> ------------[ cut here ]------------
>>>> kernel BUG at include/linux/mm.h:1084!
>>>> invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
>>>> CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ =
#6
>>>> Hardware name: Lenovo ThinkSystem SR530 =
-[7X07RCZ000]-/-[7X07RCZ000]-,
>>>> BIOS -[TEE113T-1.00]- 07/07/2017
>>>> RIP: 0010:kmemleak_scan+0x6df/0xad0
>>>> Call Trace:
>>>> kmemleak_scan_thread+0x9f/0xc7
>>>> kthread+0x1d2/0x1f0
>>>> ret_from_fork+0x35/0x4
>>>>=20
>>>> [1] https://patchwork.kernel.org/patch/10977957/
>>>>=20
>>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>>> ---
>>>> include/linux/memory_hotplug.h | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>=20
>>>> diff --git a/include/linux/memory_hotplug.h =
b/include/linux/memory_hotplug.h
>>>> index 0b8a5e5ef2da..f02be86077e3 100644
>>>> --- a/include/linux/memory_hotplug.h
>>>> +++ b/include/linux/memory_hotplug.h
>>>> @@ -28,6 +28,7 @@
>>>>        unsigned long ___nr =3D pfn_to_section_nr(___pfn);           =
\
>>>>                                                                   \
>>>>        if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
>>>> +           pfn_section_valid(__nr_to_section(___nr), pfn) &&      =
\
>>>>            pfn_valid_within(___pfn))                              \
>>>>                ___page =3D pfn_to_page(___pfn);                     =
\
>>>>        ___page;                                                   \
>>>=20
>>> Looks ok to me:
>>>=20
>>> Acked-by: Dan Williams <dan.j.williams@intel.com>
>>>=20
>>> ...but why is pfn_to_online_page() a multi-line macro instead of a
>>> static inline like all the helper routines it invokes?
>>=20
>> Sigh, probably because it is a mess over there.
>>=20
>> memory_hotplug.h and mmzone.h are included each other. Converted it =
directly to
>> a static inline triggers compilation errors because mmzone.h was =
included
>> somewhere else and found pfn_to_online_page() needs things like
>> pfn_valid_within() and online_section_nr() etc which are only defined =
later in
>> mmzone.h.
>=20
> Ok, makes sense I had I assumed it was something horrible like that.
>=20
> Qian, can you send more details on the reproduction steps for the
> failures you are seeing? Like configs and platforms you're testing.
> I've tried enabling kmemleak and offlining memory and have yet to
> trigger these failures. I also have a couple people willing to help me
> out with tracking down the PowerPC issue, but I assume they need some
> help with the reproduction as well.

https://github.com/cailca/linux-mm

You can see the configs for each arch there. It was reproduced on =
several x86 NUMA bare-metal machines HPE, Lenovo etc either Intel or =
AMD. Check the =E2=80=9Ctest.sh=E2=80=9D, there is a part to do =
offline/online will reproduce it.

The powerpc is IBM 8335-GTC (ibm,witherspoon) POWER9 which is a NUMA =
PowerNV platform.=
