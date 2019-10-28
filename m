Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C4CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6DD214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOtAhmLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfJ1WiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:38:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37388 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfJ1WiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:38:16 -0400
Received: by mail-il1-f195.google.com with SMTP id v2so9638978ilq.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pqft6NUgSGPSsYgTI6KAW/EqfWsmOX+X7GP8nWIKRQ=;
        b=KOtAhmLxM5DZQvf2Ll3f33KbklGMeTG2PKDxS+jixVpbEYv/r2fkX8rWW/POBAh8EZ
         bhaa9F6E4wiUOAv7xzTF/OPYtmaoF81sAIOIN1D7uz2hMlzRn/GbsAID1pmlxlh0ULbu
         KCWrpiKfUYuFXj/u1i4vCnm4AsCswlKrH1PH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pqft6NUgSGPSsYgTI6KAW/EqfWsmOX+X7GP8nWIKRQ=;
        b=qeqZBl0bZcuPGz+1sVsvjwYIWkInt9HpM7hHA6t/UwE7h8suTXryTQHH4xt+QBdZCi
         lT4kgqmSk3ewnKY/ChxtIEY3HT5edyQdAMS3Ki1RWzrcUf58CsEfr/Xrl5GIY6SZ3Jd2
         df+BODwdC2MsoHOckbWspsQb51uIqS3ZvY7yfJ0tn/OSCGfqVoWQDP/TgDwamt0gvpNp
         oJrXcpIkjRAw4aSeG4kEu9TNikpqiGCgFXlFvLaIkwM+cJVc5iKOvVQQPkb5YzT1tKyL
         V63zGHv6Js0tWGBXBXuqA6jk7h8TasmzG08uAa1QBFGsYjLj76HHM8bq/2trCBgkgGJ4
         sbBw==
X-Gm-Message-State: APjAAAUmOsGq211reT+VMduhmEFEdAU9sBDwzWxSZ+3G6tz3BYtofDKU
        3no1jHmccOwcAV55gomx8Cos+wbjDyG0h/mI3xlDqg==
X-Google-Smtp-Source: APXvYqzOjbPZql47NIkJK7AmtptD85c0h2swAJ0981IFdP5pW7aIvp/4iQe9Q33o2yPDwnBDa7OGwzugpAmPA0ld6FE=
X-Received: by 2002:a92:6e0a:: with SMTP id j10mr5422292ilc.26.1572302295420;
 Mon, 28 Oct 2019 15:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com> <20191007204906.19571-1-robdclark@gmail.com>
 <20191028222042.GB8532@willie-the-truck>
In-Reply-To: <20191028222042.GB8532@willie-the-truck>
From:   Rob Clark <robdclark@chromium.org>
Date:   Mon, 28 Oct 2019 15:38:04 -0700
Message-ID: <CAJs_Fx7zRWsTPiAg0PFt+8nJPpHpzSkxW6XMMJwozVO6vyB78A@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: fix "hang" when games exit
To:     Will Deacon <will@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 3:20 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Rob,
>
> On Mon, Oct 07, 2019 at 01:49:06PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > When games, browser, or anything using a lot of GPU buffers exits, there
> > can be many hundreds or thousands of buffers to unmap and free.  If the
> > GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
> > for each buffer, resulting 5-10 seconds worth of reprogramming the
> > context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
> > To the user it would appear that the system just locked up.
> >
> > A simple solution is to use pm_runtime_put_autosuspend() instead, so we
> > don't immediately suspend the SMMU device.
>
> Please can you reword the subject to be a bit more useful? The commit
> message is great, but the subject is a bit like "fix bug in code" to me.

yeah, not the best $subject, but I wasn't quite sure how to fit
something better in a reasonable # of chars.. maybe something like:
"iommu/arm-smmu: optimize unmap but avoiding toggling runpm state"?

BR,
-R


>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > v1: original
> > v2: unconditionally use autosuspend, rather than deciding based on what
> >     consumer does
> >
> >  drivers/iommu/arm-smmu.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 3f1d55fb43c4..b7b41f5001bc 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -289,7 +289,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> >  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> >  {
> >       if (pm_runtime_enabled(smmu->dev))
> > -             pm_runtime_put(smmu->dev);
> > +             pm_runtime_put_autosuspend(smmu->dev);
> >  }
> >
> >  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> > @@ -1445,6 +1445,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >       /* Looks ok, so add the device to the domain */
> >       ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
>
> Please can you put a comment here explaining what this is doing? An abridged
> version of the commit message is fine.
>
> > +     pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> > +     pm_runtime_use_autosuspend(smmu->dev);
>
> Cheers,
>
> Will
