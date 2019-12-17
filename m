Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8876AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABDC20733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+EXtC01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfLQSqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:46:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726723AbfLQSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576608411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZjRKmHuvnoVKMirbirXU2qUqtR+sRTFhW7hH7QT1ZU=;
        b=c+EXtC01uaiDmLgSiPdMZ1WD7rzCMIC3BwHAv80wuyuq2Kh+s7yTnqpk4ijuylT6aie3d5
        hAskQHZstkO3r3K7zrXW3wyJdqiVIfltMKe/o21iSk6drls9MpZOhj9d3kOVHb+gbMlEnB
        EQZQH8noZRRjJplLBEc7I4FHNmru9t0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-IK3AMFylOKmYKKjbMqy-Rw-1; Tue, 17 Dec 2019 13:46:49 -0500
X-MC-Unique: IK3AMFylOKmYKKjbMqy-Rw-1
Received: by mail-wm1-f70.google.com with SMTP id l11so1058829wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IZjRKmHuvnoVKMirbirXU2qUqtR+sRTFhW7hH7QT1ZU=;
        b=N0+KV4X4BTKl28KeynSdkXW4Nj3roy4xh5GoL0WhubZXhgX1A8WlhaW7ru3BFMqH6M
         xlA4Jh/aVzyRGsiTx9M5UNPvfDUrUBg27sBNS2udA7dZ5u9PH+va3DUT0m51CY4c0UeD
         KXuZCIg6YtdI19VVoDVEyWVRTzg/do3xtDb6kZ811Ear4rlArCFtuWHSe60Al4xoa6ow
         n95m4qlnSQtqDj7mBy4m7eRC4fnqy+GnZUL6jQdJ2kHovSreAh4cX64Waauc31/rZAWT
         F8LfBFeEEWKRub8G5UflyGwfKiho64G880nVuAwCJK+etJDj/c6mJNnMvPx/bQ4ISLBF
         pWoQ==
X-Gm-Message-State: APjAAAVuh2sV7kcg/ruhNuYa7fzerNk7KAPKd0GOi5CiYLq1p7bpxRNy
        GStJhH7K9RzLfo8c/1Fstp0G3N5Mm7RBPfAarZqCSMuzxU4rCjeJk22pyaY6nWn1rC30VBvs1CK
        4rbiRggzPsJPszYGkrlFlVHFu
X-Received: by 2002:a5d:6708:: with SMTP id o8mr39021277wru.296.1576608408737;
        Tue, 17 Dec 2019 10:46:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPvlk+TwbhCe+kHYv7eZKZShKxj66b/JxKprHybJXtulfbUtBwnBztokfND3OEGYr34Cq8KA==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr39021257wru.296.1576608408527;
        Tue, 17 Dec 2019 10:46:48 -0800 (PST)
Received: from [192.168.3.122] (p5B0C64F3.dip0.t-ipconnect.de. [91.12.100.243])
        by smtp.gmail.com with ESMTPSA id g25sm3943341wmh.3.2019.12.17.10.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:46:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v15 3/7] mm: Add function __putback_isolated_page
Date:   Tue, 17 Dec 2019 19:46:47 +0100
Message-Id: <08EFF184-E727-4A79-ABEF-52F2463860C3@redhat.com>
References: <1a6e4646f570bf193924e099557841eb6e77a80d.camel@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, yang.zhang.wz@gmail.com, nitesh@redhat.com,
        konrad.wilk@oracle.com, pagupta@redhat.com, riel@surriel.com,
        lcapitulino@redhat.com, dave.hansen@intel.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, osalvador@suse.de
In-Reply-To: <1a6e4646f570bf193924e099557841eb6e77a80d.camel@linux.intel.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 17.12.2019 um 19:25 schrieb Alexander Duyck <alexander.h.duyck@linux.in=
tel.com>:
>=20
> =EF=BB=BFOn Tue, 2019-12-17 at 18:24 +0100, David Hildenbrand wrote:
>>>>> Also there are some scenarios where __page_to_pfn is not that simple a=

>>>>> call with us having to get the node ID so we can find the pgdat struct=
ure
>>>>> to perform the calculation. I'm not sure the compiler would be ble to
>>>>> figure out that the result is the same for both calls, so it is better=
 to
>>>>> make it explicit.
>>>>=20
>>>> Only in case of CONFIG_SPARSEMEM we have to go via the section - but I
>>>> doubt this is really worth optimizing here.
>>>>=20
>>>> But yeah, I'm fine with this change, only "IMHO
>>>> get_pageblock_migratetype() would be nicer" :)
>>>=20
>>> Aren't most distros running with CONFIG_SPARSEMEM enabled? If that is th=
e
>>> case why not optimize for it?
>>=20
>> Because I tend to dislike micro-optimizations without performance
>> numbers for code that is not on a hot path. But I mean in this case, as
>> you said, you need the pfn either way, so it's completely fine with.
>>=20
>> I do wonder, however, if you should just pass in the migratetype from
>> the caller. That would be even faster ;)
>=20
> The problem is page isolation. We can end up with a page being moved to an=

> isolate pageblock while we aren't holding the zone lock, and as such we
> likely need to test it again anyway. So there isn't value in storing and
> reusing the value for cases like page reporting.
>=20
> In addition, the act of isolating the page can cause the migratetype to
> change as __isolate_free_page will attempt to change the migratetype to
> movable if it is one of the standard percpu types and we are pulling at
> least half a pageblock out. So storing the value before we isolate it
> would be problematic as well.
>=20
> Undoing page isolation is the exception to the issues pointed out above,
> but in that case we are overwriting the pageblock migratetype anyway so
> the cache lines involved should all be warm from having just set the
> value.

Nothing would speak against querying the migratetype in the caller and passi=
ng it on. After all you=E2=80=98re holding the zone lock, so it can=E2=80=98=
t change.
>=20

