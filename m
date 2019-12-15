Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D11DC2D0CA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A70C206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aaN0huOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfLOQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:34:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39136 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfLOQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:34:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so4272978pfx.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ghT5Kc9OBgiGOqjlQfLZvwFJmWLdIUaugH1WNia88Pg=;
        b=aaN0huOTqTAcMz2Z7rDunI9m2I0+1zBw8WlRPQ4oAztbBV51n15fDrnHoDDf9qmFWy
         x3lM5Y17kCSR0YAokyyHZUzduAle1cqL375xDr6kcF8ddLuFN6jjI1R1G/lrlMvg3ceb
         Lu3f58QI+iYA8Bm3Gixlt9pG5/6KAQfOu0m6s2RZf8VuHuqrAb629dXu7D1uuw6ZvdtN
         eaAIeL0c2gU1azxZiHWfD06/4b5ZOgh/HDftzzMhMuWz6UZRd4OJWzzOgSYXhKKArtf8
         3KTEbf9aVdTC1oviHSODmqBAbnHXd8MF1z2xrkJN04WsMIEUAfjVSW3uPALOqDzIVlSD
         ANrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ghT5Kc9OBgiGOqjlQfLZvwFJmWLdIUaugH1WNia88Pg=;
        b=cOasnLPRRqnmD/MvPzZIJPrUe++Ald9MdlBjWQsV625AyiZVhXtEHVOneh1d+xFUl/
         lRgTEC7PKc8ihdGatwfuJK2OPLRM8O4ZDlyA0mL6QYWsl1jGfhlC5PoxxMaxqThX40YL
         qbL6Gyl/v2Gfyp0NMSt/IQ2+pjQPbnfCJ9hWOXn3yGJWwTq0vXG82bwIBxaeCobEngPE
         vgXyUbP/e94LcNcDRxjgaaC1vbYICvrBUNKnodSZ9lQsZP1HMZhbvYHyPOmMHSPXYX/9
         81Y+ohGXKYDyq8u3QAZyxy2CVQ3RLT+GDqMWmwKvlYqa0vfa34Bb8o9QrX9oV10cPHEu
         hydQ==
X-Gm-Message-State: APjAAAXY0zKzHrlA3+/t+OgGO7jkywz2kv7lQ4x5gdhGNRLGXtXNUPR7
        2LymZvSbTFoWYFYvn43vB6/nTQ==
X-Google-Smtp-Source: APXvYqxaeqjmzDCYUp2kbqW3li8Zq9eq9xVaQ/aWJQ7p70BQNpwES4jXFX1ZCsVQ6EvdVK5NNaFtBQ==
X-Received: by 2002:aa7:9355:: with SMTP id 21mr11723007pfn.61.1576427667041;
        Sun, 15 Dec 2019 08:34:27 -0800 (PST)
Received: from localhost ([66.167.121.235])
        by smtp.gmail.com with ESMTPSA id p16sm18304339pgi.50.2019.12.15.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 08:34:26 -0800 (PST)
Date:   Sun, 15 Dec 2019 08:34:22 -0800
From:   Sandeep Patil <sspatil@android.com>
To:     Wei Wang <wvw@google.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rui.zhang@intel.com,
        edubezval@gmail.com, amit.kucheria@verdurent.com,
        rjw@rjwysocki.net, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
Message-ID: <20191215163422.GC9148@google.com>
References: <20191205071953.121511-1-wvw@google.com>
 <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
 <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
 <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org>
 <20191211085400.GB500800@kroah.com>
 <CAGXk5yrFp1eeeadhJar_qJqJ9G1q2mn+5m8JW4705ouQDLqzsw@mail.gmail.com>
 <f0ebc98d-25f2-6326-c0d8-8dda543c4091@linaro.org>
 <CAGXk5yosq5saYWdsz2k+uCYZ5CNTR4zNR2nB3H7-=TQs07u8Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXk5yosq5saYWdsz2k+uCYZ5CNTR4zNR2nB3H7-=TQs07u8Sw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

(resending because I accidentally replied only to you. Also adding everyone
else back in the thread, not sure what happened before).

On Wed, Dec 11, 2019 at 02:19:03PM -0800, Wei Wang wrote:
> On Wed, Dec 11, 2019 at 1:11 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 11/12/2019 21:11, Wei Wang wrote:
> > > On Wed, Dec 11, 2019 at 12:54 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> On Tue, Dec 10, 2019 at 09:54:11PM +0100, Daniel Lezcano wrote:
> > >>> On 10/12/2019 21:01, Wei Wang wrote:
> > >>>> On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
> > >>>> <daniel.lezcano@linaro.org> wrote:
> > >>>>>
> > >>>>> On 05/12/2019 08:19, Wei Wang wrote:
> > >>>>>> The paths thermal_zone%d and cooling_device%d are not intuitive and the
> > >>>>>> numbers are subject to change due to device tree change. This usually
> > >>>>>> leads to tree traversal in userspace code.
> > >>
> > >> tree traversal is supposed to be done in userspace code :)
> > >>
> > > Yes, that can be done in userspace, but given the amount of thermal
> > > zones we have in some mobile devices, this will bring a lot of
> > > convenience.
> >
> > But usually all these thermal zones are fixed and building the name<->tz
> > association is just a question of a few lines of code from userspace,
> > no? What would be the benefit of adding more ABI?
> 
> 
> code reuse as tz mapping is per device tree setup and we try to use
> the same _type_  in thermal zone in shared client code for Android
> thermal API.

