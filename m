Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385C1C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F155D2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557759392;
	bh=DPb0oP/MTVPYW19qM5+S/ZobSstLVv1G9/bvsnkeDh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P6HZE3Z1Vu9q5NuHmIXI+zk/hD8lGWBY17EIJ+rKqwc5odz2WFNFQqfCuFWE9/9IM
	 Wd9q3+NAmb9vis1F5+t6yrPWCY0o8L3etH3crOMkCw7FBj3AioUObljtSdsHbgrFXH
	 gBG28XPT1KQeruDZ9MOnEwYtNpZEVpVSniipJkNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfEMO4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbfEMO4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:56:30 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72BC2133F
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557759390;
        bh=DPb0oP/MTVPYW19qM5+S/ZobSstLVv1G9/bvsnkeDh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IQT90J1gBxETvADWSS2inwwXRWznQ68wmiBOUpXmxy+S8GGk8sVYebiGP2VIl6rEx
         bIIm0wsV5jep1nrj7BGQzqT7mBulT6ULTbUx9/fPeTYUZuMzOOvG3L9ivcQLainTj9
         Y6Olg2Lni78NM+ltXnD+030ujuRRyBkbMT6YbASs=
Received: by mail-qt1-f178.google.com with SMTP id r3so15031357qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:56:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVtrG7WHbaIVZUYAqy/KqrC87xevI2UfexqCCnP4XmQnXx5S9yz
        WM7eADOpuNHDCM7wk2GcHyxJ5LhnYPbAJ11QTg==
X-Google-Smtp-Source: APXvYqx3TUVas20VXhQI7JUnuJZgbmCUb7Ybz7s6QU0UhDpkeaoYIRp0leer5RB+/pONnGmpl5GRwQL69uTSyWDwlrU=
X-Received: by 2002:a0c:d2f2:: with SMTP id x47mr23231975qvh.90.1557759389164;
 Mon, 13 May 2019 07:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190507080405.GA9436@mwanda> <20190509082151.8823-1-tomeu.vizoso@collabora.com>
In-Reply-To: <20190509082151.8823-1-tomeu.vizoso@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 May 2019 09:56:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ9wd73i+zc4bnF4CdC_2Aa9u7xN1PQTUNbaaT=i1BVqg@mail.gmail.com>
Message-ID: <CAL_JsqJ9wd73i+zc4bnF4CdC_2Aa9u7xN1PQTUNbaaT=i1BVqg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Only put sync_out if non-NULL
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 3:22 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> Dan Carpenter's static analysis tool reported:
>
> drivers/gpu/drm/panfrost/panfrost_drv.c:222 panfrost_ioctl_submit()
> error: we previously assumed 'sync_out' could be null (see line 216)
>
> Indeed, sync_out could be NULL if userspace doesn't send a sync object
> ID for the out fence.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lists.freedesktop.org/archives/dri-devel/2019-May/217014.html
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied.

Rob
