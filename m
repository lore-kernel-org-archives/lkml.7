Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB60BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86A020833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Culiuvlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDIE4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:56:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37100 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfDIE4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 00:56:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so8577714pgc.4;
        Mon, 08 Apr 2019 21:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fSbzNkjsSwkHQttu+TEGQLmXcM0+AN4d0v8/VJDirT0=;
        b=Culiuvlbppghdx3mpcnmXq4pzQXD5BxfSCgJKFEUMLy2pfANurqs3aMveGuAU+//Sd
         C+HkR2TId1a65C+Bo6ktfpH6qtezABxMeWdi3IU4yxdHOMX7CRbwtNVqVQtGFydqlqY7
         J4tA52veE1Z4EaI+8fPOA13dAMVMWacUydP6vlOr0ZFcaDJgDFjZQYFNCevaLZ6D62A/
         tA3Ifbn7eRJHLljSTd4MnV015V0Y+o5bLCLfTqzo4ObooBELVzIPxaTivrRIsWe3PSQu
         29mm7qT0SQn+xhx4bh4fKQ48FF7Z9PTbrFcfy9kHalvV2kkQOxpVOSB1se0uqwyjeovy
         lNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fSbzNkjsSwkHQttu+TEGQLmXcM0+AN4d0v8/VJDirT0=;
        b=uci5mu2fvUufliuqobiWXh3FpXXPGRlwMl5aTikXqQY8Lem9erOFWd35UdNozcNkxl
         Fa1VUAr6DPt9znLTUZ9t76aCO2qehwRtJsbEOY6aPKH8vt5N0+bWZakw+6oCGo0GiQST
         d3Ki79jJFbmdGOdhrNJLNLV2rbLx24Vrc3A0YsL98+SKjw3+RHjH1RoKdJGn/EjL/BiC
         Mv5b/CCosO0dTQ0+KRe9YAEw0fRXCGiDjhazeCrFhiutdZqVqrbU+dBwJn5qrYvLmswm
         JOTAWj7GKhp00LUHFgK7Kgjxav6mUO5c0e+kdvQVT/BjpL2M9yojmuuws7xl1xa0xWOx
         xJmg==
X-Gm-Message-State: APjAAAU2lmA/PIMst0FZWAfliPCKPd76dCtzw7M3l6fs4rBDRRjASBtJ
        o5zWezuKDm2jmoEWTXo2UbI=
X-Google-Smtp-Source: APXvYqzVtYQ7/TWepFOzztOXYsTBLeJbErgA6c9WPKnHOmXfWudaRv0t8mDaEzmknLvq8tWARXeHxg==
X-Received: by 2002:a63:195e:: with SMTP id 30mr32256554pgz.312.1554785800471;
        Mon, 08 Apr 2019 21:56:40 -0700 (PDT)
Received: from icarus ([2001:268:c1c0:11e:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id c189sm48847177pfg.24.2019.04.08.21.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 21:56:39 -0700 (PDT)
Date:   Tue, 9 Apr 2019 13:57:28 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org,
        david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 01/18] counter: Introduce the Generic Counter
 interface
Message-ID: <20190409045728.GA2842@icarus>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
 <20190408215515.GA27592@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190408215515.GA27592@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:55:15PM +0200, Pavel Machek wrote:
> Hi!
> 
> > +const char *const counter_count_direction_str[2] = {
> > +	[COUNTER_COUNT_DIRECTION_FORWARD] = "forward",
> > +	[COUNTER_COUNT_DIRECTION_BACKWARD] = "backward"
> > +};
> > +EXPORT_SYMBOL_GPL(counter_count_direction_str);
> > +
> > +const char *const counter_count_mode_str[4] = {
> > +	[COUNTER_COUNT_MODE_NORMAL] = "normal",
> > +	[COUNTER_COUNT_MODE_RANGE_LIMIT] = "range limit",
> > +	[COUNTER_COUNT_MODE_NON_RECYCLE] = "non-recycle",
> > +	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
> > +};
> > +EXPORT_SYMBOL_GPL(counter_count_mode_str);
> 
> Dunno. Exporting const tables saying "forward" and "backward". Can we
> ... somehow make it work without need to export this?
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Right now there are only have 4 counter devices supported in this
patchset, but it is expected that support for a greater variety of
devices will be added. For these future cases, new count directions will
be added to match their functionality.

For example, suppose support for a rotary encoder device is added. These
type of devices do not move forward/backward but rather rotate. In these
cases, the following count directions may be added:

    [COUNTER_COUNT_DIRECTION_CLOCKWISE] = "clockwise",
    [COUNTER_COUNT_DIRECTION_COUNTERCLOCKWISE] = "counterclockwise"

Or as another example, suppose support for a two-axis precision
positioning table is added. These devices support positioning in a
cartesian coordinate system. In these cases, spatial direction may serve
as useful count directions:

    [COUNTER_COUNT_DIRECTION_NORTH] = "north",
    [COUNTER_COUNT_DIRECTION_NORTHEAST] = "northeast",
    [COUNTER_COUNT_DIRECTION_EAST] = "east",
    [COUNTER_COUNT_DIRECTION_SOUTHEAST] = "southeast",
    [COUNTER_COUNT_DIRECTION_SOUTH] = "south",
    [COUNTER_COUNT_DIRECTION_SOUTHWEST] = "southwest",
    [COUNTER_COUNT_DIRECTION_WEST] = "west",
    [COUNTER_COUNT_DIRECTION_NORTHWEST] = "northwest"

A const table is conveinent in these scenarios because support for new
count directions may be easily added by simple entry into the table.

William Breathitt Gray
