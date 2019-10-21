Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0B9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC2E2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqsYQfQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfJUNBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:01:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38317 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUNBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:01:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id v9so2632694wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8ZUCK76p+L2E8XTaNFobsobEPp230uUztFZ+QUtxrJ0=;
        b=bqsYQfQLKVQEksQEka8qdQpOPv3Ecy1ekA081bTj5eFCNFe4tRrAwwR9PH9ag2FLhM
         o/GaIsZ4Z2z5CmY+sIlD7R3ELdggCmO0QeyoqbhsSNydKVlCUefXFaagUn0L3xAZhon5
         pqWBG5SD25e/zXBCFmRfXrijjd1E+DBFNYrczBqQkEwciC0n/JuP08iqFPm3CHLMyrAz
         xUled2mExTdgE3v8Y86UbpWGzvghEIALYj0sBwaWbrp5kvf5PtFbRK6AdEQIeU+/flBD
         ewk9bs7wOUJg2jEm2X2wXmpeqrCEZjpIWXm83cnSA0bQNtxqC4ZG9cJbTI/QVLtyBtny
         zudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8ZUCK76p+L2E8XTaNFobsobEPp230uUztFZ+QUtxrJ0=;
        b=qxsMUVDD/irgVe1CiAnJcGQUucmbBVboSbhWnvizRO4uuEB1+ht+9D9uYwWHVF7ytk
         hOZzbRD29E+ol0h8/HI/9o1jVo8QaMYuPSkvU+EYQ0IXcyRA7MLiS0gi8iipmwFT5v8K
         x+9YbaR+uASKgcp3rOPaom5oUcC67BE4AlLiaMjgAhOv3m6cXxSQEJViFMsrvRGb2QGb
         8NJPh5PcG073TE8rxHrGySDjSKFinQd4dIkbFy+YiFkQWCoSp0RL373D5jZVEeoDpe0t
         Zi+bREUP6fkI2b19TAt9h0/Ae52HyJv1SCiBopRwYRoexZLCDnfiu/KGFFIuWXvIPWky
         S5uw==
X-Gm-Message-State: APjAAAU+N8vn0oJxDpkPBm+7fXMCy2Xb81Az4KBxhDGlv2rLnPB22mR3
        FbcG0LYCI6oWzGMCUFNqYV/iIA==
X-Google-Smtp-Source: APXvYqxCVuBt/shwrkMerW0kYmwBSZSGSE1GeIcI+E/tc+cZf82WHNc4SssGKl6JqbUSFwEXQIWc2A==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr5033679wru.304.1571662873352;
        Mon, 21 Oct 2019 06:01:13 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id a192sm18678335wma.1.2019.10.21.06.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 06:01:12 -0700 (PDT)
Date:   Mon, 21 Oct 2019 14:01:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Barry Song <baohua@kernel.org>, stephan@gerhold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        James Cameron <quozl@laptop.org>
Subject: Re: [PATCH v2 0/9] Simplify MFD Core
Message-ID: <20191021130111.GI4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
 <e5e7695cc82b4370752f45082be007dbe410c74c.camel@v3.sk>
 <20191021115339.GF4365@dell>
 <ba31d7cb894cb44eacee630e56fae647922f3dc2.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba31d7cb894cb44eacee630e56fae647922f3dc2.camel@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Lubomir Rintel wrote:

