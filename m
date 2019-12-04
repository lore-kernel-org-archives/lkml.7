Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E303FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B627420803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsIH14Jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLDCqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:46:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45359 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfLDCq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:46:29 -0500
Received: by mail-vs1-f68.google.com with SMTP id l24so3831856vsr.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 18:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3wMFu3Sx6jNYWZOgVEUTy/sJPhopP8NznnJcty0XhM=;
        b=jsIH14JjlrtI8ht350vH52bflG2S2FHRZBZJI9A8D//3qk8tqfA8AIydUDsKOF3fLY
         BqAscMoNF4c68OhY3bothYOoJULvfLkhIJMK60MzloWQ7thO+bmCPczLfk9OMdSteZDo
         mIAREnmdFJnSQCi+QzR+wXYvDE2iKw80x7qgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3wMFu3Sx6jNYWZOgVEUTy/sJPhopP8NznnJcty0XhM=;
        b=aorAaTq07kYBPbcrGWXXJO6HBQx+NjUYgqYgnAa5ZEyo5x9hAlqr6OsivKv/oYbi63
         ZTDRpWGCwMQDxs7Y01ozZASEH+vVioY3NITaVC8NM/3aS0YtknuqiYr+DW/LQa/YZkcJ
         8dpGfpm//qE/AQ/e/8xFhKFxLuLOq/YIKq1ywe4GU4UZKSiS7ToxrtTtn6wUVteyhRt5
         /yg6KXBV4PVxicTWI5lX4sdVQ/RQcV9+FaUJlQA1KpzxNEcKTyUVeDr3gMmDnh5D6au6
         k9fpImsmrm7GCD6TWXY6OTuHOdIz1tIb9FD+yOK52N0221D9DQVcP40f/+5VpbiekUPq
         0Oag==
X-Gm-Message-State: APjAAAUXYKGcXEmpTdmlMUU7REIm7OSccmNUEFAwbq9GHjX9BBxs/4tW
        ezd9szt2YPaoaaHKDturNqBUOM+vR7AGpxPgeHPrDg==
X-Google-Smtp-Source: APXvYqy1k9//y3Rxh91esKEW+jVlIMAM5hP9Npol/qbhbr0gv9E8PmMzJfgwVhuMAJQkagIdwF7beSYxqBbwYgdWjHM=
X-Received: by 2002:a67:f541:: with SMTP id z1mr310501vsn.70.1575427588564;
 Tue, 03 Dec 2019 18:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20191203101521.198914-1-ikjn@chromium.org> <20191203164010.GG10631@localhost>
In-Reply-To: <20191203164010.GG10631@localhost>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 4 Dec 2019 10:46:17 +0800
Message-ID: <CAATdQgBRSJVjpCawa3eZXHLex-gWqdJrmQ6xriu11ok49UmNwg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] usb: override hub device bInterval with device
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 12:40 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Dec 03, 2019 at 06:15:21PM +0800, Ikjoon Jang wrote:
> > This patchset enables hard wired hub device to use different bInterval
> > from its descriptor when the hub has a combined device node.
> >
> > When we know reducing autosuspend delay for built-in HIDs is better for
> > power saving, we can reduce it to the optimal value. But if a parent hub
> > has a long bInterval, mouse lags a lot from more frequent autosuspend.
> > So this enables overriding bInterval for a hard wired hub device only
> > when we know that reduces the power consumption.
> >
> > Changes in v4
> > - use of_property_read_u32() instead of of_property_read_u8()
>
> What changed in the previous versions?

changes in the previous versions:
v4: use of_property_read_u32() instead of of_property_read_u8()
v3: errata fixed "hub, interval" --> "hub,interval"
v2: do not use unlikely() macro, commit message

>
> Johan
