Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F762053B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9RTCSQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfF1QnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:43:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46617 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF1QnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:43:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id 65so4694210oid.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QFpm0UumsX4I37gj4rXPxQSbpBWGeOyG5IyhPSbjXkU=;
        b=q9RTCSQnZxpTkNaRIo3OFvfTXF0T70elNpWwXG6dQojmPGV3ToN5VmSJp1wsOrc+16
         41ha3a13CdvAhsI+OmoYnjkOHIyDRf/5yJBpD9LN0zcc8GNL0DadTGOCeo2t+smzWm/L
         DvLfIYiSyc4GZ/0zur4lHkHXbRdSAvnJ+BF31t2AXTKqlrovWOxRgPnna+6dZbs/CLUc
         vJvPJyLvid3Z/ATKqRbyhwl6/DFYYmp8zY3OnuhSV06DztcwHiJ5FvM+fR5FZqIzED4N
         QpFKBe21HlFd/zae9hTsV+aMbgOCYN6Gji1xu7bnana2WAFvaxE9xUVnpdh8BhfS1XYw
         5dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QFpm0UumsX4I37gj4rXPxQSbpBWGeOyG5IyhPSbjXkU=;
        b=VKJVHlbvAIwloj56EMym18gGJf93+bFeYM7xdmMI1q9WGklo4ZSVkRF3IZNgBn1bLs
         80jEJzMYzaheG+lCkWq7WLXBKkyxyKAdop+k0zIQz6iH9JI57tV1y72CW80/3mNGBRYV
         WWGJhjFcAsMlLGIVy76poPRvIZ9uJM1jB6OJ2tw0RnFDBDgf6V31cquQ8tF4i2cmf8qA
         N7AvTWx7VSaESMLafTEvk6s8z9bFi3J5afCq8MdEUIySNPVFYmS0fSIYZGP2gnKIiXMV
         ALExKZ6w2uK30/aWoGzvLKkiaedtfFz9c62Ng9kiRAdmNpCCPE57WgekvUd95T+f30fH
         /sDQ==
X-Gm-Message-State: APjAAAXdbyWzFCHOedw3X4wWuSMfBPKpqM7PYLFsOfycYV5tAyKWl334
        jBWY02HmqNs+2LPhJ+hBlI/mY/3KbJTPKOByMI8=
X-Google-Smtp-Source: APXvYqyPz5KQWvD+eakc5Lbbg9Fv9cJ+JpDlnFXrqCXzg3AuNaADqkkNAfxo1NOd5rgX2ljaHm/mIqQDuVCP+JsY+FA=
X-Received: by 2002:aca:c7c6:: with SMTP id x189mr2102706oif.4.1561740183467;
 Fri, 28 Jun 2019 09:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <156097935391.32250.14918304155094222078.malonedeb@chaenomeles.canonical.com>
 <156113479576.29306.8491703251507627705.malone@gac.canonical.com>
 <B0FDD5B2-EA6F-4ABC-8BF5-6231AA31EB70@canonical.com> <s5hh88a6pig.wl-tiwai@suse.de>
 <4E6239D9-3A70-4D66-9F88-453EB268DA2A@canonical.com>
In-Reply-To: <4E6239D9-3A70-4D66-9F88-453EB268DA2A@canonical.com>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Fri, 28 Jun 2019 12:42:52 -0400
Message-ID: <CAM8Agx0Mx+B3VeANVkO+3EZAuRPZ8z-GB0npeJwWPvQ54YaMxg@mail.gmail.com>
Subject: Re: [alsa-devel] ca0132 audio in Ubuntu 19.04 only after Windows 10
 started, missing ctefx-r3di.bin
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hm... not sure the firmware will fix this issue, as it falls back to
the default ctefx.bin firmware which should work fine. But it's worth
a shot.

His card looks like it's being identified properly, and I've had
reports from others with the same motherboard codecs not having
issues.

There's not too much that I can really troubleshoot with these cards,
as I lack the documentation. All that I know is from capturing the HDA
verbs from a Windows virtual machine with PCI passthrough.

The only thing I can really think of is GPIO potentially, but that
would be re-set when the Linux driver is booted up. I know some users
have to do a full on shutdown to clear the cards internal memory for
it to work in Linux, but it sounds like he may have already done that.

I'll look into this a little bit when I get some time, but the issue
is that I don't have too many options/ideas on what could be
potentially wrong.

On Fri, Jun 28, 2019 at 5:29 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 17:13, Takashi Iwai <tiwai@suse.de> wrote:
>
> > On Fri, 28 Jun 2019 08:35:51 +0200,
> > Kai-Heng Feng wrote:
> >> Hi Connor,
> >>
> >> The bug was filed at Launchpad [1], I think the most notable error is
> >> [    3.768667] snd_hda_intel 0000:00:1f.3: Direct firmware load for
> >> ctefx-r3di.bin failed with error -2
> >>
> >> The firmware is indeed listed in patch_ca0132.c, but looks like
> >> there=E2=80=99s no  corresponding file in linux-firmware.
> >
> > FYI, the firmware is found in alsa-firmware git repo for now.
>
> Got it, thanks for the info. Didn=E2=80=99t know there=E2=80=99s alsa-fir=
mware repo.
>
> Kai-Heng
>
> >
> >
> > Takashi
>
>
