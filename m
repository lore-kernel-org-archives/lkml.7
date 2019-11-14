Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D858DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE908206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFMJ5VH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKNOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:43:39 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41864 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfKNOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:43:39 -0500
Received: by mail-yb1-f196.google.com with SMTP id d95so2614043ybi.8;
        Thu, 14 Nov 2019 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pgB+Cd8IZTdSBIGkWqDsTXRY6q97RGvQ71jVJ4qlw0=;
        b=gFMJ5VH+kIMU2+hoWNAqr/eIhXNqrLV6mmSvpfpSXWg/SsvYydSoI0gWeiIV17plLP
         n+fYi/7BL7mCmhWtF2dTasgXKEqfVhMjN3/CeEsyJNIyObqLewtioIUcjrAejEZYrhwc
         XtAIv1BcI8lxhT/x9wNGob8nIij/8QiEjox8WW9rI9u6dqMtUFEu4LR6jijCELn7jU/n
         bDGRe0fgvhar0f0BoBoFnwgJ+dxhwowUjfPsBcY32KSLnYPUDi4FV5/OLwSpO79QGOn6
         SmUTon9X2b8EvMeRXQTnXmr89jC8iF29kY6PHfsxK46414NozpsEbnNyF+dr5VLzJfiY
         MSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pgB+Cd8IZTdSBIGkWqDsTXRY6q97RGvQ71jVJ4qlw0=;
        b=Cx6SGk2xAi8lgQX/i6uOlcTo9thJ3YIoNOUlfGttnaa81mkVD5RIjuwMBQjYJW+yDI
         VTmRood+2k+olChYYoszBCZKwXAG8JzZF90KA5u+Zg+oMhZ6ef//uh8nL6nvFB3xao8X
         V7QpwXvQCWh0hddnhKxytl9Aw3VUWZNX8s/NQ4w1oCR1LhfiZ5SS/zMt3KjVWQGohh/s
         8+TgFBem2qhlabo7BTBZI7xV2ku0PfNv5zk48MWZc0CCTMe9lPd8z5f8gvvr0+XkmJVL
         cZO7oKfJS0fb2xR1qcbwBHxamEeFxObuDI3fmCr694MS4GkNTZxlHhxQ3cZ8mESg7WWr
         GJwQ==
X-Gm-Message-State: APjAAAU41YODAczWD5A511+I47kwzr1x3gMl8h06irBjvM3mpagYT8wo
        d74Pa4bs0H7SjXjwx/SKheH6LXa8jKqvOXrbHRk=
X-Google-Smtp-Source: APXvYqzzjtMYZbdlQQuoAVP38gmtj54lHfp9b0FuWN5Kc0nv3H7D8KhIeKeMXWqAQmvWXhUUgOZrdVtUsQwZHIIGiHM=
X-Received: by 2002:a25:383:: with SMTP id 125mr7270645ybd.45.1573742617997;
 Thu, 14 Nov 2019 06:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20191113200651.114606-1-colin.king@canonical.com> <CAJfpegug-saOEigqDNKfwMR5qdzrbLnRBD=0eN5juGioFH_L_Q@mail.gmail.com>
In-Reply-To: <CAJfpegug-saOEigqDNKfwMR5qdzrbLnRBD=0eN5juGioFH_L_Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 14 Nov 2019 16:43:26 +0200
Message-ID: <CAOQ4uxgf5KAq7VoHVNVUD9QtA7Y++-_TdwOe6=icHLgJvyrg1A@mail.gmail.com>
Subject: Re: [PATCH][V4] ovl: fix lookup failure on multi lower squashfs
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin King <colin.king@canonical.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 12:30 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Nov 13, 2019 at 9:06 PM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > In the past, overlayfs required that lower fs have non null
> > uuid in order to support nfs export and decode copy up origin file handles.
> >
> > Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
> > lower fs") relaxed this requirement for nfs export support, as long
> > as uuid (even if null) is unique among all lower fs.
>
> I see another corner case:
>
> n- two filesystems, A and B, both have null uuid
>  - upper layer is on A
>  - lower layer 1 is also on A
>  - lower layer 2 is on B
>
> In this case bad_uuid won't be set for B, because the check only
> involves the list of lower fs.  Hence we'll try to decode a layer 2
> origin on layer 1 and fail.

Right.

>
> Can we fix this without special casing lower layer fsid == 0 in
> various places?  I guess that involves using lower_fs[0] for the
> fsid=0 case (i.e. index lower_fs by fsid, rather than (fsid -1)).
> Probably warrants a separate patch.
>

I guess we should.
I do hate that special casing.
I can work of that, but would you like to hold back this patch now?
Or just fix that corner case later?

Thanks,
Amir.
