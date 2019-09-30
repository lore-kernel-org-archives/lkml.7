Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D7FC388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ADE21BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfI3JQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfI3JQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:16:01 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9848458
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:16:00 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id w16so29033564ioc.15
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 02:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYALegoGq2x0f4Xpam8g4n/KmRTLzFLFdMWS2x+BRTo=;
        b=BY+Ztk6ftx6G8prHhU4C8NIGcBWWxp9oXNgVGh9nHrCQzaT53rO/vUdOpL0xmocAqp
         ZO+YZR1+Rk59O2+M1ovhc/eYK3ndFCpySaNV0Of5XgUWXKQHkDJGomktmgAsJ9tkeC6F
         mcWtgUarREPDasN849gcLNZJT2KIertWeOiBMT82O+F3aNFRysrrt9AnuW0yRYwzBVLA
         nn0hnZrX6F2P/Pu7mzE1VwO7ovibpjx8oslJmC+IveeMaY/125r7BpVH2yWxHVFnMtOw
         QKgXlFGljrc59y5/PlJoGX95W6h8aSA0YMKYdT6Kd5a2NO6hUMfQ8JyS/bsmyFvRpKq+
         CyyA==
X-Gm-Message-State: APjAAAX9luHYJzOpsDx8NGMGeh4YYgHZA9HdQsxiS0EtIspMsfy3cskt
        ak+3VHzsrs+qQyUX76RrMhlrr1vqSLIFsProbyHqQwO7gikVItQaytOd5KvU18F9CktUhdi445B
        PfyhZvXjP99aQb8lMyd0s8IcFQ2J8H61OyYmwJ6Eu
X-Received: by 2002:a92:5e1b:: with SMTP id s27mr19109715ilb.178.1569834960039;
        Mon, 30 Sep 2019 02:16:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPkXeGqth758z+hZfIc2R8kD4VkXAa/WTJi6BfLuef+qvcqGexqJEgTITxFa30xLqGIhrpPCs116BcIvdOFKY=
X-Received: by 2002:a92:5e1b:: with SMTP id s27mr19109703ilb.178.1569834959772;
 Mon, 30 Sep 2019 02:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144421.22608-1-kherbst@redhat.com> <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com> <20190930080534.GS2714@lahna.fi.intel.com>
In-Reply-To: <20190930080534.GS2714@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 30 Sep 2019 11:15:48 +0200
Message-ID: <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 10:05 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Karol,
>
> On Fri, Sep 27, 2019 at 11:53:48PM +0200, Karol Herbst wrote:
> > > What exactly is the serious issue?  I guess it's that the rescan
> > > doesn't detect the GPU, which means it's not responding to config
> > > accesses?  Is there any timing component here, e.g., maybe we're
> > > missing some delay like the ones Mika is adding to the reset paths?
> >
> > When I was checking up on some of the PCI registers of the bridge
> > controller, the slot detection told me that there is no device
> > recognized anymore. I don't know which register it was anymore, though
> > I guess one could read it up in the SoC spec document by Intel.
> >
> > My guess is, that the bridge controller fails to detect the GPU being
> > here or actively threw it of the bus or something. But a normal system
> > suspend/resume cycle brings the GPU back online (doing a rescan via
> > sysfs gets the device detected again)
>
> Can you elaborate a bit what kind of scenario the issue happens (e.g
> steps how it reproduces)? It was not 100% clear from the changelog. Also
> what the result when the failure happens?
>

yeah, I already have an updated patch in the works which also does the
rework Bjorn suggested. Had no time yet to test if I didn't mess it
up.

I am also thinking of adding a kernel parameter to enable this
workaround on demand, but not quite sure on that one yet.

> I see there is a script that does something but unfortunately I'm not
> fluent in Python so can't extract the steps how the issue can be
> reproduced ;-)
>
> One thing that I'm working on is that Linux PCI subsystem misses certain
> delays that are needed after D3cold -> D0 transition, otherwise the
> device and/or link may not be ready before we access it. What you are
> experiencing sounds similar. I wonder if you could try the following
> patch and see if it makes any difference?
>
> https://patchwork.kernel.org/patch/11106611/

I think I already tried this path. The problem isn't that the device
isn't accessible too late, but that it seems that the device
completely falls off the bus. But I can retest again just to be sure.
