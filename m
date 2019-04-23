Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250FAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F108A20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDWJrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:47:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32898 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDWJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:47:48 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hIs1h-0005lY-EE
        for linux-kernel@vger.kernel.org; Tue, 23 Apr 2019 09:47:45 +0000
Received: by mail-pf1-f198.google.com with SMTP id h69so9385266pfd.21
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SCBlIj4alBx+1+PivA2+QaEriN369MJ8nIcJXMZ73AM=;
        b=LVh4z5Nb9atmwm8yPAdZGzCtNIiDQa7k0zc+8R9opj9dFQJh28JPg+4I3qWz2Ns8AQ
         86F2+ePnDi7Q6BefEuXeDwgPrQGBc1CsU5Layo0b8qGqKRc5Gc5biskQRb8Rxug1/vme
         hTY6W8LuP/hui8eCf0ZMPXhB41nt15tKmnhimIm06vMPGWr+Cnwd1tWKC1v5cksQdGn8
         KlUUO9tqRr0IJePlzIwDSev5rLiOZCxd3FEx7LzZ9LrmRkibK891nJyNKZoZENGPjj43
         E2ZZjVMU4ogxvLSEMdstzqivGgkbJzJRzkQvG39SnbrInTIhH7KJlIxr6a053P7oWaL0
         gUGw==
X-Gm-Message-State: APjAAAU65bH0nu8X1YbRMz771hzFDqpBS7tmeQhg6qbjZCvTBXg+mQLF
        QBz/P+9RDBruonQFnw3TVGY+cN0s0+qRaRw1bJ5Ruj2EkNvj9F3v7fpmHLL+i1oyV3b6J4mu+Ut
        k5YDSszjhhMa6//36l/7115ViaPJNqjJ+66jlmB2+mQ==
X-Received: by 2002:a17:902:f084:: with SMTP id go4mr25737947plb.235.1556012863995;
        Tue, 23 Apr 2019 02:47:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwpvUihZG8o/oKWFXwf3rXRUZvSld3gFV5jMU7rDv2Ms+Jwo4Jl45y6IhXNb3dvUOL/8HhhSw==
X-Received: by 2002:a17:902:f084:: with SMTP id go4mr25737905plb.235.1556012863224;
        Tue, 23 Apr 2019 02:47:43 -0700 (PDT)
Received: from 2001-b011-380f-14b9-d015-82d6-2039-7ce9.dynamic-ip6.hinet.net (2001-b011-380f-14b9-d015-82d6-2039-7ce9.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:d015:82d6:2039:7ce9])
        by smtp.gmail.com with ESMTPSA id n11sm673780pgm.50.2019.04.23.02.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:47:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] pinctrl: intel: Clear interrupt status in unmask callback
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Ld8ZLG1--3-1@tutanota.com>
Date:   Tue, 23 Apr 2019 17:47:35 +0800
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hdegoede <hdegoede@redhat.com>,
        Linux Gpio <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <3BE5F007-CD9C-486A-90EE-326AAB807D5B@canonical.com>
References: <20190422044539.16085-1-kai.heng.feng@canonical.com>
 <Ld5HCy5--3-1@tutanota.com>
 <EA207DE8-E89A-427B-B910-A36170A76031@canonical.com>
 <Ld8QGex--3-1@tutanota.com> <20190423090816.GN2654@lahna.fi.intel.com>
 <Ld8ZLG1--3-1@tutanota.com>
To:     hotwater438@tutanota.com
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 17:40, <hotwater438@tutanota.com> <hotwater438@tutanota.com> wrote:

> Hi. Thank's for a hint!
> So catting this file gives me next content:
> s2idle [deep]

Which kernel version do you use?

The default switches to s2idle based on FADT flag and _DSM on relative new  
kernels.

Most systems preload with Windows 8.1 should default to use s2idle.

>
> So I suppose I have s2idle with deep-mode available?
>
> I've tried to select deep by creating mem_sleep_default file, but I can't  
> (Permission error).
>
> Could you explain how do I switch suspend mode in Linux, if you know?

# echo s2idle > /sys/power/mem_sleep

> And to be honest, I don't think that's a correct fix of touchpad problem.

If the system defaults to use S2I, then it’s better to stick with it.

Lots of ODM/OEM don’t really test S3.

>
> Can we somehow cut off the power by hands or send a signal to a system to  
> shut off a touchpad? Or there are no approaches like that?

I don’t think it’s possible.

Kai-Heng

>
> Regards,
> Vladislav.
>
>
> Apr 23, 2019, 12:08 PM by mika.westerberg@linux.intel.com:
> On Tue, Apr 23, 2019 at 11:00:48AM +0200, hotwater438@tutanota.com wrote:
> Hi.
>
> Honestly, I can't find any information about my acpi suspend type.
> There are no options in my BIOS to change it, and I can't determine
> which exactly I have. But I suppose I have a S3 because I have suspend
> issue.
>
> Can I somehow determine it in Linux? I did a research but found nothing
> on the internet.
>
> You can read the default mode from /sys/power/mem_sleep. "s2idle" means,
> well suspend-to-idle and "deep" means S3.


