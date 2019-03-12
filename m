Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C802147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gOF+bdT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfCLGuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:50:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44071 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLGuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:50:25 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so1097817iop.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WC9+mDI1ODU2VKEap8VCwgS/zqok4qLIPW+QbCW60bg=;
        b=gOF+bdT/m6LUqmvLzKXjo/jEYG0rKE6qDC3pdyRA3FhhRbL6AMV9VxxXEBWblfJdYa
         o68VkG/7Hr+vziPbaz9FiZLqn9dl2C0cA+pFxzaRCNg57EoAL298rT5GfLMk14MB5FF7
         kwlvJ5ydaohh0DWxXzVP67E23RZzeYARYiS4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WC9+mDI1ODU2VKEap8VCwgS/zqok4qLIPW+QbCW60bg=;
        b=jiEkuLxamLFWTuKJSwj01Xoi3PQiDHu29Trf1L9vbV/rsTSq387UAXBTTJqpAYgClY
         Y7rFs20wVAgbMYH72dCNJasZWRjCXzDr6wAo2q1PvCPnq1OJwJFRqlZJrcA3pDcPaUAW
         Bzd2+zL3M28ZPeEUA+0AbShMptQUIx83oOS8xpZvAEL4TQ0ntPiFHXaZa6VwgGzjQVow
         g3LjHlcfGJEs07INdWfHk+SgkNR8s/N+Vzfif7jr3ukpNvB+vH4DBPvU7dYKHGk6TfD5
         0GGG+rjTeGBKRy7Dupb2J9YQWJUIqCCBQq2tnl5Q1Na9rwdbGt3S8QKE9gbUwbWkUth5
         9eMw==
X-Gm-Message-State: APjAAAW2JH/7QEG20X85MhbsIUVUj7KDswO2+8pr3h60dlWF7uEM4YRG
        VyguK7SOWEYaQbGg/g3UJD9dAkSum1z5tC0tpBXW/g==
X-Google-Smtp-Source: APXvYqyn/IXkJXobFdFPCVrEe/OCMmfP5AJK1o1PsfL3qRSGA9BGMiv1rd68C1/oY9WNJtxbqCy77jiPG2hzap/zkA0=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr4248690iom.118.1552373424317;
 Mon, 11 Mar 2019 23:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190228002725.57444-1-gwendal@chromium.org> <CAFqH_52tWw8pGwY5fdAPQ6npbfWA7o4OhtPxvbUbCh5TdnbSew@mail.gmail.com>
 <CABXOdTfqPKq34OVDmJ9qjTr0nqarhpN=f37m3xH9iuHxex+xrw@mail.gmail.com>
 <CAFqH_50ZQtbOqG+u9VLT8m=9jvv_XQsghUTCuySu-=vho6rLKw@mail.gmail.com>
 <CABXOdTf3kt9EnyBB=8BjpiOOJ3=OaVodqKxTJkZC6=sTqry2jg@mail.gmail.com> <CAFqH_53uYy0oTTYSJkkgM+Sz+uJYpJ3pAq0LtRjCKaZF0FS0gg@mail.gmail.com>
In-Reply-To: <CAFqH_53uYy0oTTYSJkkgM+Sz+uJYpJ3pAq0LtRjCKaZF0FS0gg@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 11 Mar 2019 23:50:12 -0700
Message-ID: <CAPUE2usTh3Th8FySCUsbgp_WGEL2k94pxDfwp4GT1uUkksok8w@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros: Update EC protocol to match current EC code
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding: """While we are here I'd suggest if we can also fix the few
errors (3)
and warnings (5) spotted by checkpatch. With that it's an ack from my
side."""
These errors and  warning are for code that is not used by the kernel:
WARNING: __aligned(size) is preferred over __attribute__((aligned(size)))
#373: FILE: include/linux/mfd/cros_ec_commands.h:415:
+#define __aligned(x) __attribute__((aligned(x)))
Applies only when __aligned is not defined


ERROR: Macros with complex values should be enclosed in parentheses
#410: FILE: include/linux/mfd/cros_ec_commands.h:452:
+#define __ec_align2 __packed __aligned(2)
and
ERROR: Macros with complex values should be enclosed in parentheses
#411: FILE: include/linux/mfd/cros_ec_commands.h:453:
+#define __ec_align4 __packed __aligned(4)
and
ERROR: Macros with complex values should be enclosed in parentheses
#428: FILE: include/linux/mfd/cros_ec_commands.h:470:
+#define __ec_align_offset2 __packed __aligned(2)
are only defined when CONFIG_HOSTCMD_ALIGNED is defined, it is only
used by the EC.

Using u8 through the EC codebase is a big change, as it will make
merging patches from one EC branch to another painful.

I will post a new version that use BIT() - and yet more defines - shortly.

Gwendal.

