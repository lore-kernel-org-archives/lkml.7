Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD74EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EDF20709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfKTPjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:39:49 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:39565 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfKTPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:39:48 -0500
IronPort-SDR: oXXf2jN34jToYRwF3cdrryEJJGaIjc53aq+paWt7Rtj/ZX4xVtxRk/upRe2zy3ZDeM8X2tKDNX
 StP/piLSNHqyCCb350f2+ngDuSbfmUTmaD81VqcBezwBmvCF+iyORWXhLfmF/D26+pUJerzO3N
 NetXYsySxjDWQVZl7QM97Dj0xiS7Q4LmvWu5dzrXX71EQYu+OuoM3bgOkgJs+q6bezRuopGgH+
 fJKF+RdDognFKTfERY8CQGfodjc/iZc/GhrrPZT7iGOsojTEzycLuEftO7xcETWnbL6Z1RsWGD
 G8k=
X-IronPort-AV: E=Sophos;i="5.69,222,1571731200"; 
   d="scan'208";a="45220642"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 20 Nov 2019 07:39:48 -0800
IronPort-SDR: NTLHtgw50zu5G6nn7et5/NosI5DsjGCJt4yYmrwXEgSLgwUDcIePX9YhYJ22olLVglU4VJZEES
 T9EsUAqlxbztKD4g7nINe5fTvRJHxyH0BTrgwYMobdWzTkh4MhQpxPuZyEB6YlfmcUCm3s9aoC
 QzY4SJGYvG9/MuPuHOhKayDpcPBMMEwZzvYychHTYS67SCgSqzSu8uhARozG7bgOtTVWufLn+W
 C2tr8stOM/CCeX/iE/5XNVJtDTm6L/bs+o2HQnhfOZiEXXYRehc3PsO5fNPJiw7tYCYPZToqjL
 sQs=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     'Takashi Iwai' <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
