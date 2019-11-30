Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C6C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567072082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRlw7VAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfK3GCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 01:02:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46854 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3GCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:02:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so15653730pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 22:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hCkQvVpA+xQBSnTmW523N5CEpD+qnerHkkfRy0+khQQ=;
        b=YRlw7VAh8iujb7Ncv63hBBkYJHJMFRqAYUcNCfa1cvrX7cBHSA4d7N+hBGVjpc90QD
         ff1rQJK1BrR0FdThU7OziQhZOcAPDL2XQ2fDZ5ncAz+fq5lKuXq8r/Bad6K63JPzHh8V
         KG9ZIbtq9BvbK2s8h0bMKL3JdsSaq3Ab+TGrgyUMu5e3hQ5UjtYPa+b2FFz6BmW3MRQp
         3eDtrBI0wLWlATOOZ9nOYnvgL2DTtVIONzYhnwxfwkr/BsVIXu6+P5eKbSsmBuFq07n4
         e8a4aE+FIJpnnmMd5C4k+hv9/jTyG/AJxpQx/hGLAg4vkP7/y5APHNpQ/WJC5NEsvvIt
         NV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hCkQvVpA+xQBSnTmW523N5CEpD+qnerHkkfRy0+khQQ=;
        b=PxAQdOklROlp6Mm7GCHUbQbIX4rv8HH6lzzFwK0K1suWBskoP/4DySGx1nsb6NO/ab
         MZwvcn57Fk3H4QJcS1OyhQX6ZXFEUrzjyfR+ETH1Nk8cu4Lz8UAEVhDKSVhOcfJbQGXK
         C5v+QN0FDM4oe0TtR0vVlZJJtSJz2xE1uvQtiItKSECfcEkWI2chnYXJDMWmDSXhezLR
         cRX7BICiy4lnpl1iXKNVlSUpsANeEuOBpwJnXuXJ8+DAoD3AkpSQglKEOVhn50aHTYO4
         l519B2fmppdMQMFeqYXJ1Q2dXDLKNXxwnfoy85xcswcJ3A+DaQ3u7iJHHXs5iDxitRgf
         eQfg==
X-Gm-Message-State: APjAAAX6ArH6sEM51wWIIE0nYNAFY/ZH/Sx+Dd2LOjA2eTeyuaJ55prr
        KCv0xqqO2ug6SRMWzgBA/WKDBTxSHfX3tuwZhoXrEi+/
X-Google-Smtp-Source: APXvYqy8BWakF5Y2JarZ6sTaCRPFV3SoHmQntxhp/EsJ1Pd8C6oVwFtufzBlBSH7O4Xlgl1i2Ejs93KtBgKyCnqP9U0=
X-Received: by 2002:a63:e4e:: with SMTP id 14mr20530973pgo.237.1575093740272;
 Fri, 29 Nov 2019 22:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-3-xiyou.wangcong@gmail.com> <dc182be3-be98-9a8e-013c-16df0e529ed2@huawei.com>
In-Reply-To: <dc182be3-be98-9a8e-013c-16df0e529ed2@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 29 Nov 2019 22:02:08 -0800
Message-ID: <CAM_iQpX3MKoBRvxqc-bJ0HvASNeZmvVCYhbT53maMy-rqy4eiw@mail.gmail.com>
Subject: Re: [Patch v2 2/3] iommu: optimize iova_magazine_free_pfns()
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 5:24 AM John Garry <john.garry@huawei.com> wrote:
>
> On 29/11/2019 00:48, Cong Wang wrote:
> > If the maganize is empty, iova_magazine_free_pfns() should
>
> magazine

Good catch!

>
> > be a nop, however it misses the case of mag->size==0. So we
> > should just call iova_magazine_empty().
> >
> > This should reduce the contention on iovad->iova_rbtree_lock
> > a little bit.
> >
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >   drivers/iommu/iova.c | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index cb473ddce4cf..184d4c0e20b5 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
> >       kfree(mag);
> >   }
> >
> > +static bool iova_magazine_full(struct iova_magazine *mag)
> > +{
> > +     return (mag && mag->size == IOVA_MAG_SIZE);
> > +}
> > +
> > +static bool iova_magazine_empty(struct iova_magazine *mag)
> > +{
> > +     return (!mag || mag->size == 0);
> > +}
> > +
> >   static void
> >   iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
> >   {
> >       unsigned long flags;
> >       int i;
> >
> > -     if (!mag)
> > +     if (iova_magazine_empty(mag))
>
> The only hot path we this call is
> __iova_rcache_insert()->iova_magazine_free_pfns(mag_to_free) and
> mag_to_free is full in this case, so I am sure how the additional check
> helps, right?

This is what I mean by "a little bit" in changelog, did you miss it or
misunderstand it? :)

Thanks.
