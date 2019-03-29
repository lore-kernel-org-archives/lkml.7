Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAF6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E933217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hg1/mFKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfC2SYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:24:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39639 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbfC2SYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:24:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id m13so2089786lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5493l1+4S5jr86en6cj1qVlZtW1vCTlfC0aGY7brEUI=;
        b=Hg1/mFKaulT2wANAkGSpWg+kbSClYZP+usxAtNF9zzgGrE+e9brvFHdrsxgYtV8Cd8
         +xj1ih+Y8g9LM5JQkqB7JrnGsfJ3fIhjlNealXPGslWFoNf49pMvnO5stRN5lL9UVHuC
         b8iZjvO91584fmHRykuKZaooYygFV691QLLDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5493l1+4S5jr86en6cj1qVlZtW1vCTlfC0aGY7brEUI=;
        b=N4LIMVcgoBClcoSX/qqfAlX+O1F+hbXf/6DUIZjbfCTKciPf6npk+4i2V/SDx/moQ3
         XmDLpNMML83+6MZWLEWnbL9ovJ+3F0l5IOawFN2jmZAFwxHxmJpYdq1O35UHgXarrvSg
         FkWUa5dEk8+deMRI1uiepdoAFCHvDmkhtQIKVol/UByfE8pL3ZeBN1MhHe2/46Z/MXNK
         z7J/3BV0IWeXXEUZObwED70/D6bvz7EEMIX5ORBrN52bk0WlHxK87Dw6kbWcbqcSlLGd
         znnd6lLy+pVM+glt94FozHnayM+VUhNyUigoVcicpzpyeQtHmFzDSkiQtkLz1FPvVdrq
         Z/4Q==
X-Gm-Message-State: APjAAAWCqX/0iobfSGULMRjO4sZ2FKu/yYsL8kefjAuQDILyVNm6OEGW
        5SCuKYJNOyWqJedPxYcg9oEJ6uqh1CE=
X-Google-Smtp-Source: APXvYqxofEuxtgxIfJ13gpMnQRXa17EktMfJAbGVsBcuxP1Ar50vEZWMZGQ0KnK0rkPgLNnBDPFlAw==
X-Received: by 2002:ac2:482f:: with SMTP id 15mr6944233lft.57.1553883840118;
        Fri, 29 Mar 2019 11:24:00 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 18sm535201lje.81.2019.03.29.11.23.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 11:23:57 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f23so2833396ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:23:56 -0700 (PDT)
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr1825051ljk.12.1553883836592;
 Fri, 29 Mar 2019 11:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
 <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com> <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
 <abe3eccb-1490-e088-1fd8-6af4dc1bd2ec@redhat.com>
In-Reply-To: <abe3eccb-1490-e088-1fd8-6af4dc1bd2ec@redhat.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Fri, 29 Mar 2019 11:23:45 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ8f6F7EvF-Jti=nPrUZw2bN1NGGCFJFohJv2m11GbMfGw@mail.gmail.com>
Message-ID: <CAE_wzQ8f6F7EvF-Jti=nPrUZw2bN1NGGCFJFohJv2m11GbMfGw@mail.gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc:     Vladislav Dalechyn <vlad.dalechin@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, kai.heng.feng@canonical.com,
        swboyd@chromium.org, bigeasy@linutronix.de,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, hotwater438@tutanota.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 5:18 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/25/19 5:56 PM, Dmitry Torokhov wrote:
> > Hi Hans,
> >
> > On Mon, Mar 25, 2019 at 9:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> On 25-03-19 17:02, Dmitry Torokhov wrote:
> >>> Hi Vladislav,
> >>>
> >>> On Mon, Mar 25, 2019 at 5:57 AM Vladislav Dalechyn
> >>> <vlad.dalechin@gmail.com> wrote:
> >>>>
> >>>> From: Vladislav Dalechyn <hotwater438@tutanota.com>
> >>>>
> >>>> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
> >>>> caused by an error setting the correct IRQ_TRIGGER flag:
> >>>> - i2c_hid incoplete error flood in journalctl;
> >>>> - Five finger tap kill's module so you have to restart it;
> >>>> - Two finger scoll is working incorrect and sometimes even when you
> >>>> raised one of two finger still thinks that you are scrolling.
> >>>>
> >>>> Fix all of these with a new quirk that corrects the trigger flag
> >>>> announced by the ACPI tables. (edge-falling).
> >>>
> >>> I do not believe this is right solution. The driver makes liberal use
> >>> of disable_irq() and enable_irq() which may lead to lost edges and
> >>> touchpad stopping working altogether.
> >>>
> >>> Usually the "extra" report is caused by GPIO controller clearing
> >>> interrupt condition at the wrong time (too early), or in unsafe or
> >>> racy fashion. You need to look there instead of adding quirk to
> >>> i2c-hid.
> >>
> >> The falling-edge solution was proposed by Elan themselves.
> >>
> >> Also if you look at: https://bugzilla.redhat.com/show_bug.cgi?id=1543769
> >>
> >> And esp. the "cat /proc/interrupts" output there, then you will see
> >> that the interrupt seems to be stuck at low level, which according
> >> to the ACPI tables is its active level.
> >
> > So how does it generate a new edge if it is stuck at low?
> >
> > Is it bad touchpad firmware that does not deassert interrupt quickly
> > enough?
>
> I do not believe it is not de-asserting it quick enough (I believe
> the amount of interrups is too high for that.
>
> It seems to simply be low most of the time, or it is really really
> slow with de-asserting.
>
> Vladislav can you check the output of /cat/interrupts on a kernel
> without the patch and while *not* using the touchpad; and check
> if the amount of touchpads-interrupts still keeps increasing in this
> case?
>
> Also I believe that you had contact with Elan about this and they
> told you to change the interrupt type to falling-edge as work-around,
> right?  Can you ask them why?

KT, do you know anything about using edge interrupts with your
hid-over-i2c products?

>
> This is quite unususal, I've collected quite a few DSDTs over time
> and I've just checked about 40 of them all with a PNP0C50 in
> some form (and in many cases multiple such devices) and NONE of
> them is using edged-interrupts in the ACPI config.

That is because MS spec for HID over I2C requires level interrupts:

"7.4 Interrupt Line Management

DEVICE is responsible to assert the interrupt line (level trigger
interrupt required) when it has data.

DEVICE must keep the interrupt line asserted until the data has been
fully read by the HOST. After this point, the DEVICE must de-assert
the interrupt line if it has no more data to report to the HOST.
When the DEVICE has new data to report, it must repeat the process above."

See https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)

>
> <speculation>
>
> I think that the Elan touchpad firmware supports a mode to
> work on devices which only support edge interrupts and that
> this mode is accidentally enabled in this firmware.
>
> I think that the interrupt line is simply low all the time
> and gets pulsed high then low again when the touchpad detects
> a finger. Hopefully it does this pulsing on every event and not
> only when its event "fifo" is empty.

This behavior would violate HID-over-I2C spec though.

>
> </speculation>
>
> > I scrolled through the bug but I do not see if it had been
> > confirmed that original windows installation actually uses edge (it
> > may very well be using it; Elan engineers pushed us to use edge in a
> > few cases, but they all boiled down to an issue with pin control/GPIO
> > implementation).
>
> This has not been checked on Windows AFAIK.
>
> >> As for this being a GPIO chip driver problem, this is using standard
> >> Intel pinctrl stuff, which is not showing this same issue with many
> >> other i2c-hid touchpads.
> >
> > Well, there have been plenty of issues in intel drivers, coupled with
> > "interesting" things done by firmware and boards.
> >
> > If you want to keep on using edge you need to make sure that i2c-hid
> > never loses edge, as replaying of previously disabled interrupts in
> > not at all reliable. So you need to "kick" the device after
> > enable_irq() by initiating read from it and be ready to not get any
> > data or get valid data and process accordingly.
>
> That is a good point and I agree.
>
> Vladislav, let me explain this a bit. Normally the touchpad
> driver the IRQ line low when it has touch-data to respond, which means
> that if touch-data is reported before the driver loads (or while
> the driver has the irq disabled during e.g. suspend), it will immediately
> see an interrupt. If we use edge mode then the IRQ will only trigger
> when the IRQ line goes from high to low, if this happens when the driver
> is not listening then we do not see the edge. And since we never read the
> pending touch-data, the IRQ line never goes high again (which it does
> when we have read all available data), so we will never see a negative-edge
> and then things are stuck.
>
> It would be good, if running a kernel with your patch, you can try
> to trigger this by:
>
> 1) Suspending the machine by selecting suspend from a menu in your
> desktop environment, or by briefly pressing the power-button, do
> not close the lid
> 2) As soon as the system starts suspending and while it is suspended, move
> your finger around the touchpad
> 3) Wake the system up with the powerbutton while moving your finger around
> 4) Check if the touchpad still works after this
>
> Or by:
>
> 1) Using ctrl + alt + f3 to switch to a text console
> 2) Move finger around on touchpad, keep moving it around
> 3) Switch back to X11 with alt + f2 or alt + f7, while still moving the finger
> 4) Check if the touchpad still works after this
>
> If neither causes the touchpad to stop working, then at least the problem Dmitry
> fears is not easy to trigger, but we should probably still prepare to deal
> with it; and we really should try to better understand the problem here, so
> if you can answer my questions above, then that would be great.

Thanks.

-- 
Dmitry
