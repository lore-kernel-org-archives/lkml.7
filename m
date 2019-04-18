Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC5DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8C52183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555597978;
	bh=CkPZOYqUDp14rSOXDgklNUzDl96Ldze1qzapztU8hgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u+zdMagz4xHP/uwmIi3f56Bs42XlJ+RFErjUQSk7nPgp3rXbhHhTRl1PfB7aU3Ujt
	 Ru+NuAhgkippJjoO0PPN4UAlgmKVhjKzd/6h9FyoOnYvzi2posAj3cobIhENFgroyF
	 16rZx3cGaRKxxBYMtRthPfJnaLOXeEfDnDMVCQxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389369AbfDROc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbfDROc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:32:56 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD27A21479
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555597975;
        bh=CkPZOYqUDp14rSOXDgklNUzDl96Ldze1qzapztU8hgo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hn9Lkl80PRY10b5FWPqFkthf36sJl7pJIS3DAXnIp6LRMz9Wat0EIc6cHI8oGnCL/
         NUQKJTJo/tDYahEbDvMsgsCbk0//oFwWY477VDWFJBZg1sxA3D2+dqiINlDZFfpkvI
         pDtFlwxCX/ETL1hr/qCBgxR72L7a18q2nEvLz50Q=
Received: by mail-qt1-f179.google.com with SMTP id k2so2394898qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:32:55 -0700 (PDT)
X-Gm-Message-State: APjAAAVNxmCEEIydyxHoSbTLo7mVvrSTxxBpwtfhFx8pEC0U0hIMf9Ia
        Cdaev9nUHO08JXxGVg5K4thSmhJd08kWDhZ4IA==
X-Google-Smtp-Source: APXvYqwwEQ4iQws7A2Rvq1wH85+VjZMESrPoYYvdrU/izAhmQrvigXOrAnl3lS2UoVQvraJ4agPBxZz7PtCuoNiALnY=
X-Received: by 2002:ac8:7647:: with SMTP id i7mr72198284qtr.38.1555597975053;
 Thu, 18 Apr 2019 07:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190416150051.34092-1-yuehaibing@huawei.com> <7c9d75dd-ec67-4491-ca0c-79743211f308@arm.com>
In-Reply-To: <7c9d75dd-ec67-4491-ca0c-79743211f308@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Apr 2019 09:32:44 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5R3WWk-CmagO9=HE2nqPyGoHJ9aankYWh2ZOSO+k=eA@mail.gmail.com>
Message-ID: <CAL_Jsq+5R3WWk-CmagO9=HE2nqPyGoHJ9aankYWh2ZOSO+k=eA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/panfrost: Make panfrost_gem_free_object() static
To:     Steven Price <steven.price@arm.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 9:51 AM Steven Price <steven.price@arm.com> wrote:
>
> On 16/04/2019 16:00, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > Fix sparse warning:
> >
> > drivers/gpu/drm/panfrost/panfrost_gem.c:17:6:
> >  warning: symbol 'panfrost_gem_free_object' was not declared. Should it be static?
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Steven Price <steven.price@arm.com>
>
> Although while we're fixing sparse warnings, there's a few more in Panfrost:
>
> -----8<-------
> From 8aaf778262744cfbebb9b7f274ead9ba600526b0 Mon Sep 17 00:00:00 2001
> From: Steven Price <steven.price@arm.com>
> Date: Wed, 17 Apr 2019 15:47:49 +0100
> Subject: [PATCH] drm/panfrost: Add missing include
>
> Fix sparse warnings:
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:133:5:
>  warning: symbol 'panfrost_devfreq_init' was not declared. Should it be static?
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:168:6:
>  warning: symbol 'panfrost_devfreq_resume' was not declared. Should it be static?
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:182:6:
>  warning: symbol 'panfrost_devfreq_suspend' was not declared. Should it be static?
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:212:6:
>  warning: symbol 'panfrost_devfreq_record_transition' was not declared. Should it be static?
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
