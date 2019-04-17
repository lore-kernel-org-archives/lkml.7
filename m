Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D959C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A61F2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqgGIY8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfDQXUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:20:22 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39776 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfDQXUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:20:21 -0400
Received: by mail-yb1-f194.google.com with SMTP id x71so180498ybe.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fs+8ugTzVY+/dgW7sUSk5w9Um1dxgebbM67FXktR1wE=;
        b=hqgGIY8/B1WgS2E/mVmsxDEUCox8KZXWWJWhKKc88DQia3Bc7N5Olv4Ll77YIxb6Cp
         uWKPGsknJpWwCDJPprjwlmOi+PRQWC6OiEpu+TP6JsV8cTZO2SctvE2vd39sps+Km+IU
         spkRO9WhcuQmlZzZYT5X4oL6PEY+9R3zzF0oe67tMGiwJTD1UC4Jo1B5NFHsMWXV4iDh
         wiUxcQ674r/R6YAqnpHTkxN3Ov7mwDzkNPLMZ6414/2WCIXz9rCoCqLnOEHvLP9NqOUG
         We2Hhe063BSih6lRzqQaC1Wpq5iMb/P2dsuZPQgKAbNLr+AndEJSPF31S1NcVV1cMTZS
         InQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fs+8ugTzVY+/dgW7sUSk5w9Um1dxgebbM67FXktR1wE=;
        b=dgGEBdr2E7rzdfk+zot2vcRj988v50nQ7Pzh4GewPHSMuMvcRal1ke0pxmn9WoRXOR
         RM3gWsYoanGeru0BnWMf2a49Wk2mYJ7n92fvKtWreIiAdQSSsvu8+HWPLJPXqYoZx23y
         3PN+Jz/6AfU11Z2uUT5eEvrNxMDZSCAVqRyhev3/uANnoUNs9dDMu1/YK/THH7BbXvHB
         9lKgyxa1uRiVYFB24DkK/x0iw3hgP4jYJGYyVf03jAJYxy6iOQlL7mxpUTfETk60tXr/
         5TPTbWfvtujNmYJzKRQ65mCI6YApvpZZLwqv4d8nMguJU4o4x+jfjZlizT6qCSQ/ms9K
         O31w==
X-Gm-Message-State: APjAAAUDiMvc4j84FcErAuQykjgYM0J23gIitVtcvWrr/O+mbdyQFnqV
        k9AMb84tABGF3aYU8t75LJxJ+MLnpQjfLSC1ceBkdw==
X-Google-Smtp-Source: APXvYqy0t/ab3i8QNaH8M63nzlsyF5CR4b10YOlJH+iIjk1j25CcMSubsnd25LsbPDgRY+2PzRDU8FlgqISzuRNHibk=
X-Received: by 2002:a25:ca95:: with SMTP id a143mr61114536ybg.282.1555543220991;
 Wed, 17 Apr 2019 16:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190417202017.GA204974@google.com> <Pine.LNX.4.44L0.1904171635460.1400-100000@iolanthe.rowland.org>
 <CAHQZ30B3+gzuw0=tofwW3yUwJ_MkN6GWPgVg0Qq_6S2tJHkcFQ@mail.gmail.com>
 <CABXOdTcjr6zw9sceC-i_Za3uOaOVmKGFaJsyMxhLUPEhtKn_Jg@mail.gmail.com> <20190417224129.GA255388@google.com>
In-Reply-To: <20190417224129.GA255388@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 17 Apr 2019 16:20:09 -0700
Message-ID: <CABXOdTeR_91AnhmRoEvVQWMb7_ibWeSuLb=Hwsrnj-swCr7G_w@mail.gmail.com>
Subject: Re: [PATCH v3] usb/hcd: Send a uevent signaling that the host
 controller had died
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Oliver Neukum <oneukum@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:41 PM Raul Rangel <rrangel@chromium.org> wrote:
>
> On Wed, Apr 17, 2019 at 03:23:52PM -0700, Guenter Roeck wrote:
> > On Wed, Apr 17, 2019 at 3:11 PM Raul Rangel <rrangel@chromium.org> wrote:
> > >
> > > On Wed, Apr 17, 2019 at 04:39:23PM -0400, Alan Stern wrote:
> > > >
> > > > This sounds like a golden opportunity!  Submit a separate patch making
> > > > the parameter to kobject_uevent_env be const (actually const char *
> > > > const []), then submit this patch on top of that one.
> > > So there are other parts of the code base that dynamically create their
> > > array values. So by making the function take const, it breaks :(
> >
> > Confused. The calling code can still be non-const. I don't see the
> > parameter modified in kobject_uevent_env(), so declaring it const
> > should be possible. Can you give an example of code that no longer
> > works ?
> static int notify_user_space(struct thermal_zone_device *tz, int trip)
> {
>         char *thermal_prop[5];
>         int i;
>
>         mutex_lock(&tz->lock);
>         thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
>         thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
>         thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
>         thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
>         thermal_prop[4] = NULL;
>         kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
>         for (i = 0; i < 4; ++i)
>                 kfree(thermal_prop[i]);
>         mutex_unlock(&tz->lock);
>         return 0;
> }
>
> drivers/thermal/user_space.c:48:52: error: passing 'char *[5]' to parameter of type 'const char *const *' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>         kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
>                                                           ^~~~~~~~~~~~
> include/linux/kobject.h:238:22: note: passing argument to parameter 'envp' here
>                         const char *const envp[]);
>                                           ^
>
> http://c-faq.com/ansi/constmismatch.html explains why it fails.
>
Interesting. One never stops learning. So the best you could do would
be char * const envp[], but I guess that doesn't help much.

Guenter

> Raul
>
> >
> > Thanks,
> > Guenter
> >
> > > >
> > > > Alan Stern
> > > >
