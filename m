Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0CAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA41206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dmcCM7Yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfJJJq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:46:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55517 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:46:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so6183512wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QPp55kuRf3+lyRK+9iqTbgFqqJyrdtmwyo0KQ5EsOTA=;
        b=dmcCM7YrL1FFyCOdkX+y1T/WzvgfoBjg4nwbGncoILd5jM29jXMJYI8d3gz5Qg7+Uv
         X2MMdXO36rUXOEFfIrqP6g2AEbh9xym/rSgDhsomXMhWsJH++M3665Vhr1BbhER/TNhy
         R2khVK7tQeFuRcgXtkANbdKkerbb5w6wHct/FZLlygVdHCOIu+QRBXp+QMdo1z1436vN
         wAzFCfiKDvqThE1iIP3oPdOP/DjKlrzM+OkEr565JnGrQg0tRFTl/nyVHaYE+02taVpM
         4CErQcNC3OBu2KmM+xvQU/ApF6Wwc3eS7uqdQPLLP4UuokFYHnACNX5yoGmEL1WQbLKp
         egPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QPp55kuRf3+lyRK+9iqTbgFqqJyrdtmwyo0KQ5EsOTA=;
        b=FXf7GyWJlEDq4KPYOUsLmkJViglTNjzPk/SU7wzHrIkz3ETM86uxSVIRz5v7jyqcTW
         I1ryr0ZaViXasUKoMKPl3fbfiKDbmbAc0EdTcWC2O+J7IbLDCwcUEfMlGOlvC1Doj5dg
         oRywflLrRUJPn7muTCOu70Vl+tsB2D7SbMbESsb33VTGytnWFLddqdMV9ZyfhnSLYHwN
         OxGM83PJzCqkribBZdF7+T8iZZnyGFKW8my+/Z00GeUmLZWsUzG2hrdOfEm6ksQiTzaR
         eArP3p0GP6+YmiaEUHib1se2hsottbLiuFKVAFmg6Q/a6tLrhfKK6zqwD25VttwwMc0w
         Jirw==
X-Gm-Message-State: APjAAAX5Ddlwm98WGd1fBaHfh8bHfqd2y4wCL56Ry1QRu/47Xx2KLwqX
        qvi6QCcbl7KHg3VlpObT5LSAMLIntBT8S+Iu
X-Google-Smtp-Source: APXvYqxoTwpEg6SSoRFBewcWqiVLIEvIsnjXkyrjzUNSKHI1zz4JFiSD7mp4brU/DXLXplJjnQnvsw==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr6799650wmj.126.1570700815618;
        Thu, 10 Oct 2019 02:46:55 -0700 (PDT)
Received: from rudolphp (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id a2sm5156154wrp.11.2019.10.10.02.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 02:46:54 -0700 (PDT)
Message-ID: <6cfca8c34ccd51f12b4418e9a74d8961e32077ed.camel@9elements.com>
Subject: Re: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
From:   patrick.rudolph@9elements.com
To:     Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Filipe Brandenburger <filbranden@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>
Date:   Thu, 10 Oct 2019 11:46:53 +0200
In-Reply-To: <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com>
References: <20191008115342.28483-1-patrick.rudolph@9elements.com>
         <20191008115342.28483-2-patrick.rudolph@9elements.com>
         <5d9d120b.1c69fb81.b6201.1477@mx.google.com>
         <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 14:19 -0700, Julius Werner wrote:
> > Somehow we've gotten /sys/firmware/log to be the coreboot log, and
> > quite
> > frankly that blows my mind that this path was accepted upstream.
> > Userspace has to know it's running on coreboot firmware to know
> > that
> > /sys/firmware/log is actually the coreboot log.
> 
> Not really sure I understand your concern here? That's the generic
> node for the log from the mainboard firmware, whatever it is. It was
> originally added for non-coreboot firmware and that use is still
> supported. If some other non-coreboot firmware wants to join in, it's
> welcome to do so -- the interface is separated out enough to make it
> easy to add more backends.
> 
> I do agree that if we want to add other, more coreboot-specific
> nodes,
> they should be explicitly namespaced.
> 

I'll add a new namespace called 'coreboot'.

> > But I also wonder why this is being exposed by the kernel at all?
> 

It's difficult for userspace tools to find out how to access the flash
and then to find the FMAP, which resides somewhere in it on 4KiB boundary.
The "boot media params" usually give the offset to the FMAP from beginning
of the flash, but tell nothing about how to access it.

> I share Stephen's concern that I'm not sure this belongs in the
> kernel
> at all. There are existing ways for userspace to access this
> information like the cbmem utility does... if you want it accessible
> from fwupd, it could chain-call into cbmem or we could factor that
> functionality out into a library. If you want to get away from using
> /dev/mem for this, we could maybe add a driver that exports CBMEM or
> coreboot table areas via sysfs... but then I think that should be a
> generic driver which makes them all accessible in one go, rather than
> having to add yet another driver whenever someone needs to parse
> another coreboot table blob for some reason. We could design an
> interface like /sys/firmware/coreboot/table/<tag> where every entry
> in
> the table gets exported as a binary file.

I don't even consider using binaries that operate on /dev/mem.
In my opinion CBMEM is something coreboot internal, the OS or userspace
shouldn't even known about.

> I think a specific sysfs driver only makes sense for things that are
> human readable and that you'd actually expect a human to want to go
> read directly, like the log. Maybe exporting FMAP entries one by one
> like Stephen suggests could be such a case, but I doubt that there's
> a
> common enough need for that since there are plenty of existing ways
> to
> show FMAP entries from userspace (and if there was a generic
> interface
> like /sys/firmware/coreboot/table/37 to access it, we could just add
> a
> new flag to the dump_fmap utility to read it from there).

I'll expose the coreboot tables using a sysfs driver, which then can be
used by coreboot tools instead of accessing /dev/mem. As it holds the
FMAP and "boot media params" that's all I need for now.

The downside is that the userspace tools need to be keep in sync with
the binary interface the coreboot tables are providing.

