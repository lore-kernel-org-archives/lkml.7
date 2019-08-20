Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0FAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E0B22CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPpZ1C0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfHTAJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:09:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41768 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfHTAJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:09:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so3387581ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkkChTW0EqV/CgrPH+BbWe/Zt2gMOVq7+GmSUYWaXDE=;
        b=XPpZ1C0ntJ/QDMGuBSe60QhMfwQdBTtGKgaEfG1T5FoRaHQ7f3StWl6c9eD3CyyFNc
         ybxTNZf5aC9h/iBz5aLyoJzn43SIzYono7iJkqn4tFCnJ2/xWp9u4lrstgB41o2i1Bh2
         FbWaqQKVay3rP3ZfDFERUvIxYi5ptyNa5JGdiYUgxjJwAtSgQl8qmMZKgvKMl3jMURz2
         VF8v+EOCUWN8hkhsNVFkkPPD9kS8UfVH+h/4xp+lCY2P1lIjfFMrn5Ko++2cJtQyGQgQ
         opQr/DKapSrigvn8ikV8YjFscAog7WYEIlpGEpprSsD1jKGtfzP41Z6EAsuebtmgMw6q
         yt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkkChTW0EqV/CgrPH+BbWe/Zt2gMOVq7+GmSUYWaXDE=;
        b=W2wal61oQ3nGHYgkbPYB+BKxN7Ujau0pLsaX1GnUDIsbgnzuxx1KqjE64Tch8Cmb0z
         S1hb7dF+PuWtqFAUqtaGNRxMVktRg4VJcCLDcIqH7jUSXb4HrJmDa9iXiAO/jYd3ujo9
         DYncsbfOCrMKWA4p5lmn96tSjwj8UuxogL8W+UluXKtQG7LSTSqFAkzZE9D1TsS8+KRQ
         kRBoJ7trOhGmxfhnUoyoKosnorJ4ADmim7bEEBXZQ84108v9RaYll44F89mpBcqc7VgC
         5zFUlsg0KRSmH2bx+xrAxiGgHMHdmm4bomOTY5RrTa6ujv4H0Sny8k1CJlxAQEo4f3ya
         ay3g==
X-Gm-Message-State: APjAAAVjlkWEoBdFOAwTuQZpPFVOWvbnDulTzYIAfOYyxLFouyQhDSGQ
        ngXXtgLXsg7Vb6hXV653Zq+V72t3a/0y4Ius2s14bw==
X-Google-Smtp-Source: APXvYqzLrU6k2Oxl+nNG6jVEZdNpIh6QkYLJsHK+cvyresmWebIsdTzCV8QY/zFYA1GwuBK/f3qGP7C5U1TJdXJ7QAc=
X-Received: by 2002:a05:6830:1e0f:: with SMTP id s15mr21605580otr.231.1566259784272;
 Mon, 19 Aug 2019 17:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com> <20190724001100.133423-4-saravanak@google.com>
 <141d2e16-26cc-1f05-1ac0-6784bab5ae88@gmail.com> <CAGETcx-dVnLCRA+1CX47gtZgtwTcrN5KefpjMzh9OJB-BEnqyg@mail.gmail.com>
 <19c99a6e-51c3-68d7-d1d6-640aae754c14@gmail.com> <CAGETcx-XcXZq7YFHsFdzBDniQku9cxFUJL_vBoEKKhCH+cDKRw@mail.gmail.com>
 <74931824-f8a1-0435-e00a-5b5cdbe8a8a2@gmail.com>
