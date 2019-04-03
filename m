Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D069CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9747120700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSpcK+sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDCGbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:31:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40433 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfDCGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:31:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id t8so14352709otp.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 23:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NnGSpbj/RYZjac4+iGsja898j4gICW/TPJPWtWo1BH8=;
        b=jSpcK+sb3z2fH3osNSIGeErLUO6X/wF6f2dKllc3Nko1rHGLUc4kgtUVKPVz6yaeak
         /RdoB17DHczIX5ZkMTdKVB2Mqzl/atb0U6aeAsizdAF5ex2ADP3UBA28BKua/rk4ublY
         N4uJB7czmLhJAB8P4KS3FYYrWUHxekB7aBI5gON/7MnneQ5VLWF46zOZubbYUK2AIzMu
         rQDUpmlHnr4cHYaz5QLE8CmnNXX1oqtmg5NROmp2HsZMysHpc1M1LCQmL7X8R0cmlZnK
         9PWQKnjxvQBL4T0CBY2/zEBipfcRe4sLdPeuyJFhDhuSJ5o7PCoEb+NzLj0gwqKCzhOq
         gIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NnGSpbj/RYZjac4+iGsja898j4gICW/TPJPWtWo1BH8=;
        b=emJRk14dUD+H9Aaw0f853Nq3bwHITpoIt5Pew7auehHASNAbTzhDR3HTwgVwRCImvF
         dKBlmhy5uQaluPvVgVBSLjX1gpTkvcoNJMNRJYTpM5wTESyWueXm5qF0AUTup6j0o/jE
         XOBvlzuyglM5KYWHf5miaAj5Vr8HrKvMrAnSGtyw+Jwa7C/FOVYwTJ7naNEM6SqakgKi
         ej0h8qqam1aGjRsuN3U0L0gTbKAJE5/V0aaqNHrl+HNmYBMesEXhHWYThav+DVFy5hfy
         +bjCJCbLDcm9K5HkW17pkQBeYkkBwcCg2G5CSSMih3W0g7ipHm2AYRKUSrXQb4HsVBfs
         8fCQ==
X-Gm-Message-State: APjAAAXEnc46o+0p2Gmvc9zFnkCSpVj0QKoXy1aGzWZhJgYA2BASwwH7
        A9qcBjRPYlkACYJCNzgQUKDGnWHA4FK+bdaswkTvvQ==
X-Google-Smtp-Source: APXvYqylCPhf+7baMrNyW52VIphim/TJPMn32QV7EQF9gY4iZVtl7AHK5izTNIUm/yLFQ3m8Oo4hYlLG/+mrNyjuQds=
X-Received: by 2002:a9d:6f8b:: with SMTP id h11mr8947950otq.58.1554273066772;
 Tue, 02 Apr 2019 23:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190329165201.16233-1-afd@ti.com> <24aa0897-8f23-f747-d9a4-d5272f37beea@gmail.com>
In-Reply-To: <24aa0897-8f23-f747-d9a4-d5272f37beea@gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 3 Apr 2019 13:30:55 +0700
Message-ID: <CAO_48GHOi7fbG3E9pgrs0_ymUYFaEQmPt_cmQBQ1ZAXz6O4dDA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Make mmap callback actually optional
To:     Christian Koenig <christian.koenig@amd.com>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, 1 Apr 2019 at 20:38, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 29.03.19 um 17:52 schrieb Andrew F. Davis:
> > The docs state the callback is optional but it is not, make it optional=
.
> >
> > Signed-off-by: Andrew F. Davis <afd@ti.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks for the patch; I will queue it up within this week (at a
conference atm, but will squeeze out time for doing this).

>
> > ---
> >   drivers/dma-buf/dma-buf.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 7c858020d14b..4d4ae9fe9ac8 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -90,6 +90,10 @@ static int dma_buf_mmap_internal(struct file *file, =
struct vm_area_struct *vma)
> >
> >       dmabuf =3D file->private_data;
> >
> > +     /* check if buffer supports mmap */
> > +     if (!dmabuf->ops->mmap)
> > +             return -EINVAL;
> > +
> >       /* check for overflowing the buffer's size */
> >       if (vma->vm_pgoff + vma_pages(vma) >
> >           dmabuf->size >> PAGE_SHIFT)
> > @@ -404,8 +408,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf=
_export_info *exp_info)
> >                         || !exp_info->ops
> >                         || !exp_info->ops->map_dma_buf
> >                         || !exp_info->ops->unmap_dma_buf
> > -                       || !exp_info->ops->release
> > -                       || !exp_info->ops->mmap)) {
> > +                       || !exp_info->ops->release)) {
> >               return ERR_PTR(-EINVAL);
> >       }
> >
> > @@ -906,6 +909,10 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm=
_area_struct *vma,
> >       if (WARN_ON(!dmabuf || !vma))
> >               return -EINVAL;
> >
> > +     /* check if buffer supports mmap */
> > +     if (!dmabuf->ops->mmap)
> > +             return -EINVAL;
> > +
> >       /* check for offset overflow */
> >       if (pgoff + vma_pages(vma) < pgoff)
> >               return -EOVERFLOW;
>

Best,
Sumit.
