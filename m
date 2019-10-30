Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29924CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010962087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/hIlRzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfJ3N4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:56:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45084 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3N4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:56:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so2398015wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwVcSXoannBan2m8zWPB7PFI0kJUSthZFWNX18Hm/LQ=;
        b=Y/hIlRzunT8W0Xp+WjWPqr78Z2vnSK7uei64oEtx4N+eNc0jemkWFRFCtgjT/jT1r8
         XDd1W9iMqbd0lTmkQLX6U/7HUauSWOUU3l3ZgONqxoqUiV0sc7wfM9XPUoh+/sIN+n83
         En5XSIt1UCBZ6rui4krmtoWgX2/U4Y0Hurw8kpOWcU7GjRu4DJ6KnZj33d+nkW+5Jhch
         dimiw5OGcJx4ukM/iTFVW2eS248VFmsBk8VRVz7gRnY1CVRwmf2nO6Ii8x+hvlqjjlDj
         d5xCYEb33OBjoaPvStBnEBdQ6ddMhTCI1BvAfGIp3P9hYFd8oGLd2eyWB1cSNxpejHnR
         Wnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwVcSXoannBan2m8zWPB7PFI0kJUSthZFWNX18Hm/LQ=;
        b=QcFwnmr+0aP+ZCLzRkPdmHdPycJ1ADBJ8dDFfew9TTgWvwFIbpHFULxcLaLjJfewTS
         Itf4vV7ciUDHPu0ofCBdp4uZ3kjC+KA+2gWeHHUQw3Z+ttiK0mQfhnlnXmRs6VN9Rc62
         Grit9+mN9+klAnI68dW/VgY8EyWo/yh7VeNzbNuhNUx26Hl7jbzdvCgG83BqlDI53//K
         4qMY5rA9S20DRuGVa5aR+4QlARQvTJIbL/7urilkcN0W6xo8K9TxynxEHM9GPluQgJPy
         FhUiEupF2B3vDp78tf2K2QRFTEqO8y5Jybpqksys8BsBggsgx++Dlodc6IBQE7nE6NIF
         JlSw==
X-Gm-Message-State: APjAAAVeONhIiQLP05HCrx/ue0gScuaMwiAWJ15IksOCZO7ZjRoAjht7
        jFHy2vRl8hs9I2vjMkho5q1msfVhQvM5e9wE4ds=
X-Google-Smtp-Source: APXvYqyEugonbjl2q4DWU/AHaJmj/Blp0GlAvoirFuqlE/MSiO8C4JoaW1C/7bETPx1i3Wzdu9TdNu6NLtRVVwtT8gU=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr24079wrw.206.1572443813028;
 Wed, 30 Oct 2019 06:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <1572400673-42535-1-git-send-email-zhongjiang@huawei.com> <723f11bc-9a65-bce6-9c0f-2ef2dbe7a1db@amd.com>
In-Reply-To: <723f11bc-9a65-bce6-9c0f-2ef2dbe7a1db@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 30 Oct 2019 09:56:40 -0400
Message-ID: <CADnq5_PRfOn1BRJyqT54yKLnmiJxoDaMFwpTOFe=KgQWW0_bDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant null pointer check
 before kfree
To:     Harry Wentland <hwentlan@amd.com>
Cc:     zhong jiang <zhongjiang@huawei.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 9:36 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-10-29 9:57 p.m., zhong jiang wrote:
> > kfree has taken null pointer into account. hence it is safe to remove
> > the unnecessary check.
> >
> > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> > index cf6ef38..6f730b5 100644
> > --- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> > +++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> > @@ -174,9 +174,7 @@ static bool hdmi_14_process_transaction(
> >                       link->ctx,
> >                       link,
> >                       &i2c_command);
> > -
> > -     if (buff)
> > -             kfree(buff);
> > +     kfree(buff);
> >
> >       return result;
> >  }
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
