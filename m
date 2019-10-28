Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7731DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493BA21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiJaA4se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390932AbfJ1QZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:25:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35749 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390902AbfJ1QZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:25:53 -0400
Received: by mail-io1-f68.google.com with SMTP id h9so11440836ioh.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62aOCZujaPjLMXmFPiRB6XzKNfXNdqecHfS0A2Hu8ko=;
        b=BiJaA4seBZsQTPq9zw4g+A57lDEvtNeQoxuyhvCo9FUNmQt567u2xluFLm8yVUzwSO
         6JEuOH2ywUCSy8dF3elfmXyQW5ot8j4Hn+6ochXaNSLdWo41jgWxs/zdVbzR3cbNLn/n
         fJ4etMLzxmTHiqRfLDwJP2Yr2YkCxC/A3qpmPQjhSpnRLaK7BY7seX/ymv6oZLYJqtb3
         kDgCSl5H7SSeiz9Kd+AIDyMsWD58VLxPUIsyZ7fIaWr5gzomnLEQXtWCsDBVH0Ak6DB2
         I4aMXOZ/0Vi8m8tXpwmJSCTf0xk1E2yyjjZwSgtL7xGeAzyD7y/5Bodz5xHaFFONnDZD
         x1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62aOCZujaPjLMXmFPiRB6XzKNfXNdqecHfS0A2Hu8ko=;
        b=kvKaXREnzdKh5T0DyAJddeDH9u7JlKp/F3LkVc6qTCGOKxPjYoADcdsIotSVRv2O0j
         0KP8SJrLSWIHLMyFjNT+zN53b4AcBYogar0nFnNVtO+unqXJ93x8915vwUVBPVT87CXp
         i4xmcsXQF9YBPSS/Rh2gRPsnRZcTh71229AydA+NXMW7oGra/uo5DRMUb+b/4sou7/jp
         Rz/vGhlWr/GYZsG8V9Zn6Yh72AeeEKcPGg97eEP0znPGa+gHPJq3j74xdqwFJnCxRazW
         WKe159PpR60nCY5X0+PKUmQSlflOhhdV8krRa16h8bdtbmGAj2AbauMkayfsK2kBiIeO
         Dc+A==
X-Gm-Message-State: APjAAAW5k0TGug8X8sW70wcYhasWIrK1GqFgNvHkBz1/i3XKN+6+lbVF
        byqW3kEoRAYsnUbzpQ3z1KZ0fw6kAU7DFWhdmZYSw5hUngY=
X-Google-Smtp-Source: APXvYqxS+8kiAL+Wcxn+fmYc+Yioqr8WfBBuzznOXGTcdWpC3bS3vjFRwgW6Rto0lmGXcotfSYpCifNGe71zuO2R4lw=
X-Received: by 2002:a5e:9706:: with SMTP id w6mr18017287ioj.252.1572279952857;
 Mon, 28 Oct 2019 09:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191027221007.14317-1-navid.emamdoost@gmail.com> <s5hpnihmlk3.wl-tiwai@suse.de>
In-Reply-To: <s5hpnihmlk3.wl-tiwai@suse.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 28 Oct 2019 11:25:41 -0500
Message-ID: <CAEkB2ESwKEQYQx75BnaHf4aUQHObx4jf0hreQx_KTeZ+QCjL4g@mail.gmail.com>
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

Thanks for the explanation,

On Mon, Oct 28, 2019 at 1:27 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sun, 27 Oct 2019 23:10:06 +0100,
> Navid Emamdoost wrote:
> >
> > In the implementation of __snd_usbmidi_create() there is a memory leak
> > caused by incorrect goto destination. Go to free_midi if
> > snd_usbmidi_create_endpoints_midiman() or snd_usbmidi_create_endpoints()
> > fail.
>
> No, this will lead to double-free.  After registering the rawmidi
> interface at snd_usbmidi_create_rawmidi(), the common destructor will
> be called via rawmidi private_free callback, and this will release the
> all resources already.
Now I can see how rawmidi private_free is set up to release the
resources, but what concerns me is that at the moment of endpoint/port
creation umidi is not yet added to the midi_list.
In other words, what I see is that we still have just one local
pointer to umidi if any of snd_usbmidi_create_endpoint* fail.
Am I missing something?


>
>
> thanks,
>
> Takashi
>
> >
> > Fixes: 731209cc0417 ("ALSA: usb-midi: Use common error handling code in __snd_usbmidi_create()")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  sound/usb/midi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > index b737f0ec77d0..22db37fbfbbd 100644
> > --- a/sound/usb/midi.c
> > +++ b/sound/usb/midi.c
> > @@ -2476,7 +2476,7 @@ int __snd_usbmidi_create(struct snd_card *card,
> >       else
> >               err = snd_usbmidi_create_endpoints(umidi, endpoints);
> >       if (err < 0)
> > -             goto exit;
> > +             goto free_midi;
> >
> >       usb_autopm_get_interface_no_resume(umidi->iface);
> >
> > --
> > 2.17.1
> >



-- 
Navid.
