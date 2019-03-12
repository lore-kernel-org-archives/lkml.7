Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E77C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447E921734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xXGa1xhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCLOEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:04:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43208 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:04:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id i8so2124960oib.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RC9n/L2urRzMIddaEkM47GUXLJfkJCfKnT+zLB1fxyQ=;
        b=xXGa1xhPq962PZh/0M3j4mAOlmZhS6NFDXzo4vogkbyqv8U/tAbx8VNHJd6v5gaJbq
         iGPH2tBC8fkPtNUdDfrARZkcdTs9pn6H7O9/hI80ITNHS0D1dz4jr2y2Fb+w3ZCGYfCE
         A4mGfJj1LXwVSWhi/LvnZ6mfPUrMgPy61gAjgvpnWxvleAq+h6HXaEMYRJxwZVWCmRmq
         CQ87C8MPJdouValtJ3f2b6kP2ucp6E2Oxmpv+N5ezPOzbEMBLqVYMG1ZZ6L944+2pORs
         UX9YOCdpXCFbej3zSL4snoaAfGWMegeigvwjUU+7ia/FQcyNWZr8FXPErpNcFtn4MuC0
         7C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RC9n/L2urRzMIddaEkM47GUXLJfkJCfKnT+zLB1fxyQ=;
        b=H35LF4f12FG4JMVbfWQGJREapy/YItTxtBIYDfJJ6XAevUbwYfAhNFwDrXqBv6bd12
         w/r8ZiB63pkQ5xHT6HGR1mRCs9JjCZSg+GVxAGIHcJutYv1Z5bXr3Nek0V3p9idJSOdU
         83IyKm92sCsoXKtg7UM9wbRM/66DnXTPc3xP28B7HoKU7nXAH///uj6WXUbHOs0WuHn3
         t1mhNz9zQ8ujstbTOOsCpCp4avD1R3+qcymGu/i79VY9C3Pc8Nv/6s8yQOMMbpwWkr/x
         wjVb+2CHr36rsqZTKA6QT5/QjBU+Rh80bgtHTcTbVKm5rthhiXHpQyWrXrWnd30va2wY
         WeLQ==
X-Gm-Message-State: APjAAAVoNq+Y9rzNHjiXL9t3Y2R5NVoG1wwTQywnXnmrZrUBFUxWNz9X
        gbYaGtSDv/MckcL51q38mdXiR+m4Q2dhif+m1uH4QQ==
X-Google-Smtp-Source: APXvYqyO6Ri3cTvigCbe4KdbtZeEZKJtgtqAvWC8KsVCZmDNW8WB/VAD7yQrl9q0/Vf+C2xe+YiOvgpi4jzuwHVVbrk=
X-Received: by 2002:aca:4dca:: with SMTP id a193mr1806746oib.21.1552399443282;
 Tue, 12 Mar 2019 07:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190312132852.20115-1-brgl@bgdev.pl> <c86234af-a83a-712a-8dc8-0ec2a5dad103@oracle.com>
In-Reply-To: <c86234af-a83a-712a-8dc8-0ec2a5dad103@oracle.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Mar 2019 15:03:52 +0100
Message-ID: <CAMpxmJVeeMRPaXMKp29mE08pKFU4RRMetY=9-pWmazLg3DMLbg@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unused variable
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 mar 2019 o 14:59 Khalid Aziz <khalid.aziz@oracle.com> napisa=C5=82(=
a):
>
> On 3/12/19 7:28 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The mm variable is set but unused. Remove it.
>
> It is used. Look further down for calls to set_pte_at().
>
> --
> Khalid
>
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  mm/mprotect.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 028c724dcb1a..130dac3ad04f 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -39,7 +39,6 @@ static unsigned long change_pte_range(struct vm_area_=
struct *vma, pmd_t *pmd,
> >               unsigned long addr, unsigned long end, pgprot_t newprot,
> >               int dirty_accountable, int prot_numa)
> >  {
> > -     struct mm_struct *mm =3D vma->vm_mm;
> >       pte_t *pte, oldpte;
> >       spinlock_t *ptl;
> >       unsigned long pages =3D 0;
> >
>
>

Oops, I blindly assumed the compiler is right, sorry for that. GCC
complains it's unused when building usermode linux. I guess it's a
matter of how set_pte_at() is defined for ARCH=3Dum. I'll take a second
look.

Bart
