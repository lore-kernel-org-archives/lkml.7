Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E464CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 20:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA6520862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 20:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fra6o2Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKBUSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 16:18:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21699 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726523AbfKBUSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 16:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572725897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKBXfQgd5p2+gWT9zmabcT+VNhavyNSZze716SOSts4=;
        b=fra6o2RouMbxRhMru66nucPe5uoEqbWsnxhv5rSv3+82TL2uXm4r0hyJ0t1k8+dfIdt597
        vdOTuB49nR2L6sAF7pWkWR2I+OYfCGjhSuoqfD86SqeBmDUhSTWmvA0kbqAUydRa646mIh
        c3h8ZvC5VmLOD7GEbxE5GLt0F7Wr9iE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-HM3D0vF_OjaoU4DNBYqSDQ-1; Sat, 02 Nov 2019 16:18:13 -0400
Received: by mail-wr1-f71.google.com with SMTP id j17so7552935wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 13:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9C1zpO5sCBN3AehuJCR5s+kJhV1snjZ+Ujgxinq9hlQ=;
        b=AYE1KopOGuXpgOHNy/Pa2o0/IApXgKpJnuqkK39FX0Ew13c+iS10hNs7L6U7aCX8US
         migfJzeQfE9c5hkaJXDCXXKpxERoY9e89/VKQxylIyXZIwY5BPknY3/vaKtcLOaTIrdR
         ihoSESd/fpBGuemWp1OK4uo9ife5NO9/nc5f5mGBrHyvcyF+9Z2DuSyxCl4DxAbXOWAF
         /SfVJcbmq8jzvmP/aa3siHT9yD+L7C5KGdoCptNUov4QtQLG/bT4OTwElzNuSU526OGb
         oxCjTNy5qT1uYKcxaS4wKl77qA01T6FkyGP8o48b5ZzOJaw94NJ8nrI81FIvZKad3RNQ
         UpZQ==
X-Gm-Message-State: APjAAAU1PNJBx1DEYhscONhugUu5hiieacqsc+8K82O5EDJu1E7Vamhb
        2CSNltfLSNF6IKyO/lJKstEk6te+bkpl01MD3ddHjdNUonwNVJT2sVqibXFtuGxPXBbtyap21fH
        znMCrHfZ66h+aj7qUg7cM83aG
X-Received: by 2002:a05:600c:2942:: with SMTP id n2mr5238895wmd.81.1572725892540;
        Sat, 02 Nov 2019 13:18:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZYnh3qeFCkt8NaznBtHCHUVFjC6cTCZLKK+X6DBPGmUVVUJfAplS3MFEQsExKPd0n6c1Lpg==
X-Received: by 2002:a05:600c:2942:: with SMTP id n2mr5238882wmd.81.1572725892331;
        Sat, 02 Nov 2019 13:18:12 -0700 (PDT)
Received: from [192.168.3.122] (p4FF23602.dip0.t-ipconnect.de. [79.242.54.2])
        by smtp.gmail.com with ESMTPSA id w12sm2657889wmi.17.2019.11.02.13.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 13:18:11 -0700 (PDT)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drivers/base/memory.c: memory subsys init: skip search for missing blocks
Date:   Sat, 2 Nov 2019 21:18:11 +0100
Message-Id: <23B6AB80-7551-469D-AA08-C983420895BD@redhat.com>
References: <20191102194316.bnglsf5lltc4cztg@rascal.austin.ibm.com>
Cc:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com
In-Reply-To: <20191102194316.bnglsf5lltc4cztg@rascal.austin.ibm.com>
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: HM3D0vF_OjaoU4DNBYqSDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 02.11.2019 um 20:43 schrieb Scott Cheloha <cheloha@linux.vnet.ibm.com>=
:
>=20
> =EF=BB=BFOn Fri, Nov 01, 2019 at 11:47:49PM +0100, David Hildenbrand wrot=
e:
>>=20
>>>> Am 01.11.2019 um 23:32 schrieb Rick Lindsley <ricklind@linux.vnet.ibm.=
com>:
>>>=20
>>> =EF=BB=BFOn 11/1/19 12:00 PM, David Hildenbrand wrote:
>>>> No, I don't really like that. Can we please speed up the lookup via a =
radix tree as noted in the comment of "find_memory_block()".
>>>=20
>>> I agree with the general sentiment that a redesign is the correct long =
term action - it has been for some time now - but implementing a new storag=
e and retrieval method and verifying that it introduces no new problems its=
elf is non-trivial.  There's a reason it remains a comment.
>>>=20
>>> I don't see any issues with the patch itself.   Do we really want to fo=
rego the short term, low-hanging, low risk fruit in favor of waiting indefi=
nitely for that well-tested long-term solution?
>>=20
>> The low hanging fruit for me is to convert it to a simple VM_BUG_ON(). A=
s I said, this should never really happen with current code.
>>=20
>> Also, I don=E2=80=98t think adding a radix tree here is rocket science a=
nd takes indefinitely ;) feel free to prove me wrong.
>=20
> To clarify the goal here, "adding a radix tree" means changing
> subsys_private's klist_devices member from a klist to a radix
> tree or xarray, right?

I wouldn=E2=80=98t go that far and only use a subsystem local data structur=
e as a fast lookup cache. The memory subsystem is one of the rare subsystem=
s that deals with such a big number of devices (AFAIK). Most other subsyste=
ms don=E2=80=98t really need that.

I do agree that converting the klist to a radix tree would be more involved=
, but at least I think we can keep this subsystem-local, at least for now. =
Introducing a local cache should be simple.

Cheers!

>=20
> -Scott

