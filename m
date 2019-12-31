Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66161C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 14:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1C82064B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 14:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XznbIAtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLaOT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 09:19:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41231 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfLaOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 09:19:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so35347435eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 06:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9y1tmY4RwLs4Y1ujy/qNU7zmo877ZYf9RQx8Ho+O9iY=;
        b=XznbIAtguo9Bm13nZNKcGfWNbF9HeJqRmin10NcTYgr1Vw046xRj9+rzrUJU4NHprt
         Tkc0HmqBKaz7bpKSK9WQmS5/yJeSasVdRatCqWVYWuS5RL6y4ugWYo5qEWfMc2iAZ1CB
         pJ85G4GnkNzDYQmXK8F8MVqL2js7V2uXdLzFhvlZBVg2/RA7nzliUNg1iMDN5ogPCpwZ
         Ng2sw6pCeLjKh4JoSXyR4Nf3BnV9ap6rVwvJqnX33r1QmXkwcpjux8OejB9tvc+i4Psy
         y8fDgkJZ8Nhcp6JAAMUcJbepMq52Lu2nqTIeJ1FUuMqo2CfwLbrAooynJ/rUT5SJ+pX9
         Ar0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9y1tmY4RwLs4Y1ujy/qNU7zmo877ZYf9RQx8Ho+O9iY=;
        b=CfNczN9fq4gYZaw9nE87KGYNd/Q2PFG4Wp7lzvl9Wv9SOUdfutV7ToiurFkMRB+2kE
         beKpZHRl45FuEmJs9VKGKrNxVzMgGd3JZT2NGs0KEjQaegxe9E2DHal53xVTUDqq/1z1
         HK9HxVS3lA8/68jgevXo1JtW2PB446Oq/dLaMX5NdI97I2JtX7Xye8NUntX0cMrA1Zom
         Y1+3J1BcrmiahfLc0/eYueSb9GK+35pZekW9lDTrjEO/3hGsDm8tEjFj2ljLBnfrJTBf
         inv7Roi4/0D4Z6kqOEO3QwMvVArvdj74TzZ7LMs/8imiFP1WDmhc/+uGS4aoC7W9Vx/6
         Zibg==
X-Gm-Message-State: APjAAAX+RZYsNYB68i2CfG/lFDC5PHpFJAWT8m/DhGCnSYt55CxLvq1G
        vYoIKBFLvDsItrgBxsUG/+IZFpf90MZ2uGSEoIo=
X-Google-Smtp-Source: APXvYqzEOkZZG/2vGecnH7059nruHo6x8SX+ETSVkcqY8CFP1LYgZ/RDi4F7iof47RA91e8QSwcGekMXLc/GWHZYaCE=
X-Received: by 2002:a17:906:339a:: with SMTP id v26mr77221660eja.2.1577801995388;
 Tue, 31 Dec 2019 06:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20191227173707.20413-1-martin.blumenstingl@googlemail.com>
 <20191227173707.20413-2-martin.blumenstingl@googlemail.com> <CAKGbVbs365C_44p9VyW33n5r2s7VKgOzpZWCZ2rAHZ+f2sic1A@mail.gmail.com>
In-Reply-To: <CAKGbVbs365C_44p9VyW33n5r2s7VKgOzpZWCZ2rAHZ+f2sic1A@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 Dec 2019 15:19:44 +0100
Message-ID: <CAFBinCBMKBry+ynmk1byC+UweMPbQcpHnGE2CxKJVJBcrY5+QQ@mail.gmail.com>
Subject: Re: [RFC v2 1/1] drm/lima: Add optional devfreq support
To:     Qiang Yu <yuq825@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang,

On Tue, Dec 31, 2019 at 3:54 AM Qiang Yu <yuq825@gmail.com> wrote:
[...]
> > diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> > index f522c5f99729..851c496a168b 100644
> > --- a/drivers/gpu/drm/lima/lima_sched.c
> > +++ b/drivers/gpu/drm/lima/lima_sched.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/xarray.h>
> >
> > +#include "lima_devfreq.h"
> >  #include "lima_drv.h"
> >  #include "lima_sched.h"
> >  #include "lima_vm.h"
> > @@ -213,6 +214,8 @@ static struct dma_fence *lima_sched_run_job(struct drm_sched_job *job)
> >          */
> >         ret = dma_fence_get(task->fence);
> >
> > +       lima_devfreq_record_busy(pipe->ldev);
> > +
> >         pipe->current_task = task;
> >
> >         /* this is needed for MMU to work correctly, otherwise GP/PP
> > @@ -280,6 +283,8 @@ static void lima_sched_handle_error_task(struct lima_sched_pipe *pipe,
> >         pipe->current_vm = NULL;
> >         pipe->current_task = NULL;
> >
> > +       lima_devfreq_record_idle(pipe->ldev);
> > +
> >         drm_sched_resubmit_jobs(&pipe->base);
> >         drm_sched_start(&pipe->base, true);
> >  }
> > @@ -348,6 +353,8 @@ void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
> >
> >  void lima_sched_pipe_task_done(struct lima_sched_pipe *pipe)
> >  {
> > +       lima_devfreq_record_idle(pipe->ldev);
>
> This should be moved to the else {} part of the following code. As you
> have added the save
> idle record to the lima_sched_handle_error_task which is just the if
> {} part of the following
> code, so no need to call it twice for error tasks. BTW.
> lima_sched_handle_error_task is also
> used for timeout tasks, so add idle record in it is fine.
oh, that is a good catch - thank you!
I will fix that in the next version


Martin
