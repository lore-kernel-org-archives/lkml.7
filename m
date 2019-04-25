Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD8C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9E9206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556233394;
	bh=Eprjm84BhC2I/2qng2niEABfLtXC+cdm7ceZPlT0YsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1JkQpTTNQMPsxP6pUuJhOhsV8wjLQkQpXmqsTyKz+lALxt0nEFPG1INCA3XfFN/41
	 vwIe3bcb9S+5BjtCpV9jn2ruMYAKyV2aow5qnmx2gAg3ofNGpbecCqFfQQHZD0DJ0J
	 ZNQuNlaT8UUVnSUMUpEign1UR1w+vjHskiRYx9rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfDYXDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfDYXDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:03:12 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FACF20895;
        Thu, 25 Apr 2019 23:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556233391;
        bh=Eprjm84BhC2I/2qng2niEABfLtXC+cdm7ceZPlT0YsA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OgW08xEEXa6hDXPgLBqA/k/oaZZ5omsPp7Tv8nsfMUCEBCBp6C4/cWZ4r8RDRiSX9
         FA8z48MwaGzYoRWNg0odThNhM9W4RGBuyuPVoVNxhe318pvhq61zqf2yGqm9iqJvbX
         HrN4UnUc28V70nyTJmJMglUv3BebrQV0npRlSYCU=
Received: by mail-qt1-f172.google.com with SMTP id j6so2145248qtq.1;
        Thu, 25 Apr 2019 16:03:10 -0700 (PDT)
X-Gm-Message-State: APjAAAUgtVrjMCP5GBiC5yb6yrOEERUtlBbHsuVkl0aQbNkvQj5a7TMP
        HsddeVOJ1+ANCLmiJOeL130qsvpdmqSFiLtfFw==
X-Google-Smtp-Source: APXvYqylCukOpVImJQJIrdM1mx/S7o4ia6gik5qOSlcTnuTBesgUYaehkBVBOlOrs8s2iNkfm0mImzWM/VkAyyp02Jg=
X-Received: by 2002:aed:37a1:: with SMTP id j30mr1670849qtb.144.1556233390145;
 Thu, 25 Apr 2019 16:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
 <CAL_JsqJp9f3Sv08igSyR38Z5eXnAYWMNY29U5qEGLp=r2YReRw@mail.gmail.com> <CAKdAkRTUsJ4TU7BrSNXCKiQGZnArao9o_qk7i0xSzYJ1SGU14A@mail.gmail.com>
In-Reply-To: <CAKdAkRTUsJ4TU7BrSNXCKiQGZnArao9o_qk7i0xSzYJ1SGU14A@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Apr 2019 18:02:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJAnaJo4uLgNaqfnNMGYO+qqLaqdEn159hMTYqYE-Afhg@mail.gmail.com>
Message-ID: <CAL_JsqJAnaJo4uLgNaqfnNMGYO+qqLaqdEn159hMTYqYE-Afhg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add of_ functions for device_link_add()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Input <linux-input@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 2:24 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Apr 25, 2019 at 11:08 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Apr 24, 2019 at 5:19 AM Benjamin Gaignard
> > <benjamin.gaignard@st.com> wrote:
> > >
> > > It could happen that we need to control suspend/resume ordering between
> > > devices without obvious consumer/supplier link. For example when touchscreens
> > > and DSI panels share the same reset line, in this case we need to be sure
> > > of pm_runtime operations ordering between those two devices to correctly
> > > perform reset.
> > > DSI panel and touchscreen aren't sharing any heriachical relationship (unlike
> > > I2C client and I2C bus or regulator client and regulator provider) so we need
> > > to describe this in device-tree.
> >
> > Needing to know which touchscreen is attached to a panel could be
> > important to describe if you have multiple displays.
> >
> > Doesn't the reset subsystem already have some support for shared
> > resets? Seems like it could provide clients with struct device or
> > device_node ptrs to other devices sharing a reset.
> >
> > >
> > > This series introduce of_device_links_{add,remove} and devm_of_device_links_add()
> > > helpers to find and parse 'links-add' property in a device-tree node.
> >
> > Going to document that property somewhere? :)
> >
> > I think this is too generic and coupled to Linux. It doesn't have any
> > information as to what is the dependency or connection nor what the
> > direction of the dependency is.
> >
> > I'm not convinced we need to solve this generically vs. defining
> > something for this specific example.
>
> I am pretty sure there will be more drivers needing complex
> dependencies. Doesn't ACPI allow defining relationship between devices
> that goes beyond the tree structure?

Can't speak to ACPI, but I assume you where implying ACPI supports
this so DT should too.

Almost every binding we have is defining relationships between
devices. Interrupts, clocks, gpio, pinctrl, etc. all do this. To use a
similar example to the one here, we already define the relationship
between a display and a backlight with a 'backlight' property in the
display node. Why should touchscreen be any different than backlight?

What really concerns me here is folks just add relationships to
'links-add' which are already captured in DT (such as backlight) just
because they'll get it for free and not have to go add support to
handle each specific binding.

Rob
