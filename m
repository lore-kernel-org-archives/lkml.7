Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AC32245A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ihgDbrP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKMHY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:24:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36406 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMHYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:24:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id f10so788741oto.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 23:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cw82Z7YfxL1T0WRyGKJbhospSN2a6L7ddj/UV4Mdvrc=;
        b=ihgDbrP3mYJhLcPkvw/MdUwnNTMWbySH/59Y34+0qjCU8soyEtPCMQ4Lq3mCRSvcmj
         3bnM96r95d9uww5hDh9YnfCPDCDHatMP2nhONdrBOsGEzUR1ZnuRDoolTFn0VIQaHPq4
         yRYp04+QIGl3drCiwficIAsRf9mFUK0J47fgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cw82Z7YfxL1T0WRyGKJbhospSN2a6L7ddj/UV4Mdvrc=;
        b=BoZk+lJeNV52Qm1VJx0FomTj4D81UWHmy52xn6VV1yi+umyBh7FHpVrrVV/wZDjE/j
         BX894z4Yc/aGqH+mFBrYak+BEMWJXdESXeYejcaCUmGGj3r1iisPabzhwLsQKwBVIk9G
         1f/OmmMFZI7Wb2sEw9Hu3kMPtFb685MpLf0FA3tX8Rv193yFlsOUUXxBI92ZmSKbaj2s
         3Vwl/UEDrEpM5/gO+4WTrkF4gN31FhUI+97cqUc8CwyCqGUCStX5vFO6DFDTzERXRedl
         h5mUxaWPVuDGnMA6G1PIKW+c/tFcMiHbRfTg9kVFSVY8iKZ6vfUdIBG0LMEq3mhmuGX8
         oN4Q==
X-Gm-Message-State: APjAAAV6vAzeBYNyia0GfP+yEv3baWx81CNqb4QT6ZA2v6JJe4rrHLjC
        wZRpE1UHWFDQHxNxuW8rX0FHcjX+AIZLV4a4c39/cg==
X-Google-Smtp-Source: APXvYqyUHqjUDE+NYm38Q78Rn0V8WJDBDDjcJJ+6/rfxexh23AV26y67eWOYyrAWkd6wWTKUgp+c1SqKjwcFrQYAcBE=
X-Received: by 2002:a05:6830:1e4c:: with SMTP id e12mr1479662otj.358.1573629893695;
 Tue, 12 Nov 2019 23:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20191112171715.128727-1-paulhsia@chromium.org> <s5h1rud7yel.wl-tiwai@suse.de>
In-Reply-To: <s5h1rud7yel.wl-tiwai@suse.de>
From:   Chih-Yang Hsia <paulhsia@chromium.org>
Date:   Wed, 13 Nov 2019 15:24:41 +0800
Message-ID: <CAJaf1TaZzsPdydcMZMemVSkjRvhYvx7ZxY2JEvExQ56B+MjQLQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ALSA: pcm: Fix race condition in runtime access
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 2:16 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 12 Nov 2019 18:17:13 +0100,
> paulhsia wrote:
> >
> > Since
> > - snd_pcm_detach_substream sets runtime to null without stream lock and
> > - snd_pcm_period_elapsed checks the nullity of the runtime outside of
> >   stream lock.
> >
> > This will trigger null memory access in snd_pcm_running() call in
> > snd_pcm_period_elapsed.
>
> Well, if a stream is detached, it means that the stream must have been
> already closed; i.e. it's already a clear bug in the driver that
> snd_pcm_period_elapsed() is called against such a stream.
>
> Or am I missing other possible case?
>
>
> thanks,
>
> Takashi
>

In multithreaded environment, it is possible to have to access both
`interrupt_handler` (from irq) and `substream close` (from
snd_pcm_release) at the same time.
Therefore, in driver implementation, if "substream close function" and
the "code section where snd_pcm_period_elapsed() in" do not hold the
same lock, then the following things can happen:

1. interrupt_handler -> goes into snd_pcm_period_elapsed with a valid
sustream pointer
2. snd_pcm_release_substream: call close without blocking
3. snd_pcm_release_substream: call snd_pcm_detache_substream and set
substream->runtime to NULL
4. interrupt_handler -> call snd_pcm_runtime() and crash while
accessing fields in `substream->runtime`

e.g. In intel8x0.c driver for ac97 device,
In driver intel8x0.c, `snd_pcm_period_elapsed` is called after
checking `ichdev->substream` in `snd_intel8x0_update`.
And if a `snd_pcm_release` call from alsa-lib and pass through close()
and run to snd_pcm_detach_substream() in another thread, it's possible
to trigger a crash.
I can reproduce the issue within a multithread VM easily.

My patches are trying to provide a basic protection for this situation
(and internal pcm lock between detach and elapsed), since
- the usage of `snd_pcm_period_elapsed` does not warn callers about
the possible race if the driver does not  force the order for `calling
snd_pcm_period_elapsed` and `close` by lock and
- lots of drivers already have this hidden issue and I can't fix them
one by one (You can check the "snd_pcm_period_elapsed usage" and the
"close implementation" within all the drivers). The most common
mistake is that
  - Checking if the substream is null and call into snd_pcm_period_elapsed
  - But `close` can happen anytime, pass without block and
snd_pcm_detach_substream will be trigger right after it

Best,
Paul

> >
> > paulhsia (2):
> >   ALSA: pcm: Fix stream lock usage in snd_pcm_period_elapsed()
> >   ALSA: pcm: Use stream lock in snd_pcm_detach_substream()
> >
> >  sound/core/pcm.c     | 8 +++++++-
> >  sound/core/pcm_lib.c | 8 ++++++--
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > --
> > 2.24.0.rc1.363.gb1bccd3e3d-goog
> >
