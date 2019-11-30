Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FFCC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BC12084D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clDLoUN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfK3IMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 03:12:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54495 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725835AbfK3IMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 03:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575101566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFru96T4DubvSUfR9PL1XRmnM0qWdAU0eKRKMZXXxNs=;
        b=clDLoUN6FOQ0mPNdG8SdLhHCOG2NcsLFOlkFYJYZh9Rkj1LtvPL2G28dgMHCuoqNjxbr70
        crj2G8hi52Tiw9uFg+BHYdza7p/Sa5/SL+kRdF46tcV2+5I8FdHP80dXrt7fhMa3+TUOrN
        Sf0D0/FhYjWrYU588TRBdqNWpU/dBcs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-hdJRVvFUPsa38tNllAUK3w-1; Sat, 30 Nov 2019 03:12:45 -0500
Received: by mail-wr1-f70.google.com with SMTP id q6so16839300wrv.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 00:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nTv8VEQY2J0I9+5GR9aqZSdU5jHjAwzy+5bSMzhoyY4=;
        b=hEcDaMXnxlxW3HPO7UfRGU/Yy5Qyra9Uv8G/fX1fIvSKgJCwJeW59+3Fm9Ob8Z8sqy
         0BIuBnscwwjlgcvECIt/bvkO+q5tljRn1Hyj7+/hziZBQuuMnGfic4i0mNEXEe4H0JaA
         Bus1vh70AooF+A/QVVPwAOm0l9HbDNKIgfmdkD8xzZsyp1RD24Hyft7xtmcvumqKZt0i
         PjX97IFF/1Wm0XzM+7zJjZeOBltacVDijcO5KDnkHbSrkTnCuzf2u/xTMFCAHXoEvjtn
         DqDUpWX5FjjxgLG1KAyKylfHMEhdJsWZSz54C5mRfWUdc4h746NjDZ0+8tkC7W5zozwu
         DAZQ==
X-Gm-Message-State: APjAAAXii6uTidJq6vTCfxXYCB9yfAIOhsDMxMWYzL3JnCMWCrmyvAQJ
        BuYy/+eTs4j8I9EThw/uA/lklLt8kpNJolqLQckMpylS1nrR7YGszNyPz6CxT7iOdU61Q4ymftP
        wmprufug0Gj8Fyb4iFImpv0hQ
X-Received: by 2002:a5d:6886:: with SMTP id h6mr40783116wru.154.1575101564152;
        Sat, 30 Nov 2019 00:12:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSLJ4hPVLVm9zraYkjv2wlQrsiHpWbHee8avwddrk2JQnD1a8Ebwv4IdZC2aP66JIdpVTDFg==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr40783101wru.154.1575101563988;
        Sat, 30 Nov 2019 00:12:43 -0800 (PST)
Received: from ?IPv6:2a01:598:a00a:c210:4873:c6af:a739:3af0? ([2a01:598:a00a:c210:4873:c6af:a739:3af0])
        by smtp.gmail.com with ESMTPSA id g207sm17540054wmg.40.2019.11.30.00.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 00:12:43 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] mm: get rid of odd jump labels in find_mergeable_anon_vma()
Date:   Sat, 30 Nov 2019 09:12:42 +0100
Message-Id: <AC5F0A85-74BC-4F7B-8C09-33A1F87564B3@redhat.com>
References: <0db7574905b64d47a7c88766081fa0ad@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jannh@google.com" <jannh@google.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "walken@google.com" <walken@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <0db7574905b64d47a7c88766081fa0ad@huawei.com>
To:     linmiaohe <linmiaohe@huawei.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: hdJRVvFUPsa38tNllAUK3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 30.11.2019 um 08:23 schrieb linmiaohe <linmiaohe@huawei.com>:
>=20
> =EF=BB=BF
>>=20
>>> From: Miaohe Lin <linmiaohe@huawei.com>
>>>=20
>>> The jump labels try_prev and none are not really needed in=20
>>> find_mergeable_anon_vma(), eliminate them to improve readability.
>>>=20
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>=20
>> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> friendly ping ...
>=20

We=E2=80=98re currently in the merge phase, and U.S.A. just had Thanksgivin=
g - so it might take some time to get picked up. Cheers!

