Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9B2C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE91824651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fTOKyT6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfLEJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:42:30 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45606 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfLEJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:42:28 -0500
Received: by mail-qv1-f66.google.com with SMTP id c2so1019986qvp.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=zI7a5PBMJJ5CQd2iIgpWJ2uNZMsj1Eei+ZBMJ2MdOPA=;
        b=fTOKyT6d57EX40FTt7xk4dm4F/UKZ5SwM2IFqMsoI3yfCsmiz1FI8MWUjUkTW+F8U5
         5tgPXiXJqUuWe7Qodfx5FSKinWR7lJg97JBfWXy+kq3FYdd5l+903umSf2oRYNDRhE2R
         S5uHHUuFYZBkm8h4EnoqLKT1Rlyo2awbgrNFIjBCmTDh6UMW1KhhO6gVLyTg6d6H4tEW
         0Zr1G6WSRkal+43oiuUQ6FomOPA2umQZSFlLBokCeW4eEfBPY3I+Wzptb5XhEznTm8h5
         eNDVrRQcoEuMf+9dH1iAr5C0eHAXzOIecEf9jsze1Bpz6oGXAn4ShzKYlvb++3dY3XXz
         gvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=zI7a5PBMJJ5CQd2iIgpWJ2uNZMsj1Eei+ZBMJ2MdOPA=;
        b=MeBN1laEjjKfS6TikUSrV2ilaRDYGRQBzP6jS49yF7gJFlLsjPnkLmj5K0kG6RTZH+
         /Zgzl9J/yNNDMjrBAWM8fjDEIJo/5YpMF5gBpRA2aTtTIqjWZd7jgbk758jxd58wOkmR
         cCoFfYoep99ektTF3gsATdGzRVI8YbIfmreAsUWr95A3NsdZp/DQpvtam5jMaoeBHg/Z
         cAQQy6L6GtxHdZWTvbhD20MHiNkxhgGf/EKEc6roBkfa2kdYg7ZBGyNq9WIReM66Bu7t
         lbYhaST7OVkqvCM14WiwIry/mRL/kWiNLP3o7e5FHrRClMC+B4Fwmmc0WXPuisYlp2wW
         4o1A==
X-Gm-Message-State: APjAAAUzbEyKHr7XjwkVirS6DOc5sstB15QJC6vYX+rDX49yXQEpqieX
        HNuzcr2b56NWM9Q/PCFL46tfDQ==
X-Google-Smtp-Source: APXvYqw4MD2MUemRLyJ8RFAeY7TUJzzy4DevHu4JGTfkFeWfxi7tVEGh2w/A/72jz0ef24uQmreUGw==
X-Received: by 2002:ad4:5689:: with SMTP id bc9mr6409168qvb.132.1575538947064;
        Thu, 05 Dec 2019 01:42:27 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 13sm4716663qke.85.2019.12.05.01.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 01:42:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [v2 PATCH] mm: move_pages: return valid node id in status if the page is already on the target node
Date:   Thu, 5 Dec 2019 04:42:25 -0500
Message-Id: <9E51ECF6-E9E8-4772-B7D8-7E528DD56A89@lca.pw>
References: <1575519678-86510-1-git-send-email-yang.shi@linux.alibaba.com>
Cc:     fabecassis@nvidia.com, jhubbard@nvidia.com, mhocko@suse.com,
        cl@linux.com, vbabka@suse.cz, mgorman@techsingularity.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <1575519678-86510-1-git-send-email-yang.shi@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 4, 2019, at 11:21 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>=20
> Felix Abecassis reports move_pages() would return random status if the
> pages are already on the target node by the below test program:
>=20
> ---8<---
>=20
> int main(void)
> {
>    const long node_id =3D 1;
>    const long page_size =3D sysconf(_SC_PAGESIZE);
>    const int64_t num_pages =3D 8;
>=20
>    unsigned long nodemask =3D  1 << node_id;
>    long ret =3D set_mempolicy(MPOL_BIND, &nodemask, sizeof(nodemask));
>    if (ret < 0)
>        return (EXIT_FAILURE);
>=20
>    void **pages =3D malloc(sizeof(void*) * num_pages);
>    for (int i =3D 0; i < num_pages; ++i) {
>        pages[i] =3D mmap(NULL, page_size, PROT_WRITE | PROT_READ,
>                MAP_PRIVATE | MAP_POPULATE | MAP_ANONYMOUS,
>                -1, 0);
>        if (pages[i] =3D=3D MAP_FAILED)
>            return (EXIT_FAILURE);
>    }
>=20
>    ret =3D set_mempolicy(MPOL_DEFAULT, NULL, 0);
>    if (ret < 0)
>        return (EXIT_FAILURE);
>=20
>    int *nodes =3D malloc(sizeof(int) * num_pages);
>    int *status =3D malloc(sizeof(int) * num_pages);
>    for (int i =3D 0; i < num_pages; ++i) {
>        nodes[i] =3D node_id;
>        status[i] =3D 0xd0; /* simulate garbage values */
>    }
>=20
>    ret =3D move_pages(0, num_pages, pages, nodes, status, MPOL_MF_MOVE);
>    printf("move_pages: %ld\n", ret);
>    for (int i =3D 0; i < num_pages; ++i)
>        printf("status[%d] =3D %d\n", i, status[i]);
> }
> ---8<---
>=20
> Then running the program would return nonsense status values:
> $ ./move_pages_bug
> move_pages: 0
> status[0] =3D 208
> status[1] =3D 208
> status[2] =3D 208
> status[3] =3D 208
> status[4] =3D 208
> status[5] =3D 208
> status[6] =3D 208
> status[7] =3D 208
>=20
> This is because the status is not set if the page is already on the
> target node, but move_pages() should return valid status as long as it
> succeeds.  The valid status may be errno or node id.
>=20
> We can't simply initialize status array to zero since the pages may be
> not on node 0.  Fix it by updating status with node id which the page is
> already on.  And, it looks we have to update the status inside
> add_page_for_migration() since the page struct is not available outside
> it.
>=20
> Make add_page_for_migration() return 1 if store_status() is failed in
> order to not mix up the status value since -EFAULT is also a valid
> status.

Don=E2=80=99t really feel it is a bug after all. As you mentioned, the manpa=
ge was rather poorly written. Why it is not a good idea just update the manp=
age or/and code comments instead to document the current behavior?=
