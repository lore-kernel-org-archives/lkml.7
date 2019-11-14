Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C6EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94827206E5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFnbzIou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKNQiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:38:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44524 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKNQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:38:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id c19so5371191otr.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q17Vz56Lz1GgFf83icIor/sOTwRzLf9Uxkx/4Lh/cUc=;
        b=XFnbzIouRqLtmtOdJkt7axfOtgjFS/FUBeybD84+3+dN4XnZsOfe1Apq7pMjjRvlr4
         dWIot2mOXaKWRgtDJkRBKkxo47N4s8f1xIn7wjwM3YzKfFxErQTQ84ZUFizQ+UTOcorv
         pviWuwhEqviJXtaL/NLJ841S71svrBIuvBPjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q17Vz56Lz1GgFf83icIor/sOTwRzLf9Uxkx/4Lh/cUc=;
        b=YWPW2C3qb2DAyiP/jsqTFAbf3OCENc2twozkeZAmKp05E8nIOBdtfo6+ga3lbX2WYJ
         L2RayOF3a5qGk/s6cXFbkwmPejE5OXTUT1bqVMvUr84GaZ9gO6TV356Ai24SomzUO5UL
         B2mZ8vBAUl99n6io8OIU0ULied3VvVaH0/LzAo2OOLgUSCE4QTXKcAZndYzd6CLmHbkr
         D63GJI9DwDGHQDYb0Xp+0PRq/nxNuJEHYl10UW/UsBYQkKmNFPrhpNCmijNZ9OvOxAiC
         feSa9z1S9KphPXdihvK34MiVOCGfiCcRR7ReCybFYX4RnoX8N6qRw/Yrqwj4lFUWzHAp
         XJaQ==
X-Gm-Message-State: APjAAAVBpG0O2O7NL+VwsoUt2+lWV6VV5DVGKXljaLFIMriz3Y4hjBVI
        xhkpNtnxExzfS/nOO2Pi4IWb6MwdSaDwoPvVftMsVg==
X-Google-Smtp-Source: APXvYqywkMkprEVoIjGj5F9y8DQyvWnI9dSsfgC23H64OGrqUbunisT3dqytVUWEwR1zVWCOt1K26ZHWOf7q5NSc52g=
X-Received: by 2002:a9d:154:: with SMTP id 78mr7708111otu.294.1573749485907;
 Thu, 14 Nov 2019 08:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20191112171715.128727-1-paulhsia@chromium.org>
 <s5h1rud7yel.wl-tiwai@suse.de> <CAJaf1TaZzsPdydcMZMemVSkjRvhYvx7ZxY2JEvExQ56B+MjQLQ@mail.gmail.com>
 <s5h7e446raw.wl-tiwai@suse.de> <s5hftisnh3s.wl-tiwai@suse.de>
 <CAJaf1TYwbsuNZ_RmRfo7ZcVPJ04e4Dh3G1e3kVYPQh_sX9TgWQ@mail.gmail.com> <s5h36eqmtf3.wl-tiwai@suse.de>
