Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BF5C2D0BE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B04A2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsFJjiQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfLILR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:17:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39995 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727074AbfLILR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575890246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gePB6fSq/rlJBPu1erNdnBIWumv6Nl4xKIQxuD48vdE=;
        b=OsFJjiQHnTxrupAUDyHY4Bhs+Yqlfh4ym4Gg3ObMxuSjxtkCT967bulI7xqhqy5SnQ49QB
        MNDOEJJkSnfLQYTyRcAoNnQ5+5q6CNv6YhWtOSxvwtQYLWtS+rMF6L2j/Uze8S/rzp2lqr
        Ziyfy9iUxSqP4O66qxvwYuNaLyozFhU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-F3FgXZhFNMSaPeiyv34R1A-1; Mon, 09 Dec 2019 06:17:22 -0500
Received: by mail-qt1-f200.google.com with SMTP id o24so10817538qtr.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 03:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWTaEBFOGggC4ce4fgk8cEZpKpRsvl0bTsvJF/j06c4=;
        b=NOmgLfytOJA76ueRPq3Cy2YNJ69lEqlhH31vFNd7x0uok9k4CuK2QCzQADF6jF7k80
         EMGRU3nbWGsSIckAKBmidxkCPhqMQ2jQhjmYBbRrOEer2IzxqN9KMF+DwA4QAF5o496a
         Etnpig54IRWANADj8pjK2B8qIYNesuO1UHf2jvWlI0QS/oSeXB29Fgn29vIokbQI5Zff
         xHJ9lmZwbFV4bQNMtFB5SL14C6O7ykugQ1pMKGyDZwqaTTpKi6dNeM7L62xaKw5Esf4w
         CkOotssfMMhcbJHq7vQKhz0FqnUnNA6dqSkhdKkwn2kB0HKBjextypeCWJpHzNQaP2CG
         WoAg==
X-Gm-Message-State: APjAAAWHfDO/m3CQN09AFrC8ss2T+BQ2uQ8ZTDD02i9Jh26zxbSHPUZV
        a3QGezccBjRA9+biPxKIqlWXzjmuVB+rb3ajhCjeLlf040TANaDf8XJdtF1KeJjxPk2XtpxyON4
        jSq/rIHhuJE7Ne+fPUZmvwX8YEwEdvrhL40QXda0M
X-Received: by 2002:aed:2ae7:: with SMTP id t94mr24558830qtd.130.1575890242233;
        Mon, 09 Dec 2019 03:17:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXGTAHVNmpg6Y/t9znqJomJSvKwVnFUd+47PosvATYXQKxa2ZeO+n3zSeHQjAU94Sh/b3qhJ7zCxvn9RMxJHI=
X-Received: by 2002:aed:2ae7:: with SMTP id t94mr24558808qtd.130.1575890241963;
 Mon, 09 Dec 2019 03:17:21 -0800 (PST)
MIME-Version: 1.0
References: <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
 <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
 <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
 <e0eeddf4214f54dfac08e428dfb30cbd39f20680.camel@redhat.com>
 <20191127114856.GZ11621@lahna.fi.intel.com> <CACO55tt5SAf24vk0XrKguhh2J=WuKirDsdY7T+u7PsGFCpnFxg@mail.gmail.com>
 <e7aec10d789b322ca98f4b250923b0f14f2b8226.camel@redhat.com>
In-Reply-To: <e7aec10d789b322ca98f4b250923b0f14f2b8226.camel@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 9 Dec 2019 12:17:10 +0100
Message-ID: <CACO55tu+hT1WGbBn_nxLR=A-X6YWmeuz-UztJKw0QAFQDDV_xg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Lyude Paul <lyude@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: F3FgXZhFNMSaPeiyv34R1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anybody any other ideas? It seems that both patches don't really fix
the issue and I have no idea left on my side to try out. The only
thing left I could do to further investigate would be to reverse
engineer the Nvidia driver as they support runpm on Turing+ GPUs now,
but I've heard users having similar issues to the one Lyude told us
about... and I couldn't verify that the patches help there either in a
reliable way.

On Wed, Nov 27, 2019 at 8:55 PM Lyude Paul <lyude@redhat.com> wrote:
>
> On Wed, 2019-11-27 at 12:51 +0100, Karol Herbst wrote:
> > On Wed, Nov 27, 2019 at 12:49 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > > On Tue, Nov 26, 2019 at 06:10:36PM -0500, Lyude Paul wrote:
> > > > Hey-this is almost certainly not the right place in this thread to
> > > > respond,
> > > > but this thread has gotten so deep evolution can't push the subject
> > > > further to
> > > > the right, heh. So I'll just respond here.
> > >
> > > :)
> > >
> > > > I've been following this and helping out Karol with testing here an=
d
> > > > there.
> > > > They had me test Bjorn's PCI branch on the X1 Extreme 2nd generatio=
n,
> > > > which
> > > > has a turing GPU and 8086:1901 PCI bridge.
> > > >
> > > > I was about to say "the patch fixed things, hooray!" but it seems t=
hat
> > > > after
> > > > trying runtime suspend/resume a couple times things fall apart agai=
n:
> > >
> > > You mean $subject patch, no?
> > >
> >
> > no, I told Lyude to test the pci/pm branch as the runpm errors we saw
> > on that machine looked different. Some BAR error the GPU reported
> > after it got resumed, so I was wondering if the delays were helping
> > with that. But after some cycles it still caused the same issue, that
> > the GPU disappeared. Later testing also showed that my patch also
> > didn't seem to help with this error sadly :/
> >
> > > > [  686.883247] nouveau 0000:01:00.0: DRM: suspending object tree...
> > > > [  752.866484] ACPI Error: Aborting method \_SB.PCI0.PEG0.PEGP.NVPO=
 due
> > > > to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > > > [  752.866508] ACPI Error: Aborting method \_SB.PCI0.PGON due to
> > > > previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > > > [  752.866521] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON =
due
> > > > to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > >
> > > This is probably the culprit. The same AML code fails to properly tur=
n
> > > on the device.
> > >
> > > Is acpidump from this system available somewhere?
>
> Attached it to this email
>
> > >
> --
> Cheers,
>         Lyude Paul

