Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A70DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856DA206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsEJcWhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfKMTxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:53:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21840 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726105AbfKMTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573674791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MEZe/+riaKWWgzlw7jcQYCyEgNa9CVg1SPE1zIFaNk=;
        b=HsEJcWhPI0DQl6SzluY8nDb9c/UgaO5YxcODIuSrfyrmQs9XeRbYMoqiornKDtl5ftri7d
        0Oejr4Ez+S1h1+6Oof6C5hKQiPfA+Yi0wELpMqVx8FYXehq1pkV8IlrHNJp5iTi9Z+YXN8
        c4yARYRmBYmLdj7vxyOj7twJhkfp/7M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-VIs7R7E4PJGaem_RxMq2Cg-1; Wed, 13 Nov 2019 14:53:10 -0500
Received: by mail-wr1-f71.google.com with SMTP id m17so2384303wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 11:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ok38/P723sbPOaUuOpDY2d+ZI7DWUOYaW5BG9HjNV9M=;
        b=WIvSBphVYMoDusnbFamV3EmwZ79hVc5mby5VDwM0r9+VNvCQ9idrCnBmujaO0SOMUX
         ZA0VbCb7ieux4dOLuYBelbD543DLXckvc3r2nn6dt1mD/SLocS5JLubG7WxT1aTqiLRF
         8QGBxjXRdfz25TXo3FDLEnPQAYKQxcIEPyxVwf0r2mOmtmGrO74TSd/yZpCTDOjUH7l8
         9bk94houpNVQIECHqbpf16q5aqDILccpVX0cPif3hEauAuY0QZMkAC9zO0ptPO+60BQ0
         FZF77vMuZKcPSiqdHi8RvEeEmioKntPG9JAodFW7w20dswflttR+9uTA4w9lNJK118tW
         R3ow==
X-Gm-Message-State: APjAAAXmdwab3e6ciDPwvtIzJW+ccBhtBhrbho+b8OuUm/5U7ZLTzoQ9
        b1WJv4pZ9EwMMeLkk/X2l/NPXXQq6h/krfagTxc11t63Gli+jNk9lzG+Ust3oQlDL0g+rxkzd0h
        jaom0fVwGWdKsOkyrlERXJ13k
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr4323439wrj.391.1573674788836;
        Wed, 13 Nov 2019 11:53:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqznSAtgTKLoMbNgQ8n4TlniRE9luwNn4b4oqGJvjQkOTmPh6os1j+Qp9koqEVn5ssbxWiVwGA==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr4323417wrj.391.1573674788578;
        Wed, 13 Nov 2019 11:53:08 -0800 (PST)
Received: from [192.168.3.122] (p5B0C63AB.dip0.t-ipconnect.de. [91.12.99.171])
        by smtp.gmail.com with ESMTPSA id 65sm5315300wrs.9.2019.11.13.11.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 11:53:08 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
Date:   Wed, 13 Nov 2019 20:53:06 +0100
Message-Id: <6193C847-F09C-439A-81EE-98A59473D582@redhat.com>
References: <CAPcyv4iPk4bzOCE=7Eq8w-jwUuOXzZP9F=+RcxjqdXCn0SC01A@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
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
In-Reply-To: <CAPcyv4iPk4bzOCE=7Eq8w-jwUuOXzZP9F=+RcxjqdXCn0SC01A@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: VIs7R7E4PJGaem_RxMq2Cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 13.11.2019 um 20:06 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Wed, Nov 13, 2019 at 10:51 AM David Hildenbrand <david@redhat=
.com> wrote:
>>=20
>>> On 08.11.19 20:13, Dan Williams wrote:
>>> On Thu, Nov 7, 2019 at 4:15 PM Toshiki Fukasawa
>>> <t-fukasawa@vx.jp.nec.com> wrote:
>>>>=20
>>>> Currently, there is no way to identify pfn on ZONE_DEVICE.
>>>> Identifying pfn on system memory can be done by using a
>>>> section-level flag. On the other hand, identifying pfn on
>>>> ZONE_DEVICE requires a subsection-level flag since ZONE_DEVICE
>>>> can be created in units of subsections.
>>>>=20
>>>> This patch introduces a new bitmap subsection_dev_map so that
>>>> we can identify pfn on ZONE_DEVICE.
>>>>=20
>>>> Also, subsection_dev_map is used to prove that struct pages
>>>> included in the subsection have been initialized since it is
>>>> set after memmap_init_zone_device(). We can avoid accessing
>>>> pages currently being initialized by checking subsection_dev_map.
>>>>=20
>>>> Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
>>>> ---
>>>>  include/linux/mmzone.h | 19 +++++++++++++++++++
>>>>  mm/memremap.c          |  2 ++
>>>>  mm/sparse.c            | 32 ++++++++++++++++++++++++++++++++
>>>>  3 files changed, 53 insertions(+)
>>>>=20
>>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>>> index bda2028..11376c4 100644
>>>> --- a/include/linux/mmzone.h
>>>> +++ b/include/linux/mmzone.h
>>>> @@ -1174,11 +1174,17 @@ static inline unsigned long section_nr_to_pfn(=
unsigned long sec)
>>>>=20
>>>>  struct mem_section_usage {
>>>>         DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
>>>> +#ifdef CONFIG_ZONE_DEVICE
>>>> +       DECLARE_BITMAP(subsection_dev_map, SUBSECTIONS_PER_SECTION);
>>>> +#endif
>>>=20
>>> Hi Toshiki,
>>>=20
>>> There is currently an effort to remove the PageReserved() flag as some
>>> code is using that to detect ZONE_DEVICE. In reviewing those patches
>>> we realized that what many code paths want is to detect online memory.
>>> So instead of a subsection_dev_map add a subsection_online_map. That
>>> way pfn_to_online_page() can reliably avoid ZONE_DEVICE ranges. I
>>> otherwise question the use case for pfn_walkers to return pages for
>>> ZONE_DEVICE pages, I think the skip behavior when pfn_to_online_page()
>>> =3D=3D false is the right behavior.
>>=20
>> To be more precise, I recommended an subsection_active_map, to indicate
>> which memmaps were fully initialized and can safely be touched (e.g., to
>> read the zone/nid). This map would also be set when the devmem memmaps
>> were initialized (race between adding memory/growing the section and
>> initializing the memmap).
>>=20
>> See
>>=20
>> https://lkml.org/lkml/2019/10/10/87
>>=20
>> and
>>=20
>> https://www.spinics.net/lists/linux-driver-devel/msg130012.html
>=20
> I'm still struggling to understand the motivation of distinguishing
> "active" as something distinct from "online". As long as the "online"
> granularity is improved from sections down to subsections then most
> code paths are good to go. The others can use get_devpagemap() to
> check for ZONE_DEVICE in a race free manner as they currently do.

I thought we wanted to unify access if we don=E2=80=99t really care about t=
he zone as in most pfn walkers - E.g., for zone shrinking. Anyhow, a subsec=
tion online map would be a good start, we can reuse that later for ZONE_DEV=
ICE as well.

>=20
>> I dislike a map that is specific to ZONE_DEVICE or (currently)
>> !ZONE_DEVICE. I rather want an indication "this memmap is safe to
>> touch". As discussed along the mentioned threads, we can combine this
>> later with RCU to handle some races that are currently possible.
>=20
> The rcu protection is independent of the pfn_active vs pfn_online
> distinction afaics.

It=E2=80=99s one part of the bigger picture IMHO.

>=20

