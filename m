Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8615C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D26720673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnZvPVa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfD2SVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:21:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40699 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbfD2SVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:21:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so5542208pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1LpOQr9D5bQgwPLNE6mNhwOUBh1r8osOqn3zrrKXTa4=;
        b=YnZvPVa+jGuvpz3XgkIvlqZjxADTyAdRhDERPZOoN7xwPQW9AWBRDAYzgx3C69/Mxb
         I/CqBmvrbhU5QOLjEnGNRxRpaJp2QKZUunY3BK/lk2qc1nAghRplhBhSXaGYiyG8ud81
         xOovGYbfYmD+DXFo0sDnsDaTJSzBHr45uqMDLGeW95KTtGH9KYg6qZAsbybf7zA0jSL8
         g2AH5K9jbX4iOx8/heYicjxOgZAZieBJBz+5pY4k29NCcOmMcC417Ximz1r+q+fvHPd3
         gXgBdam+tznYLXVxk38GFn6vp8ODvAoxiPHZkygEMXHhJLfc7XVQWWOhaH2ruDsf2f/o
         fKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1LpOQr9D5bQgwPLNE6mNhwOUBh1r8osOqn3zrrKXTa4=;
        b=rEFBEmRQ3nPXM8It3xuExzR0j9w50qC6P7lnkhbaz5U0sqWBudrflwkWGI/KVzGuw4
         z4wuF1CVVW8IHZlAvhMkOlbLbZKJDqRz/y1c2XXzGdMwf3AgJYLPYMa4NR7FYEh7uU4P
         PRfQ1VQStPjoG2lu1ruY0rMtTmrwlSLbZSP+BFf3t+SeldCpquSJyUAM7vg38cyMwpfD
         7D6mebZnVbZyErYJFxy8mZnoksw4xyLdhKaa4RkBC1mgE+QtuMeeaofJR6+QLFw8qypV
         oxxupUhAZRCqaQBIFMIMiR/Kn/N4+xsOv+L/kNzqvpbZO8K9TxEH1pFxt8BU8JRcNj1X
         0ryA==
X-Gm-Message-State: APjAAAVki+ADWAufS5y8OVEqIY5fxUIznHYRyZb1/zGqH4Sue2lYQfxj
        8LbIJu9DGLI41XjTWheW5iwaCVby
X-Google-Smtp-Source: APXvYqx+2Mz/IDYnoHKuV8qf1KIBQG8azXXVGiooj4GNIFsdV466QyajZhzGM3ad6iAhbKtsQsAKtg==
X-Received: by 2002:a65:5c82:: with SMTP id a2mr10400160pgt.378.1556562061101;
        Mon, 29 Apr 2019 11:21:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m131sm66420883pga.3.2019.04.29.11.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 11:20:59 -0700 (PDT)
Date:   Mon, 29 Apr 2019 11:20:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        alexander.deucher@amd.com, tsoni@codeaurora.org,
        psodagud@codeaurora.org, jshriram@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: Fix the usage of platform device
 name(pdev->name)
Message-ID: <20190429182058.GA31126@roeck-us.net>
References: <1555978589-4998-1-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555978589-4998-1-git-send-email-vnkgutta@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 22, 2019 at 05:16:29PM -0700, Venkata Narendra Kumar Gutta wrote:
> Platform core is using pdev->name as the platform device name to do
> the binding of the devices with the drivers. But, when the platform
> driver overrides the platform device name with dev_set_name(),
> the pdev->name is pointing to a location which is freed and becomes
> an invalid parameter to do the binding match.
> 
> use-after-free instance:
> 
> [   33.325013] BUG: KASAN: use-after-free in strcmp+0x8c/0xb0
> [   33.330646] Read of size 1 at addr ffffffc10beae600 by task modprobe
> [   33.339068] CPU: 5 PID: 518 Comm: modprobe Tainted:
> 			G S      W  O      4.19.30+ #3
> [   33.346835] Hardware name: MTP (DT)
> [   33.350419] Call trace:
> [   33.352941]  dump_backtrace+0x0/0x3b8
> [   33.356713]  show_stack+0x24/0x30
> [   33.360119]  dump_stack+0x160/0x1d8
> [   33.363709]  print_address_description+0x84/0x2e0
> [   33.368549]  kasan_report+0x26c/0x2d0
> [   33.372322]  __asan_report_load1_noabort+0x2c/0x38
> [   33.377248]  strcmp+0x8c/0xb0
> [   33.380306]  platform_match+0x70/0x1f8
> [   33.384168]  __driver_attach+0x78/0x3a0
> [   33.388111]  bus_for_each_dev+0x13c/0x1b8
> [   33.392237]  driver_attach+0x4c/0x58
> [   33.395910]  bus_add_driver+0x350/0x560
> [   33.399854]  driver_register+0x23c/0x328
> [   33.403886]  __platform_driver_register+0xd0/0xe0
> 
> So, use dev_name(&pdev->dev), which fetches the platform device name from
> the kobject(dev->kobj->name) of the device instead of the pdev->name.
> 
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>

