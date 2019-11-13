Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDD9C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE0F206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8opMZ+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKMUkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:40:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbfKMUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573677641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqJoodJgp7wEriQoAnWcTOuFV3C+xVC1xkqGu7SmYlw=;
        b=S8opMZ+38O9+OVKq8sPZajn1qjAdwV55GjSLNoavIXhiltUpLwzepetRCMS/x1+BiwFfLj
        zHJnuJL/AL5xdSWGvx7JqpPWqv2OQBel2uTJJOw/GTgEWc9DHDqFTYwRA35JRAR7OU/MOd
        bmabiwk0n8uh9yO6l3z7BE5W7x30ayQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-8aF_1crwMu6jSfVuXqtvJw-1; Wed, 13 Nov 2019 15:40:40 -0500
Received: by mail-wr1-f72.google.com with SMTP id u2so2568447wrm.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 12:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aFGhnaJS91Vp3C1rTSputKgZM8q/556HTzVHxJjMdJo=;
        b=dMcJJzR3TPXVTzI3IWupD8GC3fhHFoX69Y8ZdBQNhGqoehyaOcohe6zBYSFJBETu/V
         QJ5CD33iQD47YjL1GyOQCnA7mNwOhKWSPym2WGNK//TEquATbiEKuacQ6aFvqdQxbo6N
         GnulnRmo1U8U9Z3CqdLEJ/BhG4JGi8K8jliUribkUvQLuDAxjemEdoNn1ciO1tuHMts5
         6B8L4kC+vjsBO46OmZK7qFoeXFub4tk3PqDVAmUfi35cBBHW0l9BMBmy2bTcOsnuN3d5
         yD1SMLdCAhHLdUq8PohNKVbgnvTwwjJhupWwTKafPTFCZPPNF/6ZXA/ela5/ytBA7soA
         2HEw==
X-Gm-Message-State: APjAAAWPmGxzruJfR4iFTsuoQUHF+kn0J4LT9smlF5GvB91cLexsEVi3
        4fySJoG+QnFTlrl0sVVzYn2RnmZfN57Vw3RSiNsyvzSfVpaqZsWAYnMaBGomJJ8co/h1OrFBaGn
        sLzeVnKiaJDjTEAk37gomyqVe
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr4520800wmj.159.1573677638935;
        Wed, 13 Nov 2019 12:40:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIVz5R/dRRvEBxH/A7ruE5SdIzCJG9Jc+dpCD6lzFPkSzA2vUC7/tHEIGoEDl8knCwbv/zxw==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr4520776wmj.159.1573677638637;
        Wed, 13 Nov 2019 12:40:38 -0800 (PST)
Received: from [192.168.3.122] (p5B0C63AB.dip0.t-ipconnect.de. [91.12.99.171])
        by smtp.gmail.com with ESMTPSA id h15sm4767080wrb.44.2019.11.13.12.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 12:40:38 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
Date:   Wed, 13 Nov 2019 21:40:37 +0100
Message-Id: <28CEC8B8-AC6A-4A13-B5A4-C47DB64B45E6@redhat.com>
References: <7B45B9B3-0947-459A-B4FD-9F6CB2F9EF3A@redhat.com>
Cc:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
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
        Junichi Nomura <j-nomura@ce.jp.nec.com>
