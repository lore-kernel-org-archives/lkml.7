Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F98206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awy48E1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfCLRWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:22:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36865 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbfCLRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:22:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so3482316qtn.4;
        Tue, 12 Mar 2019 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YesIhy2UsGnwSXTgVK14T/DbKOCbRD/Fkz2D7iXOGmE=;
        b=awy48E1mw52XmF33VF9wAJhOqXhiu1nO5hcKrPCieiIU3oa/nTc6QG9WXoMWTY3BZi
         B1AV4aN95KUiOMahv6mDDh5G2wWItD3HL0nMLxD/YaZcNhMsMULsn82/4W5ADUxDzZtO
         TS9lT0BwDa7+msf/zYaA+pzCr57EOOoaJdW/sIDkflLlY6T80CDRV2Fu1c3YLwisbEGm
         mnLeJhwcJRVg/eDm3mUnRx4hHThT4TxJ6DmzCxf/TCyi9bdGUDMmKTFuyg5UtNLIvpBv
         CRdI2l0C1LEPwLwuLREeYoMzA7D4O8QXXG+W5jrtWRL9fX2ljG7JyQaA91RNBUt/OdxZ
         CHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YesIhy2UsGnwSXTgVK14T/DbKOCbRD/Fkz2D7iXOGmE=;
        b=huiSEMLKaUof3SRooiYGqKI7Mv2Ktr7F2dv2Nz2guCxZji6G8fDem1uqT9rIVwrmqZ
         hD4DPfas8dswKhIcjnWT+7mjlGfIk0fsirvoRGGf+q3dMWTm/mLoES0uDdhAZn9RTFF2
         i5HlPI6DNgvW+yODrA8FhehU4+iql3M9a16KtTmFtloNi2C+JuvPl8pu/uHFYipto9DY
         TADN33stZRNwiy+ffjo8xafsSj/9oHH2EUHGDE+/FTjLFQdpemufex8laZViSayRSfl6
         lzzSPjhc1v7qQROKI8atxpZUXSLXgr5ymd+HU67EqRI461kBJ9POR85TKfLkrB072En2
         qzHw==
X-Gm-Message-State: APjAAAXG7BvFmWvyjnIb3usrT0tNvLYG0nfp5vAakfew92IYdyjOwaUK
        74ca0iFk2GjlWu4AGX03bp78U87rfP8sxa9kzOg=
X-Google-Smtp-Source: APXvYqx4qbyD0KKLsdCoL2GLJqLBXI/Cq2MsbKQOJmciAHIelmusfuwbbjAkBpU+GovsgCGNWp4MF55l70PdiMzkncE=
X-Received: by 2002:a0c:b524:: with SMTP id d36mr31091687qve.48.1552411335629;
 Tue, 12 Mar 2019 10:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190304224854.12494-1-pakki001@umn.edu> <854b0e4a-35e4-4666-5d05-c1f9ffaceae8@suse.com>
In-Reply-To: <854b0e4a-35e4-4666-5d05-c1f9ffaceae8@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 12 Mar 2019 10:22:04 -0700
Message-ID: <CAPhsuW5JDsRZSJY+AggEMkk59kt025NLeTV6zC2fpfv9_qTw-g@mail.gmail.com>
Subject: Re: [PATCH] md: Fix failed allocation of md_register_thread
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Shaohua Li <shli@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 7:13 PM Guoqing Jiang <gqjiang@suse.com> wrote:
>
>
>
> On 3/5/19 6:48 AM, Aditya Pakki wrote:
> > mddev->sync_thread can be set to NULL on kzalloc failure downstream.
> > The patch checks for such a scenario and frees allocated resources.
> >
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied to https://github.com/liu-song-6/linux/tree/for-5.1/md-post

@Guoqing, I added your Acked-by to the commit and also the raid5 fix.

Thanks,
Song

> > ---
> >   drivers/md/raid10.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index abb5d382f64d..f52b4d9bcd24 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -3939,6 +3939,8 @@ static int raid10_run(struct mddev *mddev)
> >               set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> >               mddev->sync_thread = md_register_thread(md_do_sync, mddev,
> >                                                       "reshape");
> > +             if (!mddev->sync_thread)
> > +                     goto out_free_conf;
> >       }
> >
> >       return 0;
>
> Could you make the change for raid5 as well? It also doesn't check the
> failure
> in raid5_run.
>
> Thanks,
> Guoqing
