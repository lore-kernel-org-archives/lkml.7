Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AB8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12B02075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ZgKAz+5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKRIMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:12:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45241 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfKRIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:12:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id z10so18212812wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gerxo1HXE3qxO7EIBzXua6pkCgqBbbDV3nyA1Pb0wBo=;
        b=ZgKAz+5OdQjkRD+eyq8cPlQgn3FarU/V2Ax05GPw/Xhr4/YKs0r98GJT9zQoHPdvmK
         k9wKXS9W0JFqKCUvnOTa05TUC5zUQO3PjBr1ed3uYib5o77jSlWnrXRaxIxRp4sGh22t
         bVZyQGTQL0Vz4hsVhtD8I9plJaDNLTo4u+y8F3v0W3ddt05KvDoZaaetgTgHfwe20+mR
         LD82XBI9aw+ur946qs9SMMEkfVqO7EhT8RZPrPKSVhDRq57Sj3VvYK7B1+oi1q/2XVDv
         frbfH3Si2SnlmgCKlH+s2lX/Z+xaEKEUM7fdYyKVIFnkhJfEOMspgTPx2mkZ6QBquYrp
         ewRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Gerxo1HXE3qxO7EIBzXua6pkCgqBbbDV3nyA1Pb0wBo=;
        b=txx5X0L0DmhBYgyDoVfsBRhu+uVtvHUyRp5SgtKLV5QkZUJDGAwcBcZMlJX5dxKRYJ
         MzQ4JF7dx+QGBn7ERyBPWxM7MhZEtFRPJ6s1RwbsGQ0X8pEmVoD9SesT98NwXysIZ+E8
         pft/2amHqMkEsfg1zr+gg0VekwkZzD1CsmaW8sRhZz8AGjPhd89xRKBsKuCyuPGkoVK4
         WZTw5FLGiW5QqmO/EHDr7wkFhFHJs8imt5mytOi7uy3r5OqM7x8UO4knLuDbt8gB0xh8
         3XZgLj9D7Cz0zCKvnXYaJFIt8VLyZVcO79b4kTqsUor+QGIp58oqN5nuZB4v4oE11W1k
         UGrg==
X-Gm-Message-State: APjAAAUhuyZuN/D0XN0SlhaC/PGNKdOHhHwW5q8INV8Au0UZeIes9ep0
        FFyN4tG5tm1Ihz1RHcrvFcDUdg==
X-Google-Smtp-Source: APXvYqznaq8NPgx9ib3bRkuzm2nqHxQVhkVx5C8CJtce7uveJTuh5OCW7AKxImyR9UQ1PUdBZyrECg==
X-Received: by 2002:adf:d842:: with SMTP id k2mr28129290wrl.163.1574064746694;
        Mon, 18 Nov 2019 00:12:26 -0800 (PST)
Received: from rudolphp (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id y78sm19882825wmd.32.2019.11.18.00.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:12:26 -0800 (PST)
Message-ID: <fd1a028bf2a5f9141b3a25459fa21b4083c58705.camel@9elements.com>
Subject: Re: [PATCH 1/3] firmware: google: Release devices before
 unregistering the bus
From:   patrick.rudolph@9elements.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Arthur Heymans <arthur@aheymans.xyz>
Date:   Mon, 18 Nov 2019 09:12:24 +0100
In-Reply-To: <20191116133849.GC454551@kroah.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
         <20191115134842.17013-2-patrick.rudolph@9elements.com>
         <20191116133849.GC454551@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-11-16 at 14:38 +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 15, 2019 at 02:48:37PM +0100, 
> patrick.rudolph@9elements.com wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > 
> > Fix a bug where the kernel module can't be loaded after it has been
> > unloaded as the devices are still present and conflicting with the
> > to be created coreboot devices.
> > 
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > ---
> >  drivers/firmware/google/coreboot_table.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/firmware/google/coreboot_table.c
> > b/drivers/firmware/google/coreboot_table.c
> > index 8d132e4f008a..88c6545bebf4 100644
> > --- a/drivers/firmware/google/coreboot_table.c
> > +++ b/drivers/firmware/google/coreboot_table.c
> > @@ -163,8 +163,14 @@ static int coreboot_table_probe(struct
> > platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > +static int __cb_dev_unregister(struct device *dev, void *dummy)
> > +{
> > +	device_unregister(dev);
> 
> Did you build this patch???
> 
> Did it work when you tested it?  How?
> 
It builds without a warning and is working.

It looks like there's no -Werror=return-type in the kernel's Makefile,
which is kind of odd as this is kind of undefined behaviour in C...

Will fix.

> Please fix up,
> 
> greg k-h

