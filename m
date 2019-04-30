Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C7EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCB420644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5fzeWhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfD3Ncc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:32:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38424 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD3Ncb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:32:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id t70so5665127oif.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IreQ0jouyS/D8gYDCyS7jEiprNx5trWg2oesU5FoXa0=;
        b=C5fzeWhQ/2btZ4CD0g7sbhi3duroFEFBk9mAeRGfXv0yxlnxQn+udOTK1Uf1fcuH7+
         L4aP4vVQCWq3O2BiKrQ+rP60GhxiGjJltQ3jzf6gTr0U2Slyrrtt2l1h09I552rIEQx4
         s9Yq/IzHKhCnF4/KsslyPH9eTtosgtTr2URw/Afe5zVxA+du6KxX0zYQOV8EaaP6+PDd
         n1yrXWZonSfJSyA7rqvbR7SzaQjlBhEN419wB4ARRyhsz/J9v5s18TMORrIXUUneTBEP
         wp7YwnSn8qmY7V1sdrDBU0ZMwB08P5wESLNTFwGVnvRE/WGXONETkh7WAeyP6JK1vHbs
         PEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IreQ0jouyS/D8gYDCyS7jEiprNx5trWg2oesU5FoXa0=;
        b=K9LmH8Npp3bDZmpdchf1643G2C7vYJ2QHl3+oopozxfha8dXNSBkBp71n6fFv7HkRM
         Q12g1/JoBsKugCTqVmO1nHF3H6KPxgk+9VYniKXA8dYO/S51Xf1ycA8ERwEFi8kAPKQL
         OLt/oXI0xUp2TkcelSaszBahj61w34E/DqT64V7ZKs2y6JxgShKCsqIYRmC1jcI+Ge3N
         /IXygS4xjC5dGcfXNSLrFDhEl66TeAjaO2qztRx4igyKadooOyS6rhEIkkKozzVRhUV6
         V3TgsiF2efo4jikZf5BXGuV31kkgzLhlyEzfuAXdBuiUMoI9uBPTHYluqGs3BJVTJYVb
         THrQ==
X-Gm-Message-State: APjAAAXIMBgfeod8NEagxp3btGJSxAls5ixBS6TivmAO0sq3PFb9lqC6
        lkyN0/5WjeXMXjzcOIdxfVsnwBvLPetUpO61iVY=
X-Google-Smtp-Source: APXvYqya3InPUbrIUL9K9lKgI8RlOhW4WAY+VMsSEUDEi0+OnTaqCKNfwyYxiJQa7n6joA4vDFzQscK5snCHLXTeXkE=
X-Received: by 2002:aca:4202:: with SMTP id p2mr2741707oia.169.1556631150997;
 Tue, 30 Apr 2019 06:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
 <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
 <20190430022238.GA22593@osadl.at> <20190430030223.GE23075@ZenIV.linux.org.uk>
 <20190430033310.GB23144@osadl.at> <20190430041934.GI23075@ZenIV.linux.org.uk>
In-Reply-To: <20190430041934.GI23075@ZenIV.linux.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 30 Apr 2019 09:32:20 -0400
Message-ID: <CAGngYiVSg86X+jD+hgwwrOYX82Fu3OWSLygwGFzyc9wYq6AesQ@mail.gmail.com>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes annotation
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nicholas Mc Guire <der.herr@hofr.at>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:19 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... not that there's much sense keeping ->fieldbus_type in host-endian,
> while we are at it.

Interesting! Suppose we make device->fieldbus_type bus-endian.
Then the endinan-ness conversion either needs to happen in
bus_match() (and we'd have to convert endianness each time
this function is called).
Or, we make driver->fieldbus_type bus-endian also, then there
is no need for conversion... but the driver writer has to remember
to specify this in bus endianness:

static struct anybuss_client_driver profinet_driver = {
        .probe = ...,
        .fieldbus_type = endian convert?? (0x0089),
};

Which pushes bus implementation details onto the
client driver writer? Also, how to convert a constant
to a specific endianness in a static initializer?

You never make a remark without good reason, so what
am I overlooking?