> On Mon, 2019-10-21 at 12:53 +0100, Lee Jones wrote:
> > On Mon, 21 Oct 2019, Lubomir Rintel wrote:
> > 
> > > On Mon, 2019-10-21 at 13:29 +0200, Arnd Bergmann wrote:
> > > > On Mon, Oct 21, 2019 at 12:58 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > MFD currently has one over-complicated user.  CS5535 uses a mixture of
> > > > > cell cloning, reference counting and subsystem-level call-backs to
> > > > > achieve its goal of requesting an IO memory region only once across 3
> > > > > consumers.  The same can be achieved by handling the region centrally
> > > > > during the parent device's .probe() sequence.  Releasing can be handed
> > > > > in a similar way during .remove().
> > > > > 
> > > > > While we're here, take the opportunity to provide some clean-ups and
> > > > > error checking to issues noticed along the way.
> > > > > 
> > > > > This also paves the way for clean cell disabling via Device Tree being
> > > > > discussed at [0]
> > > > > 
> > > > > [0] https://lkml.org/lkml/2019/10/18/612.
> > > > 
> > > > As the CS5535 is primarily used on the OLPC XO1, it would be
> > > > good to have someone test the series on such a machine.
> > > > 
> > > > I've added a few people to Cc that may be able to help test it, or
> > > > know someone who can.
> > > > 
> > > > For the actual patches, see
> > > > https://lore.kernel.org/lkml/20191021105822.20271-1-lee.jones@linaro.org/T/#t
> > > 
> > > Thanks for the pointer. I'd by happy to test this.
> > > 
> > > Which tree do the patches apply to?
> > > Or, better, is there a tree with the patches applied that I could use?
> > 
> > Ideal.  Thank you.
> > 
> > http://git.linaro.org/people/lee.jones/linux.git/log/?h=topic/mfd-remove-clone-cs5535-mfd
> 
> Thanks. My boot attempt ends up in a panic [1]:

Ah yes, that makes sense.

I guess the subsystem doesn't like there being empty cells.

Please bear with me.

