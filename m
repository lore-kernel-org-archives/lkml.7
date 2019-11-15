Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFFCC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2B920729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtUCMld7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKOAqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:46:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726852AbfKOAqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573778781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4vVvPkB3x0L4WLxmAx03mTpE89in9HeN5HPv2q+2W8=;
        b=MtUCMld7fed/a9tfHhyd8rJaMEJuN3AnHe7A/hB/SViOV9TSfCTx8IP9tHcz/YcO4z8rI9
        85PS8yd0fYAjhxV6Bac805hH7tXvnuiW6DyDeaQMmCdYOisu2hbRhD5ccxBLVQpbX6GkKH
        QwwXxEWQEJ82gEzdkLDAZZFn/nPEU6o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-fGT2lxXgN9uDEucalTdP6Q-1; Thu, 14 Nov 2019 19:46:19 -0500
Received: by mail-wr1-f70.google.com with SMTP id 92so6557561wro.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 16:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=hLdCjTGec/dDjtDlx0ZJMfLMsCTDiljq7wYu4KUhWKQ=;
        b=B0XDNjlcSvqZ3QLE8RiAhvV5tckt2A4CLzOTCUnERtl6jJZOHB+En7CX5lc4Rqmzt5
         IlYjytS24F8rE1iF96wRtDbP1FqKQuH2sxUX985vd9nCOWwPHAfK+hs6KPSMcOZFgB52
         rMsLg6n1Y/JgcAvP1h6O+VTC+Re229LjxBxBeHXIdB/5cpgzjJP6bLDAMSNEX/smbxIm
         m8O8AeAGvP8RI0y482TU7gMxdDM2TRDwyT0VMQztXmMfy1RttPT1S/rRed8PpeCnXtqb
         YFZToRKvNfCSEka/Aes2on+K1VPVMUmX4IHZLibg8FVRdr6YrRcVErVU+1GZsu4mzS3q
         PzNA==
X-Gm-Message-State: APjAAAUAWfC1IUHdM8bdb+z4/rZJIkuAEenYaCplG96oiikKsAq1Ijko
        N/gqNE3K1OJOJQQqZYs736xRYvP8UW/cr0oe7bg/zHW77ICTj/jQrJE7bbQ8LKEW7/R8YnOXHQ+
        kQqWZm9Cl3LQnBgqxoHMO8+Bv
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr12937226wru.175.1573778777407;
        Thu, 14 Nov 2019 16:46:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXQUaXzjlPAig78IGNXSc6GbQ37rJNwRpHYq/LIj60+eqS82OLSF8ehfSXLPj2M9jNo4HTGQ==
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr12937195wru.175.1573778777125;
        Thu, 14 Nov 2019 16:46:17 -0800 (PST)
Received: from [192.168.3.122] (p4FF23EA2.dip0.t-ipconnect.de. [79.242.62.162])
        by smtp.gmail.com with ESMTPSA id 4sm8813753wmd.33.2019.11.14.16.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 16:46:16 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
Date:   Fri, 15 Nov 2019 01:46:15 +0100
Message-Id: <759F6C7C-C34F-433E-8909-DB76A626CF3F@redhat.com>
References: <49786b4d-ba95-21b5-c079-46d93c2fe53f@vx.jp.nec.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <49786b4d-ba95-21b5-c079-46d93c2fe53f@vx.jp.nec.com>
To:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: fGT2lxXgN9uDEucalTdP6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 15.11.2019 um 00:42 schrieb Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com=
>:
>=20
> =EF=BB=BFOn 2019/11/14 6:26, Dan Williams wrote:
>>> On Wed, Nov 13, 2019 at 1:22 PM David Hildenbrand <david@redhat.com> wr=
ote:
>>>=20
>>>=20
>>>=20
>>>> Am 13.11.2019 um 22:12 schrieb Dan Williams <dan.j.williams@intel.com>=
:
>>>>=20
>>>> =EF=BB=BFOn Wed, Nov 13, 2019 at 12:40 PM David Hildenbrand <david@red=
hat.com> wrote:
>>>> [..]
>>>>>>>>> I'm still struggling to understand the motivation of distinguishi=
ng
>>>>>>>>> "active" as something distinct from "online". As long as the "onl=
ine"
>>>>>>>>> granularity is improved from sections down to subsections then mo=
st
>>>>>>>>> code paths are good to go. The others can use get_devpagemap() to
>>>>>>>>> check for ZONE_DEVICE in a race free manner as they currently do.
>>>>>>>>=20
>>>>>>>> I thought we wanted to unify access if we don=E2=80=99t really car=
e about the zone as in most pfn walkers - E.g., for zone shrinking.
>>>>>>>=20
>>>>>>> Agree, when the zone does not matter, which is most cases, then
>>>>>>> pfn_online() and pfn_valid() are sufficient.
>>>>>=20
>>>>> Oh, and just to clarify why I proposed pfn_active(): The issue right =
now is that a PFN that is valid but not online could be offline memory (mem=
map not initialized) or ZONE_DEVICE. That=E2=80=98s why I wanted to have a =
way to detect if a memmap was initialized, independent of the zone. That=E2=
=80=98s important for generic PFN walkers.
>>>>=20
>>>> That's what I was debating with Toshiki [1], whether there is a real
>>>> example of needing to distinguish ZONE_DEVICE from offline memory in a
>>>> pfn walker. The proposed use case in this patch set of being able to
>>>> set hwpoison on ZONE_DEVICE pages does not seem like a good idea to
>>>> me. My suspicion is that this is a common theme and others are looking
>>>> to do these types page manipulations that only make sense for online
>>>> memory. If that is the case then treating ZONE_DEVICE as offline seems
>>>> the right direction.
>>>=20
>>> Right. At least it would be nice to have for zone shrinking - not sure =
about the other walkers. We would have to special-case ZONE_DEVICE handling=
 there.
