Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCCECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC8220717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klGwHRTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbfJ1QnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:43:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38735 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733000AbfJ1QnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:43:03 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so11448495iom.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7hboFEeFKyd5NAixP5xiZOuYFeH/C9fhpLKgwRHkUs=;
        b=klGwHRTL5mrKIVtDuSfO99e4sh4sykQEmk1xCfQjQO93WTHqN2jd09J2wI82K7XZv3
         lHFxONAggH6yEFrVcPrsdNnmX+845szwZcXqLaUQd/60yJfww2rxSNhCwyQGDk5hOjO2
         AhktlWElZ7n1NVCMhAxkfoYXhr+doOi0WuQK7WxnWDLl8NVhfxDJR/GJLcY6A7zRF0Es
         8wLHwk+CXeET308GS896cr6zifsPfRJFF6onjNS6w617znys6hy2yZ3LpfmcIk4Zs/g6
         n86RLtYt6t5jcIKe53pGUGqR0Yg91ymfUJ6wAOUtWjftFAWuv7DYdM0UWKIC/YIp7wNc
         QMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7hboFEeFKyd5NAixP5xiZOuYFeH/C9fhpLKgwRHkUs=;
        b=Qw2wp4OB96ZQLiYywFHedm8zjlXdxa6DKJPfT5x15iYKFWAkMELylNp9CklTN4F7Dm
         p6jpZVPmU8KwT5lpluYSV6T1nDyUeZNDLPuiSi7OgM+hQ1En6XC/pHS18dR3HEGD5KQf
         kUEHu4Aedkc5u4yAUc7coBHJvvJ5Hm4d2qMzS8IjE22+CyLKPNns/df0vTPPqc+AzWZk
         aKwHLD5seIij2AvsqintLztGREJG/X8bpf5vQ0OeU2UmS3apKLpvhDHlSDbpul3BjkEs
         q0++CidxIRVviYHubSVm5xQoZBf8uEVjKyorUegkxarM0CwJH3fMg74kKH494Hiy9AJJ
         M35Q==
X-Gm-Message-State: APjAAAXaQbYRcX9J+5dI/nwsdEopCgmHRN1EJgh7BGpIjjYMN94Ywshi
        odFGimH0X5f7km4jJoy+ZPeSgs71X6+8fBCwIYQ=
X-Google-Smtp-Source: APXvYqxI39T88uTzfIWo1E/+l15lDn1rBKzV5Mm1lUMuD5oaP5IrRMkeMKreID8HOeG0AEElnlLbCSwIpd0X2zWWJ3A=
X-Received: by 2002:a6b:ba44:: with SMTP id k65mr86633iof.190.1572280982021;
 Mon, 28 Oct 2019 09:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191027221007.14317-1-navid.emamdoost@gmail.com>
 <s5hpnihmlk3.wl-tiwai@suse.de> <CAEkB2ESwKEQYQx75BnaHf4aUQHObx4jf0hreQx_KTeZ+QCjL4g@mail.gmail.com>
 <s5hy2x4u8oi.wl-tiwai@suse.de>
In-Reply-To: <s5hy2x4u8oi.wl-tiwai@suse.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 28 Oct 2019 11:42:50 -0500
Message-ID: <CAEkB2ERL9GPXWvkPViMp4k1MrZn08v-kTNv8B495hqi4e-TJog@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix memory leak in __snd_usbmidi_create
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:38 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 28 Oct 2019 17:25:41 +0100,
> Navid Emamdoost wrote:
> >
> > Thanks for the explanation,
> >
> > On Mon, Oct 28, 2019 at 1:27 AM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Sun, 27 Oct 2019 23:10:06 +0100,
> > > Navid Emamdoost wrote:
> > > >
> > > > In the implementation of __snd_usbmidi_create() there is a memory leak
> > > > caused by incorrect goto destination. Go to free_midi if
> > > > snd_usbmidi_create_endpoints_midiman() or snd_usbmidi_create_endpoints()
> > > > fail.
> > >
> > > No, this will lead to double-free.  After registering the rawmidi
> > > interface at snd_usbmidi_create_rawmidi(), the common destructor will
> > > be called via rawmidi private_free callback, and this will release the
> > > all resources already.
> > Now I can see how rawmidi private_free is set up to release the
> > resources, but what concerns me is that at the moment of endpoint/port
> > creation umidi is not yet added to the midi_list.
> > In other words, what I see is that we still have just one local
> > pointer to umidi if any of snd_usbmidi_create_endpoint* fail.
> > Am I missing something?
>
> The rawmidi object that is created via snd_rawmidi_new() is managed
> via snd_device list, and it's traversed at snd_card_disconnect() and
> snd_card_free() calls.  It's something like devm-stuff (but
> implemented in a different way).  The midi_list is an explicit list
> for the USB MIDI driver, and it's an individual one from the device
> list.

Thanks for the clarification.

>
>
> Takashi
>
> >
> >
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > >
> > > > Fixes: 731209cc0417 ("ALSA: usb-midi: Use common error handling code in __snd_usbmidi_create()")
> > > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > > ---
> > > >  sound/usb/midi.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > > > index b737f0ec77d0..22db37fbfbbd 100644
> > > > --- a/sound/usb/midi.c
> > > > +++ b/sound/usb/midi.c
> > > > @@ -2476,7 +2476,7 @@ int __snd_usbmidi_create(struct snd_card *card,
> > > >       else
> > > >               err = snd_usbmidi_create_endpoints(umidi, endpoints);
> > > >       if (err < 0)
> > > > -             goto exit;
> > > > +             goto free_midi;
> > > >
> > > >       usb_autopm_get_interface_no_resume(umidi->iface);
> > > >
> > > > --
> > > > 2.17.1
> > > >
> >
> >
> >
> > --
> > Navid.
> >



-- 
Navid.
