Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D41C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 11:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D56A2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 11:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qSx2IaXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfHQLMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 07:12:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38990 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 07:12:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id 125so6878065qkl.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hnyyRW//9ToVhTEfhUiVXZ2Yyj1FvnMmcd3JbCX3+aQ=;
        b=qSx2IaXwKkkJqUZtdP4/4hGRUvZuLmGzJrYSfyHP+BQVI9iOXx6sSWDiQfSrKSbq6N
         qGdTkuHrmmeCqp9HQT8H3oWfMn5wP2DSJC9bnhJ0+xfKaYpuhX3Jph0U9GL1kg3cssLL
         WdkqE9tPlgjvMu1uGES1PHvZxkq43kngKdySieo/p805oqWBDK/sBFlYjYhJCzjD3M3p
         t6w9+W0Cg8Qhw4wdE68A3ugfDEvvT8CuYSsStILA9kTP6lWx/megpx3NmcWHsJiTImRr
         jnoRinq51vUTVHqxfGKtsOBq6M2XsP69RWHfYY9UwhKkjSblW6GqxYHb01883zAUNjuI
         0vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hnyyRW//9ToVhTEfhUiVXZ2Yyj1FvnMmcd3JbCX3+aQ=;
        b=AcZC8fp5qejS/EmRt5p+Cu/GF0LjULbBqxS5cySWjzOTmeej3R5xgl3oJwtN5QUSXU
         GeoO3hrMov2L/F0KMmtlNC8KNb4WhhSG2BTd1AMRu8fXjUlcLS7127HLsylJU9vOGR2K
         co5f4GRjtp5VzPD6xnHyMidmH7dlqAUvE3EbhimgvRS704aIq4/NQZqiQejZw8XlirEt
         Bp51dKnc7eKBt0jULj0bo3gjZvLAw+zkD6BHsbnCqTE/3Xt2LYs7AauV90e+7ibeuv2/
         zlUjzqtFcQ5sdOc2zi/jGk4L27wqR58UN2wRhgYQgEmuXWkjO22iIcfQT72EWvcgIIdg
         E2hg==
X-Gm-Message-State: APjAAAWUfVyHGtWdqHTyUPF+ae1j3UOEE252nwV2c/vPmWFLPuairvVz
        G6I9J7s2n4M5AP7Q8gm8aWazEw==
X-Google-Smtp-Source: APXvYqyP1n6fzmK5Pi+fG/jVsWvFqk8Nk1ND3552uBk0xHltRjB/H7Sl53O0p4ngqNDVcYI95hSINg==
X-Received: by 2002:a37:8607:: with SMTP id i7mr3251078qkd.455.1566040365423;
        Sat, 17 Aug 2019 04:12:45 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s3sm1906595qkc.57.2019.08.17.04.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 04:12:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAPcyv4h9Y7wSdF+jnNzLDRobnjzLfkGLpJsML2XYLUZZZUPsQA@mail.gmail.com>
Date:   Sat, 17 Aug 2019 07:12:43 -0400
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7A04694-504D-4FB3-9864-03C2CBA3898E@lca.pw>
References: <1565991345.8572.28.camel@lca.pw>
 <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
 <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
 <CAPcyv4h9Y7wSdF+jnNzLDRobnjzLfkGLpJsML2XYLUZZZUPsQA@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 16, 2019, at 11:57 PM, Dan Williams <dan.j.williams@intel.com> =
