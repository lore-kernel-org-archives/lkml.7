Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346B92075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfCKO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:56:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38984 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfCKO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:56:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so1697005qte.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6WUodKr6yAywA/HHVdmRHarMgILwJ8qtk0xnCBTaQc=;
        b=WbreCW/DdPQbuzxd+j4IgpPk4B2RPSnohpG6ceTUV3Rw6lnk/gBFfPmuNzE85b4KKc
         73pmF32l1hF+jlkbRODLGAau06q3j2x/IJHCq6+ss2LzMKTowcno7F1NgglEq3CI+mYT
         tAtYTx8DbCGW5IRY1nLQA7ncP9HD3HIEATdew1K/7wrfgZ9jc7JaU/8WYKxVtdqCv2CM
         pU1G+dys5H3wcWHUZZKjYI5ARSpgq6zOkEd7QY+3RQpvHGW7mot0nvUBXeBWk2pUuQAO
         KxF/tiqU3+JpCvgfB33qYCTa6WF2LeEan/nhFiRIRubmOCQHgf4V75VhWQtGEhfhFBEF
         qcUA==
X-Gm-Message-State: APjAAAUlr2LykcPxpwB5Kb0d2r4ciEjJBB97OwZzbZwcTi3vXuc8eQI7
        lUAl+T5baM8rb+ZEabr+7oeIhHFkk0zACOTs/8EK3Q==
X-Google-Smtp-Source: APXvYqzLNCQzgTMPjeo2/4640ScxGsLNtI0VYZrrW92+xN1xPY1QY2pYUDcvQTb3yWzPjZrSaq5SWBupYq6+hyZwFpo=
X-Received: by 2002:ac8:2527:: with SMTP id 36mr11186029qtm.308.1552316184343;
 Mon, 11 Mar 2019 07:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190226234853.20441-1-louis@kragniz.eu> <20190227110720.27329-1-louis@kragniz.eu>
 <CAKwvOd=RZ7E3MRo4dB6KEi5aw92kjZ63ij0jL4XJ0nKzDwcm=g@mail.gmail.com>
In-Reply-To: <CAKwvOd=RZ7E3MRo4dB6KEi5aw92kjZ63ij0jL4XJ0nKzDwcm=g@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 11 Mar 2019 15:56:13 +0100
Message-ID: <CAO-hwJKD_Oy9_znmNL2s_652YuS59O4O9_2Qk=HZZ58XcT75cg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: quirks: use correct format chars in dbg_hid
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Louis Taylor <louis@kragniz.eu>, Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 8:43 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Feb 27, 2019 at 3:08 AM Louis Taylor <louis@kragniz.eu> wrote:
> >
> > When building with -Wformat, clang warns:
> >
> > drivers/hid/hid-quirks.c:1075:27: warning: format specifies type
> > 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> > [-Wformat]
> >                   bl_entry->driver_data, bl_entry->vendor,
> >                                          ^~~~~~~~~~~~~~~~
> > ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
> >           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
> >                                    ~~~~~~              ^~~
> > drivers/hid/hid-quirks.c:1076:4: warning: format specifies type
> > 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> > [-Wformat]
> >                   bl_entry->product);
> >                   ^~~~~~~~~~~~~~~~~
> > ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
> >           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
> >                                    ~~~~~~              ^~~
> > drivers/hid/hid-quirks.c:1242:12: warning: format specifies type
> > 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> > [-Wformat]
> >                   quirks, hdev->vendor, hdev->product);
> >                           ^~~~~~~~~~~~
> > ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
> >           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
> >                                    ~~~~~~              ^~~
> > drivers/hid/hid-quirks.c:1242:26: warning: format specifies type
> > 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> > [-Wformat]
> >                   quirks, hdev->vendor, hdev->product);
> >                                         ^~~~~~~~~~~~~
> > ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
> >           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
> >                                    ~~~~~~              ^~~
> > 4 warnings generated.
> >
> > This patch fixes the format strings to use the correct format type for unsigned
> > ints.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > Signed-off-by: Louis Taylor <louis@kragniz.eu>
>
> Thanks for following up on the feedback.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to for-5.1/upstream-fixes

Cheers,
Benjamin

>
> > ---
> >
> > v2: change format string to use %04x instead of %x
> >
> >  drivers/hid/hid-quirks.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > index 94088c0ed68a..b608a57b7908 100644
> > --- a/drivers/hid/hid-quirks.c
> > +++ b/drivers/hid/hid-quirks.c
> > @@ -1071,7 +1071,7 @@ static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
> >         }
> >
> >         if (bl_entry != NULL)
> > -               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
> > +               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%04x:0x%04x\n",
> >                         bl_entry->driver_data, bl_entry->vendor,
> >                         bl_entry->product);
> >
> > @@ -1238,7 +1238,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
> >                 quirks |= bl_entry->driver_data;
> >
> >         if (quirks)
> > -               dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
> > +               dbg_hid("Found squirk 0x%lx for HID device 0x%04x:0x%04x\n",
> >                         quirks, hdev->vendor, hdev->product);
> >         return quirks;
> >  }
> > --
> > 2.20.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
