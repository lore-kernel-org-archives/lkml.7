Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E52C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799CB214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfKHSK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:10:26 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:41938 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:10:26 -0500
IronPort-SDR: xWtMSIWV6u08FLvwfs6RmotHZVdiS0Z+wKIoAA6MDWM8O9yvhp0Oy5YWKvBX3uvAB5VyGj8WGz
 D3g4jOO577/CBhfyWR+6eaBgomG06cnQPA7cwdCgP5mdTymLc8SIZpdtxg8DYKyORx8vRtm1d8
 eBbCHaTpIvXAQFiHars2KCZv2qn6+NdthbewQnOqD6aWmsVA+xHbaGgFlQmaUIux6wDonwN73y
 B7wjVOvBJEAAFVXMIp+RJ2IkJcO2N41YPTOF3/0Po+KiInTWIOcbD+5Nh7bhNt6ENXIwxZ2WVg
 GfU=
X-IronPort-AV: E=Sophos;i="5.68,282,1569312000"; 
   d="scan'208";a="42941491"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 08 Nov 2019 10:10:25 -0800
IronPort-SDR: cJ2HoOQvWhF2kgqOONtw7dTLSUBbSQhARRgpLNdOm56y0+Zz/d4pC7X9wCb0W/+esi3Ui+AK0I
 OelaEfNmlar+YzaLsHO8sAgGFebumZDNoZlF3ulCEWjQTFNw5ZSULTj8+K7Q+CIlr14OGR7ZRC
 CKVQpxDEvCBScstQyvVBAWlQ7aKOucbdREEPevqolIE4AraoH0cs0PeH6XPLsMT0+t7X7Nc170
 AUkLwrmVZpwwMusLMfNImLDFnUiuD/y8FZaMlbDE/FdmWYXjusnq+E8HCFTQQ4+FNYWe+615l3
 g7E=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     'Takashi Iwai' <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>  <20191105143218.5948-2-andrew_gabbasov@mentor.com>      <20191105143218.5948-3-andrew_gabbasov@mentor.com>      <20191105143218.5948-4-andrew_gabbasov@mentor.com>      <20191105143218.5948-5-andrew_gabbasov@mentor.com>      <20191105143218.5948-6-andrew_gabbasov@mentor.com>      <20191105143218.5948-7-andrew_gabbasov@mentor.com>      <20191105143218.5948-8-andrew_gabbasov@mentor.com> <s5hlfss862t.wl-tiwai@suse.de>
In-Reply-To: <s5hlfss862t.wl-tiwai@suse.de>
Subject: RE: [PATCH v2 7/8] ALSA: aloop: Support selection of snd_timer instead of jiffies
Date:   Fri, 8 Nov 2019 21:09:22 +0300
Organization: Mentor Graphics Corporation
Message-ID: <000001d5965f$b1926ac0$14b74040$@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHVk+YmK3KlOO6PeUGxcY472O0ao6d/XF4AgAB4QPA=
Content-Language: en-us
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi,

Thank you very much for your feedback.

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, November 07, 2019 11:05 AM

