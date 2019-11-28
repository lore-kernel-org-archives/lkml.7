Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36EAC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FCE21775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6mA1/La"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfK1KZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:25:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59498 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbfK1KZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574936733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rw/Z1WNwE0fQEgH1sv3/zJ1Nx0wUIiBPaXjZPkBKb4s=;
        b=W6mA1/La/GIwdEu6CnnWG9GKiBxEWqJsln9tnSUFVD0npjeWy7y58jMjur7aQBnkTb50+u
        +10kmEEKytbwlcgaYLfVbtG/0V3ACNjufUag3UYCCXUadUdzRRTUTrdw3R1bysmh2S8k+K
        IY3ZocJNDUdYfhBR1MmWXOdRtKu9sQw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Pccz79Q7P5SI0WwE8vnp4g-1; Thu, 28 Nov 2019 05:25:31 -0500
Received: by mail-wm1-f70.google.com with SMTP id l23so3525571wmh.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=OJBkLA3P+RwpZfnKrgFiiyed5FQIvT6v7F5xZZrt+VQ=;
        b=sAvGWMZ88B3OXD/mgWC8J57c53It/PUG+rW6KpTku+OMx6Q9uWUYQN9G/NKwkohbz4
         R2reeHa14nEDSH/yyanuaBovSxJQXRdryrFUMqF3cYyFdRRFkBrCtTmnSfM8jWwMn7jS
         TgpSORSOmZYmRqQN9Kfv5MWdlL3pqru4Fh/WOGnfjqfCt2rlP96agHfJkdI0cS/Q4Fyy
         RtaKfMuwEcLwSmHLTsIGcKiHLYKUHUM5OrmsfQLE8idvGb2Yq1o9gDzeIxwKjk3bZSXb
         fApt8+T5hbVmvnlYLV+B2L1IiNofBQe+u5G2TfInmbMK0IEAxYj7bDqnkpWZEeUAHDtx
         5HQA==
X-Gm-Message-State: APjAAAUMEsugeGbbawHTrg/hbhUK8s1JG+kl4IYHLh5+70Q3rDARRvw9
        JNZxVJMMFRhMx5hSL9rHBehvc4hvxWQxSK8gJV+KNAOG1rJpxi4ortqazRAM5ns14n1NZ7dYF0u
        otYi+WKpDYtASYWl+8znFnwmV
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr8454204wmj.106.1574936729733;
        Thu, 28 Nov 2019 02:25:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAXhqrHgLGp5/jEnLPb9QoqBHuvd0KKT1/UCjphh1rtgV28fsjozDraIqPBr4PgeTQGg3fYA==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr8454173wmj.106.1574936729504;
        Thu, 28 Nov 2019 02:25:29 -0800 (PST)
Received: from ?IPv6:2a01:598:b889:7f36:a401:5177:c4ae:d2ba? ([2a01:598:b889:7f36:a401:5177:c4ae:d2ba])
        by smtp.gmail.com with ESMTPSA id u135sm4609065wmu.20.2019.11.28.02.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 02:25:28 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] drivers/base/node.c: get rid of get_nid_for_pfn()
Date:   Thu, 28 Nov 2019 11:25:28 +0100
Message-Id: <5E2F5866-0605-4DD2-9AEA-4B1C44E57D9F@redhat.com>
References: <20191128102051.GI26807@dhcp22.suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20191128102051.GI26807@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: Pccz79Q7P5SI0WwE8vnp4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 28.11.2019 um 11:20 schrieb Michal Hocko <mhocko@kernel.org>:
>=20
> =EF=BB=BFOn Wed 27-11-19 18:41:26, David Hildenbrand wrote:
>> Since commit d84f2f5a7552 ("drivers/base/node.c: simplify
>> unregister_memory_block_under_nodes()") we only have a single user of
>> get_nid_for_pfn(). Let's just inline that code and get rid of
>> get_nid_for_pfn().
>>=20
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> I am not really sure this is an improvement. The code is ugly as hell
> and open coding it just makes register_mem_sect_under_node harder to
> read.

The issue I see is that this is a dangerous wrapper for pfn_to_nid() that i=
s absolutely not obvious. The old second user on the memory removal path wa=
s completely buggy. IMHO nobody should be reusing that function. But it loo=
ks like a general =E2=80=9Esafe wrapper to get a nid=E2=80=9C - it=E2=80=98=
s not.

How can we make that more obvious instead?

>=20
> If anything get_nid_for_pfn deserves a comment why
> CONFIG_DEFERRED_STRUCT_PAGE_INIT calls for special case as
> early_pfn_to_nid is not bound to that config (it is defined when
> CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID || CONFIG_HAVE_MEMBLOCK_NODE_MAP
>=20
>> ---
>> drivers/base/node.c | 23 +++++++----------------
>> 1 file changed, 7 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 98a31bafc8a2..735073fd2926 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -744,17 +744,6 @@ int unregister_cpu_under_node(unsigned int cpu, uns=
igned int nid)
>> }
>>=20
>> #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
>> -static int __ref get_nid_for_pfn(unsigned long pfn)
>> -{
>> -    if (!pfn_valid_within(pfn))
>> -        return -1;
>> -#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> -    if (system_state < SYSTEM_RUNNING)
>> -        return early_pfn_to_nid(pfn);
>> -#endif
>> -    return pfn_to_nid(pfn);
>> -}
>> -
>> /* register memory section under specified node if it spans that node */
>> static int register_mem_sect_under_node(struct memory_block *mem_blk,
>>                     void *arg)
>> @@ -766,8 +755,6 @@ static int register_mem_sect_under_node(struct memor=
y_block *mem_blk,
>>    unsigned long pfn;
>>=20
>>    for (pfn =3D start_pfn; pfn <=3D end_pfn; pfn++) {
>> -        int page_nid;
>> -
>>        /*
>>         * memory block could have several absent sections from start.
>>         * skip pfn range from absent section
>> @@ -784,11 +771,15 @@ static int register_mem_sect_under_node(struct mem=
ory_block *mem_blk,
>>         * block belong to the same node.
>>         */
>>        if (system_state =3D=3D SYSTEM_BOOTING) {
>> -            page_nid =3D get_nid_for_pfn(pfn);
>> -            if (page_nid < 0)
>> +            if (!pfn_valid_within(pfn))
>>                continue;
>> -            if (page_nid !=3D nid)
>> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> +            if (early_pfn_to_nid(pfn) !=3D nid)
>>                continue;
>> +#else
>> +            if (pfn_to_nid(pfn) !=3D nid)
>> +                continue;
>> +#endif
>>        }
>>=20
>>        /*
>> --=20
>> 2.21.0
>=20
> --=20
> Michal Hocko
> SUSE Labs
>=20

