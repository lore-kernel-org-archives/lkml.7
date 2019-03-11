Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1640EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D911C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIqdc4wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfCKRCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:02:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45093 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:02:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id t82so4225670oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TbVtP0Cj4bmw2Da24wUcfs6Q5Qke3mMiEDs+Miru/A=;
        b=fIqdc4wpO6StOLFT8oWU1XI7m5mw67XLkZVDuDPwHw0S2DD2mSb8MhdTVorY8XmJJ+
         WQUwszYhD1W+ihS6vDgpuNvEJdn4aPY7dDRdzGwGHLDdAlkzDWSQaOyUzUfFuIHam4EN
         V+RYcGvAyvH+7WqbFsdTD8XedCCWsfXiZlzq7ihL8ril1PUiW8yb4azifxmdiVoFJ3E/
         3+79ouQbd8q3+/0fghDWaKyl16pecJqjHYuu93Tcyop8FG1jpizFSgBQeDF7jbeTAenp
         JEA1jbWX6RMLRTgiq7nWoQF+kz8wqOmaPuRuN4gbflHIGy9W5c/5xQjKU+Yh7tHNuMKe
         gU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TbVtP0Cj4bmw2Da24wUcfs6Q5Qke3mMiEDs+Miru/A=;
        b=hX5oPsCPgEGQI4TB4ObwZgE+uUTJ+dnwTd+88qmGndDn+mo3CoRivz4+Ztvpxpvstx
         n0YVZufvzNNGxEohggvqGAlNiLf7CvKN9n5W5TXNycnxhVC17nDLmxEoazsT/MOYhAlN
         XDxUFksUtxThj52VDb/xve4AFZ0G5fy2obj+yfFX+rlSrI14uMtm6CHH/VjSqxmKuUH6
         NSJ1O18DdbRTKm1JU7XLX8RFJJvuf6CrPwQ15Ber0YanXXOoUZT309Sy2Ci1tadIy7ME
         93YAamdv3w96Ch1iwlRcKImFGqYdACUgRgA5yW8Mc4yPZBwJ9EV+xJJnc3Yvjz42sVIQ
         fYTg==
X-Gm-Message-State: APjAAAVvDLXHSrSAC2/jLk3mnLmmTGkiYJ580nZjRBSB4L017FAyKWVs
        nq8SnqFs6fJKN2IuamIjkV/zPDjSEnZwZlnUeIs=
X-Google-Smtp-Source: APXvYqyUJh5SwMWdRQjBfOgNTs3gt0ln9otGe2JA4zycV0jREnAjG8P4pCtKfnt4YWR2T/ntMd0kjU/yIteMt71lDDU=
X-Received: by 2002:aca:5d0a:: with SMTP id r10mr41143oib.92.1552323765878;
 Mon, 11 Mar 2019 10:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
 <20190208121916.GE23483@kroah.com> <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
 <20190208141400.GA22162@kroah.com>
In-Reply-To: <20190208141400.GA22162@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 11 Mar 2019 13:02:34 -0400
Message-ID: <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 9:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Well, who wants this code?  Who uses it?  Find those people and get them
> to review it.  If no one wants it or uses it, that kind of implies that
> it's not needed :)

We have customers who (will) talk to this ABI from userspace, but they are
not 'Linux-y' enough to come to the mailing list and meaningfully review
the userspace ABI.

IMHO the current reality of Fieldbus on Linux is companies rolling their own
proprietary out-of-tree interfaces and drivers. They do this partly because
there is no existing community or infrastructure. So there is no incentive
to be involved with mainline, which could also explain why no-one is commenting
on this Fieldbus ABI.

Chicken-and-egg problem ?

Greg, could I convince you to take this Fieldbus subsystem in drivers/staging?
Perhaps its presence may kickstart or seed a Linux Fieldbus community.
Being in staging/ also means that we can tweak the userspace ABI to our
heart's content if more people/requirements come in.

If there's been no meaningful activity in, say, one year from now, you may
decide to send this whole subsystem to /dev/null.

Sven