References: <20191120115856.4125-1-andrew_gabbasov@mentor.com>  <20191120115856.4125-2-andrew_gabbasov@mentor.com>      <20191120115856.4125-3-andrew_gabbasov@mentor.com>      <20191120115856.4125-4-andrew_gabbasov@mentor.com>      <20191120115856.4125-5-andrew_gabbasov@mentor.com>      <20191120115856.4125-6-andrew_gabbasov@mentor.com>      <20191120115856.4125-7-andrew_gabbasov@mentor.com>      <s5hh82y8vn5.wl-tiwai@suse.de>  <000001d59fb6$4ca36aa0$e5ea3fe0$@mentor.com> <s5h5zje8sxl.wl-tiwai@suse.de>
In-Reply-To: <s5h5zje8sxl.wl-tiwai@suse.de>
Subject: RE: [PATCH v4 6/7] ALSA: aloop: Support selection of snd_timer instead of jiffies
Date:   Wed, 20 Nov 2019 18:39:00 +0300
Organization: Mentor Graphics Corporation
Message-ID: <000101d59fb8$a288a280$e799e780$@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHVn7ezhCAU3Kkkmk2hDkJrcybUyqeUMFOA
Content-Language: en-us
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, November 20, 2019 6:32 PM
> To: Gabbasov, Andrew
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Jaroslav
> Kysela; Takashi Iwai; Timo Wischer
> Subject: Re: [PATCH v4 6/7] ALSA: aloop: Support selection of snd_timer
> instead of jiffies
> 
> On Wed, 20 Nov 2019 16:21:36 +0100,
> Andrew Gabbasov wrote:
> >
> > Hello Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, November 20, 2019 5:34 PM
> > > To: Gabbasov, Andrew
> > > Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
Jaroslav
> > > Kysela; Takashi Iwai; Timo Wischer
> > > Subject: Re: [PATCH v4 6/7] ALSA: aloop: Support selection of
snd_timer
> > > instead of jiffies
> > >
> > > On Wed, 20 Nov 2019 12:58:55 +0100,
> > > Andrew Gabbasov wrote:
> > > > +/* call in loopback->cable_lock */
> > > > +static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
> > > > +{
> > > > +	int err = 0;
> > > > +	struct snd_timer_id tid = {
> > > > +		.dev_class = SNDRV_TIMER_CLASS_PCM,
> > > > +		.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION,
> > > > +	};
> > > > +	struct snd_timer_instance *timeri;
> > > > +	struct loopback_cable *cable = dpcm->cable;
> > > > +
> > > > +	spin_lock_irq(&cable->lock);
> > > > +
> > > > +	/* check if timer was already opened. It is only opened once
> > > > +	 * per playback and capture subdevice (aka cable).
> > > > +	 */
> > > > +	if (cable->snd_timer.instance)
> > > > +		goto unlock;
> > > > +
> > > > +	err = loopback_parse_timer_id(dpcm->loopback->timer_source,
> &tid);
> > > > +	if (err < 0) {
> > > > +		pcm_err(dpcm->substream->pcm,
> > > > +			"Parsing timer source \'%s\' failed with
%d",
> > > > +			dpcm->loopback->timer_source, err);
> > > > +		goto unlock;
> > > > +	}
> > > > +
> > > > +	cable->snd_timer.stream = dpcm->substream->stream;
> > > > +	cable->snd_timer.id = tid;
> > > > +
> > > > +	timeri = snd_timer_instance_new(dpcm->loopback->card->id);
> > > > +	if (!timeri) {
> > > > +		err = -ENOMEM;
> > > > +		goto unlock;
> > > > +	}
> > > > +	/* The callback has to be called from another tasklet. If
> > > > +	 * SNDRV_TIMER_IFLG_FAST is specified it will be called from
> the
> > > > +	 * snd_pcm_period_elapsed() call of the selected sound card.
> > > > +	 * snd_pcm_period_elapsed() helds
> snd_pcm_stream_lock_irqsave().
> > > > +	 * Due to our callback loopback_snd_timer_function() also
> calls
> > > > +	 * snd_pcm_period_elapsed() which calls
> > > snd_pcm_stream_lock_irqsave().
> > > > +	 * This would end up in a dead lock.
> > > > +	 */
> > > > +	timeri->flags |= SNDRV_TIMER_IFLG_AUTO;
> > > > +	timeri->callback = loopback_snd_timer_function;
> > > > +	timeri->callback_data = (void *)cable;
> > > > +	timeri->ccallback = loopback_snd_timer_event;
> > > > +
> > > > +	/* snd_timer_close() and snd_timer_open() should not be
called
> with
> > > > +	 * locked spinlock because both functions can block on a
> mutex. The
> > > > +	 * mutex loopback->cable_lock is kept locked. Therefore
> > > snd_timer_open()
> > > > +	 * cannot be called a second time by the other device of the
> same
> > > cable.
> > > > +	 * Therefore the following issue cannot happen:
> > > > +	 * [proc1] Call loopback_timer_open() ->
> > > > +	 *	   Unlock cable->lock for snd_timer_close/open()
call
> > > > +	 * [proc2] Call loopback_timer_open() -> snd_timer_open(),
> > > > +	 *	   snd_timer_start()
> > > > +	 * [proc1] Call snd_timer_open() and overwrite running timer
> > > > +	 *	   instance
> > > > +	 */
> > > > +	spin_unlock_irq(&cable->lock);
> > > > +	err = snd_timer_open(timeri, &cable->snd_timer.id, current-
> >pid);
> > > > +	if (err < 0) {
> > > > +		pcm_err(dpcm->substream->pcm,
> > > > +			"snd_timer_open (%d,%d,%d) failed with %d",
> > > > +			cable->snd_timer.id.card,
> > > > +			cable->snd_timer.id.device,
> > > > +			cable->snd_timer.id.subdevice,
> > > > +			err);
> > > > +		snd_timer_instance_free(timeri);
> > > > +		return err;
> > > > +	}
> > > > +	spin_lock_irq(&cable->lock);
> > > > +
> > > > +	cable->snd_timer.instance = timeri;
> > > > +
> > > > +	/* initialise a tasklet used for draining */
> > > > +	tasklet_init(&cable->snd_timer.event_tasklet,
> > > > +		     loopback_snd_timer_tasklet, (unsigned
> long)timeri);
> > >
> > > This has to be set before snd_timer_open().  The callback might be
> > > called immediately after snd_timer_open().
> >
> > This tasklet is used/scheduled only in ccallback (not regular tick
> > callback),
> > and only for SNDRV_TIMER_EVENT_MSTOP event. Can this event really happen
> > immediately after snd_timer_open()?
> 
> Why not?  The master timer can be stopped at any time, even between
> these two lines.
> 
> Beware that there are fuzzer programs that can trigger such racy
> things, and you're adding the code to the target that is actively
> slapped by them :)

OK, got it.
I'll move this initialization to before snd_timer_open() in the next
update together with the fixes for the other issues you will find
in this version.

Thanks!

Best regards,
Andrew

