Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02351C352A9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 02:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3B921835
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 02:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdfJvpS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfI3CXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 22:23:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36055 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3CXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 22:23:08 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so34106554iof.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6d1aTnpV9qgl7UermuKekYZL5z0DnNnEo0ldYVTZofk=;
        b=MdfJvpS4TFGgkoqxVqVr+F71V8IY7jN7qcoUDam6i6WNdq/mZu8zqiV73DfVSdqJux
         JdCUBRlQ6Db7Gx4p0YYEoiMhqnoqZNm7bx2tvgXURpJSmlVUEI93W/m/U4lNwN5MfW5J
         CH5tUxR6v7TNwq04aHp9qSzV4S3lIufruFOBajaXTqU6fd2Pxv3DMWBgCyQ7LoQjMCxz
         ETjLhgDZqEMCIUDDx3DWVYFroHibHVaHwdO2p9fSl88tlFTQOcbP/p0QZpm+RZeCk7er
         9QWa1T3AxFxeSlpzPuUS6Bi+uncG9qOBSMUQuiUdWQN1ESZnEzeRh6yRDsJ6K1gTfIAq
         ZoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6d1aTnpV9qgl7UermuKekYZL5z0DnNnEo0ldYVTZofk=;
        b=CGeEiQ6yNcCS13L65tr37wk+Z32dWlAaOmL68OwaH+FTEgNl3ODCWeeIwA6vjziYrg
         2lE4VkgBgRfFwDXVhexicI3lv/VDGdKHecV9FDJMj5uJeUoEbPjtWekYOLcPAqSHdQIk
         B8m5/jN+RSXOL4pNIssUNNE2v5kXJTQC/cxh4oachqj2QdxDXcGRbucvvKA8aJnkWvLO
         2ZOfeUcy4hd/mIox0uWToMyuGIwfDnqB6CZX598WU0poiGKB8vuB1qNt/GgXvuZvQ60p
         J4IkAffOkKJv3+BIEHViONYXMfYgIg2LMp2FvTOa7rE3w3mlXU4YemjFG6CY0+p8x35v
         /VeA==
X-Gm-Message-State: APjAAAW9Rd3vC5CUIAfPgXeY4mdauTy5JeYtSaJAuukJT9bqMnxwRe6u
        KQng2+d38PUBIkmBte4ZUpLbz+1ycAUazaLEbXk=
X-Google-Smtp-Source: APXvYqw/lG63dH/Q4k2EQmL3tWXYQO7oUN8aIONoiWlZfmPRTw9dNSHOlrg+Gy/f25trAIawzLcGpOnzXt637Q06GLM=
X-Received: by 2002:a92:ced0:: with SMTP id z16mr17806215ilq.172.1569810187596;
 Sun, 29 Sep 2019 19:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190927230421.20837-1-navid.emamdoost@gmail.com> <3b5913e3-856a-db81-7708-929e62ee53d4@redhat.com>
In-Reply-To: <3b5913e3-856a-db81-7708-929e62ee53d4@redhat.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sun, 29 Sep 2019 21:22:56 -0500
Message-ID: <CAEkB2ER7xVU3vzK4ohj7f9=b=ZpNx++dyNrtLhOieeDgyeVBDg@mail.gmail.com>
Subject: Re: [PATCH] virt: vbox: fix memory leak in hgcm_call_preprocess_linaddr
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>, kjlu@umn.edu,
        Stephen McCamant <smccaman@umn.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a neat fix now, thank you.


On Sat, Sep 28, 2019 at 4:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 28-09-2019 01:04, Navid Emamdoost wrote:
> > In hgcm_call_preprocess_linaddr memory is allocated for bounce_buf but
> > is not released if copy_form_user fails. The release is added.
> >
> > Fixes: 579db9d45cb4 ("virt: Add vboxguest VMMDEV communication code")
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Thank you for catching this, I agree this is a bug, but I think we
> can fix it in a cleaner way (see below).
>
> > ---
> >   drivers/virt/vboxguest/vboxguest_utils.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
> > index 75fd140b02ff..7965885a50fa 100644
> > --- a/drivers/virt/vboxguest/vboxguest_utils.c
> > +++ b/drivers/virt/vboxguest/vboxguest_utils.c
> > @@ -222,8 +222,10 @@ static int hgcm_call_preprocess_linaddr(
> >
> >       if (copy_in) {
> >               ret = copy_from_user(bounce_buf, (void __user *)buf, len);
> > -             if (ret)
> > +             if (ret) {
> > +                     kvfree(bounce_buf);
> >                       return -EFAULT;
> > +             }
> >       } else {
> >               memset(bounce_buf, 0, len);
> >       }
> >
>
> First let me quote some more of the function, pre leak fix, for context:
>
>         bounce_buf = kvmalloc(len, GFP_KERNEL);
>         if (!bounce_buf)
>                 return -ENOMEM;
>
>         if (copy_in) {
>                 ret = copy_from_user(bounce_buf, (void __user *)buf, len);
>                 if (ret)
>                         return -EFAULT;
>         } else {
>                 memset(bounce_buf, 0, len);
>         }
>
>         *bounce_buf_ret = bounce_buf;
>
> This function gets called repeatedly by hgcm_call_preprocess(), and the
> caller of hgcm_call_preprocess() already takes care of freeing the
> bounce bufs both on a (later) error and on success:
>
>         ret = hgcm_call_preprocess(parms, parm_count, &bounce_bufs, &size);
>         if (ret) {
>                 /* Even on error bounce bufs may still have been allocated */
>                 goto free_bounce_bufs;
>         }
>
>         ...
>
> free_bounce_bufs:
>         if (bounce_bufs) {
>                 for (i = 0; i < parm_count; i++)
>                         kvfree(bounce_bufs[i]);
>                 kfree(bounce_bufs);
>         }
>
> So we are already taking care of freeing bounce-bufs allocated for previous
> parameters to the call (which me must do anyways), so a cleaner fix would
> be to store the allocated bounce_buf in the bounce_bufs array before
> doing the copy_from_user, then if copy_from_user fails it will be cleaned
> up by the code at the free_bounce_bufs label.
>
> IOW I believe it is better to fix this by changing the part of
> hgcm_call_preprocess_linaddr I quoted to:
>
>         bounce_buf = kvmalloc(len, GFP_KERNEL);
>         if (!bounce_buf)
>                 return -ENOMEM;
>
>         *bounce_buf_ret = bounce_buf;
>
>         if (copy_in) {
>                 ret = copy_from_user(bounce_buf, (void __user *)buf, len);
>                 if (ret)
>                         return -EFAULT;
>         } else {
>                 memset(bounce_buf, 0, len);
>         }
>
> This should also fix the leak in IMHO is a clear way of doing so.
>
> Regards,
>
> Hans
>
>
>
>
>


-- 
Navid.