In-Reply-To: <s5h36eqmtf3.wl-tiwai@suse.de>
From:   Chih-Yang Hsia <paulhsia@chromium.org>
Date:   Fri, 15 Nov 2019 00:37:54 +0800
Message-ID: <CAJaf1TbOqOeRqN6jfAeHVu6drTZ9wBUHf5J9uy4-Ng1Pkr5nww@mail.gmail.com>
Subject: Re: [PATCH 0/2] ALSA: pcm: Fix race condition in runtime access
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:20 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 14 Nov 2019 15:16:04 +0100,
> Chih-Yang Hsia wrote:
> >
> > On Wed, Nov 13, 2019 at 7:36 PM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Wed, 13 Nov 2019 10:47:51 +0100,
> > > Takashi Iwai wrote:
> > > >
> > > > On Wed, 13 Nov 2019 08:24:41 +0100,
> > > > Chih-Yang Hsia wrote:
> > > > >
> > > > > On Wed, Nov 13, 2019 at 2:16 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > >
> > > > > > On Tue, 12 Nov 2019 18:17:13 +0100,
> > > > > > paulhsia wrote:
> > > > > > >
> > > > > > > Since
> > > > > > > - snd_pcm_detach_substream sets runtime to null without stream lock and
> > > > > > > - snd_pcm_period_elapsed checks the nullity of the runtime outside of
> > > > > > >   stream lock.
> > > > > > >
> > > > > > > This will trigger null memory access in snd_pcm_running() call in
> > > > > > > snd_pcm_period_elapsed.
> > > > > >
> > > > > > Well, if a stream is detached, it means that the stream must have been
> > > > > > already closed; i.e. it's already a clear bug in the driver that
> > > > > > snd_pcm_period_elapsed() is called against such a stream.
> > > > > >
> > > > > > Or am I missing other possible case?
> > > > > >
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > Takashi
> > > > > >
> > > > >
> > > > > In multithreaded environment, it is possible to have to access both
> > > > > `interrupt_handler` (from irq) and `substream close` (from
> > > > > snd_pcm_release) at the same time.
> > > > > Therefore, in driver implementation, if "substream close function" and
> > > > > the "code section where snd_pcm_period_elapsed() in" do not hold the
> > > > > same lock, then the following things can happen:
> > > > >
> > > > > 1. interrupt_handler -> goes into snd_pcm_period_elapsed with a valid
> > > > > sustream pointer
> > > > > 2. snd_pcm_release_substream: call close without blocking
> > > > > 3. snd_pcm_release_substream: call snd_pcm_detache_substream and set
> > > > > substream->runtime to NULL
> > > > > 4. interrupt_handler -> call snd_pcm_runtime() and crash while
> > > > > accessing fields in `substream->runtime`
> > > > >
> > > > > e.g. In intel8x0.c driver for ac97 device,
> > > > > In driver intel8x0.c, `snd_pcm_period_elapsed` is called after
> > > > > checking `ichdev->substream` in `snd_intel8x0_update`.
> > > > > And if a `snd_pcm_release` call from alsa-lib and pass through close()
> > > > > and run to snd_pcm_detach_substream() in another thread, it's possible
> > > > > to trigger a crash.
> > > > > I can reproduce the issue within a multithread VM easily.
> > > > >
> > > > > My patches are trying to provide a basic protection for this situation
> > > > > (and internal pcm lock between detach and elapsed), since
> > > > > - the usage of `snd_pcm_period_elapsed` does not warn callers about
> > > > > the possible race if the driver does not  force the order for `calling
> > > > > snd_pcm_period_elapsed` and `close` by lock and
> > > > > - lots of drivers already have this hidden issue and I can't fix them
> > > > > one by one (You can check the "snd_pcm_period_elapsed usage" and the
> > > > > "close implementation" within all the drivers). The most common
> > > > > mistake is that
> > > > >   - Checking if the substream is null and call into snd_pcm_period_elapsed
> > > > >   - But `close` can happen anytime, pass without block and
> > > > > snd_pcm_detach_substream will be trigger right after it
> > > >
> > > > Thanks, point taken.  While this argument is valid and it's good to
> > > > harden the PCM core side, the concurrent calls are basically a bug,
> > > > and we'd need another fix in anyway.  Also, the patch 2 makes little
> > > > sense; there can't be multiple close calls racing with each other.  So
> > > > I'll go for taking your fix but only the first patch.
> > > >
> > > > Back to this race: the surfaced issue is, as you pointed out, the race
> > > > between snd_pcm_period_elapsed() vs close call.  However, the
> > > > fundamental problem is the pending action after the PCM trigger-stop
> > > > call.  Since the PCM trigger doesn't block nor wait until the hardware
> > > > actually stops the things, the driver may go to the other step even
> > > > after this "supposed-to-be-stopped" point.  In your case, it goes up
> > > > to close, and crashes.  If we had a sync-stop operation, the interrupt
> > > > handler should have finished before moving to the close stage, hence
> > > > such a race could be avoided.
> > > >
> > > > It's been a long known problem, and some drivers have the own
> > > > implementation for stop-sync.  I think it's time to investigate and
> > > > start implementing the fundamental solution.
> > >
> > > BTW, what we need essentially for intel8x0 is to just call
> > > synchronize_irq() before closing, at best in hw_free procedure:
> > >
> > > --- a/sound/pci/intel8x0.c
> > > +++ b/sound/pci/intel8x0.c
> > > @@ -923,8 +923,10 @@ static int snd_intel8x0_hw_params(struct snd_pcm_substream *substream,
> > >
> > >  static int snd_intel8x0_hw_free(struct snd_pcm_substream *substream)
> > >  {
> > > +       struct intel8x0 *chip = snd_pcm_substream_chip(substream);
> > >         struct ichdev *ichdev = get_ichdev(substream);
> > >
> > > +       synchronize_irq(chip->irq);
> > >         if (ichdev->pcm_open_flag) {
> > >                 snd_ac97_pcm_close(ichdev->pcm);
> > >                 ichdev->pcm_open_flag = 0;
> > >
> > >
> > > The same would be needed also at the beginning of the prepare, as the
> > > application may restart the stream without release.
> > >
> > > My idea is to add sync_stop PCM ops and call it from PCM core at
> > > snd_pcm_prepare() and snd_pcm_hw_free().
> > >
> > Will adding synchronize_irq() in snd_pcm_hw_free there fix the race issue?
> > Is it possible to have sequence like the following steps ?
> > - [Thread 1] snd_pcm_hw_free: just pass synchronize_irq()
> > - [Thread 2] another interrupt come -> snd_intel8x0_update() -> goes
> > into the lock region of snd_pcm_period_elapsed() and passes the
> > PCM_RUNTIME_CHECK (right before snd_pcm_running())
>
> This shouldn't happen because at the point snd_pcm_hw_free() the
> stream has been already in the SETUP state, i.e. with trigger PCM
> callback, the hardware has been programmed not to generate the PCM
> stream IRQ.
>
Thanks for pointing that out.
snd_pcm_drop() will be called right before accessing `opts->hw_free`
and device dma will be stopped by SNDRV_PCM_TRIGGER_STOP.
And snd_pcm_prepare() will be called when the device is not running.
So synchronize_irq() should be enough for both of them.

I have a patch like this now in intel8x0:

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 6ff94d8ad86e..728588937673 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -923,8 +923,10 @@ static int snd_intel8x0_hw_params(struct
snd_pcm_substream *substream,

 static int snd_intel8x0_hw_free(struct snd_pcm_substream *substream)
 {
+       struct intel8x0 *chip = snd_pcm_substream_chip(substream);
        struct ichdev *ichdev = get_ichdev(substream);

+       synchronize_irq(chip->irq);
        if (ichdev->pcm_open_flag) {
                snd_ac97_pcm_close(ichdev->pcm);
                ichdev->pcm_open_flag = 0;
@@ -993,6 +995,7 @@ static int snd_intel8x0_pcm_prepare(struct
snd_pcm_substream *substream)
        struct snd_pcm_runtime *runtime = substream->runtime;
        struct ichdev *ichdev = get_ichdev(substream);

+       synchronize_irq(chip->irq);
        ichdev->physbuf = runtime->dma_addr;
        ichdev->size = snd_pcm_lib_buffer_bytes(substream);
        ichdev->fragsize = snd_pcm_lib_period_bytes(substream);

If that looks good to you, I can upload the patch to pw as well.
Then we can upstream the intel8x0 patch and the first change I made in
this series (the elapse one).
Does that sound good to you?

Thanks,
Paul

>
> Takashi
>
>
> > - [Thread 1] snd_pcm_hw_free finished() -> snd_pcm_detach_substream()
> > -> runtime=NULL
> > - [Thread 2] Execute snd_pcm_running and crash
> >
> > I can't trigger the issue after adding the synchronize_irq(), but
> > maybe it's just luck. Correct my if I miss something.
> >
> > Thanks,
> > Paul
> >
> >
> >
> >
> > >
> > > thanks,
> > >
> > > Takashi
> >