In-Reply-To: <7B45B9B3-0947-459A-B4FD-9F6CB2F9EF3A@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: 8aF_1crwMu6jSfVuXqtvJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 13.11.2019 um 21:23 schrieb David Hildenbrand <david@redhat.com>:
>=20
> =EF=BB=BF
>=20
>>> Am 13.11.2019 um 21:10 schrieb Dan Williams <dan.j.williams@intel.com>:
>>>=20
>>> =EF=BB=BFOn Wed, Nov 13, 2019 at 11:53 AM David Hildenbrand <david@redh=
at.com> wrote:
>>>=20
>>>=20
>>>=20
>>>>> Am 13.11.2019 um 20:06 schrieb Dan Williams <dan.j.williams@intel.com=
>:
>>>>=20
>>>> =EF=BB=BFOn Wed, Nov 13, 2019 at 10:51 AM David Hildenbrand <david@red=
hat.com> wrote:
>>>>>=20
>>>>>> On 08.11.19 20:13, Dan Williams wrote:
>>>>>> On Thu, Nov 7, 2019 at 4:15 PM Toshiki Fukasawa
>>>>>> <t-fukasawa@vx.jp.nec.com> wrote:
>>>>>>>=20
>>>>>>> Currently, there is no way to identify pfn on ZONE_DEVICE.
>>>>>>> Identifying pfn on system memory can be done by using a
>>>>>>> section-level flag. On the other hand, identifying pfn on
>>>>>>> ZONE_DEVICE requires a subsection-level flag since ZONE_DEVICE
>>>>>>> can be created in units of subsections.
>>>>>>>=20
>>>>>>> This patch introduces a new bitmap subsection_dev_map so that
>>>>>>> we can identify pfn on ZONE_DEVICE.
>>>>>>>=20
>>>>>>> Also, subsection_dev_map is used to prove that struct pages
>>>>>>> included in the subsection have been initialized since it is
>>>>>>> set after memmap_init_zone_device(). We can avoid accessing
>>>>>>> pages currently being initialized by checking subsection_dev_map.
>>>>>>>=20
>>>>>>> Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
>>>>>>> ---
>>>>>>> include/linux/mmzone.h | 19 +++++++++++++++++++
>>>>>>> mm/memremap.c          |  2 ++
>>>>>>> mm/sparse.c            | 32 ++++++++++++++++++++++++++++++++
>>>>>>> 3 files changed, 53 insertions(+)
>>>>>>>=20
>>>>>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>>>>>> index bda2028..11376c4 100644
>>>>>>> --- a/include/linux/mmzone.h
>>>>>>> +++ b/include/linux/mmzone.h
>>>>>>> @@ -1174,11 +1174,17 @@ static inline unsigned long section_nr_to_p=
fn(unsigned long sec)
>>>>>>>=20
>>>>>>> struct mem_section_usage {
>>>>>>>       DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
>>>>>>> +#ifdef CONFIG_ZONE_DEVICE
>>>>>>> +       DECLARE_BITMAP(subsection_dev_map, SUBSECTIONS_PER_SECTION)=
;
>>>>>>> +#endif
>>>>>>=20
>>>>>> Hi Toshiki,
>>>>>>=20
>>>>>> There is currently an effort to remove the PageReserved() flag as so=
me
>>>>>> code is using that to detect ZONE_DEVICE. In reviewing those patches
>>>>>> we realized that what many code paths want is to detect online memor=
y.
>>>>>> So instead of a subsection_dev_map add a subsection_online_map. That
>>>>>> way pfn_to_online_page() can reliably avoid ZONE_DEVICE ranges. I
>>>>>> otherwise question the use case for pfn_walkers to return pages for
>>>>>> ZONE_DEVICE pages, I think the skip behavior when pfn_to_online_page=
()
>>>>>> =3D=3D false is the right behavior.
>>>>>=20
>>>>> To be more precise, I recommended an subsection_active_map, to indica=
te
>>>>> which memmaps were fully initialized and can safely be touched (e.g.,=
 to
>>>>> read the zone/nid). This map would also be set when the devmem memmap=
s
>>>>> were initialized (race between adding memory/growing the section and
>>>>> initializing the memmap).
>>>>>=20
>>>>> See
>>>>>=20
>>>>> https://lkml.org/lkml/2019/10/10/87
>>>>>=20
>>>>> and
>>>>>=20
>>>>> https://www.spinics.net/lists/linux-driver-devel/msg130012.html
>>>>=20
>>>> I'm still struggling to understand the motivation of distinguishing
>>>> "active" as something distinct from "online". As long as the "online"
>>>> granularity is improved from sections down to subsections then most
>>>> code paths are good to go. The others can use get_devpagemap() to
>>>> check for ZONE_DEVICE in a race free manner as they currently do.
>>>=20
>>> I thought we wanted to unify access if we don=E2=80=99t really care abo=
ut the zone as in most pfn walkers - E.g., for zone shrinking.
>>=20
>> Agree, when the zone does not matter, which is most cases, then
>> pfn_online() and pfn_valid() are sufficient.

Oh, and just to clarify why I proposed pfn_active(): The issue right now is=
 that a PFN that is valid but not online could be offline memory (memmap no=
t initialized) or ZONE_DEVICE. That=E2=80=98s why I wanted to have a way to=
 detect if a memmap was initialized, independent of the zone. That=E2=80=98=
s important for generic PFN walkers.

>>=20
>>> Anyhow, a subsection online map would be a good start, we can reuse tha=
t later for ZONE_DEVICE as well.
>>=20
>> Cool, good to go with me sending a patch to introduce pfn_online() and
>> a corresponding subsection_map for the same?
>=20
> Yeah, let=E2=80=98s see how this turns out and if we=E2=80=98re on the sa=
me page. Thanks!
>=20
>>=20
>=20

