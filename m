Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6820C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BED3216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="mnbXHvPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfEHR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:56:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36661 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfEHR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:56:58 -0400
Received: by mail-it1-f194.google.com with SMTP id o190so5402186itc.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhHKTz8mMoSCnbDCtBRD8sjKIRg9nf6n5gxFy6aVPmk=;
        b=mnbXHvPTJVuUQuoWXvkL+9wvd75xxvsse7tZ/Ecxz+gwOxUmAPh3CLNfyI7m1r0A2y
         SyN3/X7R+K+RYjnC0dVycmKkkHsI/y88ffDNRp1lnvATqX7PE2pIM54euZmg/7WhaQVa
         fU1tHBKxNmRZR/+l7hC9n6iXNa+O4/T+c+36xD8yf82EFy4Lh6C7Jx+t33CwfBtid1jA
         TM2iTtelB+hslen66V73HX2/+1PDbqv6c9PQ5LJswTBWBVXE9ofrIQ1Wzp2Mtcl/Y+4w
         SgLgAp1xWh8iUne/CWL9LPP/8MpnlKDImNfmG4IqUcjWAzn4vM+Z39SAJ+WyVwfJVD02
         pfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhHKTz8mMoSCnbDCtBRD8sjKIRg9nf6n5gxFy6aVPmk=;
        b=YPmYWi9IUcDVn+LA0SkqcinsFHbOcLNhI2G7fxFOR9Pg0N2JBnoqnmegDj5vEvFCey
         +HCqKfs/1XE8ZNam3z9uKX05NWX6UcROqFJ6jOQYQtGw3j26L/31IzFjEQqgRiOkpZpb
         kih3K0tFPaR/EBVgUsHk7bEC1daf2fXfOVMUMbWCRtMxpbzFn56PgkClmcsis3dnKKYa
         7dny7X+qn0ZFdry8WZs+nIJ34GH7m2eUPMJ6PlT6Bnkpmvnh7unN5T1A6CvnOgD+pfoG
         10I5mKAmONAW5ejInPgiTbf0VaBSsJMBzmUuNba3uPtgXbS/rRiN/+Rj98b3yA4PtKTM
         krCg==
X-Gm-Message-State: APjAAAVPaCexqeDQKEmBrqlwXTftbrK78vnaMHXNFk3TwYgYKN7X6JTR
        LQrMxe453wngMBGLQ+ZZ5GcOFKmIaF/Q0Ep+pWItjB1DvZf/sd8Q
X-Google-Smtp-Source: APXvYqwwbrSrH8bWql7TsXpdIPRUme76bef88udigyRsDUu+naQnXu4Dyz0DOtKTnPLkIkmFquNG95C6SuAuxBHfAiI=
X-Received: by 2002:a24:9d0d:: with SMTP id f13mr4995215itd.162.1557338217593;
 Wed, 08 May 2019 10:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190409140347.GA11524@lst.de> <CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com>
 <20190508175219.GA32030@lst.de>
In-Reply-To: <20190508175219.GA32030@lst.de>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Wed, 8 May 2019 18:56:46 +0100
Message-ID: <CAPoiz9zQuJ0-9wJBNo=Wvi9qquyid9vjmHODy=VJad_PE=cgdA@mail.gmail.com>
Subject: Re: status of the calgary iommu driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, x86@kernel.org,
        iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 6:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 08, 2019 at 06:42:39PM +0100, Jon Mason wrote:
> > These systems were plentiful for 2-4 years after the original series
> > made it in.  After that, the Intel and AMD IOMMUs should were shipped
> > and were superior to this chip.  So, even in systems where these might
> > be present, the AMD/Intel ones should be used (unknown if they were
> > shipped on the same ones, as both Muli and I have left IBM).
> >
> > You thinking about removing the code?
>
> I'm wondering if we could remove it.  I've been done lots of
> maintainance on various dma mapping and iommu drivers, and the calgary
> one seems like it didn't get a whole lot of love, and I've not seen
> any recent users, so I mostly wonder if I should bother at all.


I do have a system.  So, it could be tested.  However given the age of
the HW, I would say it is not worth the effort to update and it would
be best to remove it from the kernel.

I can send a patch to do this, unless you would prefer to do it (or
already have something handy).

Thanks,
Jon
