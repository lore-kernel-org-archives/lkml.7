Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD55C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F5120715
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnfFvHfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfK0TGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:06:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbfK0TGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574881559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPK1uKbvCdfloKioaMzTiu8Ub2ENTVhi00J6YfIG22A=;
        b=JnfFvHfrYdgcKnbOWT1JvWTj2sGrmxVK4zeyFKgAufDskElMZpoKJYjjTxoC1HZg1HEYm0
        kjxTGP5LcMDq39pl3KzbQhyTnc3sq8CVo1rKO4OLdlkYPQ8sZO/2e1/rOLKfk0kJxcYwF9
        UBDkeiIWrPyO1xaZwL19mCTRQ6LhdpM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-6BkLmYrGPlamD1eFVeRUvA-1; Wed, 27 Nov 2019 14:05:56 -0500
Received: by mail-wr1-f70.google.com with SMTP id e3so12572877wrs.17
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=N+mx2v5Qhmct9j+TWX3Bk8z8S7DDXof1/IQjLkrr1bY=;
        b=rXEdvfEfriTZq+2bCHCk5DWI1e8Jv4rvWS/nHb+oZB8RevZgFm9tlc4NaZzgrNvQqX
         eLteTiZ2830+CGRv1ab9cg0YElxihQrzW2aDssJ9+d+qXxf7zmeHmUZs3RyRQk/UjNRQ
         w5uf56+RptO7Q7UcQVajPGCpZ3Juv792PJbeVd+kD3+UqkrY7UOPX2UXojtKQ2oXRJGW
         z1hrnuauTM13LjmoQpGNTxmCEEO9Vu4jhAn0L+uFitJw6O8R3TETBnFxFtBpSSZFmVO3
         vSaVTVyagBYXAAxN6k+KPoic2Z7nocMkCQaFC50C2nD+3QLWmrS/05cyzTPj8hR6nRGY
         HgMQ==
X-Gm-Message-State: APjAAAU2n7K9buPKeT7e+wXNCQUj9kyPStWJBf6kZPbi3CHQLBBXxQSf
        /vTO9q7sdrgMm30ITWcliECPDW1yYcJkOXcqwjS2VmoqNJrvh9nBTQsGohCvY/0tzloe4npUawu
        eExq7RVqrrzb0iMCKj/FgWSG7
X-Received: by 2002:adf:e94e:: with SMTP id m14mr45434443wrn.233.1574881555430;
        Wed, 27 Nov 2019 11:05:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzS3GD0yCu0lPMXf7TJ3jsw4UEOG2LnCGqBp/mJt19sZ8lSVW7CRB+bzWsy9O6DezolcMRjCw==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr45434430wrn.233.1574881555252;
        Wed, 27 Nov 2019 11:05:55 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6355.dip0.t-ipconnect.de. [91.12.99.85])
        by smtp.gmail.com with ESMTPSA id g74sm7515055wme.5.2019.11.27.11.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 11:05:54 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Wed, 27 Nov 2019 20:05:52 +0100
Message-Id: <1F8C5EE3-4F07-4B23-9612-25FA265557C5@redhat.com>
References: <74CE315E-319F-4D2D-8276-7F89293286CF@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <74CE315E-319F-4D2D-8276-7F89293286CF@lca.pw>
To:     Qian Cai <cai@lca.pw>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: 6BkLmYrGPlamD1eFVeRUvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 27.11.2019 um 20:03 schrieb Qian Cai <cai@lca.pw>:
>=20
> =EF=BB=BF
>=20
>> On Nov 27, 2019, at 12:42 PM, David Hildenbrand <david@redhat.com> wrote=
:
>>=20
>> Now that we always check against a zone, we can stop checking against
>> the nid, it is implicitly covered by the zone.
>>=20
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> mm/memory_hotplug.c | 23 ++++++++---------------
>> 1 file changed, 8 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 46b2e056a43f..602f753c662c 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -344,17 +344,14 @@ int __ref __add_pages(int nid, unsigned long pfn, =
unsigned long nr_pages,
>> }
>>=20
>> /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
>> -static unsigned long find_smallest_section_pfn(int nid, struct zone *zo=
ne,
>> -                     unsigned long start_pfn,
>> -                     unsigned long end_pfn)
>> +static unsigned long find_smallest_section_pfn(struct zone *zone,
>> +                           unsigned long start_pfn,
>> +                           unsigned long end_pfn)
>> {
>>   for (; start_pfn < end_pfn; start_pfn +=3D PAGES_PER_SUBSECTION) {
>>       if (unlikely(!pfn_to_online_page(start_pfn)))
>>           continue;
>>=20
>> -        if (unlikely(pfn_to_nid(start_pfn) !=3D nid))
>> -            continue;
>=20
> Are you sure? I thought this is to check against machines with odd layout=
s, no?=20

The zone pointer is unique for every node. (in contrast to the zone index).

Thanks!

>=20
>            /*
>             * Nodes's pfns can be overlapping.
>             * We know some arch can have a nodes layout such as
>             * -------------pfn-------------->
>             * N0 | N1 | N2 | N0 | N1 | N2|....
>             */
>=20

