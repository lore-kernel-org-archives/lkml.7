Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D988DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9789D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ebLoXPCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfD2Oo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:44:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50274 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfD2Oox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:44:53 -0400
Received: by mail-it1-f193.google.com with SMTP id q14so16596556itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XMGdoAytJZYLIEjS5YuwMYRgJWQI6ikHtyLu0eBdrg=;
        b=ebLoXPCvsVtjVKlYnuDaoE/vTcZEjFgtCNZy/GJ9RM7CqdGpbdNpyJ/MGlHiTn8mwU
         cNsqm35xFbA0XbkywCTWXXW+87WMdZDdAr99EbknWBCCfipowQkXrsgbO/O6/TKeHRKm
         YCZ4hxNICRW4XSQ9d5gCdAf72YEQsAM9IZEJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XMGdoAytJZYLIEjS5YuwMYRgJWQI6ikHtyLu0eBdrg=;
        b=gJL7rGyiBHJlAtMbB1FrirEg6fO31kVNXs81t0OcqO4mpxYB5nCJ7KbIXLcBYC02sM
         W/vBEm6YgLlPqWsWIiZlXc/Y/mPhk1EiTZLPrRe1mtFCG0WFmSIjmjvYKMRoIxskNpNT
         p8Fko5e60jf3aV3jY+CyC23VMDAdBycWsCsd1xto2c4e5JND/SJof8kfa8n9ibvUiX6u
         FhBvy4xZ0MCN+OFXiNypSzMXwLRq5DqCzatZqFctMyF/73qAvf+J3LLDZ6aAFfDsE63G
         oR6Ku98yfz4SP5a9N40PU5ajP9ATsjx2Dm7uyHT9itQYZ6qj3GeObsDv3e3umN3hnpBG
         Urow==
X-Gm-Message-State: APjAAAVZqozJ+/pznzRaETcOW/PDwJgGw94fnWlVKTSnOv0bXNCRNhe+
        VjBtHhZuiuATJA4oq8Fd/4UCS1oYz7Y5wXckuY+5hQ==
X-Google-Smtp-Source: APXvYqyC+k0ZQbGHt6LZUZL+iV+YTOgPi+kmdEsi7UKxu3MuNzurrBR7OzXmdy7mQ47RnHA3m349CFEdQv66aJzM/2c=
X-Received: by 2002:a24:6f48:: with SMTP id x69mr5454748itb.117.1556549092746;
 Mon, 29 Apr 2019 07:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190426053324.26443-1-kraxel@redhat.com> <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
 <20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org> <CAKMK7uFB8deXDMP9cT634p_dK5LsM37R1v_vGhAEY1ZLZ+WBVA@mail.gmail.com>
 <20190429143757.yljjfsgobhi23xnb@sirius.home.kraxel.org>
In-Reply-To: <20190429143757.yljjfsgobhi23xnb@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 29 Apr 2019 16:44:40 +0200
Message-ID: <CAKMK7uE_+-pFuVrqznj9ZbRxwyNM9mRhoY-y4xCBjjY9Z-sNDg@mail.gmail.com>
Subject: Re: [Spice-devel] [PATCH] Revert "drm/qxl: drop prime import/export callbacks"
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@redhat.com>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 4:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > More useful would be some way to signal this self-reimport capability
> > > to userspace somehow.  See DRM_PRIME_CAP_LOCAL patch.
> >
> > Userspace is supposed to test whether import/export works for a
> > specific combo, not blindly assume it does and then keel over. I think
> > we need to fix that, not add more flags - there's lots of reasons why
> > a given pair of devices can't share buffers (e.g. all the contiguous
> > allocations stuff on socs).
>
> Ok.  Lets scratch the DRM_PRIME_CAP_LOCAL idea then and blame userspace
> instead.
>
> > > Right now I have the choice to set DRM_PRIME_CAP_{IMPORT,EXPORT}, in
> > > which case some userspace assumes it can do cross-driver export/import
> > > and trips over that not working.  Or I do not set
> > > DRM_PRIME_CAP_{IMPORT,EXPORT}, which breaks DRI3 ...
> >
> > Yeah that's not an option.
>
> Good.  Can I get an ack for this patch then, as it unbreaks DRI3 with qxl?

Oh sure, acked-by: me. Sorry forgot to supply that ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