On Thu, Mar 7, 2019 at 6:49 AM Enric Balletbo Serra <eballetbo@gmail.com> w=
rote:
>
> Hi Lee,
> Missatge de Guenter Roeck <groeck@google.com> del dia dc., 6 de mar=C3=A7
> 2019 a les 19:58:
> >
> > On Wed, Mar 6, 2019 at 10:27 AM Enric Balletbo Serra
> > <eballetbo@gmail.com> wrote:
> > >
> > > Hi Guenter,
> > >
> > > Missatge de Guenter Roeck <groeck@google.com> del dia dc., 6 de mar=
=C3=A7
> > > 2019 a les 18:20:
> > > >
> > > > [resending in plain text mode ]
> > > >
> > > > On Wed, Mar 6, 2019 at 8:57 AM Enric Balletbo Serra <eballetbo@gmai=
l.com> wrote:
> > > > >
> > > > > Hi Gwendal,
> > > > >
> > > > > Many thanks to send this upstream.
> > > > >
> > > > > Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dj., 2=
8 de
> > > > > febr. 2019 a les 1:31:
> > > > > >
> > > > > > Chromebook Embedded Controller protocol is defined in the kerne=
l at
> > > > > > cros_ec_commands.h.
> > > > > > The source of trust for the EC protocol is at
> > > > > > https://chromium.googlesource.com/chromiumos/platform/ec/+/mast=
er/include/ec_commands.h
> > > > > >
> > > > > > Only needed changes have been picked up from this file to the k=
ernel
> > > > > > include file leading to gaps between the upstream version and w=
hat the
> > > > > > latest ECs can do.
> > > > > >
> > > > > > Fill the gaps to ease future integrations. Changes from the ori=
ginal
> > > > > > files is header/footer for license and include files for alignm=
ent.
> > > > > >
> > > > > > Check this include file works on ChomeOS kernel 4.14 and 4.19 o=
n eve.
> > > > > >
> > > > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > ---
> > > > > >  include/linux/mfd/cros_ec_commands.h | 3627 ++++++++++++++++++=
+++-----
> > > > >
>
> Just for if I was not clear after the discussion this is an ack from my s=
ide
>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> > > > > I'm wondering if we should move this file to include/uapi at some
> > > > > point as this file is also used as user-space API for some usersp=
ace
> > > > > applications.
> > > > >
> > > > > While we are here I'd suggest if we can also fix the few errors (=
3)
> > > > > and warnings (5) spotted by checkpatch. With that it's an ack fro=
m my
> > > > > side.
> > > > >
> > > > > Being strict, though, on most cases the variables are going to be=
 used
> > > > > in code that can be seen by user-space programs so maybe we shoul=
d
> > > > > really need to switch to __u8/__u16/etc exportable data types ins=
tead
> > > > > of the uint8_t/uint16_t/etc types (those are not aimed to be used
> > > > > within the kernel). For those types that are internal we should u=
se
> > > > > in-kernel type (u8/u16/etc)
> > > > >
> > > > > There is also the use of the BIT macro instead of the (1 << x), I=
 know
> > > > > that this is a maintainer preference.
> > > > >
> > > > Is all that even possible ?
> > >
> > > Sorry, if I wasn't clear from my side, I should have marked those as
> > > nit, as in this case, I don't really mind, but I remember Lee
> > > requesting some of those changes for this file.
> > >
> > > What I want to avoid is the desynchronization again. As this file
> > > belongs to the MFD subsystem Lee needs to be happy with it or at leas=
t
> > > know that we're not following the kernel style because is an imported
> > > file (i.e not using the BIT macro, doing this example because I know
> > > he takes care of this).
> > >
> > > So I think that the main question here is if an imported file like
> > > this is acceptable in the include/linux/mfd?
> > >
> >
> > I find it highly (and more and more) confusing about what is
> > acceptable in the kernel and where, and what isn't. There are imported
> > files all over the place, and they seem to be widely acceptable and
> > accepted. It is difficult to keep track of what is acceptable and what
> > isn't on a per subsystem basis. I'll step back and keep my confusion
> > to myself.
> >
>
> In theory, I should be cc'ied if someone sends a modification to this
> file, also Guenter and Benson. So we can take care that is synced with
> the EC code and doesn't diverge again. I think that this is the main
> purpose.
>
> Thanks,
>  Enric
>
> > > > After all, this is an imported file, and
> > > > we don't usually expect that imported files meet the Linux kernel
> > > > coding style.
> > > >
> > >
> > > I remember seeing somewhere that the EC code was following the Linux
> > > kernel style? Now I am not able to find where.
> > >
> >
> > You are correct: https://www.chromium.org/chromium-os/ec-development
> >
> > Running checkpatch over the code, it doesn't look like that is
> > followed, though, much less enforced.
> >
> > Guenter
> >
> > > Thanks,
> > >  Enric
> > >
> > > > Thanks,
> > > > Guenter
> > > >
> > > > > [snip]
> > > > >
> > > > > Thanks,
> > > > >  Enric
