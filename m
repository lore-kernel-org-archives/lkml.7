Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D12DC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED7220855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8Iaaphp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfDDU0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:26:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39921 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfDDU0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:26:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so2752056lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dp1Y9Dv5GK630BR2v0clibblX4rr7K4ynMZz4d+Iw/8=;
        b=K8IaaphpikRsNexVl3wgZLY/JMVAKJ5G67c8zuE2BC6Uf9275KJvoN7xkhJ4z/MRN7
         MbvfkeCVogYxyRuU9QWbibGKatbH8RB5d3UPo1G/7UJePlMY/H6lDxc+QESATdB5lfr6
         dSdLuNxXGQhc1TtbaDSCBDwXgNzb5t5bBpYq2QCcnDD+J/h0Fq/VG5a3r9hphrETRq40
         RmJMPpOZsU0U8zV9vWVfSvHcYIqHfj8AR/Ju64CGxwiIfb4GOrsIKRIfsRLYzOS5pxAO
         nab8OW6cK6U5pu+5TyiQcgCAv1TE4V5A/JvPY7i4iFDNbZ6WCMWyNfq1y7D+00bLK7Iw
         ySuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dp1Y9Dv5GK630BR2v0clibblX4rr7K4ynMZz4d+Iw/8=;
        b=paa+nN4M3L2Jb54BrPBqMs1cb3VKQ58tQJTk379GA7A0tb/Rx5e08frwgZKk6j0OtK
         jiBEMqJSrX7T8QEpaPw6BXqqUzgvp0r1bGONLHHOkuAFZ4x46/mqJnRC4tl5nLVaWa+Z
         xIxdXhOCIUQK/ps6H+7KiIIR+F21j/+uJZHRz05MpCz0pZVuELxLu8UNkXl0lp8faMND
         zWVEJeZX69vU1K+WGsEcC0GmtPP77X5VNW+YKm9ofRG42KgN0V83FDNuSxWH/5Vupl6K
         mIqQNrsGx12B2E3lGprZaRb9EyyrkOsJwMLD7SlbgL9PRtO35ig8PPDg0i1oGDdUIedA
         ahsA==
X-Gm-Message-State: APjAAAWe7/BXvQikZVSgyCHWz9K7L4FRZr19ML6nPvnCRGk+4ChJCfyA
        vzY6qmvAfMrmEQGwaXAk3Hk70EH906DsOh3CShnj7Q==
X-Google-Smtp-Source: APXvYqzA/4XqKeWk3nJEd1+1EoFUCYSaB34T+DGf+lDfFLGDsF4eM0t+zuClKCQ+zwftlC0TUebdXUXuVHX1VnULltk=
X-Received: by 2002:ac2:5108:: with SMTP id q8mr3971924lfb.99.1554409606022;
 Thu, 04 Apr 2019 13:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
 <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
 <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
 <CAE_wzQ8k4vO4yLsr2WNxYQ=-6JDmTsj6OxD0f3P=k8kJYFOD9Q@mail.gmail.com>
 <20190404185919.GB27340@amd> <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd> <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
 <20190404200658.GD29984@amd> <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
 <20190404202042.GF29984@amd>
In-Reply-To: <20190404202042.GF29984@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 13:26:35 -0700
Message-ID: <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Nick Crews <ncrews@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:20 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2019-04-04 13:13:34, Dmitry Torokhov wrote:
> > On Thu, Apr 4, 2019 at 1:06 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > > > > It is *function* and maybe color that userspace is interested i=
n, and
> > > > > > here we have proper standardization in form of "kbd_backlight".=
 Device
> > > > > > name is, well, device name. It should uniquely identify the dev=
ice led
> > > > > > is attached to, but otherwise is rarely interesting. If userspa=
ce is
> > > > > > really concerned what kind of keyboard backlight it is it shoul=
d
> > > > > > investigate parent device(s) and see what they end up with.
> > > > >
> > > > > That does not work. Userspace wants to know if it is internal key=
board
> > > > > or USB keyboard, not what kind of i2c controller the LED is conne=
cted
> > > > > to.
> > > >
> > > > Why does userspace want to know it?
> > >
> > > For example to turn off backlight on internal keyboard when the lid i=
s closed.
> >
> > Would you not want to turn off external as well?
>
> Not really. If I'm using machine with lid closed, external monitor and
> USB keyboard attached, I want to control backlight of USB keyboard,
> but backlight of internal keyboard can stay off.
>
> > And what to do if internal keyboard is not platform but USB? Like
> > Google "Whiskers"? (I am not sure why you decided to drop my mention
> > of internal USB keyboards completely off your reply).
>
> I don't have answers for everything. Even if you have USB keyboard, you'l=
l
> likely still have backlight connected to embedded controller. If not,
> then maybe you have exception userland needs to know about.
>
> Still better than making everything an exception.

You do not need to make everything exception. You just need to look
beyond the name, and see how the device is connected. And then apply
your exceptions for "weird" devices.

>
> > > > > grep for platform::mic_mute .
> > > > >
> > > > > (And platform is even pretty good match for how the LED is connec=
ted
> > > > > in your case).
> > > >
> > > > Until we get a secondary interface that is also "platform"...
> > >
> > > How would that happen?
> >
> > It won't happen on Wilco, but you can't imagine that several blocks
> > get reused in the same device and they end up clashing?
>
> In the end, there will be just one internal keyboard backlight, right?

=C2=AF\_(=E3=83=84)_/=C2=AF Maybe. Maybe not. Who knows what HW designers w=
ill come up with.

Thanks.

--=20
Dmitry
