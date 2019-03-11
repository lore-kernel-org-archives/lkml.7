Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54765C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E02D206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mbG5HFOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfCKSJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:09:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35169 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKSJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:09:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id z25so39778otk.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4mC82pidqSCPI9N9AxvKpvaBTHGNkY4Lid4nwuaH4M=;
        b=mbG5HFOvWilg9mQu5jG1qVpu/8BbTUud8Yc+8AAgitqarqAW88LjstsFDPF3saF7Nr
         /d/TlnRnGsf/3HXc99JNEBRyfMUcjRzTQywYnObeK17NsZaeg4H4I5VSiPFSkVOuIIHb
         nwVAtIE9O+F+VgADPxzLFvK2i9MCgfLA/pAj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4mC82pidqSCPI9N9AxvKpvaBTHGNkY4Lid4nwuaH4M=;
        b=LJ1vnsCVmxboNCtIub+cHf7bSZmv/KJllTAoDgph5aQX1Epftq+c4blgh6Dg6b1oJ8
         RXOUeLFbP58LKURaTTsFdM7P8St4ypmUnLXXE0yK6A+pfz/ChwxVpus5rDlKyH80V6XE
         19SdCFg0Hrb30OpqdAhheA4yVkAXsjEck0ex6tFbloFmlTGB0t6MR3av7KXI0e3HgjYd
         DMetqciklphPv6rMoM+3ZPAypiSeTqCr4w4P+0MLlu8nFhmaWkkxvneTw97Yh6c+29ZV
         8t76actSwqGd02NH38xTY4yhT/JyZ76wDoZKiiyMXkcIm/fw8qxeusfXGp2Wsu8q0LhX
         hg9w==
X-Gm-Message-State: APjAAAXQmegcu4PqBx/kjhMpKIXSUzKltStum8a4gFOm/THmhO4TVf+9
        4FhZDIbjP0YJvbmh1n6j+YSQPEwreAY=
X-Google-Smtp-Source: APXvYqycX7E8c2mqsexzPrXZb4PEWCGyBkQq5CuVSbd6+FWA6sED4FsM2EjdE9uDhEOzoQEdjBv3gg==
X-Received: by 2002:a9d:7f8d:: with SMTP id t13mr20359412otp.92.1552327751968;
        Mon, 11 Mar 2019 11:09:11 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id 97sm2618996otc.25.2019.03.11.11.09.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 11:09:11 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w66so4429420oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:09:10 -0700 (PDT)
X-Received: by 2002:aca:d803:: with SMTP id p3mr23407oig.111.1552327749933;
 Mon, 11 Mar 2019 11:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190225190957.40425-1-ncrews@chromium.org> <CAFqH_52NG0Zmc=dtZa=6o7kJc0fdueLqTaQiZdtM=2tBer+6vA@mail.gmail.com>
 <CAHX4x84gmrvnGMSE9Geb=8s+Htao+Z=Zp=rR0GpCV+FP5Ax+QQ@mail.gmail.com>
In-Reply-To: <CAHX4x84gmrvnGMSE9Geb=8s+Htao+Z=Zp=rR0GpCV+FP5Ax+QQ@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 11 Mar 2019 12:08:57 -0600
X-Gmail-Original-Message-ID: <CAHX4x84UE_TD4kSny3JABTzORWrirSNsFb7GkdF=Rqcj9uHEkw@mail.gmail.com>
Message-ID: <CAHX4x84UE_TD4kSny3JABTzORWrirSNsFb7GkdF=Rqcj9uHEkw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: Add Wilco EC Event Handling
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Oleh Lamzin <lamzin@google.com>,
        Bartosz Fabianowski <bartfab@google.com>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump so this doesn't get lost :)

On Mon, Mar 4, 2019 at 4:54 PM Nick Crews <ncrews@chromium.org> wrote:
>
> Hi Enric,
>
> On Tue, Feb 26, 2019 at 8:04 AM Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
> >
> > Hi Nick,
> >
> > Missatge de Nick Crews <ncrews@chromium.org> del dia dl., 25 de febr.
> > 2019 a les 20:13:
> > >
> > > This patch is meant to be applied on top of the current
> > > for-next top of tree in the chrome/platform repo, at
> > > https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=for-next
> > >
> > > The Wilco Embedded Controller can return extended events that
> > > are not handled by standard ACPI objects. These events can
> > > contain information about changes in EC controlled features,
> > > such as the charger or battery getting plugged/unplugged.
> > >
> >
> > To understand better this I think would be good to know what kind of
> > events or which specific events do you expect to handle through this
> > interface. Because if these events are like the ones you described
> > above (charger/battery plugged/unplugged) this should go again through
> > the power-supply subsystem and use the standard interface for that.
>
> I didn't fully understand what was going on here either, so I had to figure
> it out myself as well :)
>
> I had a bad description for what sort of events this driver will be used for.
> There are two general classes of events that are generated by the EC and
> sent to the OS over ACPI: Standard ones (such as charger/battery/lid stuff
> as you mention) and the special ones that we care about. These special events
> include errors and notifications from the optional charging/display
> dock accessory,
> for instance "The cable you connected with is not supported". The
> standard ones are
> indeed handled through the standard interfaces. This interface also
> gets notified
> for a few of the standard events such as the battery getting plugged
> and unplugged,
> and that's why I was getting confused.
>
> You can see in some of the coreboot code where ACPI determines whether
> or not to forward these special "QS events" to this driver or to the
> standard ACPI system:
> https://review.coreboot.org/cgit/coreboot.git/tree/src/ec/google/wilco/acpi/event.asl#n80
>
> >
> > I suspect that what you want here, is different kernel drivers
> > accessing this event interface. E.g a wilco_ec_charger hooked to this
> > event interface that is able to get the event when the battery is
> > charging or not charging or charged. Maybe something similar to MKBP
> > events in cros-ec? Is that what you want?
>
> This is not what we want, I should have explained the use case in my
> original message.
> The point of this driver is to allow telemetry and diagnostics management for
> enterprise uses. A telemetry daemon will be running on the device
> waiting for events,
> (such as "The video port on the dock is not working.") and will report
> them to a cloud service.
> An example daemon that will use this is here:
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/1390115
>
> With these explanations, do you now think that we should keep this structure,
> and not move to the power_supply subsystem?
>
> Thanks for your thoughts,
> Nick
