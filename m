Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C62C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681CF217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555597997;
	bh=ZScN0yIxa2Ca7nIYThWONBmva+Cc2sxs/8AL8/sx31E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UyciV58UGBvBRR4AY/tGtcLw9SENseV1aQMTEtxb5t3Dg5LIBF0a3dIL8nyzpTAeQ
	 P+D2FmkskXdPVbjysRlN1CqzL2Q4+8PLSX/EnMj4flA5dcftqEaxv/mE7IvoL/ZL42
	 akMYQWtLrD4Rj2wnQgYTIEHzzMCGwHOokAaq7Plw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbfDROdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbfDROdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:33:15 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78C421479
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555597994;
        bh=ZScN0yIxa2Ca7nIYThWONBmva+Cc2sxs/8AL8/sx31E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p4u/VbM6uHsAznb+2asMPq4Z4I113mfwo3VYzhWrPuq21TbDekkbwav2bY8/Inn/z
         2i7NzNkJLr2V1gVuVB1H9/sLmQR32Yo3WEFJ5+hNPWKUjO+MDWwiCUTBG9ZrmxBsSv
         kVGGaLiAheq9jTgFpYuXt7ezEDmL75vgLdYH3sc4=
Received: by mail-qt1-f173.google.com with SMTP id z16so2384674qtn.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:33:14 -0700 (PDT)
X-Gm-Message-State: APjAAAVyYKNicv9zZeT9Qw/lPza2lPRWN0mEM73xdDDIEDamvLz+v8sh
        sGjujD7Z9Rw36xKeAgSWjivpERO6tSnUFWA+Cw==
X-Google-Smtp-Source: APXvYqzPZaLxAg2XRYcfLeg1/S7T4bQUBJDYXDFzw6ryhSmc1U6zGGYk0rdFHbHWzJi5rPZ4/AjeP1FbvN8XMbf6ivQ=
X-Received: by 2002:ac8:30bc:: with SMTP id v57mr77866639qta.26.1555597994095;
 Thu, 18 Apr 2019 07:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190418084305.45021-1-tomeu.vizoso@collabora.com>
In-Reply-To: <20190418084305.45021-1-tomeu.vizoso@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Apr 2019 09:33:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKJmhrYYQ-WANKk9haMoEyED6NmtPqMq9v+5ocOzEwicg@mail.gmail.com>
Message-ID: <CAL_JsqKJmhrYYQ-WANKk9haMoEyED6NmtPqMq9v+5ocOzEwicg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Prevent concurrent resets
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 3:43 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> If a job times out in slot 0 while a reset is performed because a job
> timed out in slot 1, the drm-sched core can get into a deadlock.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 1 +
>  drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 4 ++++
>  3 files changed, 6 insertions(+)

Applied, thanks.