>>>=20
>>=20
>> I think that's ok... It's already zone aware code whereas pfn walkers
>> are zone unaware and should stay that way if at all possible.
>>=20
>>> But as I said, a subsection map for online memory is a good start, espe=
cially to fix pfn_to_online_page(). Also, I think this might be a very good=
 thing to have for Oscars memmap-on-memory work (I have a plan in my head I=
 can discuss with Oscar once he has time to work on that again).
>>=20
>> Ok, I'll keep an eye out.
>=20
> I understand your point. Thanks!
>=20
> By the way, I found another problem about ZONE_DEVICE, which
> is race between memmap initialization and zone shrinking.
>=20
> Iteration of create and destroy namespace causes the panic as below:
>=20
> [   41.207694] kernel BUG at mm/page_alloc.c:535!
> [   41.208109] invalid opcode: 0000 [#1] SMP PTI
> [   41.208508] CPU: 7 PID: 2766 Comm: ndctl Not tainted 5.4.0-rc4 #6
> [   41.209064] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
> [   41.210175] RIP: 0010:set_pfnblock_flags_mask+0x95/0xf0
> [   41.210643] Code: 04 41 83 e2 3c 48 8d 04 a8 48 c1 e0 07 48 03 04 dd e=
0 59 55 bb 48 8b 58 68 48 39 da 73 0e 48 c7 c6 70 ac 11 bb e8 1b b2 fd ff <=
0f> 0b 48 03 58 78 48 39 da 73 e9 49 01 ca b9 3f 00 00 00 4f 8d 0c
> [   41.212354] RSP: 0018:ffffac0d41557c80 EFLAGS: 00010246
> [   41.212821] RAX: 000000000000004a RBX: 0000000000244a00 RCX: 000000000=
0000000
> [   41.213459] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb=
b1197dc
> [   41.214100] RBP: 000000000000000c R08: 0000000000000439 R09: 000000000=
0000059
> [   41.214736] R10: 0000000000000000 R11: ffffac0d41557b08 R12: ffff8be47=
5ea72b0
> [   41.215376] R13: 000000000000fa00 R14: 0000000000250000 R15: 00000000f=
ffc0bb5
> [   41.216008] FS:  00007f30862ab600(0000) GS:ffff8be57bc40000(0000) knlG=
S:0000000000000000
> [   41.216771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.217299] CR2: 000055e824d0d508 CR3: 0000000231dac000 CR4: 000000000=
00006e0
> [   41.217934] Call Trace:
> [   41.218225]  memmap_init_zone_device+0x165/0x17c
> [   41.218642]  memremap_pages+0x4c1/0x540
> [   41.218989]  devm_memremap_pages+0x1d/0x60
> [   41.219367]  pmem_attach_disk+0x16b/0x600 [nd_pmem]
> [   41.219804]  ? devm_nsio_enable+0xb8/0xe0
> [   41.220172]  nvdimm_bus_probe+0x69/0x1c0
> [   41.220526]  really_probe+0x1c2/0x3e0
> [   41.220856]  driver_probe_device+0xb4/0x100
> [   41.221238]  device_driver_attach+0x4f/0x60
> [   41.221611]  bind_store+0xc9/0x110
> [   41.221919]  kernfs_fop_write+0x116/0x190
> [   41.222326]  vfs_write+0xa5/0x1a0
> [   41.222626]  ksys_write+0x59/0xd0
> [   41.222927]  do_syscall_64+0x5b/0x180
> [   41.223264]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   41.223714] RIP: 0033:0x7f30865d0ed8
> [   41.224037] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 0=
0 f3 0f 1e fa 48 8d 05 45 78 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> [   41.225920] RSP: 002b:00007fffe5d30a78 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
> [   41.226608] RAX: ffffffffffffffda RBX: 000055e824d07f40 RCX: 00007f308=
65d0ed8
> [   41.227242] RDX: 0000000000000007 RSI: 000055e824d07f40 RDI: 000000000=
0000004
> [   41.227870] RBP: 0000000000000007 R08: 0000000000000007 R09: 000000000=
0000006
> [   41.228753] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000004
> [   41.229419] R13: 00007f30862ab528 R14: 0000000000000001 R15: 000055e82=
4d07f40
>=20
> While creating a namespace and initializing memmap, if you destroy the na=
mespace
> and shrink the zone, it will initialize the memmap outside the zone and
> trigger VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page) in
> set_pfnblock_flags_mask().

Does that happen with -next as well? There, we currently don=E2=80=98t shri=
nk the ZONE_DEVICE zone anymore.

>=20
> Thanks,
> Toshiki Fukasawa

