Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C9C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270EF208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddD/HTEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfFGSjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:39:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42740 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbfFGSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:39:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so2345514lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBZaGIwgweQnWOXVd6rMqfse78NHRo0T4EcStz9iVIQ=;
        b=ddD/HTEp9Q9UDuxE2OsndGwM27L5u0P3bcjGx9VditCdq16qF4fOWLiTkia5NCHEC/
         1v5Ost4CHsFNdQpW1cFlTs06z2zn4hlRi3dOhy0Uu7+Cxf2W9uhXNrH7aiYYWruJqyrO
         c5ApyyrOQkorfM3Yc7/u5WB/XIvCt0VDQo2wSmDP+4yRe/LxcSYNCqPkQFsIJSNX4La3
         4W8LU8QK/BQczStVvqxD8XJF5uDRZ1lOn5p6x7JfqdxKrel1Q+hFosS6JIDFT0nZIc/8
         N7iLBzKoc2lJGV8v/gHsjhktl8xmPYIastjNXFb/fJnBdnTgux/CvqhXOzNg1+7f+TIv
         14Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBZaGIwgweQnWOXVd6rMqfse78NHRo0T4EcStz9iVIQ=;
        b=J8TIIN8WEvlS9x9MHKevKPF3Esl2C7HSdHtWKQ9U4mHXruVPIA3YlfHtwxilLg2fxU
         2+yU209OWP7CO5vS0EJc5PWjyDKcS6EkwqFILk+wnTgWFQrGy9Y3JAoxjYrglirsX8mj
         29EismBPqUwFSrMd/hfGM0CGFIIfgnzhoni7FkZBL60VkdBxE2hEQCUwqYAwLtz+qaOG
         siVS2LX5rJ5zslJ1DvhSHQSPqS7gUM/u6o5or+vId9Q8hW8UH4vlusvbDxNg87S4XVne
         JMOvOJCDgt/4lMgg+LJw147cJRpM+LjX5+e1fPXq0Vz0GXgr5cJwMycGDloT9vAVp9cv
         PcKA==
X-Gm-Message-State: APjAAAUnF/0vP/K+cRcRB/ZkqIm0OhQFxwZtANasvl+/psBnaxPlbOdc
        5ABB3AFjei3W3g/FOJUpgXDa9oZyw9MR1ehyvLo=
X-Google-Smtp-Source: APXvYqzpYru1mSiIJAYAAln379ADncNx7MWnLg9IN9S/saFxt4Q/t15ioOsTVLZoxtjNBsXdLo/cW12pg/MP2MV24cM=
X-Received: by 2002:ac2:5189:: with SMTP id u9mr26487227lfi.189.1559932786305;
 Fri, 07 Jun 2019 11:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <1558378918-25279-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1558378918-25279-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 00:14:50 +0530
Message-ID: <CAFqt6zYmL2P9w0Z4yfPtB=ftiy-H6-_beYsXJq-nD9T5OAw6Dg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/svm: Convert to use hmm_range_fault()
To:     bskeggs@redhat.com, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        jasojgg@ziepe.ca
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, May 21, 2019 at 12:27 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use hmm_range_fault().
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Would you like to take it through your new hmm tree or do I
need to resend it ?

> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 93ed43c..8d56bd6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -649,7 +649,7 @@ struct nouveau_svmm {
>                 range.values = nouveau_svm_pfn_values;
>                 range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
>  again:
> -               ret = hmm_vma_fault(&range, true);
> +               ret = hmm_range_fault(&range, true);
>                 if (ret == 0) {
>                         mutex_lock(&svmm->mutex);
>                         if (!hmm_vma_range_done(&range)) {
> --
> 1.9.1
>
