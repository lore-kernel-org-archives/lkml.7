Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACE723406
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566525183;
	bh=PJMc6ZKXa/g7b223/+IaOfRLu5NCsAji7zbyi99Rxnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r+fnAvOJBzcC1rLmjnyauMGTxSxwXMmp89WBzOd/cGOMwse1+YjqXrlHkfPAMf8zG
	 DFV8iIAH7HvwdsHCv3YOHziBmeQIh2PnIZmDf1+tp3EW/U7iHkqD8HdE6T6WJ8rMWd
	 YUvSWuUWk6HQqSc2+QStzU4wHRvruHVPz9fJVehU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfHWBxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388293AbfHWBxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:53:01 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49FBD23407
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566525180;
        bh=PJMc6ZKXa/g7b223/+IaOfRLu5NCsAji7zbyi99Rxnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xfMBdrqoXmc7m3LbbE4byZwHzsPlVQD8gMPd1xbVbzV/s7O2qOwPeqOPvCZU7Qx2m
         oF/8cBtjKeFn7jXuSQaPXd977axDelbI4W973BABG4vUsZxnVDeRu2MT8tlqq0rJec
         j4VWYVgrGY8vxY6mbVqTTKA3OQNUeOhexOg0nMug=
Received: by mail-qt1-f179.google.com with SMTP id k13so9795804qtm.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 18:53:00 -0700 (PDT)
X-Gm-Message-State: APjAAAV64jYjalhtZkTeOR0mhoHY/CmdRnPl9bPVoyyosn+DtPrDAVXK
        fMw+vtF3Uy2m4DqB8BTt++9y0bd2MQuDs2q1Ag==
X-Google-Smtp-Source: APXvYqyft5c7abf/T+bpSEI9M+ywHq6Wph5MWDZMqP+5YUyAX8skWG5A3788yiHHwtXhbqi9IRuH2qDSGZMrPQLxNCg=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr2664407qto.224.1566525179427;
 Thu, 22 Aug 2019 18:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190822091512.GA32661@mwanda> <20190822093218.26014-1-steven.price@arm.com>
In-Reply-To: <20190822093218.26014-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Aug 2019 20:52:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+1-qUxF3FSocVis6h4HV-=qnzWfK13hDq+Ns9kNEZuUg@mail.gmail.com>
Message-ID: <CAL_Jsq+1-qUxF3FSocVis6h4HV-=qnzWfK13hDq+Ns9kNEZuUg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Add missing check for pfdev->regulator
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 4:32 AM Steven Price <steven.price@arm.com> wrote:
>
> When modifying panfrost_devfreq_target() to support a device without a
> regulator defined I missed the check on the error path. Let's add it.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: e21dd290881b ("drm/panfrost: Enable devfreq to work without regulator")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Looks fine to me, but seems to be delayed getting to the list and
patchwork. I'm guessing you're not subscribed to dri-devel because all
your patches seem to get delayed.

Rob

>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 710d903f8e0d..a1f5fa6a742a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -53,8 +53,10 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
>         if (err) {
>                 dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
>                         err);
> -               regulator_set_voltage(pfdev->regulator, pfdev->devfreq.cur_volt,
> -                                     pfdev->devfreq.cur_volt);
> +               if (pfdev->regulator)
> +                       regulator_set_voltage(pfdev->regulator,
> +                                             pfdev->devfreq.cur_volt,
> +                                             pfdev->devfreq.cur_volt);
>                 return err;
>         }
>
> --
> 2.20.1
>
