Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8EAC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3381B20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuDWYt9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfDSTIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:08:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbfDSTIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:08:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id f14so7368911wrj.5;
        Fri, 19 Apr 2019 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqKHyAc/Mh+pYqG7lJJYAQ02n/3414OubCST9G5qLTw=;
        b=DuDWYt9GYi6DdaLj16N2FDkeM2JkXIKD8sNl3svy2ewhPpFATlk7n6EYC9YXXt7+Lr
         JZywIGEvhHLrlKel8B9w36YfzPRqu6hPq1MhQR+J7q5jPX7zcboolD3sTv9jthlsnoCu
         IeLZiz/qLuG57RkyeGXnkfa5VQDq5h9jIsSvik8ZiMcevUDyGZ66lVDeG3HdiSc8NcnH
         RTayXdtVQqTbGr5h3G5G2l6T8oQanVngYo/9XJSIvcaMVXAG6SMnAKkBCGIb5KJmSeoN
         FYbGEsKDBlM8BS48zxHZyLXH+VPMEih91gKVR9TG9rOGn/l1x3CIEZoUI5VhZuUHa08g
         sPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqKHyAc/Mh+pYqG7lJJYAQ02n/3414OubCST9G5qLTw=;
        b=umwoG6K/s2bwRtRjllaBNoOSh6O/GtAa15B1y82JFDOaqr2T7+eHKbRw6wVxDH/2M0
         aCMrvwMG0dIFsgLIYhn0yUIOEJ6t71jbvnrM00O/L5qlfEwEBIohMt35PgxhBAvnDaN3
         ou5VyecLLDfIR3kJvqN+fghVLt9Wu5f0gixnFfzcvYIW+GlKmjE87NRdUGyALPe+LHoh
         7mvWte4zCBNhv/xqnMftAtIGNKce51edM8504VHHKAX0D7ozBhDo5WLqBDumShnqE8tR
         iGf1QzSb+tLRsQGIHf3WzY6sBd7t7Xu4I//fQJsxrXhWq3kTDlnlq6mJLKR2qNGnqJlL
         tuSQ==
X-Gm-Message-State: APjAAAW63C9aEPCtdryUjBb8sltUTcyfUm9GMvcUyXCz9PBrOFEewBWh
        2ycnVhnKeJ1Z8GP/VterBh2RJn/WtCrCaPDVjF+XSvfEoPQ=
X-Google-Smtp-Source: APXvYqwjnC3JI1rr1mndCcge4mRNK47SGNTRqNHM0Mo9NRBqDzLyaQ99gQHczK8juOFP2bTVPK7+3kgCGm4P26hecsY=
X-Received: by 2002:a5d:6184:: with SMTP id j4mr3183095wru.317.1555686324628;
 Fri, 19 Apr 2019 08:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190418102510.10253-1-colin.king@canonical.com> <541d2a2a-bcdf-5c4f-b075-7ca128757a45@codeaurora.org>
In-Reply-To: <541d2a2a-bcdf-5c4f-b075-7ca128757a45@codeaurora.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Apr 2019 11:05:11 -0400
Message-ID: <CADnq5_PF+1fVOXaZh=F7tw=YzB48b1qHJHW56nEFhvUygQPd0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: fix spelling mistake "recieve" -> "receive"
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 1:58 PM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
>
> On 4/18/2019 3:55 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in a pr_err message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied.  thanks!

Alex


>
> Cheers,
> -Mukesh
> > ---
> >   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> > index 6a0fcd67662a..aef9d059ae52 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> > @@ -515,7 +515,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
> >
> >       /* wait until RCV_MSG become 3 */
> >       if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
> > -             pr_err("failed to recieve FLR_CMPL\n");
> > +             pr_err("failed to receive FLR_CMPL\n");
> >               return;
> >       }
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
