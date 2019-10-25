Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83524CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C7B20578
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6vDnA9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409059AbfJYKLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:11:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33364 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408997AbfJYKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:11:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so1676145wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAD6ZzaZyQsOGAtOPlQ1VAdek0AzOAWPDx07f4OSZF4=;
        b=G6vDnA9ukuAGDzLUpMimNpZMuMQhp3A1G9/CRnCCvMz3bi6q0gk2DVrZtOUvjGItir
         LmyD7QTi+bK7Uqxi3h3QOLHei2Hnvahbfq67+6YJczqNpuSBdsls+uGgE29tZLIBPbt7
         KoLklQzdDmj+6WXr8wIzjsC3NZvbyUQzx4u2uH3rTPvzEMa1oAOX4TUTyNZxl6TRpoRR
         pjgWL2aCw4e+bxeHH4YhGvVbcHsZ7aZxy2i4bt6LJK26C8cYXse6iefLX8zJXbgTEhBm
         HBFJ/l4+h7I36ODRMkaIdXWoOrN0yEfxHDCXtVc/56K/ZdkPynA4qWIvpsMF0IvTUm7q
         PSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAD6ZzaZyQsOGAtOPlQ1VAdek0AzOAWPDx07f4OSZF4=;
        b=fG/ZUj12JtPXtWKqSpqaNeZqSLa6kp3EhygOfJleim9HbS8kck7kDTL+BAsyBrlEV1
         4wNnt9SmToABRYucV4Sa1GVxKk/QSVOCvbRS+LKFKLIXXC2pCfZh4CuZKpVlOnkR2rRg
         L2CGixWlfpGGQGGzv0RvWI8uMeLMbAX9WWhGwPbH2ArPzM3+Gsh2tovOZw76dMR7DIYX
         7vAZb4F1sG4waKmFQN5YEXUzUx8r5YA69tj4lEZD0MC7pslh8Tz0oQPPOHXhGpJxyqk8
         k/JlIupOzfXC+5n525K99UHgmheUjDmfea9QWOXxqiljtav/d4nam1VMeC23Hqarxc39
         X38w==
X-Gm-Message-State: APjAAAViZee6nmCQTwFcmUIAT07gINB24O3Tf0f9rPCA4mwrX0xfLdkF
        7JvAusg7kdbG5k6c1yLtM8LQdCJ7HZM/doyKUw0=
X-Google-Smtp-Source: APXvYqzhinGDUdQ3f70E0S5qjeySWIXV3GGj0hExkZ85bjLLl01EyWNG6tk8kP2wxSrIjSAPC4xjpC+C44+fB0n6d8o=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr2103728wrw.391.1571998309987;
 Fri, 25 Oct 2019 03:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com> <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
In-Reply-To: <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 12:11:37 +0200
Message-ID: <CAHtQpK5ZSOMKY4U0y-HHHH6QiuYRWHr90SAzjaACpAGgTzALLQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 25-10-2019 09:53, Andy Shevchenko wrote:
> > On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
> >> This patchset introduces additional regulator driver for Intel Cherry
> >> Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
> >> PMIC, which is used to instantiate this regulator.
> >>
> >> Regulator support for this PMIC was present in kernel release from Intel
> >> targeted Aero platform, but was not entirely ported upstream and has
> >> been omitted in mainline kernel releases. Consecutively, absence of
> >> regulator caused the SD Card interface not to be provided with Vqcc
> >> voltage source needed to operate with UHS-I cards.
> >>
> >> Following patches are addessing this issue and making sd card interface
> >> to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
> >> of the SD Card interface in consumers and exposes optional "vqmmc"
> >> voltage source, which mmc driver uses to switch signalling voltages
> >> between 1.8V and 3.3V.
> >>
> >> This set contains of 2 patches: one is implementing the regulator driver
> >> (based on a non upstreamed version from Intel Aero), and another patch
> >> registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
> >
> > Thank you.
> > Hans, Cc'ed, has quite interested in these kind of patches.
> > Am I right, Hans?
>
> Yes since I do a lot of work on Bay and Cherry Trail hw enablement I'm
> always interested in CHT specific patches.
>
> Overall this series looks good (from a high level view I did not
> do a detailed review) but I wonder if we really want to export all the
> regulators when we just need the vsdio one?

I thought about this point, and actually came to a personal conclusion
that if I do this as a new driver - then it is better to list all
possible regulators, creating some sort of "skeleton" which people
could then work on if need be. I do agree that at the present moment
the one regulator which is exposed is the one for vsdio, but listing
all possibilities should not hurt. This was my motivation to put them
all into the driver on the first place.

If you believe additional regulator elements should be removed from
this version of the driver - I can clean them up and come up with v2
here.

>
> Most regulators are controlled by either the P-Unit inside the CHT SoC
> or through ACPI OpRegion accesses.  Luckily the regulator subsys does not
> expose a sysfs interface for users to directly poke regulators, but this will
> still make it somewhat easier for users to poke regulators which they should
> leave alone.

Agree, this is a valid point. But honestly I would really be surprised
if a user would directly touch something which can burn his silicon to
pieces. Regulators are usually not approached by users; unless they
are really HW engineers and know what they are doing.

>
> Note I'm not saying this is wrong, having support for all regulators in place
> in case we need it in the future is also kinda nice. OTOH if we just need the
> one now, maybe we should just support the one for now ?

This I've already covered above I guess.

> Andrey, may I ask which device you are testing this on?

Sure, I use the original Intel Aero board. It used to have an official
image from Aero team with a heavily patched 4.4.y kernel, but when I
decided to have this updated to the latest stable branch - I've faced
the issue of missing core functionality, which led me to this patch.

>
> Anyways overall good work, thank you for doing this!

You're welcome, and thanks for looking into this!

>
> Regards,
>
> Hans
>

-- 
Regards,
Andrey.
