Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C321CC282E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9933B20644
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jD0wZt/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbfEXNQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:16:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44848 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391496AbfEXNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:15:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id g18so8607195otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WbM2LHjiKTY+9+3kLdGdCgm4glTt5XXlGcOyxX/K4fI=;
        b=jD0wZt/ia++5OEv1+vFgCsAfXbjJ3WLF8YSvAMbMdw5PtHEWttTs8Lvkuciy7k+JBf
         6Cb/fBWFKt6h8h43NOnZbDokjOnbh0JYYSb8gorylXTGmV7yL4QxMUk8m8xAjRn9h9P3
         go1OMNLBf7T70y8UzgJfNYWAD0WEmSKTpRkD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WbM2LHjiKTY+9+3kLdGdCgm4glTt5XXlGcOyxX/K4fI=;
        b=OYOp4hgysZOWGJDpup1udxqXJ7qi01/14RfzM3iI/6HIzWFXRqSc/m6yFyRmY7Qwif
         DCKWweJmptIHFFAbYt6cYU7+yAns27Z2U60w+iJfh7QXCtdrWDhDKkyjJsIUVvofkRHr
         doFZTIU9KiCEKGaknHMCKcrn4uO6opELda46oLWlo7AKbb4glNtz0vmKK4fXfDbCR6t+
         kNdSiPdGLa80HfeUFNZqinirkiRKkonZV5IgXRYkFm/iUptSKEWaPgkTys/mRCxyIz9R
         cwyqYW3JiBv1wHsWnGmBET47LL2XgHUz9wN2XE+4uEmePfhb3TiJCLQzY6qFG3IX7Pp/
         Tg6A==
X-Gm-Message-State: APjAAAVjCPq45S3dv1Gdwix21LaJCprQOrmwmG0Jh2Ses2w+/pOn1fjs
        CdJhsFbL48g1JbcxojnIeOyVD313of+dxqLSTVGccg==
X-Google-Smtp-Source: APXvYqzYvbI98itpS0F9VsEq/N+NUGgG7PndBlowPnu06UxQRS9rukPdoQcI9sAIXURDXo30fEZWH1MRe9ln7CpXfI8=
X-Received: by 2002:a9d:6e07:: with SMTP id e7mr28531134otr.53.1558703758437;
 Fri, 24 May 2019 06:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190523215902epcas5p40e3aca0efb342c8d778529fef416c3fd@epcas5p4.samsung.com>
 <20190523215853.16622-1-robdclark@gmail.com> <9c63ac15-9917-7adc-3ef8-3e44060797bd@samsung.com>
In-Reply-To: <9c63ac15-9917-7adc-3ef8-3e44060797bd@samsung.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 24 May 2019 06:15:46 -0700
Message-ID: <CAJs_Fx4hw3nrUAksQxTrVrJubQAxADE5FmBrSs+EOmE3jwL9bg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: try_then_request_governor should not return NULL
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, thanks, I've not moved to the latest -rc yet..

That commit would be a good candidate for 5.1.y stable branch

BR,
-R

On Fri, May 24, 2019 at 12:13 AM Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
>
> Hi,
>
> This issue[1] is already fixed on latest linux.git
> You can check it. Thanks.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Db53b0128052ffd687797d5f4deeb76327e7b5711
>
> Regards,
> Chanwoo Choi
>
>
> On 19. 5. 24. =EC=98=A4=EC=A0=84 6:58, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The two spots it is called expect either an IS_ERR() or a valid pointer=
,
> > but not NULL.
> >
> > Fixes this crash that I came across:
> >
> >    Unable to handle kernel NULL pointer dereference at virtual address =
0000000000000030
> >    Mem abort info:
> >      ESR =3D 0x96000005
> >      Exception class =3D DABT (current EL), IL =3D 32 bits
> >      SET =3D 0, FnV =3D 0
> >      EA =3D 0, S1PTW =3D 0
> >    Data abort info:
> >      ISV =3D 0, ISS =3D 0x00000005
> >      CM =3D 0, WnR =3D 0
> >    [0000000000000030] user address but active_mm is swapper
> >    Internal error: Oops: 96000005 [#1] PREEMPT SMP
> >    Modules linked in:
> >    Process kworker/2:1 (pid: 212, stack limit =3D 0x(____ptrval____))
> >    CPU: 2 PID: 212 Comm: kworker/2:1 Not tainted 5.1.0-43338-g460e69846=
75c-dirty #54
> >    Hardware name: Google Cheza (rev3+) (DT)
> >    Workqueue: events deferred_probe_work_func
> >    pstate: 00c00009 (nzcv daif +PAN +UAO)
> >    pc : devfreq_add_device+0x2e4/0x410
> >    lr : devfreq_add_device+0x2d4/0x410
> >    sp : ffffff8013d93740
> >    x29: ffffff8013d93790 x28: ffffffc0f54f8670
> >    x27: 0000000000000001 x26: 0000000000000007
> >    x25: ffffff80124abfd8 x24: 0000000000000000
> >    x23: ffffffc0fabc4048 x22: ffffffc0fabc4388
> >    x21: ffffffc0fabc4010 x20: ffffffc0fa243010
> >    x19: ffffffc0fabc4000 x18: 0000000091c3d373
> >    x17: 0000000000000400 x16: 000000000000001a
> >    x15: 000000019e06d400 x14: 0000000000000001
> >    x13: 0000000000000000 x12: 00000000000006b6
> >    x11: 0000000000000000 x10: 0000000000000000
> >    x9 : ffffffc0fa18ba00 x8 : 0000000000000000
> >    x7 : 0000000000000000 x6 : ffffff80127a3d9a
> >    x5 : ffffff8013d93550 x4 : 0000000000000000
> >    x3 : 0000000000000000 x2 : 0000000000000000
> >    x1 : 00000000000000fe x0 : 0000000000000000
> >    Call trace:
> >     devfreq_add_device+0x2e4/0x410
> >     devm_devfreq_add_device+0x64/0xac
> >     msm_gpu_init+0x320/0x5c0
> >     adreno_gpu_init+0x21c/0x274
> >     a6xx_gpu_init+0x68/0xf4
> >     adreno_bind+0x158/0x284
> >     component_bind_all+0x110/0x204
> >     msm_drm_bind+0x118/0x5b8
> >     try_to_bring_up_master+0x15c/0x19c
> >     component_master_add_with_match+0xb4/0xec
> >     msm_pdev_probe+0x1f0/0x27c
> >     platform_drv_probe+0x90/0xb0
> >     really_probe+0x120/0x298
> >     driver_probe_device+0x64/0xfc
> >     __device_attach_driver+0x8c/0xa4
> >     bus_for_each_drv+0x88/0xd0
> >     __device_attach+0xac/0x134
> >     device_initial_probe+0x20/0x2c
> >     bus_probe_device+0x34/0x90
> >     deferred_probe_work_func+0x74/0xac
> >     process_one_work+0x210/0x428
> >     worker_thread+0x278/0x3e4
> >     kthread+0x120/0x130
> >     ret_from_fork+0x10/0x18
> >    Code: aa0003f8 b13ffc1f 54000762 f901c278 (f9401b08)
> >    ---[ end trace a6ecc18ce5894375 ]---
> >    Kernel panic - not syncing: Fatal exception
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/devfreq/devfreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 0ae3de76833b..d29f66f0e52a 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_go=
vernor(const char *name)
> >               /* Restore previous state before return */
> >               mutex_lock(&devfreq_list_lock);
> >               if (err)
> > -                     return NULL;
> > +                     return ERR_PTR(err);
> >
> >               governor =3D find_devfreq_governor(name);
> >       }
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