CMIIW, but the tz mapping today can still be done by parsing through the
directory the other way? (i.e. tz->type) instead of type->tz?

Also, I understand the resistance to add a new ABI since it will have to be
kept around forever. What would be worth knowing is if these mappings are
static (built once) or you have to go through and parse the directories every
time? AFAIU, the parsing (map creation) seems to only happen once during
boot, so we (Android) should be ok?

> 
> >
> > If there is a thermal zone change, then a notification can be used, so
> > the userspace code rebuild the name<->tz, no?
> 
> 
> Assuming you meant for type<->tz, this mapping won't change in runtime
> in our case (not unloading things), but it could be changed due to
> device tree change, e.g. adding/removing thermal zones.

I actually think we might need this after all. This assumes all tz devices
are registered when userspace (thermal hal/daemon) is coming up. However,
that may soon not be the case and we have to adjust for devices being added
in parallel with userspace?

So, may be we need to start monitoring uevents like we do for power supplies
too? In that case, the mapping can also be done dynamically.

Lastly, I think we can make a case further if there are benefits we can share
here other than convenience. Like startup time, handing hardware variations
etc? (Also point to the current userspace code that uses this)

- ssp
> 
> 
> >
> > > e.g. this is on Pixel 4 XL:
> > > coral:/ # ls  /sys/devices/virtual/thermal/
> > > cdev-by-name      cooling_device15  cooling_device22  cooling_device3
> > >  cooling_device9  thermal_zone15  thermal_zone22  thermal_zone3
> > > thermal_zone37  thermal_zone44  thermal_zone51  thermal_zone59
> > > thermal_zone66  thermal_zone73  thermal_zone80  thermal_zone88
> > > cooling_device0   cooling_device16  cooling_device23  cooling_device30
> > >  thermal_zone0    thermal_zone16  thermal_zone23  thermal_zone30
> > > thermal_zone38  thermal_zone45  thermal_zone52  thermal_zone6
> > > thermal_zone67  thermal_zone74  thermal_zone81  thermal_zone9
> > > cooling_device1   cooling_device17  cooling_device24  cooling_device31
> > >  thermal_zone1    thermal_zone17  thermal_zone24  thermal_zone31
> > > thermal_zone39  thermal_zone46  thermal_zone53  thermal_zone60
> > > thermal_zone68  thermal_zone75  thermal_zone82  tz-by-name
> > > cooling_device10  cooling_device18  cooling_device25  cooling_device4
> > >  thermal_zone10   thermal_zone18  thermal_zone25  thermal_zone32
> > > thermal_zone4   thermal_zone47  thermal_zone54  thermal_zone61
> > > thermal_zone69  thermal_zone76  thermal_zone83
> > > cooling_device11  cooling_device19  cooling_device26  cooling_device5
> > >  thermal_zone11   thermal_zone19  thermal_zone26  thermal_zone33
> > > thermal_zone40  thermal_zone48  thermal_zone55  thermal_zone62
> > > thermal_zone7   thermal_zone77  thermal_zone84
> > > cooling_device12  cooling_device2   cooling_device27  cooling_device6
> > >  thermal_zone12   thermal_zone2   thermal_zone27  thermal_zone34
> > > thermal_zone41  thermal_zone49  thermal_zone56  thermal_zone63
> > > thermal_zone70  thermal_zone78  thermal_zone85
> > > cooling_device13  cooling_device20  cooling_device28  cooling_device7
> > >  thermal_zone13   thermal_zone20  thermal_zone28  thermal_zone35
> > > thermal_zone42  thermal_zone5   thermal_zone57  thermal_zone64
> > > thermal_zone71  thermal_zone79  thermal_zone86
> > > cooling_device14  cooling_device21  cooling_device29  cooling_device8
> > >  thermal_zone14   thermal_zone21  thermal_zone29  thermal_zone36
> > > thermal_zone43  thermal_zone50  thermal_zone58  thermal_zone65
> > > thermal_zone72  thermal_zone8   thermal_zone87
> > >
> > >
> > >> But what userspace code needs to do this, and for what?
> > > In Android, thermal daemon and thermal HAL as well as some init.rc
> > > script would use those thermal paths for managing and monitoring
> > > thermal. The daemon/HAL could have logic pipled in, however Android's
> > > init.rc script would be really tricky.
> > > On a related note, we also create /dev/block/by-name links from userspace.
> > >
> > > Thanks!
> > > -Wei
> > >>
> > >> thanks,
> > >>
> > >> greg k-h
> >
> >
> > --
> >  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> >
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
> >
