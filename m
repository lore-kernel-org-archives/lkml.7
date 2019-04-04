Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98234C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6738B2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdeOJ7Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfDDUNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:13:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35953 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfDDUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:13:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so3251584ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYqmvWtL2dBFReY5T53bjMy7K/Ka+ZEzCOL2OVrFB08=;
        b=KdeOJ7ZkPcCwS03a2RdwMO7t9na8oge+X+usfZw/BjBMiDttJD8QrM4s0/ECeaVImc
         PQ2OmyLrAkfTbsL8Yjt9+3WVwJJkCjxeAsVgUUPJ7B6WD8700Z3pqtXZi2RvnrxvVPjF
         XKKvvAlgstqpk1tEd67bNKdposPNR6lci8CmtKJesl49XjpcZgMfJ9ULIj7AnOGCINqM
         MjJ0Dg15NYUF/NCksUnWgtxWwvsPqWCREsyFXr8x3/cFXZ8N39bNNXaqrjWNV7zJ+nQf
         rZxaxR6kc6LY/YzVnESvoJkFzlh1R6F8N1AM0uLO/JpO8hqlXc1e/kKALfeGIKEJwX69
         l+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYqmvWtL2dBFReY5T53bjMy7K/Ka+ZEzCOL2OVrFB08=;
        b=JxyvpcpJOgB7TgVmxdrfcRI4ZAw0u1k5wxOdF/yTilLcHCFCAz+sdOham0b6+gaw09
         4iMtjvngyJlssNlRLHhZyJJDwajvV0xIUXSm4rSK9iitiNq8eRP6KDmcFcyhfADHXxUD
         oYQ89ZmE5iR4dVjdips82xiRS4pkJ+p+ezsMPeJ1Yh2Kj6yM99+GHqV48orfCV6pcq3z
         cQ1bCN5W1yW22egInIE/v6lWG+jFKsKQU7KrqG+H/5SJexOoUFF/8UP51iAyIekxwyEM
         ysWDYC492VqWnlW7g1/xMcF44P73sf4TeCjV0xhGWz+ALSuDHLHtkpWxzum88h9WQkR2
         Bd4g==
X-Gm-Message-State: APjAAAWFiugKaKDRiaRdkno/K60C9KBw1DTFBcCNRLXtByprPRRcGxgr
        AzcMbZIlB1UiYf7OtFjqBBN97bXy4Y5w6iPq3d+CcQ==
X-Google-Smtp-Source: APXvYqzR2SreJaBZ7ZLOKCZogo6k5iWjHqEIJkSWqqFwGCoeaLUwmLFVqMLnf5TxiW4mkVTFXU3corQUyQspb497SGI=
X-Received: by 2002:a2e:219:: with SMTP id 25mr4544058ljc.34.1554408825519;
 Thu, 04 Apr 2019 13:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-3-ncrews@chromium.org>
 <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
 <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
 <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
 <CAE_wzQ8k4vO4yLsr2WNxYQ=-6JDmTsj6OxD0f3P=k8kJYFOD9Q@mail.gmail.com>
 <20190404185919.GB27340@amd> <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd> <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
 <20190404200658.GD29984@amd>
In-Reply-To: <20190404200658.GD29984@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 13:13:34 -0700
Message-ID: <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:06 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > It is *function* and maybe color that userspace is interested in, and
> > > > here we have proper standardization in form of "kbd_backlight". Device
> > > > name is, well, device name. It should uniquely identify the device led
> > > > is attached to, but otherwise is rarely interesting. If userspace is
> > > > really concerned what kind of keyboard backlight it is it should
> > > > investigate parent device(s) and see what they end up with.
> > >
> > > That does not work. Userspace wants to know if it is internal keyboard
> > > or USB keyboard, not what kind of i2c controller the LED is connected
> > > to.
> >
> > Why does userspace want to know it?
>
> For example to turn off backlight on internal keyboard when the lid is closed.

Would you not want to turn off external as well?

And what to do if internal keyboard is not platform but USB? Like
Google "Whiskers"? (I am not sure why you decided to drop my mention
of internal USB keyboards completely off your reply).

>
> > > grep for platform::mic_mute .
> > >
> > > (And platform is even pretty good match for how the LED is connected
> > > in your case).
> >
> > Until we get a secondary interface that is also "platform"...
>
> How would that happen?

It won't happen on Wilco, but you can't imagine that several blocks
get reused in the same device and they end up clashing?

Thanks.

-- 
Dmitry