> On Tue, 05 Nov 2019 15:32:17 +0100,
> Andrew Gabbasov wrote:
> > @@ -102,6 +106,13 @@ struct loopback_cable {
> >  	unsigned int pause;
> >  	/* timer specific */
> >  	struct loopback_ops *ops;
> > +	/* If sound timer is used */
> > +	struct {
> > +		int owner;
> 
> The term "owner" is a bit confusing here.  It seems holding the PCM
> direction, but most people expect it being a process-id or something
> like that from the word.

Will be fixed in next update.

> 
> > +		struct snd_timer_id id;
> > +		struct tasklet_struct event_tasklet;
> 
> You don't need to make own tasklet.  The timer core calls it via
> tasklet in anyway unless you pass SNDRV_TIMER_IFLG_FAST -- see below.
> 
> And the tasklet is no longer recommended infrastructure in the recent
> kernel, we should avoid it as much as possible.

See below about the tasklet.

> 
> >  struct loopback_setup {
> > @@ -122,6 +133,7 @@ struct loopback {
> >  	struct loopback_cable *cables[MAX_PCM_SUBSTREAMS][2];
> >  	struct snd_pcm *pcm[2];
> >  	struct loopback_setup setup[MAX_PCM_SUBSTREAMS][2];
> > +	char *timer_source;
> 
> This can be const char *, I suppose.

Yes, this will be fixed.

> > +static void loopback_snd_timer_period_elapsed(
> > +		struct loopback_cable * const cable,
> > +		const int event, const unsigned long resolution)
> > +{
> > +	struct loopback_pcm *dpcm_play =
> > +			cable->streams[SNDRV_PCM_STREAM_PLAYBACK];
> > +	struct loopback_pcm *dpcm_capt =
> > +			cable->streams[SNDRV_PCM_STREAM_CAPTURE];
> 
> You shouldn't assign them outside the cable->lock.

I'll move these assigns to after obtaining the lock.

> > +	struct snd_pcm_runtime *valid_runtime;
> > +	unsigned int running, elapsed_bytes;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&cable->lock, flags);
> > +	running = cable->running ^ cable->pause;
> > +	/* no need to do anything if no stream is running */
> > +	if (!running) {
> > +		spin_unlock_irqrestore(&cable->lock, flags);
> > +		return;
> > +	}
> > +
> > +	if (event == SNDRV_TIMER_EVENT_MSTOP) {
> > +		if (!dpcm_play || !dpcm_play->substream ||
> > +		    !dpcm_play->substream->runtime ||
> > +		    !dpcm_play->substream->runtime->status ||
> 
> Would these conditions really happen?

This seems to be kind of over cautiousness ;-)
I remove all intermediate members checks.

> > +		    dpcm_play->substream->runtime->status->state !=
> > +		    SNDRV_PCM_STATE_DRAINING) {
> 
> What's special with DRAINING state?  The code doesn't show or explain
> it.  And for other conditions, we keep going even if the event is
> MSTOP?

There are some comments below in loopback_snd_timer_event() function.
When the sound timer stops and the stream is in the draining state,
we still need to flush the data remaining in the buffer, and the regular
"elapsed" functions are called for that.

> > +			spin_unlock_irqrestore(&cable->lock, flags);
> > +			return;
> > +		}
> > +	}
> > +
> > +	valid_runtime = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
> > +				dpcm_play->substream->runtime :
> > +				dpcm_capt->substream->runtime;
> > +
> > +	/* resolution is only valid for SNDRV_TIMER_EVENT_TICK events */
> > +	if (event == SNDRV_TIMER_EVENT_TICK) {
> > +		/* The hardware rules guarantee that playback and capture
> period
> > +		 * are the same. Therefore only one device has to be checked
> > +		 * here.
> > +		 */
> > +		if (loopback_snd_timer_check_resolution(valid_runtime,
> > +							resolution) < 0) {
> > +			spin_unlock_irqrestore(&cable->lock, flags);
> > +			if (cable->running & (1 <<
SNDRV_PCM_STREAM_PLAYBACK))
> > +				snd_pcm_stop_xrun(dpcm_play->substream);
> > +			if (cable->running & (1 <<
SNDRV_PCM_STREAM_CAPTURE))
> > +				snd_pcm_stop_xrun(dpcm_capt->substream);
> 
> Referencing outside the lock isn't really safe.  In the case of
> jiffies timer code, it's a kind of OK because it's done in the timer
> callback function that is assigned for each stream open -- that is,
> the stream runtime is guaranteed to be present in the timer callback.
> But I'm not sure about your case...

I re-structure this code a little to make all de-referencing inside the
lock.

> > @@ -749,6 +1037,152 @@ static struct loopback_ops
> loopback_jiffies_timer_ops = {
> >  	.dpcm_info = loopback_jiffies_timer_dpcm_info,
> >  };
> >
> > +static int loopback_parse_timer_id(const char * const str,
> > +				   struct snd_timer_id *tid)
> > +{
> > +	/* [<pref>:](<card name>|<card idx>)[{.,}<dev idx>[{.,}<subdev
> idx>]] */
> > +	const char * const sep_dev = ".,";
> > +	const char * const sep_pref = ":";
> > +	const char *name = str;
> > +	char save, *sep;
> > +	int card = 0, device = 0, subdevice = 0;
> > +	int err;
> > +
> > +	sep = strpbrk(str, sep_pref);
> > +	if (sep)
> > +		name = sep + 1;
> > +	sep = strpbrk(name, sep_dev);
> > +	if (sep) {
> > +		save = *sep;
> > +		*sep = '\0';
> > +	}
> > +	err = kstrtoint(name, 0, &card);
> > +	if (err == -EINVAL) {
> > +		/* Must be the name, not number */
> > +		for (card = 0; card < snd_ecards_limit; card++) {
> > +			if (snd_cards[card] &&
> > +			    !strcmp(snd_cards[card]->id, name)) {
> > +				err = 0;
> > +				break;
> > +			}
> > +		}
> > +	}
> 
> As kbuildbot reported, this is obviously broken with the recent
> kernel.  snd_cards[] is no longer exported!  And I don't want to
> export again.
> 
> IOW, if we need this kind of thing, it's better to modify the existing
> code in sound/core/init.c and export that function.

Yes, I realized it a little late ;-)
So far I changed the loop to something like

	for (card_idx = 0; card_idx < snd_ecards_limit; card_idx++) {
		struct snd_card *card = snd_card_ref(card_idx);
		if (card) {
			if (!strcmp(card->id, name))
				err = 0;
			snd_card_unref(card);
		}
		if (!err)
			break;
	}

Of course, adding a separate lookup helper function to sound/core/init.c,
like, for example,
	struct snd_card *snd_card_find_id(const char *id)
that makes similar loop in a more "atomic" way, with proper locking and
reference incrementing for the result, would be more efficient, so if you
decide to create such a helper, that would help to eliminate this loop
from here.

> > +/* call in loopback->cable_lock */
> > +static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
> > +{
> > +	int err = 0;
> > +	unsigned long flags;
> > +	struct snd_timer_id tid = {
> > +		.dev_class = SNDRV_TIMER_CLASS_PCM,
> > +		.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION,
> > +	};
> > +	struct snd_timer_instance *timer = NULL;
> 
> Why initialing to NULL here?

Will be fixed too.

> > +	spin_lock_irqsave(&dpcm->cable->lock, flags);
> 
> You need no irqsave version but spin_lock_irq() for the context like
> open/close that is guaranteed to be sleepable.

And this will be fixed.

> > +	spin_lock_irqsave(&dpcm->cable->lock, flags);
> > +
> > +	/* The callback has to be called from another tasklet. If
> > +	 * SNDRV_TIMER_IFLG_FAST is specified it will be called from the
> > +	 * snd_pcm_period_elapsed() call of the selected sound card.
> 
> Well, you're the one who specifies SNDRV_TIMER_IFLG_XXX, so you know
> that the flag isn't set.  So tasklet makes little sense.

Indeed, that flag is not set, and the regular callback is already called
from the tasklet. That's why the callback function, registered here
(loopback_snd_timer_function) does not use the tasklet.
However, the ccallback event handler is called by sound core directly,
without a tasklet, and within "spin_lock_irqsave(&timer->lock, flags)".
So, it's not possible to call snd_pcm_period_elapsed() directly
from ccallback function (loopback_snd_timer_event). In order to
be able to make this call, the local tasklet is used.

> > +	 * snd_pcm_period_elapsed() helds snd_pcm_stream_lock_irqsave().
> > +	 * Due to our callback loopback_snd_timer_function() also calls
> > +	 * snd_pcm_period_elapsed() which calls
> snd_pcm_stream_lock_irqsave().
> > +	 * This would end up in a dead lock.
> > +	 */
> > +	timer->flags |= SNDRV_TIMER_IFLG_AUTO;
> > +	timer->callback = loopback_snd_timer_function;
> > +	timer->callback_data = (void *)dpcm->cable;
> > +	timer->ccallback = loopback_snd_timer_event;
> 
> This reminds me that we need a safer way to assign these stuff in
> general...  But it's above this patch set, in anyway.
> 

I'm preparing the next version of this patch set with the changes,
described above, and some more code cleanup. It will be submitted soon.

Thanks!

Best regards,
Andrew

