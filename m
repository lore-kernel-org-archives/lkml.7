Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3317AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A21A206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVX53tvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKNPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:11:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44747 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfKNPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:11:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so4419516pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roRKIOX40b6Q/3+a+NshMVYzTrBfNeebY8L+kjytXRs=;
        b=kVX53tvflJrZ7i67dieAEPqJqgEgquhZFRAnVlI2YJDx22zztmIu11TLh4NDNAFN+T
         CX2YMO3wEPmmGACgjIYO7Xy0Ky3FlajlIbzeAr+2yadmJKDMhAyXwQXfkf2czRxnIchB
         zIRqC3mXkttBVprXoxuF3wc4pxgrHCB9YFiLkEOyNb5uONi/4ghGFaWSYip7g3fS0OiA
         QZYsqd8CHe50zJ9urtLSHndShhunx6Enr4KdX3E3ThBnXOD4SCrBwkWhONnRqZBDYHUt
         6XRB3xhz5g/NPTOsOWJf+7E0aodZKkybEyE09+8ASgfLlm7I3bD/SrZOerG8F+K5W9d3
         v9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roRKIOX40b6Q/3+a+NshMVYzTrBfNeebY8L+kjytXRs=;
        b=FC+WhLzVfz8OGmp8HQpGNbQ5Ddu0a5tyVOYSySN+kJXHB9+F087kPA1SowYffLi+OW
         FvRwg7wzuolNuA2CPVbXbw7RoKFZeN5lVATuwE9lqY7IQ2pku6GhrNgNICFlNahqu3vb
         xzrxfAk/K6cKiH4/2U0VIPj9o9O5nFXRKvEdjBgpnn9BFqfrZTBbUF7lvJmdqmdo9uQt
         eFZyaNr+x090uzUa/IGso5bNLprZryCfLvTisJjZZ7chFj1i343iEycFKWyJIGjGRB7D
         JfyD1R+kv3tfMPqL0ZTSJOturifCdghSWc+nQbUDL7Pz5CN6JRMnRdxa3lLUpjKbYIjw
         d3KQ==
X-Gm-Message-State: APjAAAV3jwYmjdE+E/pxT5fvNy+ZuoU2OxO/GEZz81zWl8xeiXoQIClw
        xtfcISzeuLkWyKhWTllU3ruWmUcdSX3J6bhS9VvlRw==
X-Google-Smtp-Source: APXvYqy8RhVcoQfGMi3SQ2aWlAr/b6M45vVTAnMILXZxwSYzz3/3mUs/jgcrwBgYeRwMyc8Ky+UoPtCMANbq/bcfyys=
X-Received: by 2002:a63:541e:: with SMTP id i30mr10665060pgb.130.1573744260540;
 Thu, 14 Nov 2019 07:11:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573236684.git.andreyknvl@google.com> <Pine.LNX.4.44L0.1911081642461.1498-100000@iolanthe.rowland.org>
 <CAAeHK+zyvqJs_5X61NriLdHoityTdVJ0O=a-xrcq+-7Vb_F0FQ@mail.gmail.com>
In-Reply-To: <CAAeHK+zyvqJs_5X61NriLdHoityTdVJ0O=a-xrcq+-7Vb_F0FQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Nov 2019 16:10:49 +0100
Message-ID: <CAAeHK+zPh1zkALKNgnJb0_rGWYfTJGU2H+fsbe5XkSD9HLWumA@mail.gmail.com>
Subject: Re: [PATCH 0/1] usb: gadget: add raw-gadget interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 11:18 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Fri, Nov 8, 2019 at 10:45 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, 8 Nov 2019, Andrey Konovalov wrote:
> >
> > > This patchset (currently a single patch) adds a new userspace interface
> > > for the USB Gadget subsystem called USB Raw Gadget (I don't mind changing
> > > the name to something else if there are better ideas). This is what
> > > currently being used to enable coverage-buided USB fuzzing with syzkaller:
> > >
> > > https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md
> > >
> > > Initially I was using GadgetFS (together with the Dummy HCD/UDC module)
> > > to perform emulation of USB devices for fuzzing, but later switched to a
> > > custom written interface. The incentive to implement a different interface
> > > was to provide a somewhat raw and direct access to the USB Gadget layer
> > > for the userspace, where every USB request is passed to the userspace to
> > > get a response. See documentation for the list of differences between
> > > Raw Gadget and GadgetFS.
> > >
> > > This patchset has been pushed to the public Linux kernel Gerrit instance:
> > >
> > > https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2144
> > >
> > > Andrey Konovalov (1):
> > >   usb: gadget: add raw-gadget interface
> > >
> > >  Documentation/usb/index.rst         |    1 +
> > >  Documentation/usb/raw-gadget.rst    |   60 ++
> > >  drivers/usb/gadget/Kconfig          |    9 +
> > >  drivers/usb/gadget/Makefile         |    2 +
> > >  drivers/usb/gadget/raw.c            | 1150 +++++++++++++++++++++++++++
> >
> > As a general rule, gadget drivers don't go directly in
> > drivers/usb/gadget.  raw.c counts as a legacy driver (because it's not
> > written to use the composite gadget framework), so it belongs in
> > drivers/usb/gadget/legacy.  That's where the gadgetfs driver lives, for
> > example.
>
> Hi Alan! Sure, I'll move it to legacy/ in v2. Thanks!

Hi Alan,

Should I move CONFIG_USB_RAW_GADGET into legacy/Kconfig as well? AFAIU
this makes it impossible to turn on e.g. both GadgetFS and Raw Gadget
at the same time, since they both become options of the same choice.

Thanks!
