Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1512C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732D42081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3pzMB1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCHWqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:46:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36138 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfCHWqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:46:35 -0500
Received: by mail-oi1-f195.google.com with SMTP id t206so17146936oib.3;
        Fri, 08 Mar 2019 14:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFcYUr04KwGP5Qc7R1Y9xAYqLxD0IXc69XmuN4hpOKo=;
        b=S3pzMB1xxyA6ySeElsxo9LkrPd8vvsAd9YuftDp+ErSPcBUrnX1+UT66XVbDo45BBE
         0J7gf8E9bGqm8AM4e49/t/zJJyOtQJ5MD5uBMx2tK/QCNDt2iTbt35JTVs1rvgfNHco4
         ZzwVhDghiHYNAz6JLYLNWc8Nixm0JjW7OCqYzBdylXkky5cyhbHG9aaxoMm/sY1tbAqO
         dVWD7X/KgRwfZJvciNbl/1dX9D24hRDpdVx4XYF9F8uCQec6+hGc2q11YfAKkr0DYvot
         dP2HIgFX04WICbBMwSdLlP68pMty/3Q/eUUW5Va4D87LOkYS+U0EZ9+6UxwsL7CkgvZm
         Vuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFcYUr04KwGP5Qc7R1Y9xAYqLxD0IXc69XmuN4hpOKo=;
        b=txLktamkVDONEJE5Klwx58Gl4L0ocU+im4LAPizJkgK/L3K43Q95rwERrVveFbBl9Q
         57pEMrkDQd2TyFOnS36ZzNX8gzvyoymZIJVRBygVm5Hxu3qalB5dk5K8yxBmhZs7zhuo
         +Zyd1p85uvpouDCe57hjbvIJabMpuwTmoHmSqNRmYIvRMWUdFxsz2ZQvCsct8kwTK7ji
         1QW8QpZaWNyjJCfE0XqS688P/GlrJOCQGIpa3OwiHwt2YYEcjjLmKwRwLFHPiMyfpJaf
         DmiC7FhkTXTo9ooMlBLy9UFxTBRiRpFkM5YlP+8dx0h+zk9lTtPqidCwUjM1FLaqOk1z
         uCDQ==
X-Gm-Message-State: APjAAAXvIYAu7BYWmHiA1lQk8AOw1emU3oMUTb+OAyjl813H6IYwRudq
        0YttJzXiYYPpmzOIsgUMLMi3clKi5MYimnlQhcw=
X-Google-Smtp-Source: APXvYqymlen71oTRVJuHZrg7LqDOK/FssHEblQ1x/y9bo0Hz6Ic6dza5E6QUuFTmGbfAtUC4dhzymjH8r4eVhQenxBk=
X-Received: by 2002:aca:5d0a:: with SMTP id r10mr9305475oib.92.1552085194812;
 Fri, 08 Mar 2019 14:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20190308175935.21904-1-TheSven73@gmail.com> <20190308202936.GA32641@arch>
 <CAGngYiVgEDTQxynjPDMO_ZApAX6uyvUL+iqyK-QHnhDz=E4eCw@mail.gmail.com> <20190308223249.GC32641@arch>
In-Reply-To: <20190308223249.GC32641@arch>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 8 Mar 2019 17:46:24 -0500
Message-ID: <CAGngYiWSaJqtzUA+nUNJTcssUq1Y=UzYc2u8hDcKDjF6944o1Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: fix use-after-free on device remove
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 5:33 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
>
> So perhaps that change deserves a separate patch because it smells like
> a code cleanup.

Not really. This patch fixes the order in which resources are torn
down on release().
You do this by fixing the order by which devm-resources are allocated
on probe().

So it's a fundamental use-after-free fix, and not really a cleanup.
But I'm happy to split into multiple patches if you want ?
