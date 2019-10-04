Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AF5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738B02070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF2MWzbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbfJDMzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:55:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37665 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387719AbfJDMzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:55:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so6126249wro.4;
        Fri, 04 Oct 2019 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2rHqJdypJd0DpptSQAbAu2oMkWuEe9MsrDHs1Du//rI=;
        b=DF2MWzbsC2Asi2Gnr/CI21X/qnFP61GWEpwl80XUDTqhGXB3+BBplFMPT4dot2tOIm
         q5t0tMLcz1Dt63c8PrE2Rr/8ssAedbneXDyT2lJIygz7thJx5RlzF28sHYXnmKGTOW8f
         bjnGXnADMzKVQoPypEnRN+quaksn3a7zIUXA+l6F+ranNKFgsSO5HZE7VcTpC4C8aKCp
         gm9mh706njzMqOuwPln/yMdaTPOi4BjQRX6L70POXRoFlVBQNwsikPN7k6LGD4IL7Cpp
         5Q2WBuxSF9atJWf9kPL8hyu7KgXjVn88gv7Jl9QZ/Z7G7VIOEsCFcprbnz62ZdRE/2VY
         XczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2rHqJdypJd0DpptSQAbAu2oMkWuEe9MsrDHs1Du//rI=;
        b=EDq53koPxEnRjG0Cy21iXqkNLXtR+XEZ3NN2XQo1F09NFS9lL4uw7C0Kufkl1RT/gb
         MjZzxPf+cz4BRXF9f2rxkIO9+uNwKvdGO3neHsGJ8kwwQZdEjEIgEQLc4r9rkSXpls+F
         ORPH/AJ9O39wj27xZUGAHySfkC5ZUlTkmHasLV6BSjbOwjgkN8nXvbT1PzX3ShxgCOjq
         nHttpZu4rbPfdBwuLoQEfCoKBZwpCv7jUABkENJmpAkvot1RBXVz1rjemdy1cSKTeZ7M
         PiF3TUb7PgbRkRDtLDyxh29iE9owU4ed/CENe/uRm3+sF5CgrhJ52g73X8X/yshLQtLP
         ho5Q==
X-Gm-Message-State: APjAAAVtmAZJ7d1+6ULJkGOCujGMAXmjxU/qpwt40NpzznpWaruAD9lW
        n+FXpOKr0WOIw/yaQdtcOhg8OXSpyEgLix4sYrw=
X-Google-Smtp-Source: APXvYqy8KM1R+jii8lv+15rBGuFP7KVh7Nffpmw4utZFyRG9g8ITym8TZa9ET9jU8+LLfiQFulKpd6tg50WCki56Mg4=
X-Received: by 2002:adf:e951:: with SMTP id m17mr11364492wrn.154.1570193708775;
 Fri, 04 Oct 2019 05:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191003215227.23540-1-colin.king@canonical.com> <55116b72-4e15-7efe-09a6-283a7090966a@amd.com>
In-Reply-To: <55116b72-4e15-7efe-09a6-283a7090966a@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Oct 2019 08:54:56 -0400
Message-ID: <CADnq5_N-tdCJ_LUwunwmrj88vAPBbCLD2uwDTBGzB0XJWdak2g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix uninitialized variable pasid_mapping_needed
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 3:28 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 03.10.19 um 23:52 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The boolean variable pasid_mapping_needed is not initialized and
> > there are code paths that do not assign it any value before it is
> > is read later.  Fix this by initializing pasid_mapping_needed to
> > false.
> >
> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: 6817bf283b2b ("drm/amdgpu: grab the id mgr lock while accessing =
passid_mapping")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

Applied.  thanks!

Alex

> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index a2c797e34a29..be10e4b9a94d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1055,7 +1055,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
> >               id->oa_size !=3D job->oa_size);
> >       bool vm_flush_needed =3D job->vm_needs_flush;
> >       struct dma_fence *fence =3D NULL;
> > -     bool pasid_mapping_needed;
> > +     bool pasid_mapping_needed =3D false;
> >       unsigned patch_offset =3D 0;
> >       int r;
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
