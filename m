Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD4AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226202071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574440434;
	bh=0Adq0cz7fbHoUOTKT+s9l1SPAPwabZRExUUmuY6Sx7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uJmTUIrdgDUV8VLkp3splyjwDML4GmvlUyZzjJpwmP1BtTYnkWju9F1jVm+czfMQM
	 4umssGnLgmJWFprI0FMPUKhRrcQtD9JjtwZSJtwYhKKpBobABMAT/uJ4+o/5gS35hI
	 +NNDClE4iGBECOUiKyB2pFbi3nzLtbh8XxOvkLrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKVQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVQdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:33:52 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BF220726
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574440432;
        bh=0Adq0cz7fbHoUOTKT+s9l1SPAPwabZRExUUmuY6Sx7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6oUiLfCGwAyPMNAv+ioG5XZ7ORx3ZNVXsaOH5HgayrTF7v2Sh/wqScJjuqKPqxmU
         k2JkKLVQjliVzIxhyMOrbM4/X65M5tywH5jd2DLNZKqDY9jCT5T/XTJ/Y9HVF8Fhg9
         ifib79nGisdM8psZ5sZLU47mqCTHAo7wSTZdPsmk=
Received: by mail-qt1-f177.google.com with SMTP id y10so8477195qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:33:51 -0800 (PST)
X-Gm-Message-State: APjAAAV9nXLgvR/pekBVvk5f4FeoL3dV9UIpk74jtmVDMoy4luFVC4+F
        O5IaykBweNgzkZqcw0EdWzMYM6li4UTS7ctDvw==
X-Google-Smtp-Source: APXvYqxchCFnjicpj/mI4c77iDCN/gC9ccsQrxBycA7EYCX5YjWvwLHuCLYbnAj5UJswQc9IhOoMnO8aF/oMxE2ZINM=
X-Received: by 2002:ac8:458c:: with SMTP id l12mr65541qtn.300.1574440431080;
 Fri, 22 Nov 2019 08:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20191122063749.27113-1-kraxel@redhat.com> <20191122063749.27113-2-kraxel@redhat.com>
In-Reply-To: <20191122063749.27113-2-kraxel@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Nov 2019 10:33:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8+REqdZKCwPbsahdRPFd4dTd9vHq4RT_zcwFqikR9qQ@mail.gmail.com>
Message-ID: <CAL_JsqL8+REqdZKCwPbsahdRPFd4dTd9vHq4RT_zcwFqikR9qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: call drm_gem_object_funcs.mmap with fake offset
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:37 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The fake offset is going to stay, so change the calling convention for
> drm_gem_object_funcs.mmap to include the fake offset.  Update all users
> accordingly.
>
> Note that this reverts 83b8a6f242ea ("drm/gem: Fix mmap fake offset
> handling for drm_gem_object_funcs.mmap") and on top then adds the fake
> offset to  drm_gem_prime_mmap to make sure all paths leading to
> obj->funcs->mmap are consistent.

IOW, v1 of my original fix. :) Though you did it a little differently:

> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 0814211b0f3f..a9633bd241bb 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -714,6 +714,9 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>         int ret;
>
>         if (obj->funcs && obj->funcs->mmap) {
> +               /* Add the fake offset */
> +               vma->vm_pgoff += drm_vma_node_start(&obj->vma_node);
> +

Can't this be moved out of the if and then the same thing later down
removed? Unless there's some requirement that drm_vma_node_allow() be
called before drm_vma_node_start() in that case. Doesn't look like it
to me, but I'm not really sure.

>                 ret = obj->funcs->mmap(obj, vma);
>                 if (ret)
>                         return ret;
