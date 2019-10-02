Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B694C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4347D21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoQ1KrSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfJBPhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:37:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35504 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:37:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so13094237lfl.2;
        Wed, 02 Oct 2019 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECk1ds4yK/usm2oIeYQjQGNy286MUJFaO7tGfpvFD48=;
        b=CoQ1KrSaEemORYxjU84eBuww9g+jHyC1zvOrDjol+mHTXwQgcut1PrbZ70siVxxIws
         fqLYMg3nXcClqhgn3q0o5oI11PE70rV4m3+B5ZSgNme6zhiCaGEAlfvGMXXtDqXXFfKZ
         CK+6VadXiz4ZHpkEyCoR9ClJRs2Te7NYLIEpHHoN/bHRnscraSiHcu9ccIaBKPIApItj
         iib+H5wCYqiFGcjGzPucHGd7s2WUtA9BPCLp0uiJGU/ImTV1FQdNMwCZGSVp/yUt0lLi
         cAsjgkxcQ7MWA2PPgYP3KWAw/WVqI1Pr27b8YE6yHUgzTVRwAXLdRn6RmxsXqki83Rab
         bBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECk1ds4yK/usm2oIeYQjQGNy286MUJFaO7tGfpvFD48=;
        b=dc+3fg8dCIK9X4PpruizXPw7hAluHt7xTadHtasbplqviHo9b33eqsaOukPtp6tQSn
         ctv/F17aRNQDgiJFoJjI9conNdKZ4rZvRxs8LVFd/lIeGWzwip/FJX8A3YnJIaKlR/A5
         0KNlO08xWuth+qB5KiqGTbpxTv3xejZ5o4Is/kKRGcnptVVLKIz3c00C9xqF3+r1WCAf
         ePExAPKs+2Pd0smsNUx8umDSE8PTdDF9cZBpDDr2d6JOFxOHp+QSlyzvfRTKImOtix5a
         urjVJGoJZ6+Yf19UtDTmkbG7A7WZwwyF0wi30foG2xXfLROOf5Iphpt1PTX3BStOM+2s
         7qDg==
X-Gm-Message-State: APjAAAUzVkSG/ti0jWMu6P/9+HAzNiD2Yu1YdjUqvOno2Mhw8aWA42vk
        NkOp0n+LtbBMEKp8scF0zwQe4Kurg+vA9F/qRvvEuBI/S8z1vg==
X-Google-Smtp-Source: APXvYqw7Pzup4qrI0RpSRsrMyLy6h7TqPRZ0+qB46VbUUejl4bYnS47U5zMYnHld3F3fszOxtXLC8pUV9lu17A52XNM=
X-Received: by 2002:a19:ec16:: with SMTP id b22mr2796735lfa.189.1570030625007;
 Wed, 02 Oct 2019 08:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com> <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
 <20191002083913.GG2714@lahna.fi.intel.com> <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Wed, 2 Oct 2019 18:36:48 +0300
Message-ID: <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        nicholas.johnson-opensource@outlook.com.au,
        Lukas Wunner <lukas@wunner.de>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu,
        Anthony Wong <anthony.wong@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 6:09 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Wednesday, October 2, 2019 3:39 AM
> > To: Limonciello, Mario
> > Cc: linux-usb@vger.kernel.org; andreas.noever@gmail.com;
> > michael.jamet@intel.com; YehezkelShB@gmail.com; rajmohan.mani@intel.com;
> > nicholas.johnson-opensource@outlook.com.au; lukas@wunner.de;
> > gregkh@linuxfoundation.org; stern@rowland.harvard.edu;
> > anthony.wong@canonical.com; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Tue, Oct 01, 2019 at 06:14:23PM +0000, Mario.Limonciello@dell.com wrote:
> > > One more thought; would you consider exporting to sysfs sw-
> > >config.vendor_id?
> > > Maybe an attribute that is switch_vendor?
> > >
> > > Userland fwupd also does validation on the NVM and will need to follow this.
> > > The same check will go into fwupd to match the vendor and lack of
> > nvm_non_active0
> > > to mark the device as not updatable.  When the checks in the kernel get
> > relaxed,
> > > some NVM parsing will have to make it over to fwupd too to relax the check at
> > that point.
> >
> > The original idea was that the kernel does the basic validation and
> > userspace then does more complex checks. Currently you can compare the
> > two NVM images (active one and the new) and find that information there.
> > I think fwupd is doing just that already. Is that not enough?
>
> I guess for fwupd we can do this without the extra attribute:
>
> 1) If no NVM files or nvm_version: means unsupported vendor -show that messaging somewhere.
> This means kernel doesn't know the vendor.
>
> 2) If NVM file and nvm_version: means kernel knows it
> *fwupd checks the vendor offset for intel.
> -> intel: good, proceed
> ->something else: fwupd needs to learn the format for the new vendor, show messaging
>
> There is the unlikely case that kernel knows new vendor format and vendor NVM happened to have
> same value as Intel vendor ID in same location of Intel NVM but another meaning.
> Hopefully that doesn't happen :)

It's not even "same location - another meaning", the vendor ID comes from the
DROM section, so it takes a few internal jumps inside the NVM to find the
location. One of the "pointers" or section headers will be broken for sure.

And after this, we need to find the NVM in LVFS and it has to pass validation in
a few other locations. The chances are so low that I'd think it isn't worth
worrying about it.