> [    2.090943] cs5535-gpio cs5535-gpio: reserved resource region [io  0x1000-0x10ff]
> [    2.129084] cs5535-mfgpt cs5535-mfgpt: reserved resource region [io  0x1800-0x183f]
> [    2.173457] cs5535-mfgpt cs5535-mfgpt: 8 MFGPT timers available
> [    2.200731] BUG: kernel NULL pointer dereference, address: 00000000
> [    2.210655] #PF: supervisor read access in kernel mode
> [    2.210655] #PF: error_code(0x0000) - not-present page
> [    2.210655] *pde = 00000000 
> [    2.210655] Oops: 0000 [#1] PREEMPT                                                                                                   
> [    2.210655] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc3-00013-gd8518b1ac7282 #17                                                
> [    2.210655] Hardware name: OLPC XO/XO, BIOS OLPC Ver 1.00.01 10/16/2019                                                               
> [    2.210655] EIP: strlen+0xb/0x17                                                                                                      
> [    2.210655] Code: c3 55 89 e5 56 89 c6 89 d0 88 c4 ac 38 e0 74 09 84 c0 75 f7 be 01 00 00 00 89 f0 48 5e 5d c3 55 89 e5 83 c9 ff 57 89 c7 31 c0 <f2> ae b8 fe ff ff ff 5f 29 c8 5d c3 85 c9 74 17 55 89 e5 57 89 c7
> [    2.210655] EAX: 00000000 EBX: 00000000 ECX: ffffffff EDX: ffffffff
> [    2.210655] ESI: c0d214a0 EDI: 00000000 EBP: ce487dd8 ESP: ce487dd4
> [    2.210655] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [    2.210655] CR0: 80050033 CR2: 00000000 CR3: 00e08000 CR4: 00000090
> [    2.210655] Call Trace:
> [    2.210655]  platform_device_alloc+0x11/0xb2
> [    2.210655]  mfd_add_devices+0x3c/0x285
> [    2.210655]  cs5535_mfd_probe+0x95/0x159
> [    2.210655]  ? cs5535_mfd_remove+0x2e/0x2e
> [    2.210655]  pci_device_probe+0x83/0xe9
> [    2.210655]  really_probe+0x16f/0x335
> [    2.210655]  driver_probe_device+0x113/0x148
> [    2.210655]  device_driver_attach+0x2e/0x41
> [    2.210655]  __driver_attach+0xe4/0xee
> [    2.210655]  ? device_driver_attach+0x41/0x41
> [    2.210655]  bus_for_each_dev+0x54/0x81
> [    2.210655]  driver_attach+0x14/0x16
> [    2.210655]  ? device_driver_attach+0x41/0x41
> [    2.210655]  bus_add_driver+0xe9/0x190
> [    2.210655]  ? max8925_i2c_init+0x2a/0x2a
> [    2.210655]  driver_register+0x87/0xb9
> [    2.210655]  ? max8925_i2c_init+0x2a/0x2a
> [    2.210655]  __pci_register_driver+0x37/0x3a
> [    2.210655]  cs5535_mfd_driver_init+0x14/0x16
> [    2.210655]  do_one_initcall+0x78/0x169
> [    2.210655]  ? do_early_param+0x75/0x75
> [    2.210655]  kernel_init_freeable+0xe6/0x16d
> [    2.210655]  ? rest_init+0x8e/0x8e
> [    2.210655]  kernel_init+0x8/0xd5
> [    2.210655]  ret_from_fork+0x2e/0x38
> [    2.210655] Modules linked in:
> [    2.210655] CR2: 0000000000000000
> [    2.210655] ---[ end trace b02c575c8463e16f ]---
> [    2.210655] EIP: strlen+0xb/0x17
> [    2.210655] Code: c3 55 89 e5 56 89 c6 89 d0 88 c4 ac 38 e0 74 09 84 c0 75 f7 be 01 00 00 00 89 f0 48 5e 5d c3 55 89 e5 83 c9 ff 57 89 c7 31 c0 <f2> ae b8 fe ff ff ff 5f 29 c8 5d c3 85 c9 74 17 55 89 e5 57 89 c7
> [    2.210655] EAX: 00000000 EBX: 00000000 ECX: ffffffff EDX: ffffffff
> [    2.210655] ESI: c0d214a0 EDI: 00000000 EBP: ce487dd8 ESP: ce487dd4
> [    2.210655] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [    2.210655] CR0: 80050033 CR2: 00000000 CR3: 00e08000 CR4: 00000090
> [    4.012823] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> [    4.022771] Kernel Offset: 0x0 from 0xc0400000 (relocation range: 0xc0000000-0xcf3fffff)
> [    4.022771] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
> 
> [1] http://v3.sk/~lkundrak/mfp.txt
> 
> Also:
> 
> There's a build warning, caused by "x86: olpc: Remove invocation of
> MFD's .enable()/.disable() call-backs" I suppose:
> 
> arch/x86/platform/olpc/olpc-xo1-pm.c: In function ‘xo1_pm_probe’:
> arch/x86/platform/olpc/olpc-xo1-pm.c:123:6: warning: unused variable ‘err’ [-Wunused-variable]
>   123 |  int err;
>       |      ^~~
> 
> I didn't look further into it. I'm happy to do so if necessary or try
> out a fix.
> 
> Take care
> Lubo
> 
> > 
> > > > > Lee Jones (9):
> > > > >   mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
> > > > >   mfd: cs5535-mfd: Remove mfd_cell->id hack
> > > > >   mfd: cs5535-mfd: Request shared IO regions centrally
> > > > >   mfd: cs5535-mfd: Register clients using their own dedicated MFD cell
> > > > >     entries
> > > > >   mfd: mfd-core: Remove mfd_clone_cell()
> > > > >   x86: olpc: Remove invocation of MFD's .enable()/.disable() call-backs
> > > > >   mfd: mfd-core: Protect against NULL call-back function pointer
> > > > >   mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
> > > > >   mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()
> > > > > 
> > > > >  arch/x86/platform/olpc/olpc-xo1-pm.c |   6 --
> > > > >  drivers/mfd/cs5535-mfd.c             | 124 +++++++++++++--------------
> > > > >  drivers/mfd/mfd-core.c               | 113 ++++--------------------
> > > > >  include/linux/mfd/core.h             |  20 -----
> > > > >  4 files changed, 79 insertions(+), 184 deletions(-)
> > > > > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