This patch results in a large number of crashes (statistics: total: 349
pass: 244 fail: 105) in my boot tests (https://kerneltests.org/builders).
Affected architectures are (at least) arm, m68k, mips, ppc, and sh.
The reason for the crash is different for each architecture. Sometimes
the boot will stall, sometimes there is a crash, and sometimes the system
will fail to restart.

Here is an example for a log message, seen on arm (and m68k, but with ttyS
instead of ttySA).

WARNING: CPU: 0 PID: 1 at drivers/tty/tty_io.c:1349 tty_init_dev+0x14c/0x1a4
tty_init_dev: ttySA driver does not set tty->port. This will crash the kernel later. Fix the driver!

This is then indeed followed by a crash in tty_init_dev().

Bisect log for m68k attached below. Reverting this patch fixes the
problem at least for arm, m68k, and mips images.

Guenter

---
# bad: [3d17a1de96a233cf89bfbb5a77ebb1a05c420681] Add linux-next specific files for 20190429
# good: [085b7755808aa11f78ab9377257e1dad2e6fa4bb] Linux 5.1-rc6
git bisect start 'HEAD' 'v5.1-rc6'
# good: [48ea994d711ca2e66038741e549f3ebd3072e215] Merge remote-tracking branch 'crypto/master'
git bisect good 48ea994d711ca2e66038741e549f3ebd3072e215
# good: [2d49c5dbbd93045625927b6acf54bf43f86f97fd] Merge remote-tracking branch 'spi/for-next'
git bisect good 2d49c5dbbd93045625927b6acf54bf43f86f97fd
# bad: [7d38461c1c19569f7952c66913b38a78b2c51828] Merge remote-tracking branch 'staging/staging-next'
git bisect bad 7d38461c1c19569f7952c66913b38a78b2c51828
# bad: [b827800209cf30ed4e2d3a503044014b56f2b06f] Merge remote-tracking branch 'tty/tty-next'
git bisect bad b827800209cf30ed4e2d3a503044014b56f2b06f
# good: [e643fe145f03134a9de2b8996e11e03b8a0cd90a] Merge remote-tracking branch 'tip/auto-latest'
git bisect good e643fe145f03134a9de2b8996e11e03b8a0cd90a
# good: [cac573af020fbe8b16c1c769ed692126b8eceb69] Merge remote-tracking branch 'ipmi/for-next'
git bisect good cac573af020fbe8b16c1c769ed692126b8eceb69
# good: [ad74b8649beaf1a22cf8641324e3321fa0269d16] usb: typec: ucsi: Preliminary support for alternate modes
git bisect good ad74b8649beaf1a22cf8641324e3321fa0269d16
# bad: [9dc730c74af21b8403a9befba0f5f2e3bd9d6be4] Merge remote-tracking branch 'usb/usb-next'
git bisect bad 9dc730c74af21b8403a9befba0f5f2e3bd9d6be4
# good: [ab3a9f2ccc080d27873f76869c9a780be45e581e] acpi/hmat: fix an uninitialized memory_target
git bisect good ab3a9f2ccc080d27873f76869c9a780be45e581e
# good: [70283454c918f1d65de0ec50c45ef592d781bcae] livepatch: Replace klp_ktype_patch's default_attrs with groups
git bisect good 70283454c918f1d65de0ec50c45ef592d781bcae
# good: [33e39350ebd20fe6a77a51b8c21c3aa6b4a208cf] usb: xhci: add Immediate Data Transfer support
git bisect good 33e39350ebd20fe6a77a51b8c21c3aa6b4a208cf
# good: [5afa0a5ed3da85f64f27613a38daa1c4f69dd8ff] usb: xhci: add endpoint context tracing when an endpoint is added
git bisect good 5afa0a5ed3da85f64f27613a38daa1c4f69dd8ff
# bad: [a85b96e9e11d97a1fb4a683030d6aa98e1a872e8] Merge remote-tracking branch 'driver-core/driver-core-next'
git bisect bad a85b96e9e11d97a1fb4a683030d6aa98e1a872e8
# bad: [edb16da34b084c66763f29bee42b4e6bb33c3d66] driver core: platform: Fix the usage of platform device name(pdev->name)
git bisect bad edb16da34b084c66763f29bee42b4e6bb33c3d66
# first bad commit: [edb16da34b084c66763f29bee42b4e6bb33c3d66] driver core: platform: Fix the usage of platform device name(pdev->name)
