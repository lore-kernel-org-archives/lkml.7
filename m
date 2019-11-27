Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A11C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5891D2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFRDAi7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfK0Lv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:51:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbfK0Lv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574855517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XhIGMtsi7KjLuMFks8eIn7a7OR+crqiPZAFOU/Qxss=;
        b=iFRDAi7XhSv2bcOJ+Ffw0LowCrf4yFK4HhrIA73B7bKD8SE1LqZVID+ilrKeX0QLAu0BdY
        RbvvGZmX4WAEXIG4nXqlq4SFOJDImwK65lEAQrMkOPecvTKLqCXfYT6h3y2i6+QKOUAWf/
        GunixtYqp8VOss5xH1bWyY/hOGHle48=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-lyJ-O4l_OLaQEc0p2RyDOg-1; Wed, 27 Nov 2019 06:51:54 -0500
Received: by mail-qt1-f198.google.com with SMTP id x21so14644838qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 03:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfYAUmGvWJZJSRiVsjUka5mWwDiEaeMITYpQOX7mwXY=;
        b=MDcsB/K7LsorhhpG6DHZI04rQra7jCcbXwLZr6kSQ4tPheMsbTDBq3TpHp3yNg6bm+
         gsAvSHSxPzZUdWgshB6nFR/5V3NN5+GP4Dr0fGsjjlBY3eCysdXhfen+RPCZ5nw9hvl/
         TsDxWYPi0YjPl2DD4hwWJIqEaZygrju4u74bZhSqqIrwBQ7o/V+gZAIywtM3v4mAW/hZ
         SKsBec64F445BIDpkrqb92XlEbeMPLtQERe7F2DGAJMr9muBFKdfmgTkqi+oRbJ6sfD8
         6MaisNMG1c+ZjhwLmAp5q4zEBWurk7X0C9qBeFCBponWbbZ7qxxJGpVHrguIoPmqU5wk
         VlPg==
X-Gm-Message-State: APjAAAU9AssXAVML6Px0Z28AiCvu12gzAHgwcYkiiUaATHtPYQtawrr/
        U0YIZZYtCYHt7NVSaASPNoGjPAAoQuWHM+uN4D4aIfNMsBwiXwl/oCT7GUvJ7TF9tFr8SOlyCZN
        nHSDOfafX0biwoHzlD5C0t11X0KLwwHMHjsEEdW0X
X-Received: by 2002:a37:9083:: with SMTP id s125mr3828282qkd.192.1574855513971;
        Wed, 27 Nov 2019 03:51:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZYMA+GCGq805VHWy/zJ5Esuj29dPvonXDjlfISqurrPh5cY/HxAxHE6xgDQ+gYrWiq10cFGm+kgXM2WTFJbE=
X-Received: by 2002:a37:9083:: with SMTP id s125mr3828257qkd.192.1574855513663;
 Wed, 27 Nov 2019 03:51:53 -0800 (PST)
MIME-Version: 1.0
References: <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
 <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
 <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
 <e0eeddf4214f54dfac08e428dfb30cbd39f20680.camel@redhat.com> <20191127114856.GZ11621@lahna.fi.intel.com>
In-Reply-To: <20191127114856.GZ11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 27 Nov 2019 12:51:42 +0100
Message-ID: <CACO55tt5SAf24vk0XrKguhh2J=WuKirDsdY7T+u7PsGFCpnFxg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Lyude Paul <lyude@redhat.com>,
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
X-MC-Unique: lyJ-O4l_OLaQEc0p2RyDOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:49 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Tue, Nov 26, 2019 at 06:10:36PM -0500, Lyude Paul wrote:
> > Hey-this is almost certainly not the right place in this thread to resp=
ond,
> > but this thread has gotten so deep evolution can't push the subject fur=
ther to
> > the right, heh. So I'll just respond here.
>
> :)
>
> > I've been following this and helping out Karol with testing here and th=
ere.
> > They had me test Bjorn's PCI branch on the X1 Extreme 2nd generation, w=
hich
> > has a turing GPU and 8086:1901 PCI bridge.
> >
> > I was about to say "the patch fixed things, hooray!" but it seems that =
after
> > trying runtime suspend/resume a couple times things fall apart again:
>
> You mean $subject patch, no?
>

no, I told Lyude to test the pci/pm branch as the runpm errors we saw
on that machine looked different. Some BAR error the GPU reported
after it got resumed, so I was wondering if the delays were helping
with that. But after some cycles it still caused the same issue, that
the GPU disappeared. Later testing also showed that my patch also
didn't seem to help with this error sadly :/

> > [  686.883247] nouveau 0000:01:00.0: DRM: suspending object tree...
> > [  752.866484] ACPI Error: Aborting method \_SB.PCI0.PEG0.PEGP.NVPO due=
 to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > [  752.866508] ACPI Error: Aborting method \_SB.PCI0.PGON due to previo=
us error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > [  752.866521] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due =
to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
>
> This is probably the culprit. The same AML code fails to properly turn
> on the device.
>
> Is acpidump from this system available somewhere?
>

