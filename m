Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF69C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084FA20873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ehV7+gKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbfGROZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:25:57 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43731 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfGROZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:25:54 -0400
Received: by mail-oi1-f175.google.com with SMTP id w79so21645207oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEfHbVHTHxaeDRfwOPqdRBhxdA+kWRw0lTsxb4KwEKY=;
        b=ehV7+gKgD9TaoC10Ox+amOqzeQyE5iWOsMyaZ6c6J97blX6bDdl27Fkxll2rfap8Ie
         d3FvKZu4jnSjHtRt+zyjzfqyUjUezaboOSKVN2rTmg6atVMl8zO6SlGfAHF5NRNq3YEw
         Da9CHQ8/1BtOlwmuHDFcn1FM0YL9LYregEa7sLPL4H/Eso3q4o4OfqiFXIBxIBk7nNYw
         yfS06g3/EhNX53CTlRtQJf7p4U8FvnwIXEBvkjLcjCMVksc8fMjyCFpN+M7AAyiBsHO9
         ajCJm7+QxK/4rsLnxw+X8NB8DVWVtPwlt0zdSobQsocGQiqVIqoy/WBxhvdtQXdEqAxE
         b0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEfHbVHTHxaeDRfwOPqdRBhxdA+kWRw0lTsxb4KwEKY=;
        b=G50EEfKYPJIveFzmhTz9w7af1Fhb6gOXUTOSseN9rlXOMDtk+T1zDMt7uAZQ5KKY8l
         gFzFOfiNTTRQPqiXBP614/1VXQoy5DkBqE0xGj7eDf/yfuWPPDtTKkfeiOSXKa8QJXoS
         Kvvgt4ZepYulf/0BFqpmN3dAiwTjCUd6lWDQJ48imqoiHyJzD6lMHqMR6zbV1HcCR9+/
         CuT1yWiTCR9eSKI7XyANoCYoz7iLqWHklHn6E8NvABORC14TZfpR5wwHbvuzYwr74D5q
         1ozDqtgIprk2HSG8vSZ9EiERGztG/KLE36eB/nOZ0rw3bahXeCoYuH/50cIiYsy1Sbip
         Xh6A==
X-Gm-Message-State: APjAAAX7/sBN+2ysm/Z+UupzjM+Rqm4x/Gfg0+00GTFTAcioAJpdud2k
        4PgIWs+p3++e0FI0jY3wHySI2DxBfDwjdNegytxg3w==
X-Google-Smtp-Source: APXvYqyfSizMBYHdg9A4A5XJN/lkGzKxRPIuVjry5ro6O76uXW3vLd0OVskfLnW3se9OsFgQKY699AtG3Mfp0njz298=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr23203418oig.105.1563459954012;
 Thu, 18 Jul 2019 07:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190717074124.GA21617@amd> <CAKTCnzkzvPgMK8i-cTuWFLRPPg4=DTkVQmS238VTgYJaUy=iVA@mail.gmail.com>
In-Reply-To: <CAKTCnzkzvPgMK8i-cTuWFLRPPg4=DTkVQmS238VTgYJaUy=iVA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Jul 2019 07:25:42 -0700
Message-ID: <CAPcyv4i3vzuWfKQXF-GWKpCXACjE6HTeczPRoHUp+tOBMEAP-Q@mail.gmail.com>
Subject: Re: HMM_MIRROR has less than useful help text
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Sherry Cheung <SCheung@nvidia.com>,
        Subhash Gutti <sgutti@nvidia.com>,
        Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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

On Thu, Jul 18, 2019 at 4:04 AM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Wed, Jul 17, 2019 at 5:41 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > Commit c0b124054f9e42eb6da545a10fe9122a7d7c3f72 has very nice commit
> > message, explaining what HMM_MIRROR is and when it is
> > needed. Unfortunately, it did not make it into Kconfig help:
> >
> > CONFIG_HMM_MIRROR:
> >
> > Select HMM_MIRROR if you want to mirror range of the CPU page table of
> > a
> > process into a device page table. Here, mirror means "keep
> > synchronized".
> > Prerequisites: the device must provide the ability to write-protect
> > its
> > page tables (at PAGE_SIZE granularity), and must be able to recover
> > from
> > the resulting potential page faults.
> >
> > Could that be fixed?
> >
> > This is key information for me:
> >
> > # This is a heterogeneous memory management (HMM) process address space
> > # mirroring.
> > # This is useful for NVidia GPU >= Pascal, Mellanox IB >= mlx5 and more
> > # hardware in the future.
> >
>
> That seems like a reasonable request

Hi Pavel, care to send a patch?
