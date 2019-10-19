Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD3CA9EA9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927B3222C3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZFSWVo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfJSCOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 22:14:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35303 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfJSCOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 22:14:34 -0400
Received: by mail-io1-f66.google.com with SMTP id t18so5548874iog.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LujGUq1E17eLWfgXufkbIxk3Qf8zWuZzZ2ag7/KZIM=;
        b=LZFSWVo/FqIfWtBRcAdoNjHvH3rvfX9qMcVfsVCthMDFqbJLtWi9KZSI/wvRDvRhMH
         iUvv6ziZzP77fV19rG8K3bCitaXGfwwgjf458UW4NA6v6SiPBBYpi1YuuJpH8KyWO/d+
         PebGapSS6u3xTu5dfdJiKtuFtx5aUFJQSn7WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LujGUq1E17eLWfgXufkbIxk3Qf8zWuZzZ2ag7/KZIM=;
        b=N3u7qWH/w+2DdhsbnHRibM79jH03mRjnpelqawCEtGe3KLq6gs++GjQFsXi3iFJdZq
         QXa4QYT2rr/U1Dp+yLC0kwvBKn1cnG+Y4AX0nvYU29t5igdd6v+i/jNbrC1zRWGWyPHD
         9qpu3jKj6m8zp+2Z9cuzjkheCo4XK0pDkadZHqg8oRDXVeL3ExfAZQ2ce75SQRovR8+f
         E49yEdnQ6pWCUsfM4uzyKAwDJtLnyxvfa5AI4gDg50Hcg9yxoG7MocmXTV3T+XHS/ui3
         rPQDdu1pHnfohFkFdgGugWbSmaF+F38YNmswaMPWnoNH1mwePNfuCFPp5d5WqEpzHujZ
         GJHQ==
X-Gm-Message-State: APjAAAWo36m9gjZXDytiVELOk0vaVk1/ClRzVxkfsnfE9V5Zw2TcQzat
        EUMzsLDA5Vu8AEv+yJEo36CghgfJ2dhA7bY7lZICQQ==
X-Google-Smtp-Source: APXvYqz2oISE6BZo5J5v4ZJ3dazA6CNos/7qV2oR900EYojIfIBsbrGRhelFaKMttJ9Z/nDNRbOY8932+XNlNbq0njc=
X-Received: by 2002:a02:77c4:: with SMTP id g187mr1197307jac.83.1571451273159;
 Fri, 18 Oct 2019 19:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191008115342.28483-1-patrick.rudolph@9elements.com>
 <20191008115342.28483-2-patrick.rudolph@9elements.com> <5d9d120b.1c69fb81.b6201.1477@mx.google.com>
 <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com>
 <6cfca8c34ccd51f12b4418e9a74d8961e32077ed.camel@9elements.com>
 <5d9f3b9f.1c69fb81.62109.325d@mx.google.com> <CAODwPW-x1fwGSrvLNWCU4GAfGbD0zqo2HLm+33D8eUtxbnFLCg@mail.gmail.com>
 <5da779b4.1c69fb81.2d904.a23f@mx.google.com>
In-Reply-To: <5da779b4.1c69fb81.2d904.a23f@mx.google.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 18 Oct 2019 19:14:20 -0700
Message-ID: <CAODwPW9rnB2UZVXCEdMQvtiTQVRgBKHtFPGg7RO_rg=CqfOmEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know why we need to draw a line in the sand and say that if the
> kernel doesn't need to know about it then it shouldn't parse it. I want
> there to be a consistent userspace ABI that doesn't just move things
> straight from memory to userspace in some binary format. I'd rather we
> have an ABI that decodes and exposes information about the coreboot
> tables through existing frameworks/subsystems where possible and makes
> up new ones otherwise.

Okay... I'm just saying this might grow to become a lot of stuff as
people start having more and more use cases they want to support. But
if you think the kernel should be the one parsing all that, I'm happy
to defer to your expertise there (I'm not really a kernel guy after
all).

> One concern I have is endianness of the binary data. Is it big endian or
> little endian or CPU native endian? The kernel can boot into big or
> little endian on ARM platforms and userspace can be different vs. the
> bootloader too. Userspace shouldn't need to know this detail, the kernel
> should know and do the conversions and expose it somehow. That's why I'm
> suggesting in this case we describe fmap as a sysfs class. I don't see
> how we could export that information otherwise, besides in a binary blob
> that falls into traps like this.

Right now it's just always CPU byte order of what coreboot happened to
run at, and it's not exporting that info in any way either. We don't
really have support for big-endian architectures anyway so it's not
something we really thought about yet. If it ever comes to that, I
assume the byte order of the table header's magic number could be used
to tell the difference.

> Right now we make devices for all the coreboot table entries, which is
> pretty weird considering that some table entries are things like
> LB_TAG_LINKER. That isn't a device. It's some information about how
> coreboot was linked. We should probably blacklist tags so we don't make
> devices and capture these ones in the bus code and expose them in
> /sys/firware/coreboot/ somehow. We should also add device randomness
> from the serial numbers, etc. that coreboot has stashed away in the
> tables.

I mean... should any of them be devices, then? All table entries are
just "some information", where are you defining the difference there?
I'm not sure if the current representation is the right one, but I
think they should probably all be handled in a consistent way.
