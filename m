Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE88C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4877E21897
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIOpzqUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfIDDYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 23:24:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45223 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIDDYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:24:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id l1so18109131lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YcK3/y3M/0YXrOuuPTwztt6NID6ZpNe9KPTNvrMrEWQ=;
        b=aIOpzqUMV/A0dnG9n/5KyHemYAFQY5TPigJU9atZMROpInjsZ5Rp6bL0nPr5ehwsQw
         lzgM++PugG3vWhxGLm4dlFA5eyHP1ewzhTSxZYEcNRm4ucByyLogukQrBpGomBXNfOpB
         eRR961wcKT2JFO1DN5LmyStommNr4E5wMl2D5PMAn0XByRtJCHYDfOh6X4I/zT2WNuNj
         5BQmk6YHzTL4VTukyA56/4zMjAXgbsRLm0I/lcPgT0pDFHNI/o6xd9TzIzTEaZbDxe24
         C+qSrjBgjffn+9ISRdkcoRBMCboMDweP0Ehhtz5BJPO2c11I0qn26DdFjB7L1wWCRHUQ
         Xv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YcK3/y3M/0YXrOuuPTwztt6NID6ZpNe9KPTNvrMrEWQ=;
        b=bsBpMW/yBosabMCvpBqEdX1VGnaH2A6s/47APg+HUzXGsrP+DozKn5WvsbJZ5gnz5C
         2FDtV7y2abEe7ZlFzacdVrwJ7sim5cWuTjwlD+J8Rx+MHEYtPg9dLF8IrCE09Lb5tsCQ
         Q6BMsnFN4IAFauVPOqyEfE/Mv10WJr5Oz3/43U9zmRjN0FXnJ6N6ahHq7BuKAjCAhufP
         wvy5LHUEuJ9rfsl6xoSBbEwFe13KM33eezBM2PN6bMSU2gkkvyHnNwtpjPqnst7qc9mH
         dk2+F8YeSbYbCWVl0BFF/Fy2OgDc93C7U2AgP7Un4lpPSI/HfFyka8JrXmzQBTshw815
         ug1Q==
X-Gm-Message-State: APjAAAVAGKy2LDLoTpTuxySj2d+4tLGKwLRxYt4SHWtEL1wKTq+0Kqym
        RtmFrxQknQeJ+sTRXss292V/rgfmlfuDdT5bsSE=
X-Google-Smtp-Source: APXvYqwyOYzbfLpZIRUCsJ3ehB6OE32PazN0+fk5schcHdQrPHRnp4LIJ4b11ROaozjdfjlobw67dDOrU00x3qP6gDI=
X-Received: by 2002:a2e:534e:: with SMTP id t14mr21945713ljd.218.1567567462673;
 Tue, 03 Sep 2019 20:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <1567086657-22528-1-git-send-email-totty.lu@gmail.com> <1f0e6e1a-c947-f389-801e-b1d748cb5bce@oracle.com>
In-Reply-To: <1f0e6e1a-c947-f389-801e-b1d748cb5bce@oracle.com>
From:   =?UTF-8?B?6ZmG5b+X5Yia?= <totty.lu@gmail.com>
Date:   Wed, 4 Sep 2019 11:24:13 +0800
Message-ID: <CAFa9Ja9Y4ixQjwr2VBg5-rTc2ie0i6B=g2c3B-UuGoAdsWvJYA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugetlb: avoid looping to the same hugepage if
 !pages and !vmas
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     luzhigang001@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zhigang Lu <tonnylu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/29/19 6:50 AM, Zhigang Lu wrote:
> > From: Zhigang Lu <tonnylu@tencent.com>
> >
> > When mmapping an existing hugetlbfs file with MAP_POPULATE, we find
> > it is very time consuming. For example, mmapping a 128GB file takes
> > about 50 milliseconds. Sampling with perfevent shows it spends 99%
> > time in the same_page loop in follow_hugetlb_page().
> >
> > samples: 205  of event 'cycles', Event count (approx.): 136686374
> > -  99.04%  test_mmap_huget  [kernel.kallsyms]  [k] follow_hugetlb_page
> >         follow_hugetlb_page
> >         __get_user_pages
> >         __mlock_vma_pages_range
> >         __mm_populate
> >         vm_mmap_pgoff
> >         sys_mmap_pgoff
> >         sys_mmap
> >         system_call_fastpath
> >         __mmap64
> >
> > follow_hugetlb_page() is called with pages=3DNULL and vmas=3DNULL, so f=
or
> > each hugepage, we run into the same_page loop for pages_per_huge_page()
> > times, but doing nothing. With this change, it takes less then 1
> > millisecond to mmap a 128GB file in hugetlbfs.
>
> Thanks for the analysis!
>
> Just curious, do you have an application that does this (mmap(MAP_POPULAT=
E)
> for an existing hugetlbfs file), or was this part of some test suite or
> debug code?

Yes, DPDK and SPDK actually do this in vhost_user.c.
vhost_setup_mem_table() {
...
mmap_size =3D RTE_ALIGN_CEIL(mmap_size, alignment);

mmap_addr =3D mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
MAP_SHARED | MAP_POPULATE, fd, 0);
...
}

>
> > Signed-off-by: Zhigang Lu <tonnylu@tencent.com>
> > Reviewed-by: Haozhong Zhang <hzhongzhang@tencent.com>
> > Reviewed-by: Zongming Zhang <knightzhang@tencent.com>
> > Acked-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  mm/hugetlb.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6d7296d..2df941a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4391,6 +4391,17 @@ long follow_hugetlb_page(struct mm_struct *mm, s=
truct vm_area_struct *vma,
> >                               break;
> >                       }
> >               }
>
> It might be helpful to add a comment here to help readers of the code.
> Something like:
>

Thanks, I will add this comment and send a new version.

>                 /*
>                  * If subpage information not requested, update counters
>                  * and skip the same_page loop below.
>                  */
> > +
> > +             if (!pages && !vmas && !pfn_offset &&
> > +                 (vaddr + huge_page_size(h) < vma->vm_end) &&
> > +                 (remainder >=3D pages_per_huge_page(h))) {
> > +                     vaddr +=3D huge_page_size(h);
> > +                     remainder -=3D pages_per_huge_page(h);
> > +                     i +=3D pages_per_huge_page(h);
> > +                     spin_unlock(ptl);
> > +                     continue;
> > +             }
> > +
> >  same_page:
> >               if (pages) {
> >                       pages[i] =3D mem_map_offset(page, pfn_offset);
> >
>
> With a comment added to the code,
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> --
> Mike Kravetz
