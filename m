Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD010C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9770820673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbMwvfM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgAIWfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:35:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34144 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725807AbgAIWfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578609331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6Tk6NXbKeintPhmiO4q8CGSHf8p5iQXCoANZ85vxp8=;
        b=TbMwvfM4oOwKIPUdqNomcwNPHJF5cFzGlSI0X78+qMQWlaW549jtYyblhkMbgEpTwj2c7Y
        JYR1VuvEFi2EoShkCWoybWRkKcIK8+UtcMwBSrpNxXhrNECZvrB2E2wx+Wyh/iHhnEKXSZ
        ndnb7DVrmUmvHFLMNv2neP9+H6u/0JY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-3r4EzD79P_mWB-fLxCMtWA-1; Thu, 09 Jan 2020 17:35:30 -0500
X-MC-Unique: 3r4EzD79P_mWB-fLxCMtWA-1
Received: by mail-wr1-f70.google.com with SMTP id c6so6120wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 14:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=L6Tk6NXbKeintPhmiO4q8CGSHf8p5iQXCoANZ85vxp8=;
        b=HBsSESbOMtiEC5Nk3GK8PnJk2vfyVMlXf/cECkEwjd9b30a15D44JFMV1sg47kdKDm
         pZYq3AN5BppXUHCC/5Vph9Cpxgk1nCEPJ6IsowTsY0YFbzdIdjDtHs4bzZARZIJg6KfM
         4vLKA2JvhWCfDzJMFNa38JZmo4XEf3YHRS5WTs/IoR3UNHIWyYDl2hF20nBYnKG8k+uN
         YlObJtI+fI4cbsk673Dn9r3wPvZzTN/QLcWhNbnBl3H5F1NKqbAJuqU6lFuwZBlTqBFI
         jRzOSzFP9PyJGZWuEfu+Z8ZsG0jcGfWczgI+MDdrAk1nZYJJPcDIeH1lmlMnNNhXqKay
         SgGA==
X-Gm-Message-State: APjAAAWcrBpqz4qn7shKUGUNM0iEmfs+gm3ltKTPbpVNVDbxXxAEC1lH
        yRBbTPZwMm/owRGMDHhuxvkM7Hpq0VuJ2meSsB07p2x5tq5pAySsighvPfsR5/Xyd8h2mXxd+az
        +cYqz6M+f//faTa990WTY2SE3
X-Received: by 2002:adf:f311:: with SMTP id i17mr60432wro.81.1578609329576;
        Thu, 09 Jan 2020 14:35:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZZQgsjQgoTa3XQg9OT9RA1d3vUlDtC6jFGQi3+0UHka7xLUT13x2pMcJ6IVUXwqGFKExVPQ==
X-Received: by 2002:adf:f311:: with SMTP id i17mr60417wro.81.1578609329396;
        Thu, 09 Jan 2020 14:35:29 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6BE2.dip0.t-ipconnect.de. [91.12.107.226])
        by smtp.gmail.com with ESMTPSA id d12sm10031475wrp.62.2020.01.09.14.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 14:35:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
Date:   Thu, 9 Jan 2020 23:35:28 +0100
Message-Id: <F8AD9915-061E-4829-8670-B35D5F2DFC03@redhat.com>
References: <20200109142758.659c1545cb8df2d05f299a4a@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        mhocko@suse.com, Scott Cheloha <cheloha@linux.ibm.com>
In-Reply-To: <20200109142758.659c1545cb8df2d05f299a4a@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 09.01.2020 um 23:28 schrieb Andrew Morton <akpm@linux-foundation.org>:
>=20
> =EF=BB=BFOn Thu, 9 Jan 2020 23:17:09 +0100 David Hildenbrand <david@redhat=
.com> wrote:
>=20
>>=20
>>=20
>>>> Am 09.01.2020 um 23:00 schrieb Andrew Morton <akpm@linux-foundation.org=
>:
>>>=20
>>> =EF=BB=BFOn Thu,  9 Jan 2020 15:25:16 -0600 Scott Cheloha <cheloha@linux=
.vnet.ibm.com> wrote:
>>>=20
>>>> Searching for a particular memory block by id is an O(n) operation
>>>> because each memory block's underlying device is kept in an unsorted
>>>> linked list on the subsystem bus.
>>>>=20
>>>> We can cut the lookup cost to O(log n) if we cache the memory blocks in=

>>>> a radix tree.  With a radix tree cache in place both memory subsystem
>>>> initialization and memory hotplug run palpably faster on systems with a=

>>>> large number of memory blocks.
>>>>=20
>>>> ...
>>>>=20
>>>> @@ -56,6 +57,13 @@ static struct bus_type memory_subsys =3D {
>>>>   .offline =3D memory_subsys_offline,
>>>> };
>>>>=20
>>>> +/*
>>>> + * Memory blocks are cached in a local radix tree to avoid
>>>> + * a costly linear search for the corresponding device on
>>>> + * the subsystem bus.
>>>> + */
>>>> +static RADIX_TREE(memory_blocks, GFP_KERNEL);
>>>=20
>>> What protects this tree from racy accesses?
>>=20
>> I think the device hotplug lock currently (except during boot where no ra=
ces can happen).
>>=20
>=20
> So this?
>=20
> --- a/drivers/base/memory.c~drivers-base-memoryc-cache-blocks-in-radix-tre=
e-to-accelerate-lookup-fix
> +++ a/drivers/base/memory.c
> @@ -61,6 +61,9 @@ static struct bus_type memory_subsys =3D {
>  * Memory blocks are cached in a local radix tree to avoid
>  * a costly linear search for the corresponding device on
>  * the subsystem bus.
> + *
> + * Protected by mem_hotplug_lock in mem_hotplug_begin(), and by the guara=
nteed
> + * single-threadness at boot time.
>  */
> static RADIX_TREE(memory_blocks, GFP_KERNEL);
>=20
>=20
> But are we sure this is all true?

I think the device hotplug lock, not the memory hotplug lock. Will double ch=
eck later.
>=20