wrote:
>=20
> On Fri, Aug 16, 2019 at 8:34 PM Qian Cai <cai@lca.pw> wrote:
>>=20
>>=20
>>=20
>>> On Aug 16, 2019, at 5:48 PM, Dan Williams <dan.j.williams@intel.com> =
wrote:
>>>=20
>>> On Fri, Aug 16, 2019 at 2:36 PM Qian Cai <cai@lca.pw> wrote:
>>>>=20
>>>> Every so often recently, booting Intel CPU server on linux-next =
triggers this
>>>> warning. Trying to figure out if  the commit 7cc7867fb061
>>>> ("mm/devm_memremap_pages: enable sub-section remap") is the culprit =
here.
>>>>=20
>>>> # ./scripts/faddr2line vmlinux devm_memremap_pages+0x894/0xc70
>>>> devm_memremap_pages+0x894/0xc70:
>>>> devm_memremap_pages at mm/memremap.c:307
>>>=20
>>> Previously the forced section alignment in devm_memremap_pages() =
would
>>> cause the implementation to never violate the =
KASAN_SHADOW_SCALE_SIZE
>>> (12K on x86) constraint.
>>>=20
>>> Can you provide a dump of /proc/iomem? I'm curious what resource is
>>> triggering such a small alignment granularity.
>>=20
>> This is with memmap=3D4G!4G ,
>>=20
>> # cat /proc/iomem
> [..]
>> 100000000-155dfffff : Persistent Memory (legacy)
>>  100000000-155dfffff : namespace0.0
>> 155e00000-15982bfff : System RAM
>>  155e00000-156a00fa0 : Kernel code
>>  156a00fa1-15765d67f : Kernel data
>>  157837000-1597fffff : Kernel bss
>> 15982c000-1ffffffff : Persistent Memory (legacy)
>> 200000000-87fffffff : System RAM
>=20
> Ok, looks like 4G is bad choice to land the pmem emulation on this
> system because it collides with where the kernel is deployed and gets
> broken into tiny pieces that violate kasan's. This is a known problem
> with memmap=3D. You need to pick an memory range that does not collide
> with anything else. See:
>=20
>    =
https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel_par=
ameter_for_pmem_on_your_system
>=20
> ...for more info.

Well, it seems I did exactly follow the information in that link,

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000093fff] =
usable
[    0.000000] BIOS-e820: [mem 0x0000000000094000-0x000000000009ffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005a7a0fff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000005a7a1000-0x000000005b5e0fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x000000005b5e1000-0x00000000790fefff] =
usable
[    0.000000] BIOS-e820: [mem 0x00000000790ff000-0x00000000791fefff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000791ff000-0x000000007b5fefff] =
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007b5ff000-0x000000007b7fefff] =
ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007b7ff000-0x000000007b7fffff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000007b800000-0x000000008fffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fffffff] =
usable

Where 4G is good. Then,

[    0.000000] user-defined physical RAM map:
[    0.000000] user: [mem 0x0000000000000000-0x0000000000093fff] usable
[    0.000000] user: [mem 0x0000000000094000-0x000000000009ffff] =
reserved
[    0.000000] user: [mem 0x00000000000e0000-0x00000000000fffff] =
reserved
[    0.000000] user: [mem 0x0000000000100000-0x000000005a7a0fff] usable
[    0.000000] user: [mem 0x000000005a7a1000-0x000000005b5e0fff] =
reserved
[    0.000000] user: [mem 0x000000005b5e1000-0x00000000790fefff] usable
[    0.000000] user: [mem 0x00000000790ff000-0x00000000791fefff] =
reserved
[    0.000000] user: [mem 0x00000000791ff000-0x000000007b5fefff] ACPI =
NVS
[    0.000000] user: [mem 0x000000007b5ff000-0x000000007b7fefff] ACPI =
data
[    0.000000] user: [mem 0x000000007b7ff000-0x000000007b7fffff] usable
[    0.000000] user: [mem 0x000000007b800000-0x000000008fffffff] =
reserved
[    0.000000] user: [mem 0x00000000ff800000-0x00000000ffffffff] =
reserved
[    0.000000] user: [mem 0x0000000100000000-0x00000001ffffffff] =
persistent (type 12)
[    0.000000] user: [mem 0x0000000200000000-0x000000087fffffff] usable

The doc did mention that =E2=80=9CThere seems to be an issue with =
CONFIG_KSAN at the moment however.=E2=80=9D
without more detail though.=
