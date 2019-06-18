Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE3BC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392A920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwBVnBXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfFRRuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:50:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35591 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfFRRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:50:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so4182535wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1WigYm0cUIC6hZkrAWAPPTHDebRZz1ezFBY1qzMeiw=;
        b=RwBVnBXMUs6CyRSqQXw1Doxy4/DTjCa3zCPa//ustSWnjdVbTRmtoP9TN/oSuf+krX
         xl4fkoWrMAxa7R40u5rQS4PdI+iEJcO3uKO4D0bkbh/B5KWBLvg3lGo7+FdIxMUrU+Bk
         rvEmDc+IBNiTeTABtleg0an5BGIUgk10CMRKiYoZNAttBlfEicQfnQLY+9kDs29ckxqz
         65IqBq5uwXfydw2R7Lg1zG/1DFjmBXIwHeqx3q8Ijsr1e4cNt7GKq0hvEoPL5iNKvtQq
         U6SWTmZI7yQGUfc753z1fEtZRZPvUdKT1kOJcVZtu+PEDdRq29uH2R2DzGprlWoXffg8
         KCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1WigYm0cUIC6hZkrAWAPPTHDebRZz1ezFBY1qzMeiw=;
        b=rK/0v8bIvO3mBHLpO2hL1QXLj1VmBeGNqmjoZ+lDuOkCMGyzwdZR+gs16C5+0zJ+3c
         LnLiw+RacUp/ON8X0+JkJcJRw5viEZdk3PgvuQaMu8MK0qAPGoNtc3KelzJdt/3SeoUG
         h162+LAnm3w94g3YxhmLySZPiWIKES4V1nGAk3l0tB/YSFRzavD2bQUyd3AmvRB7N/2g
         6jr0YaoQQCo+oNiH8Rcu/4iefd/k8cXk7guPitTrBqEQphjQs95rDObxEEwuK/C0fT8U
         hZYcPndLczodl9Q/tD9sAVePKS0eIctS1zQ14Dv1F8PhFSL49z8x1Lm07luGI0xXt0Wx
         yaLw==
X-Gm-Message-State: APjAAAWWXwtiBxyi1+Aw76s5SaAUGukozpBlfPIo7i9/6WYGl37ldXaP
        qpA/E9Q2dUZC2Iik2A/vJAXDJA7hX7sQfCrcNWXr
X-Google-Smtp-Source: APXvYqwLpfFc3r+km3hllshfsJW4QlbwLhJP2SjcQT8KlUVTF5+VyukGnP6yn1xqzrGCctHX8i1Wihvkr2VXhMe2zT8=
X-Received: by 2002:a1c:f102:: with SMTP id p2mr4299194wmh.60.1560880235583;
 Tue, 18 Jun 2019 10:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <1560507893-42553-1-git-send-email-john.garry@huawei.com>
 <CAErSpo6jRVDaVvH+9XvzUoEUbHi9_6u+5PcVGVDAmre6Qd0WeQ@mail.gmail.com>
 <CAErSpo6qaMc1O7vgcuCwdDbe4QBcOw83wd7PbuUVS+7GDPgK9Q@mail.gmail.com>
 <82840955-6365-0b95-6d69-8a2f7c7880af@huawei.com> <CAErSpo5cqJCZjt6QqMNZ6_n=G-_WxFeERnsESOMxsdr1P-6JLg@mail.gmail.com>
 <9e8b6971-3189-9d4b-de9a-ff09f859f4f6@huawei.com> <CAErSpo4DemDWtnP2Gtram9tfQ0CaN9Na9_Gxk6Qk+nG5+JLuzA@mail.gmail.com>
 <539835d3-770c-285c-0c49-ae15ceaa3079@huawei.com>
In-Reply-To: <539835d3-770c-285c-0c49-ae15ceaa3079@huawei.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 18 Jun 2019 12:50:23 -0500
Message-ID: <CAErSpo576mVAFkF69bxaTpyxELXEG+z_m7CmUE3WGqfCmy57uQ@mail.gmail.com>
Subject: Re: [PATCH v2] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, linuxarm@huawei.com, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, linux-pci@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jiang Liu <jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Rafael, Mika, Jiang, linux-pci for ACPI host bridge hotplug test question]

On Tue, Jun 18, 2019 at 3:44 AM John Garry <john.garry@huawei.com> wrote:

> >>> Could you just move the logic_pio_register_range() call farther down
> >>> in hisi_lpc_probe()?  IIUC, once logic_pio_register_range() returns,
> >>> an inb() with the right port number will try to access that port, so
> >>> we should be prepared for that, i.e., maybe this in the wrong order to
> >>> begin with?
> >>
> >> No, unfortunately we can't. The reason is that we need the logical PIO
> >> base for that range before we enumerate the children of that host. We
> >> need that base address for "translating" the child bus addresses to
> >> logical PIO addresses.

> > Ah, yeah, that makes sense.  I think.  We do assume that we know all
> > the MMIO and I/O port translations before enumerating devices.  It's
> > *conceivable* that could be changed someday since we don't actually
> > need the translations until a driver claims the device,
>
> We actually need them before a driver claims the device.
>
> The reason is that when we create that child platform device we set the
> device's IORESOURCE_IO resources according to the translated logic PIO
> addresses, and not the host bus address. This is what makes the host
> transparent to the child device driver.

I think you need it to set pdev->resource[], which is currently done
long before the driver claims the device (though one could imagine
delaying it even as far as pci_enable_device()-time).  I don't think
the translation is actually *used* until the driver claims the device
because only the driver knows how to do any inb/outb to the device.

But of course, that's all speculative and doesn't change what you need
to do now.  The current code assumes we know the translations during
enumeration, so you need to do the logic_pio registration before
enumerating.

> > and it would
> > gain some flexibility if we didn't have to program the host bridge
> > windows until we know how much space is required.  But I don't see
> > that happening anytime soon.

> My problem is that I need to ensure that the new logical PIO unregister
> function works ok for hot-pluggable host bridges. I need to get some way
> to test this. Advice?

Good question.  The ACPI host bridge driver (drivers/acpi/pci_root.c)
should support hotplug, but I'm not sure if there's a manual way to
trigger it via sysfs or something similar.  If there is, and you have
a machine with more than one host bridge, you might be able to remove
one that leads to non-essential devices.

Bjorn
