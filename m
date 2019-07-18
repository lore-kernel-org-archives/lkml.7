Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E1C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43BF2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9BvDgFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfGRLEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:04:10 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34083 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfGRLEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:04:10 -0400
Received: by mail-yw1-f67.google.com with SMTP id q128so12052351ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 04:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBv28uUWucv+cpCMKBZBbJSYqn9qCk7kmVDxU47irTg=;
        b=O9BvDgFLqQrmpCO2W4J+8cB8nWua67KNs9q4UuWvJpvBRikX2pS5wMqFn0URKq7xfK
         p4AaAUyBAx5as42WMu1ZghUuulE7KzBVPB2p92ezKKp/mqZg4p7JI/GswsTtGE78k8Y+
         S4i9GJYIovxggHejdcivgBTeoxawA578//2AIxA8c1hmOiKUSWONWke3CBiO9XQ5dSu5
         YfY48Js6zuY0Lb3gTB9WCo03kjw4n0oFUVOWrEnRt6Ha56SydXoLgseH8KMxztnyeIRy
         aY/VekKkoGKSDKqVbUcF8D9dFAsdBpJ3faC2OqCuCCO5F0h5Rlp8M8AtgF6NyDfVoJkR
         V5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBv28uUWucv+cpCMKBZBbJSYqn9qCk7kmVDxU47irTg=;
        b=GErRxmTFfpDuNhor3Iw8M93Ub2YBfyp6TeBodlWjvfcfnmM3MhcqBK3dj1Lfo5n7PJ
         eXsZkHtXeqfBE8jI4xefMqeE+BZGjIFv7n3Zvg71KkZv74kYLFCylrZlKEAP1pd+666P
         ATL3TyUHL8vU8vzWPQimKzz957BlqjviwF/I6n7g5VI3UwDpPKIHwLV/iGTl/H1Oajns
         PagLRfPYTnw44ezhIZmeGU5/ejuKhyEb4n+NbN3Fqh++1/CuAjZg7eqEpCo5hAmsvEhb
         9TRw3IloFvLGzPUTRe2824m2YcTU1c9ZOsSCHc9CkPmNomj7l7je1i3SVmukVviOBdmB
         ksmg==
X-Gm-Message-State: APjAAAWbZiQH0CbJRwDSwnVQGTqAqnkhJn+kvUriVtQuS0I0lJkx9sl5
        mejPWXSSzeMJenHOJkj0x8Kc0umo769o1jdoLzw=
X-Google-Smtp-Source: APXvYqwge0gF0bznG0LzkU5wpelqXk/tFMth5F1vNFfhFaa+11MqZoL76FLHrceaADhbfItshbotoC/hXM9Q8soDlPw=
X-Received: by 2002:a0d:c943:: with SMTP id l64mr27778395ywd.320.1563447848948;
 Thu, 18 Jul 2019 04:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190717074124.GA21617@amd>
In-Reply-To: <20190717074124.GA21617@amd>
From:   Balbir Singh <bsingharora@gmail.com>
Date:   Thu, 18 Jul 2019 21:03:57 +1000
Message-ID: <CAKTCnzkzvPgMK8i-cTuWFLRPPg4=DTkVQmS238VTgYJaUy=iVA@mail.gmail.com>
Subject: Re: HMM_MIRROR has less than useful help text
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Sherry Cheung <SCheung@nvidia.com>,
        Subhash Gutti <sgutti@nvidia.com>,
        Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Nellans <dnellans@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Bob Liu <liubo95@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 5:41 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> Commit c0b124054f9e42eb6da545a10fe9122a7d7c3f72 has very nice commit
> message, explaining what HMM_MIRROR is and when it is
> needed. Unfortunately, it did not make it into Kconfig help:
>
> CONFIG_HMM_MIRROR:
>
> Select HMM_MIRROR if you want to mirror range of the CPU page table of
> a
> process into a device page table. Here, mirror means "keep
> synchronized".
> Prerequisites: the device must provide the ability to write-protect
> its
> page tables (at PAGE_SIZE granularity), and must be able to recover
> from
> the resulting potential page faults.
>
> Could that be fixed?
>
> This is key information for me:
>
> # This is a heterogeneous memory management (HMM) process address space
> # mirroring.
> # This is useful for NVidia GPU >= Pascal, Mellanox IB >= mlx5 and more
> # hardware in the future.
>

That seems like a reasonable request

Balbir

> Thanks,
>                                                                 Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