In-Reply-To: <74931824-f8a1-0435-e00a-5b5cdbe8a8a2@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 19 Aug 2019 17:09:08 -0700
Message-ID: <CAGETcx8UHA9kNkjjnBXcf_OYXaaPO9ky60M01Cfz3NFb1c1FZw@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 2:30 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 8/19/19 1:49 PM, Saravana Kannan wrote:
> > On Mon, Aug 19, 2019 at 10:16 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 8/15/19 6:50 PM, Saravana Kannan wrote:
> >>> On Wed, Aug 7, 2019 at 7:06 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> On 7/23/19 5:10 PM, Saravana Kannan wrote:
> >>>>> Add device-links after the devices are created (but before they are
> >>>>> probed) by looking at common DT bindings like clocks and
> >>>>> interconnects.
> >>
> >>
> >> < very big snip (lots of comments that deserve answers) >
> >>
> >>
> >>>>
> >>>> /**
> >>>>  * of_link_property - TODO:
> >>>>  * dev:
> >>>>  * con_np:
> >>>>  * prop:
> >>>>  *
> >>>>  * TODO...
> >>>>  *
> >>>>  * Any failed attempt to create a link will NOT result in an immediate return.
> >>>>  * of_link_property() must create all possible links even when one of more
> >>>>  * attempts to create a link fail.
> >>>>
> >>>> Why?  isn't one failure enough to prevent probing this device?
> >>>> Continuing to scan just results in extra work... which will be
> >>>> repeated every time device_link_check_waiting_consumers() is called
> >>>
> >>> Context:
> >>> As I said in the cover letter, avoiding unnecessary probes is just one
> >>> of the reasons for this patch. The other (arguably more important)
> >>
> >> Agree that it is more important.
> >>
> >>
> >>> reason for this patch is to make sure suppliers know that they have
> >>> consumers that are yet to be probed. That way, suppliers can leave
> >>> their resource on AND in the right state if they were left on by the
> >>> bootloader. For example, if a clock was left on and at 200 MHz, the
> >>> clock provider needs to keep that clock ON and at 200 MHz till all the
> >>> consumers are probed.
> >>>
> >>> Answer: Let's say a consumer device Z has suppliers A, B and C. If the
> >>> linking fails at A and you return immediately, then B and C could
> >>> probe and then figure that they have no more consumers (they don't see
> >>> a link to Z) and turn off their resources. And Z could fail
> >>> catastrophically.
> >>
> >> Then I think that this approach is fatally flawed in the current implementation.
> >
> > I'm waiting to hear how it is fatally flawed. But maybe this is just a
> > misunderstanding of the problem?
>
> Fatally flawed because it does not handle modules that add a consumer
> device when the module is loaded.

If you are talking about modules adding child devices of the device
they are managing, then that's handled correctly later in the series.

If you are talking about modules adding devices that aren't defined in
DT, then right, I'm not trying to handle that. The module needs to
make sure it keeps the resources needed for new devices it's adding
are in the right state or need to add the right device links.

> > In the text below, I'm not sure if you mixing up two different things
> > or just that your wording it a bit ambiguous. So pardon my nitpick to
> > err on the side of clarity.
>
> Please do nitpick.  Clarity is good.
>
>
> >
> >> A device can be added by a module that is loaded.
> >
> > No, in the example I gave, of_platform_default_populate_init() would
> > add all 3 of those devices during arch_initcall_sync().
>
> The example you gave does not cover all use cases.
>
> There are modules that add devices when the module is loaded.  You can not
> ignore systems using such modules.

I'll have to agree to disagree on that. While I understand that the
design should be good and I'm happy to work on that, you can't insist
that a patch series shouldn't be allowed because it's only improving
99% of the cases and leaves the other 1% in the status quo. You are
just going to bring the kernel development to a grinding halt.

> >
> >>  In that case the device
> >> was not present at late boot when the suppliers may turn off their resources.
> >
> > In that case, the _drivers_ for those devices aren't present at late
> > boot. So that they can't request to keep the resources on for their
> > consumer devices. Since there are no consumer requests on resources,
> > the suppliers turn off their resources at late boot (since there isn't
> > a better location as of today). The sync_state() call back added in a
> > subsequent patche in this series will provide the better location.
>
> And the sync_state() call back will not deal with modules that add consumer
> devices when the module is loaded, correct?

Depends. If it's just more devices from DT, then it'll be fine. If
it's not, then the module needs to take care of the needs of devices
it's adding.

> >
> >> (I am assuming the details since I have not reviewed the patches later in
> >> the series that implement this part.)
> >>
> >> Am I missing something?
> >
> > I think you are mixing up devices getting added/populated with drivers
> > getting loaded as modules?
>
> Only some modules add devices when they are loaded.  But these modules do
> exist.

Out of the billions of Android devices, how many do you see this happening in?

Thanks,
Saravana
