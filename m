Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51103C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3315F23F04
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFDIx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:53:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44492 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfFDIxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:53:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so12766176qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVr7blrSWK0UByMgK8SdANdy6UgQTdw57Gh17vSspak=;
        b=dsMHO875mIiCL/RxUBgrN9MyzSsleL/hGUT7guB1drfPQieqJgVEZfuCpbMh62GKDk
         Qf7ozeOI9ZnCMXf9WVPuSuvCIjc9DJdObXIv40OTl9A+mmdUhFU+4LG7i8jJgyFxmOU1
         ITQn/yUCrHH8iSYoIPhAIf9/zGCEZRjEhM950zoocP1B2XOFTcHcNN1vkZgvZOFFP8vm
         F/Tt9oT1MtLabBgGvySVZOWBHYFLJvPSkH2bDuhVjK4xQ45KC64r1EG4EJbhLAZq5Si+
         Xd+6K4MCuMAy+Oir9+qxnYt0VFZkNli/nGbnPnUlEGbkUOuYRRj5FYxkQbMCauiMEjK+
         KkCw==
X-Gm-Message-State: APjAAAUZZrr6UuoHGM0azDZXeG0qWsM4eFDYOeAAl2osAzRgqj21EeAU
        fRpgZy8pOluW/VY6xMWxD3x8tbtMlEbQH7NEfwyilw==
X-Google-Smtp-Source: APXvYqwcmdQn7jDdAX4WgObYwtS3WxheoXf60Q29VNVzRPMwaGTHOaSlfLpwLzwB163jQdXsgkYWrER3QOHoHJmUpZk=
X-Received: by 2002:ac8:2998:: with SMTP id 24mr26315694qts.31.1559638404643;
 Tue, 04 Jun 2019 01:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm> <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com> <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com> <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
 <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com> <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
 <CAO-hwJKRRpsShw6B-YLmsEnjQ+iYtz+VmZK+VSRcDmiBwnS+oA@mail.gmail.com>
 <e431dafc-0fb4-4be3-ac29-dcf125929090@redhat.com> <CAO-hwJ+5UYJMnuCS0UL4g45Xc181LraAzc-CMuYB2rcqKGe_Sw@mail.gmail.com>
 <4548d196-b75f-c4d0-8f3c-3e734b9a758c@redhat.com> <c05929f4-00b6-e098-cd69-cd6539ccd3f1@redhat.com>
In-Reply-To: <c05929f4-00b6-e098-cd69-cd6539ccd3f1@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 4 Jun 2019 10:53:12 +0200
Message-ID: <CAO-hwJJWWRf8cCLCB3JdfFGCGPnp9ar9HC_QAg7crJ0y+pA-hg@mail.gmail.com>
Subject: Re: hid-related 5.2-rc1 boot hang
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 10:36 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 04-06-19 10:05, Hans de Goede wrote:
>
> <snip>
>
> >>>> We should likely just remove c52f from the list of supported devices.
> >>>> C52f receivers seem to have a different firmware as they are meant to
> >>>> work with different devices than C534. So I guess it is safer to not
> >>>> handle those right now and get the code in when it is ready.
> >>>
> >>> Ack. Can you prepare a patch to drop the c52f id?
> >>
> >> Yes. I have an other revert never submitted that I need to push, so I
> >> guess I can do a revert session today.
> >>
> >> I think I'll also buy one device with hopefully the C52F receiver as
> >> the report descriptors attached in
> >> https://bugzilla.kernel.org/show_bug.cgi?id=203619 seems different to
> >> what I would have expected.
> >
> > They are actually what I expected :)
> >
> > The first USB interface is a mouse boot class device, since this is a mouse
> > only receiver. This means that the mouse report is unnumbered and we need to
> > extend the unnumbered mouse-report handling to handle this case. Also the
> > device is using the same highres mouse-reports as the gaming receiver is.
> >
> > I'm actually preparing a patch right now which should fix this. Still might
> > be better to do the revert for 5.2 and get proper support for the c52f
> > receiver into 5.3.
>
> I've attached a patch to the bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=203619

Cool, thanks.

>
> Which should fix this. It is quite simple and safe, so if we get testing
> feedback relatively soon, we could go with the fix instead of dropping the
> product-id, your call.

I should receive the M280 tomorrow, hopefully with the C52F. If the
receiver is correct and the tests are successful, I'd prefer to take
this one over the revert :)

Cheers,
Benjamin
