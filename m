Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B416C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109A2206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFn5J4BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKMVWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:22:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31925 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726162AbfKMVWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573680172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEzo2vwLZjPjo79V3NSCv0uzS6NnVJqYYive5MQEnio=;
        b=IFn5J4BQGstHAilmoUaU1H7yBECcjHRSvnoNvTV9LvrPNvSgd6Do1yQu84YtD4ZiHypvCf
        l1DEh7UTJJR59qniP3rLJBuTzun4TFTcm6gwizVRCwUZIK3Y8wJtq1vNKINd3VXl8sIpC2
        hjGnnSeg8YP05FjLuz9MrBr4HE12Y1M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-bK-t2AwVPKOFHLTPZYw9Tw-1; Wed, 13 Nov 2019 16:22:51 -0500
Received: by mail-wr1-f69.google.com with SMTP id g17so2720408wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0M1Zgy0vxFoFP5/tV9MR/RlrQo4XZunSomplfBOMFgs=;
        b=FMxxx4JTfUgnzHEl/i9fbFMniXHj1qdQa3Phq5Wk+RphFMF6RT4BL+q9z43EhgbrXS
         cizXRIwWVdV47l3yYPFXECVg5stlan7lPAebyEgiPdqkJmJM3wZR2wayYIyy+jrbBhiP
         zsMpsQNVMcCXUBE/Ovh8R+HXhzqOI+hWtZF/zrAhfogxcOGaMH7h5smZ4UBo3VijneeI
         PWkP/x4YhMnN501Nr/Ik/fxnIMaKIzB4yNXccBs+352+309T+NKM69nbfdvlj9EKX0vo
         kjEMFn7L6nOll5LNaOcoobggWNGmUcKmuXvObyexkAN51d6OFiLn0V0N/1KQjsn4trM5
         FLgQ==
X-Gm-Message-State: APjAAAUxT7VGEs5bzfIup7uu+h+uQgr76x4ekmr/NEqh+tBAKBzCosdC
        wQ+AMKupbYaReOEH6T8c2eM6RW3aXoTOzin+ITURHf1Mvi+6p5apsb08NGCb5wW030W028tP4iH
        XN37YCz0oaRlxXkUU3B1k24+F
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr5024145wmc.113.1573680170400;
        Wed, 13 Nov 2019 13:22:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEVgBlG4P7CSVjUC2mczFP5f7xAgjTp5OSlvHE+YRruvah5qetSi7fIBN/9yaK/Yq8atTG/Q==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr5024113wmc.113.1573680170187;
        Wed, 13 Nov 2019 13:22:50 -0800 (PST)
Received: from [192.168.3.122] (p5B0C63AB.dip0.t-ipconnect.de. [91.12.99.171])
        by smtp.gmail.com with ESMTPSA id j11sm4207776wrq.26.2019.11.13.13.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:22:49 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
Date:   Wed, 13 Nov 2019 22:22:48 +0100
Message-Id: <3E71366A-9232-46BB-8261-3FCB2300C80A@redhat.com>
References: <CAPcyv4gpN8kbh1i6jCDdC2OP41G3C2+7YD4rYz-3HaD_pufvyg@mail.gmail.com>
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
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <CAPcyv4gpN8kbh1i6jCDdC2OP41G3C2+7YD4rYz-3HaD_pufvyg@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: bK-t2AwVPKOFHLTPZYw9Tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 13.11.2019 um 22:12 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Wed, Nov 13, 2019 at 12:40 PM David Hildenbrand <david@redhat=
.com> wrote:
> [..]
>>>>>> I'm still struggling to understand the motivation of distinguishing
>>>>>> "active" as something distinct from "online". As long as the "online=
"
>>>>>> granularity is improved from sections down to subsections then most
>>>>>> code paths are good to go. The others can use get_devpagemap() to
>>>>>> check for ZONE_DEVICE in a race free manner as they currently do.
>>>>>=20
>>>>> I thought we wanted to unify access if we don=E2=80=99t really care a=
bout the zone as in most pfn walkers - E.g., for zone shrinking.
>>>>=20
>>>> Agree, when the zone does not matter, which is most cases, then
>>>> pfn_online() and pfn_valid() are sufficient.
>>=20
>> Oh, and just to clarify why I proposed pfn_active(): The issue right now=
 is that a PFN that is valid but not online could be offline memory (memmap=
 not initialized) or ZONE_DEVICE. That=E2=80=98s why I wanted to have a way=
 to detect if a memmap was initialized, independent of the zone. That=E2=80=
=98s important for generic PFN walkers.
>=20
> That's what I was debating with Toshiki [1], whether there is a real
> example of needing to distinguish ZONE_DEVICE from offline memory in a
> pfn walker. The proposed use case in this patch set of being able to
> set hwpoison on ZONE_DEVICE pages does not seem like a good idea to
> me. My suspicion is that this is a common theme and others are looking
> to do these types page manipulations that only make sense for online
> memory. If that is the case then treating ZONE_DEVICE as offline seems
> the right direction.

Right. At least it would be nice to have for zone shrinking - not sure abou=
t the other walkers. We would have to special-case ZONE_DEVICE handling the=
re.

But as I said, a subsection map for online memory is a good start, especial=
ly to fix pfn_to_online_page(). Also, I think this might be a very good thi=
ng to have for Oscars memmap-on-memory work (I have a plan in my head I can=
 discuss with Oscar once he has time to work on that again).


>=20
> [1]: https://lore.kernel.org/linux-mm/CAPcyv4joVDwiL21PPyJ7E_mMFR2SL3QTi0=
9VMtfxb_W+-1p8vQ@mail.gmail.com/
>=20

