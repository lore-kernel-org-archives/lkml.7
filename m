Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0175AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB53D206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCDVMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:12:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42322 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:12:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id u7so6720723qtg.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 13:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCoYSQIO/+zehB3BDPmDZjYiph2cEHcK1xxO4AnmERc=;
        b=auLNZuQz6vs9QEtD+T3LJ+E6Lm41vL/k0OWkgo2HMPCgkWTyuPq9eBZ1VzkvtWU+hZ
         5uPzgllxZr2+8ES/5rBFHKNxggAeJNLcnNy0qvzL3X2WNS4jSUzzoI0h8Nn9LDpG7HZL
         Yn1JO1dxE/iXSsWAXS0hSR1c1jqfjInXAigrQa0TlWcDHbdafnqOF8N3lWmnqUYKut+v
         iE7y3KcHfEIjX/bNKJeNuyBa1klomMMQv3sAHypO8nJprt+8wnaQrN2+UE+z4dAU0xY+
         mDyB+aldyZzaXUv34rA0YKRlTqD1x97+E/M6oezD0gMXgxm8m9kW2hbtb8quuDccO+yK
         AwBQ==
X-Gm-Message-State: APjAAAV8gA0Zvi+QPvQjAb13/WqMkbwceLekCUYZp51DPJI1JnfVzamJ
        KSoZuTSpu1Nf94izgPT0Ew9Vo9Ee3KVLbdSU490=
X-Google-Smtp-Source: APXvYqwudGqQtAGQ/mdo9O9aYgrY41DjzyUYTaFgCuYhAngb4XOtYnuAcRvEV0p6+cpmvVxS7sQauT29U9uwWxGOV4k=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr16158854qvd.161.1551733939063;
 Mon, 04 Mar 2019 13:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20190304200412.1269035-1-arnd@arndb.de> <CAFCwf132vLS4jkc6QriNmV8bf4LzRGCyKXkdxQteJPcwuJBjUg@mail.gmail.com>
In-Reply-To: <CAFCwf132vLS4jkc6QriNmV8bf4LzRGCyKXkdxQteJPcwuJBjUg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Mar 2019 22:12:02 +0100
Message-ID: <CAK8P3a1ak3kXSXGbDMRTJdGStDJybxusq0vkqsjcWiG_kLWkRg@mail.gmail.com>
Subject: Re: [PATCH] misc: habanalabs: avoid HWMON dependency
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 9:21 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Mon, Mar 4, 2019 at 10:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > When CONFIG_HWMON is disabled, we currently get a link error for this driver:
> >
> > ERROR: "hwmon_device_unregister" [drivers/misc/habanalabs/habanalabs.ko] undefined!
> > ERROR: "hwmon_device_register_with_info" [drivers/misc/habanalabs/habanalabs.ko] undefined!
> >
> > As the hardware monitoring is not a required part of the functionality,
> > make it possible to compile without HWMON by ignoring all that functionality
> > depending on the configuration.

> Hi Arnd,
> I sent a patch to gkh to fix this last week (and he merged that into
> his tree), but I took a different approach of selecting HWMON in
> kconfig (with an added depends on of HAS_IOMEM to prevent dependency
> breakage).
> I don't really want the driver to load without HWMON support. I took
> the example from AMD's amdgpu driver which does the same thing.

Ok, that's fine, I see your fix now.

I tried to avoid doing this in Kconfig, as we already have a mix of 'depends on
HWMON' and 'select HWMON', which sooner or later is likely to cause
circular dependencies. Since you don't have any 'depends on' statements
so far, it's not a problem for you though.

      Arnd
