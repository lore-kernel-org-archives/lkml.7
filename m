Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBACECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB7A2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KhT7nTxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394683AbfJPUMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:12:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35187 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfJPUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:12:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id p30so14947979pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=E9LjC5oklhR4kjD5uD1w7QuSgrBGPx/NWSLuggGG8U8=;
        b=KhT7nTxPjTP9N00Ib/UeLkiQnZ+BEMWoYGu9hRYupHczb7EGfd8unL4Dak0cFqMk/b
         XjTjLYPUYeAXhtTNTlHxX3C9SE84qgklRaud7D1dk/Tm2RIOGiGgveCgwIPds7FiKgY/
         RTmqI+cNieNd+9CypEHl9OIA5KxjceFykssWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=E9LjC5oklhR4kjD5uD1w7QuSgrBGPx/NWSLuggGG8U8=;
        b=chS+/T3JiTXNbSHSNAedC/Vhtt5WQ1WOH2Gyb59r3BeQZbFWfiN5ciRgduHT9lLLt4
         MY5kDDds6x/gSLwbojTC30V6Xfx9wCTcjUQXB6lIMLj70oRzYe8dpJNJLadkHxo3ZTvh
         9wzMytpmfqOkp8XOfzCwLSilpR+0xt0cNQtb/buC7pmQ0diVmOmUJeImbDc68vBoOsa6
         j1jKGnaGcpuTCaHMKchd19wwJ57G0D0MgNZ5zxuOJdp21N5z+2tp8lLfj7GinI6eu0i6
         sCOuNh+vJ90HVWryoO8npt5jXU8XQSiZUDb1r7PUcDyig23POuFWNKWv+jEWFAyYBv3s
         /nRA==
X-Gm-Message-State: APjAAAV7Pj7SPKgN4AeOi+zD8wBDYG+yZAJhogeV1Nbj2fgJqM2zX9zj
        AzBjEjuS3LMWqVTu6gy1FhTA2Q==
X-Google-Smtp-Source: APXvYqxnWcVmDMT/YjiG2qusWyULsrRfZrVFM1l38NSPe+zBHQiFIAPLA+azHH8jdGboxINmOvp0PQ==
X-Received: by 2002:a17:90a:c38b:: with SMTP id h11mr6917131pjt.112.1571256757322;
        Wed, 16 Oct 2019 13:12:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k15sm26750399pgt.25.2019.10.16.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:12:36 -0700 (PDT)
Message-ID: <5da779b4.1c69fb81.2d904.a23f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAODwPW-x1fwGSrvLNWCU4GAfGbD0zqo2HLm+33D8eUtxbnFLCg@mail.gmail.com>
References: <20191008115342.28483-1-patrick.rudolph@9elements.com> <20191008115342.28483-2-patrick.rudolph@9elements.com> <5d9d120b.1c69fb81.b6201.1477@mx.google.com> <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com> <6cfca8c34ccd51f12b4418e9a74d8961e32077ed.camel@9elements.com> <5d9f3b9f.1c69fb81.62109.325d@mx.google.com> <CAODwPW-x1fwGSrvLNWCU4GAfGbD0zqo2HLm+33D8eUtxbnFLCg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 13:12:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2019-10-10 11:37:58)
> > > I'll expose the coreboot tables using a sysfs driver, which then can =
be
> > > used by coreboot tools instead of accessing /dev/mem. As it holds the
> > > FMAP and "boot media params" that's all I need for now.
> > >
> > > The downside is that the userspace tools need to be keep in sync with
> > > the binary interface the coreboot tables are providing.
>=20
> Well, in the other version the kernel needs to be kept in sync
> instead. No matter where you do the parsing, something needs to be
> kept in sync. I think userspace would be easier, especially if we
> would host a small userspace library in the coreboot repository that
> other tools could just link.
>=20
> > I'd rather we export this information in sysfs via some coreboot_fmap
> > class and then make the "boot media params" another property of one of
> > the fmap devices. Then userspace can search through all the fmap devices
> > and find the "boot media params" one. Is anything else needed?
>=20
> Okay, this is the fundamental question we need to answer first... do
> you really think it's better to add a separate interface for each of
> these, Stephen? The coreboot table[1] currently contains 49 entries
> with all sorts of random firmware information, and most of these will
> never be interesting to the kernel. Do we want to establish a pattern
> where we add a new sysfs interface for each of them whenever someone
> has a use case for reading it from userspace? I think this might be a
> good point to implement a generic interface to read any coreboot table
> entry from userspace instead, and say that if the kernel doesn't need
> the information in a specific entry itself, it shouldn't need to know
> how to parse it.

I don't know why we need to draw a line in the sand and say that if the
kernel doesn't need to know about it then it shouldn't parse it. I want
there to be a consistent userspace ABI that doesn't just move things
straight from memory to userspace in some binary format. I'd rather we
have an ABI that decodes and exposes information about the coreboot
tables through existing frameworks/subsystems where possible and makes
up new ones otherwise.

One concern I have is endianness of the binary data. Is it big endian or
little endian or CPU native endian? The kernel can boot into big or
little endian on ARM platforms and userspace can be different vs. the
bootloader too. Userspace shouldn't need to know this detail, the kernel
should know and do the conversions and expose it somehow. That's why I'm
suggesting in this case we describe fmap as a sysfs class. I don't see
how we could export that information otherwise, besides in a binary blob
that falls into traps like this.

Right now we make devices for all the coreboot table entries, which is
pretty weird considering that some table entries are things like
LB_TAG_LINKER. That isn't a device. It's some information about how
coreboot was linked. We should probably blacklist tags so we don't make
devices and capture these ones in the bus code and expose them in
/sys/firware/coreboot/ somehow. We should also add device randomness
from the serial numbers, etc. that coreboot has stashed away in the
tables.

>=20
> [1] https://review.coreboot.org/cgit/coreboot.git/tree/src/commonlib/incl=
ude/commonlib/coreboot_tables.h
