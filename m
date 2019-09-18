Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A6C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B1622490
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vV8oMvOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfIRTpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:45:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36262 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfIRTpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:45:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so695183oih.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFRuQuV9XjCqqduSCnKp7lM1BpDzx2ulePxOFHhxylY=;
        b=vV8oMvOLZnR1Wz2UcWF5lk/DQOyFhdBBIgYV3sjsEq6s/bSlOfU21/Jc9BsD0xtuqQ
         U5R/RflBDY3JWtRhe4C3seGlY1sGIBFYT82y3oXXWSu0goL+yus2MucrrO8whMtfHoqP
         J1i3dkGqBZau5j3fbxnW7x9URktaqvP9XA0bv24JgXlGONsK+bgu2vtnRRVP8sd6ouRa
         WLhKZi4uo/PxDytqa95O0gf8W975W7nHZeDLuM/4OvqkAhxxIsy1/ORInMPizexzzIE4
         Kwx+GYqBYFvMNZrVtrfID+iN+ejO/wqIXxkxQ7Z5orwBC/Xx/JZrHyjKO0rv8ueIyi29
         apRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFRuQuV9XjCqqduSCnKp7lM1BpDzx2ulePxOFHhxylY=;
        b=eSQxnNubfpJRDgVWy/T0zN3bNG38sOsTbe31sYfsvEzzhVrCyBuUHMchVsqVDkd8Bk
         8WBizlE+TXiUl1Kq8xdNEM7hNJhWTDnUdhSivdgHbr7jKIm/NVufEu4WGJabDmMhiDkQ
         XgCjWsM3XLYrwzUKJyK37aCO/aLWZDbVQo6mtOMDQ1cAU9oKHlYB0Yp7SXQXTbrCQKb7
         1991njYDVHiXfJWKecvRB5FCU7bAzh4Oh1YNHvjQFBBVwVGh0267V1suvXSmDo+MvYv/
         QAD1SQXjxPZwrQ8BmjmA6mVYRpcSXZBtdHsQzlbAvOuKeGQ3WN80D71fxtCZ9kvUNw6f
         M/aQ==
X-Gm-Message-State: APjAAAVmH8ryXyWdRZwoU1UuDweuSWfY7OfxT69OQXmduBr7ZDxNZ1c/
        GwlsP/ARCT6WqAHBoYWLJDL8E+Q9QFGnHZokbIyQMQ==
X-Google-Smtp-Source: APXvYqxWS0XYUX1CSpnY3gTX28OO3/FQnJB5A3pp7NjvWrHVFfXoTCc7kD/+pUTCbd/ehw2A6/9H1eO/dtXJVnFDswM=
X-Received: by 2002:aca:3bc2:: with SMTP id i185mr3637318oia.77.1568835943095;
 Wed, 18 Sep 2019 12:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com> <20190918190529.17298-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190918190529.17298-1-navid.emamdoost@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 18 Sep 2019 15:45:32 -0400
Message-ID: <CAGngYiUJYUGN9CA1smKvy3GF=HWEXtaSdCZHEK64A_63edqF6A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Christian.Koenig@amd.com, emamd001@umn.edu, smccaman@umn.edu,
        kjlu@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 3:09 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
>         i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
>         if (i2s_pdata == NULL) {
> -               kfree(adev->acp.acp_res);
> -               kfree(adev->acp.acp_cell);
> -               return -ENOMEM;
> +               ret = -ENOMEM;
> +               goto out3;
>         }

I don't see a corresponding kfree() for i2s_pdata in acp_hw_fini().
Could this be a memory leak?
