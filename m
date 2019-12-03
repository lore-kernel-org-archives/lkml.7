Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98415C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5925B2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTWcfIvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLCTkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:40:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfLCTkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:40:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so2126159pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfDVgB5+i6zMO7sX/GHYsvnOpqqvJcvPmfj3Eu7Zh4c=;
        b=mTWcfIvZlqb3Fyx4NUGszEs7Ru7EDfEdW7iIznueVQ4g/GPjYgnNGS2wbbUBGSq0is
         EgMnNCa6m9Mgv/iY1hRqtlsSwWennBTCnoRYhRNlWOljckrrN0jfAEpz8r8lJi36+eCr
         b3MggEuXHLQsyTv+E9SDS0+hnNDjFj3ssH1AziU2GW/8WWTow6FtxOQp8Gf1K0uDIaW/
         yHUeLieIY8k/2hmKdw0qD2miEx7hGaLgBUWaLLpmJQP01G5dY/F4DBnFPzDJ0W4qAO3L
         3HgkRxJKNVAZf2+Ue635aFtvTUPuY8FFFt2CCkaUPsU9a6k/fexPl05lA3W7eZ7BbIcA
         idxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfDVgB5+i6zMO7sX/GHYsvnOpqqvJcvPmfj3Eu7Zh4c=;
        b=RUc+qNq0/YwtlovfGYYWZYKo9waMoxD3l95tID41xs3avTNnvCd0z8+fCXImbZ6AmP
         66dTnyJfAbwGy8M2YtRFmRgU6aQl4hntZtYkua+6fHUl90leSYHSm+GlKz0z42LLTLRW
         cwk90SYc/z7S5Wk14pF7D+XEk3PM5jO/iqjrtr2+Q0spWgAkamt0bd25Du1Tn7G4wIPs
         tbTGqq33KVeu+nspzhZ1d8DF5eIZ2Fd4vxne2AjTpYXT+LmSIBfuwlLkV7RxDrO2Dd9m
         q5iySZZ1bazjz9I1HfnLGX3z+BWVswWPMzX9Xc9ezQ9uSC0HgVjrlSJO6VIiJep2JhxQ
         4bKg==
X-Gm-Message-State: APjAAAWYYrsLC6n6raelLJK/UblR2krc9i7/fXphUM2FE0pYX5JvCpAM
        9KOMMbBfnIvRmBHzOUYGdvL2p9MeT9OWolHIasQ=
X-Google-Smtp-Source: APXvYqzjpbPmnmo7+e0YFMOFzXQ62Ql/XSh2Qjwwjzqstd9rwX8jXIFS1c31sqZf8pkK6pCLm6IgvSLfMvKBorczZSM=
X-Received: by 2002:a65:44ca:: with SMTP id g10mr7238631pgs.104.1575402050480;
 Tue, 03 Dec 2019 11:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-3-xiyou.wangcong@gmail.com> <dc182be3-be98-9a8e-013c-16df0e529ed2@huawei.com>
 <CAM_iQpX3MKoBRvxqc-bJ0HvASNeZmvVCYhbT53maMy-rqy4eiw@mail.gmail.com> <9996d30c-e063-e74d-925f-4181c36ca764@huawei.com>
In-Reply-To: <9996d30c-e063-e74d-925f-4181c36ca764@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 3 Dec 2019 11:40:34 -0800
Message-ID: <CAM_iQpX+V=Hv+3QQU-FrsRKm=75cghSTx-ip2oU=Mn1tdXywjA@mail.gmail.com>
Subject: Re: [Patch v2 2/3] iommu: optimize iova_magazine_free_pfns()
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 2:02 AM John Garry <john.garry@huawei.com> wrote:
>
> On 30/11/2019 06:02, Cong Wang wrote:
> > On Fri, Nov 29, 2019 at 5:24 AM John Garry <john.garry@huawei.com> wrote:
> >>
> >> On 29/11/2019 00:48, Cong Wang wrote:
> >>> If the maganize is empty, iova_magazine_free_pfns() should
> >>
> >> magazine
> >
> > Good catch!
> >
> >>
> >>> be a nop, however it misses the case of mag->size==0. So we
> >>> should just call iova_magazine_empty().
> >>>
> >>> This should reduce the contention on iovad->iova_rbtree_lock
> >>> a little bit.
> >>>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> >>> ---
> >>>    drivers/iommu/iova.c | 22 +++++++++++-----------
> >>>    1 file changed, 11 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> >>> index cb473ddce4cf..184d4c0e20b5 100644
> >>> --- a/drivers/iommu/iova.c
> >>> +++ b/drivers/iommu/iova.c
> >>> @@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
> >>>        kfree(mag);
> >>>    }
> >>>
> >>> +static bool iova_magazine_full(struct iova_magazine *mag)
> >>> +{
> >>> +     return (mag && mag->size == IOVA_MAG_SIZE);
> >>> +}
> >>> +
> >>> +static bool iova_magazine_empty(struct iova_magazine *mag)
> >>> +{
> >>> +     return (!mag || mag->size == 0);
> >>> +}
> >>> +
> >>>    static void
> >>>    iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
> >>>    {
> >>>        unsigned long flags;
> >>>        int i;
> >>>
> >>> -     if (!mag)
> >>> +     if (iova_magazine_empty(mag))
> >>
> >> The only hot path we this call is
> >> __iova_rcache_insert()->iova_magazine_free_pfns(mag_to_free) and
> >> mag_to_free is full in this case, so I am sure how the additional check
> >> helps, right?
> >
> > This is what I mean by "a little bit" in changelog, did you miss it or
> > misunderstand it? :)
>
> I was concerned that in the fastpath we actually make things very
> marginally slower by adding a check which will fail.

The check is done without any locking, so it is cheap. And it is a
common pattern that we do a check without lock and do a second same
check with lock:

https://en.wikipedia.org/wiki/Double-checked_locking

Thanks.
