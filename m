Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C24C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FC620818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="q5a6Wu2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfHFSv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:51:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38087 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:51:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id d17so95169935oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGCcLtK25GuveYiFjhwocqTOqxw5HIZH0JbQl66UTl8=;
        b=q5a6Wu2JffaVHSnXg3X5NgLo7sEfrMh4H/pE7ZTJenizHNyZziPaDY+sKY4OALTbdm
         wWeUsPsuiAD7aiR2FOdge5bw9vBJkZpbZK/ApWIjWB3eOGut9lYi7v626S/DWLkuG+Fr
         HsqzZuekniCMpYkDgy/V6P9lbnq9eSJXNuVH7/+d+SlnrhpWcjGn3c8gqHa1e6jPm2He
         44FW/xjQAlIzFwFgX6j548WyXfkKSDNpble5Vw2lfIJHPA2Lb5ZWUjBDWaxgMWCRMb6J
         H2FW8SGNPvor8jaYMjskiuEJCJSfaC57nPSIZVEgYfTfpuFwxmHWH3nSpAXN/go/VPiE
         D0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGCcLtK25GuveYiFjhwocqTOqxw5HIZH0JbQl66UTl8=;
        b=IvA7/LG2ibAydV36Xav91MWrynWB0Wh0ZDhJQxfeqpFIUSPtTOytITeF/gsu8mshFu
         fUeMwaugRF9XlYRaESKnceaa4MTcUaORGqzIGD0ray8lXEvZZnjm/yYkRv9QBToUXclV
         N+WIBa6aC5/LawR1Xsoay2Fv+s6cfjG69tPktgF1Eklt02UfuYFw6wYcxqoMBioQdowD
         t1N2TtphFXJaouf/wfOXH3ndValHWjxbmrJLRQ0X6FWYKSnlXeXkQl0bnz7XYsQr3RVs
         sNjCHSOWi8U0+0A641fhzEcCr0tyuUk5YZx8L0/vIwUMcpGdHPHT8zp75gFRffDTRutB
         EI3Q==
X-Gm-Message-State: APjAAAXrNEHY54vYBgdry+dHRP7t+QfOPPaRDAeQVuZ0vDgxXPabtBzf
        ehWCT6nyJTjs6mmUGzWLClWk2K5NAcaNPMow2IYzSQ==
X-Google-Smtp-Source: APXvYqwcmVP6EF7nHglBfXmejG+UyrqAm46scDpHmg5aEHLa6bLfwM+0QBmdRY1EL3pmwrUfpCyo9HYDXxOrdkSyK5s=
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr4622173otq.197.1565117516786;
 Tue, 06 Aug 2019 11:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-4-trong@android.com>
 <5d48bbc2.1c69fb81.62114.5473@mx.google.com>
In-Reply-To: <5d48bbc2.1c69fb81.62114.5473@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 6 Aug 2019 11:51:45 -0700
Message-ID: <CANA+-vBFY_mVfhhK=5BL5m_yyQ5+GTE9bv32fk-qsfnAmfE4nA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] PM / wakeup: Show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 4:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Tri Vo (2019-08-05 10:58:48)
> > diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
> > new file mode 100644
> > index 000000000000..3a4f55028e27
> > --- /dev/null
> > +++ b/drivers/base/power/wakeup_stats.c
> > @@ -0,0 +1,161 @@
> [...]
> > +/**
> > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > + * @ws: Wakeup source to be added in sysfs.
> > + */
> > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > +{
> > +       struct device *dev;
> > +
> > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > +                                       wakeup_source_groups, "wakeup%d",
> > +                                       ws->id);
> > +       if (IS_ERR(dev))
> > +               return PTR_ERR(dev);
> > +       ws->dev = dev;
> > +       pm_runtime_no_callbacks(ws->dev);
>
> Does this only avoid adding runtime PM attributes?
>
> I thought we would call device_set_pm_not_required() on the device here.
> Probably requiring a bit of copy/paste from device_create_with_groups()
> so that it can be set before the device is registered. Or another
> version of device_create_with_groups() that does everything besides call
> device_add().

Comments on pm_runtime_no_callbacks() say,
  "Set the power.no_callbacks flag, which tells the PM core that this
   device is power-managed through its parent and has no runtime PM
   callbacks of its own.  The runtime sysfs attributes will be removed."

Sound like it's appropriate to apply this function to the wakeup source.
