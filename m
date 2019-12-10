Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6630DC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA01206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EOSodPBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfLJGyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:54:37 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38344 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfLJGyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:54:36 -0500
Received: by mail-il1-f195.google.com with SMTP id u17so15190589ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 22:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gu0tI1Ph2fkGTpOQyVLmgqpol4E6X/tEFsGWyYePxFo=;
        b=EOSodPBvj8YO5TUFc/w6bgKtErmFN3IADsXNow5Dn0RDaYlWV7fzSalNujYqj+W7Ea
         vMcGDUeAqyOAVmkKnYSXWKOxwdUL/+YXgTVZxijs49Qm2F7s93h2rj9jtq2Kg+VQKc5w
         mYKfcvW9cULBVw3OI8imSJXJMYD/oWIajIlnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gu0tI1Ph2fkGTpOQyVLmgqpol4E6X/tEFsGWyYePxFo=;
        b=Jv8ak4yf4ORvD+p4A+n2uZfgJPWK2VKWPTT67KPAWAJvD5oPnnIrijq+xIGy7gbBlc
         aZWGjxquDXlLPyXPKmv2L1or+aG7IoS++SUXiBo9XyypWlU5ty4tfSWfBB5ybZvzs1DJ
         vlPRIiEdaNLWWWQf6acSJy2qin5Y8caX4DzUKT7JtTa4eAdy4zEAZMHhdyPWju/b9Ma/
         PL1UHmgqtAxaytyCOO8NYRkF301Yg/MzkdSD9iLallZSJJ4tT86/lr3F+dITucSGmWJ/
         ZrjSFmX9ZVyoy4aFYUENl+Y67s7ahIxG3bbbGJvkF9CwKXXD7eQEjucJzHc6nw9Kneb8
         qkDw==
X-Gm-Message-State: APjAAAW4flrI+AbrckR82QispD8w9FeboY9UD0t5Z6guxF9WcoHfj7AP
        ItOLvGAsrSkUhoYt7ukvFhfTfFxcfX573ap5K1tvdQ==
X-Google-Smtp-Source: APXvYqzeecdVJpN22hzm3NN0X757pkAa6hjd9KkC9mnUCmHxZKpkuuZRPLFDBaLHWi7AKKKmVYEnJhEoLcgSsypydlo=
X-Received: by 2002:a92:5c47:: with SMTP id q68mr25325970ilb.41.1575960875769;
 Mon, 09 Dec 2019 22:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20191128125100.14291-1-patrick.rudolph@9elements.com> <20191128125100.14291-2-patrick.rudolph@9elements.com>
In-Reply-To: <20191128125100.14291-2-patrick.rudolph@9elements.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 9 Dec 2019 22:54:23 -0800
Message-ID: <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int cbmem_probe(struct coreboot_device *cdev)
> +{
> +       struct device *dev = &cdev->dev;
> +       struct cb_priv *priv;
> +       int err;
> +
> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> +
> +       priv->remap = memremap(priv->entry.address,
> +                              priv->entry.entry_size, MEMREMAP_WB);

We've just been discussing some problems with CBMEM areas and memory
mapping types in Chrome OS. CBMEM is not guaranteed to be page-aligned
(at least not the "small" entries), but the kernel can only assign
memory attributes for a page at a time (and refuses to map the same
area twice with two different memory types, for good reason). So if
CBMEM entries sharing a page are mapped as writeback by one driver but
uncached by the other, things break.

There are some CBMEM entries that need to be mapped uncached (e.g. the
ACPI UCSI table, which isn't even handled by anything using this CBMEM
code) and others for which it would make more sense (e.g. the memory
console, where firmware may add more lines at runtime), but I don't
think there are any regions that really *need* to be writeback. None
of the stuff accessing these areas should access them often enough
that caching matters, and I think it's generally more common to map
firmware memory areas as uncached anyway. So how about we standardize
on mapping it all uncached to avoid any attribute clashes? (That would
mean changing the existing VPD and memconsole drivers to use
ioremap(), too.)
