Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507ABC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDC22084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ss3lFDmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfIKRf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:35:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32770 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfIKRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:35:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id g25so22118748otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEfrk6KvUm4zkJzNEnqhME9vQpfgK19PybX3jXtohZo=;
        b=Ss3lFDmf2x1zmO1RCvXlfUtFdYVJh0kNCj3udMihFRoZiN/GWtF+/4KvyzEQubX/KW
         iBu3xQLy7jsvT6xaWVkJLfsbEL/t5g94+kfe3NqgjagfCJbtbHrjENvnn8uOMcZFuWca
         +zDutqYLaEIojaveCLCcZw7YstXFgG9iDo2/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEfrk6KvUm4zkJzNEnqhME9vQpfgK19PybX3jXtohZo=;
        b=LoxeHihWOGn8XGIQ65jUZ50mup0AGpm4wzo+JbHRZlvW/+EJEbX9Xoq7ZebNrOIiuW
         ebKX6FYukdVQNcBHEdlx4jefkVc+SOm/SH5YhEgyNXbwcF+ozxayTpPSm6gcEW3YqRZW
         ZX87h19hmrF5ObBQyIo8t3L9mBCoSccRht6+/C6ZEixT9Gmpc3kizx04mRrvt/Xe8swH
         3wyP0pb2A7DsDjXXMr+QteaA8F51hPRP1ONtd3VaXQ03siTQiUyinSab0elvNau3QmUW
         ftcnwufQyX1ZU4x15SaQlkqhhmtrZgWDQCpFOCIb0teBMqRx+vXhVua7tXyjvyEd9ixO
         gxLg==
X-Gm-Message-State: APjAAAUmxnmmc9qPB9VWymKkPhZIXvQT1ApAGRHrdl7leuxX0CJsmIXO
        pgb/18/V7n4XQCSu8/PUlBYYeF520Sn1bnONEWuwpQ==
X-Google-Smtp-Source: APXvYqw3z/39J3ppM7jVmY15tndaCB9Zdaqc203+jWogzJDkjqR8oemXGl5cld6feJSozj9QyZvIBinE9kz+zlDrRX0=
X-Received: by 2002:a9d:6a95:: with SMTP id l21mr4192885otq.127.1568223326279;
 Wed, 11 Sep 2019 10:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190829212417.257397-1-davidriley@chromium.org>
 <20190910200651.118628-1-davidriley@chromium.org> <20190911051240.2k2olzsc3xnqaggl@sirius.home.kraxel.org>
In-Reply-To: <20190911051240.2k2olzsc3xnqaggl@sirius.home.kraxel.org>
From:   David Riley <davidriley@chromium.org>
Date:   Wed, 11 Sep 2019 10:35:15 -0700
Message-ID: <CAASgrz3rA-i3AjT3UuG7gPTHzdHppNLR3C0j23DEgqxivXtPmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Rewrite virtio_gpu_queue_ctrl_buffer
 using fenced version.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They were based off of  Linus' https://github.com/torvalds/linux
master from yesterday.

I can rebase onto drm-misc-next.

On Tue, Sep 10, 2019 at 10:12 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Sep 10, 2019 at 01:06:50PM -0700, David Riley wrote:
> > Factor function in preparation to generating scatterlist prior to locking.
>
> Patches are looking good now, but they don't apply.  What tree was used
> to create them?
>
> Latest virtio-gpu driver bits are in drm-misc-next (see
> https://cgit.freedesktop.org/drm/drm-misc).
>
> cheers,
>   Gerd
