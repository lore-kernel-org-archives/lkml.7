Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3636C24125
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1LMhsGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLMVcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:32:00 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42108 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:31:59 -0500
Received: by mail-yb1-f196.google.com with SMTP id z10so361515ybr.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 13:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7UQIqVTtAUuqjJ6O3IPUORsorWi4L1xwTpqAKgJuaU=;
        b=k1LMhsGaHtSh53In008IyDmwqy5ZwYYM27qRr25YGj4IULduelp6jCo6pllVJW4S32
         FHA96KboNljrw2wp81a4kAejbfBzn7QRFzchm9pko3Br59mjJHhZ5jLgzsYKKiopEMkk
         IG5YU97Ed5sceAjRqhTXSe9zyN6aqmDC57TgoClwmNkg2ZfPtHcWq/N/wNY8sQd2MHbP
         E7PzyRluFW7kLDehjL9WMoI+qbKvFsi8/ScOUWaRWluvikU9cQxR+CnmvWjHBqrP9UDp
         slECZSmWK0QzQ7coykNv5OQSbifYZ6GoBGXnpqj1jz5TUeXZjvCTZiy5ajcn579I3nXq
         j2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7UQIqVTtAUuqjJ6O3IPUORsorWi4L1xwTpqAKgJuaU=;
        b=ReGpglHA2lGnMtQhpQt5vyUuKoY0D33oHCzoTVcc2Qvc850+z/zIWKy+Ya5EVK5Hw3
         TYg/tDPZbRFpKcD46490iujLEhvhAIiDr4V+JSM5o9+K++RMTvgx7FfZkxZoJ+UBSfbK
         njc8izKG8C4imri0l1Dk6IMms9P7qncsBh5u7k801uuC3BS6+fgrAScSEkDapyTT8XdW
         rkwQZ7Qaz+KUHKPIO8VAwPiGUYBM2NGyzLS6KxNkcJ7FfVWVVIXIpFl3ItKPnSSX5z2G
         7UgRqg2ElCp5KOTqK1J/J+AKxvV9HAkBNnMhkw7XilpOFurlFaQojF3jQJMUGYw9+auo
         cGXg==
X-Gm-Message-State: APjAAAVJ2yxxagHeCflcuRRl3cfIcsehprr8+R3IBtIQeF2YDO/sZLAu
        HT51J/JkqtU6+Y9igMZVC+nfuGJGRGzMwXTAlPPCTXTJMNQ=
X-Google-Smtp-Source: APXvYqxxcZUIjUfnW6TES8n+/1GVJXmXVZNGyCAcLEwE8tTkZ5e153wS7FOVPCI5GIXigdP+wS1lg0vfhdm+Wo8ScfM=
X-Received: by 2002:a25:75c5:: with SMTP id q188mr7337708ybc.418.1576272718020;
 Fri, 13 Dec 2019 13:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20191128125100.14291-1-patrick.rudolph@9elements.com>
 <20191128125100.14291-2-patrick.rudolph@9elements.com> <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com>
 <CAOxpaSXUgNXaZ40ScZKZQ+iDEQ=vqPytLgicBx==hxp5uL_+dA@mail.gmail.com>
In-Reply-To: <CAOxpaSXUgNXaZ40ScZKZQ+iDEQ=vqPytLgicBx==hxp5uL_+dA@mail.gmail.com>
From:   Mat King <mathewk@google.com>
Date:   Fri, 13 Dec 2019 14:31:46 -0700
Message-ID: <CAL_quvScPUuocogrghzH_vNb2uxyBupBKYikG0Bwf4OcfSRWsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
To:     Julius Werner <jwerner@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 11:57 PM Julius Werner <jwerner@chromium.org> wrote:
> > +static int cbmem_probe(struct coreboot_device *cdev)
> > +{
> > +       struct device *dev = &cdev->dev;
> > +       struct cb_priv *priv;
> > +       int err;
> > +
> > +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> > +
> > +       priv->remap = memremap(priv->entry.address,
> > +                              priv->entry.entry_size, MEMREMAP_WB);
>
> We've just been discussing some problems with CBMEM areas and memory
> mapping types in Chrome OS. CBMEM is not guaranteed to be page-aligned
> (at least not the "small" entries), but the kernel can only assign
> memory attributes for a page at a time (and refuses to map the same
> area twice with two different memory types, for good reason). So if
> CBMEM entries sharing a page are mapped as writeback by one driver but
> uncached by the other, things break.
>
> There are some CBMEM entries that need to be mapped uncached (e.g. the
> ACPI UCSI table, which isn't even handled by anything using this CBMEM
> code) and others for which it would make more sense (e.g. the memory
> console, where firmware may add more lines at runtime), but I don't
> think there are any regions that really *need* to be writeback. None
> of the stuff accessing these areas should access them often enough
> that caching matters, and I think it's generally more common to map
> firmware memory areas as uncached anyway. So how about we standardize
> on mapping it all uncached to avoid any attribute clashes? (That would
> mean changing the existing VPD and memconsole drivers to use
> ioremap(), too.)

I don't think that uncached would work here either because the acpi
driver will have already mapped some of these regions as write-back
before this driver is loaded so the mapping will fail.

Perhaps the best way to make this work is to not call memremap at all
in the probe function but instead call memremap and memunmap every
time that data_read is called. memremap can take multiple caching mode
flags and will try each until one succeeds. So if you call it with
MEMREMAP_WB | MEMREMAP_WT in data_read it should succeed no matter how
it has been mapped by other drivers which should already be loaded
when it is called.
