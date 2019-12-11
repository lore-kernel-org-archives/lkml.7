Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FD62073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhitx4aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfLKCeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:34:02 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35816 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfLKCeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:34:02 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so18083395ild.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 18:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iEKzTuCqR7pNiiQwEPYEy8kcmr1QVizqhrNITFAc66g=;
        b=jhitx4aRBOOz+jmv2AdxMTyqInT1bcrJpJQrh2AujwgKjCk7x80bT0oiDqPkvTISqQ
         VrBBCyTpvQeSo7dTn6TGKeeBekh7krkbUT/+1rwJp9fjTg+daD1Tb3jNrZkOGzm1D4on
         Man28nmAuAeeDJtWUMKkJx51s8TauUwWxFLrICSSBE316NILVKWpSYlYOoVIO9PDmnFb
         ABJtdiBmhEFMvhz+N3VZGM5xiWp2fzeZWIjYuaiaX9IT3cO+Y4395HQCyHACRXdyKj6E
         4b880AaNKmyxDxQzOyorITa2vuUTbVvAkAbshJ0KRN2p6Ur37qO/k9+WLCF8EM3c/TWG
         n7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iEKzTuCqR7pNiiQwEPYEy8kcmr1QVizqhrNITFAc66g=;
        b=pZU9j0t0qJvze8iVSA72uTHnCXdUvsx2m/0IUzI8/+AD37cLGmA23RRUZJ4/RbtKWW
         7OfNo/LxwMBy0qBItq7AFftuCTiMkbwwGPQcuRyJ0GFSW1k92EF4KHQN6zqdHtqtCISM
         E8fBY8nZx5MuvmYKAHss7JzPUP+duRRHPvn4GkPj7TfBLWJ5mqZZltqOg/PjlHlZljsC
         BBEjEVA4nkh/7bXMbYCzQnAIlZYVkTlGP2yPFb4osJqwOi+6rlHst4H35CEhjavIELKO
         9PsD6ZpUsemy3cxfIbnGmNlk+2+MzIvA/VTNONvZ7f9keJFdfnmzGUSKlLI1jTTlxaHk
         oY2w==
X-Gm-Message-State: APjAAAVVoRnUb+aNN1ujzRrZGNQh5M7vMHQxB1jLh+10nFRsJblh3HfN
        uC47XHrbU/YLwnHhT20XNH4QxQzwuuHSuM4Fv08=
X-Google-Smtp-Source: APXvYqyiQ0K2uymzvEliQKKGQlUjrB9uGQcWoNfdP49kozTiunn3j2aLL8/7xYJJ45Sdd8cPvRBMm2S64IigQd+05ls=
X-Received: by 2002:a92:8d4e:: with SMTP id s75mr885642ild.172.1576031641683;
 Tue, 10 Dec 2019 18:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20190925043800.726-1-navid.emamdoost@gmail.com> <CAEkB2ESR+GictT00W95pADAeakAuLrTECqUxEt=b7TG2x=FgVw@mail.gmail.com>
In-Reply-To: <CAEkB2ESR+GictT00W95pADAeakAuLrTECqUxEt=b7TG2x=FgVw@mail.gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 10 Dec 2019 20:33:50 -0600
Message-ID: <CAEkB2ETfnejEiOeOWU1LdSW+SoovdqXOeJX+C=HK9=jMZDP0Ag@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On Thu, Nov 21, 2019 at 12:17 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> On Tue, Sep 24, 2019 at 11:38 PM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> >
> > In vmw_cmdbuf_res_add if drm_ht_insert_item fails the allocated memory
> > for cres should be released.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Would you please review this patch?
>
> Thanks,
>
> > ---
> >  drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
> > index 4ac55fc2bf97..44d858ce4ce7 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
> > @@ -209,8 +209,10 @@ int vmw_cmdbuf_res_add(struct vmw_cmdbuf_res_manager *man,
> >
> >         cres->hash.key = user_key | (res_type << 24);
> >         ret = drm_ht_insert_item(&man->resources, &cres->hash);
> > -       if (unlikely(ret != 0))
> > +       if (unlikely(ret != 0)) {
> > +               kfree(cres);
> >                 goto out_invalid_key;
> > +       }
> >
> >         cres->state = VMW_CMDBUF_RES_ADD;
> >         cres->res = vmw_resource_reference(res);
> > --
> > 2.17.1
> >
>
>
> --
> Navid.



-- 
Navid.
