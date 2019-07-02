Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3BFC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F6321721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryyozQML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGBRDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:03:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33892 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfGBRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:03:24 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so38765563iot.1;
        Tue, 02 Jul 2019 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coCn1S/KhTlU6UnovTFnkK0gRN1c323cXsK4kHrMZx4=;
        b=ryyozQMLfXxI705cSwC2vCV77+ux9SbAMvRyV52eweQ45EjCUkQYAJDtX7lAdis14Y
         MHZBQ41ADOI6DCMm8kzW5d2SyGyfTV0EVTiK3dPk9ZMX3rkgq3UnVLSj2Q/9BkdM2W2T
         2VuKWrxHqYVX39Gs3RV7OaxUmH4OICxe2QRfCDqG0xT47qBfzvZJMnNeq08TG/SAityp
         tqS2PpaALsQdIp6RuwXH4h5zm5fRA9fOkrY+Q0YtQmGLBWHwR3acOdf8UWf1SmKwXKsq
         KggQbCfbZIAeIpjXiWlDE+sM7Ud7MUkCxhOmEj8s4rMLM8fmCLQFYBsllSBiAS43UH5i
         cggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coCn1S/KhTlU6UnovTFnkK0gRN1c323cXsK4kHrMZx4=;
        b=BGZr3AFtKC7gQtDfEF8KvdoXYCzIiK3+n7Qri0auYSIuraICO8lUruUKz85yFr2sZI
         +vYsm1e1OTpwBr+5+11nP0jbV/t6yBJcBFBfLTSw/JbiUsYtt1yio4dB8MPrRlZSi7Qf
         8BWDMJ0+xzWQcP1InpKBAX8pWBzE7fPX6wXq6HhWw7tSK3R69RTGb+yHUdN4l6NeFG9m
         infATqtUQHpseqdVuHgpsFZ0hJDXcseFGcYgLtjXKVzmypRhgDjTAA9qO5dhuoHYnN64
         FZLqR6CIIMBjBLCwBgpuLirfNqQm0H9OC8iVRmDGVgzL9SGvxbH763/cjqDgSfW/q/So
         DG7A==
X-Gm-Message-State: APjAAAV0jGiiSwJ8W9CwsM5NAQe4i96Qh+91ZVQbUXQa19XooRceYyua
        vtzMD31u7RGXxNAwSUb7iaX5eGmfVI0panBM65E=
X-Google-Smtp-Source: APXvYqxnFMtieZLKZd/T/0vK9Gp3smQydqy37XS5zeh3WsU3mF/z6ESMHfhgZOIpIhAt7qH3m94Mtg0/4O6cvn9KvRI=
X-Received: by 2002:a6b:b987:: with SMTP id j129mr31324445iof.166.1562087003547;
 Tue, 02 Jul 2019 10:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190702154419.20812-1-robdclark@gmail.com> <20190702154419.20812-2-robdclark@gmail.com>
In-Reply-To: <20190702154419.20812-2-robdclark@gmail.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Tue, 2 Jul 2019 11:03:13 -0600
Message-ID: <CAOCk7NqifwhT=MRddB7ikh8My1y6ROL2L1B2k_djfLdd=sAxrw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/bridge: ti-sn65dsi86: add link to datasheet
To:     Rob Clark <robdclark@gmail.com>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 9:45 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The bridge has pretty good docs, lets add a link to make them easier to
> find.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

This is in the DT binding, but having it in the driver as well is a nice touch.

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
