Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05625C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C975C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g94yYYWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfDWT0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:26:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41503 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDWT0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:26:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so2076154pls.8;
        Tue, 23 Apr 2019 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WP4G9WVvvp7Zl7pFv+60wIUYSGE55jMf3NxRJJgk0Zs=;
        b=g94yYYWtPzN3KItE0dHLdgZjwmUjS81wxZPNGUHOao3GkMLE7f7WcC83SiEI6xv3st
         y6artZcMRQFDBxVGwrsomyVUggNi574kfxZAvZbaoByv/f+tGyG8g/lCVX1MHH0yR5r9
         HpRb918nv8lbBcn4ai6fqBNg5ABxR3W9ir1a2pwdorM/RHR9oizcIRtfWSTsdnmbue/d
         any+DGZn3iYqInTjnv7xnBak0neOOlLge3ziTkstwBMvRlwCl9m0iPCLNgHUH9sA7wEK
         g/ky/YvxHmvGHoXlGu+9Uirxm38ilaFMgC/nAruAHYmf2Vw+Ot1eDcI8ZIoV+6XORpKK
         4Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WP4G9WVvvp7Zl7pFv+60wIUYSGE55jMf3NxRJJgk0Zs=;
        b=khFGqbsC9kmYsDYn0B8z4PF4VnR622MgJ2Ro6R9INJi0tTk615P/I4ZMGgMTrNYYql
         u4NwjeGD+krMw+TGqZgdHXmhHMoydNQBdVfHnUVDOt6ul0Sviz5imubCnsPSXrbL+Iu/
         wcmx4Zsd5UGh8780+F5V++KJE40/rlEb9Mo7edHtvdS4au8/pr5wOeKfs/wUMJeKqmHA
         KW2MMrttTaV8MdwTE+goarHnKrxlUwWSOfEhwg851dyXPrdsHbdOVeJbtubHGM8nFTxl
         6rkiz8ip8xuaDw6dUuT0gK6g0S90f7jI3Z3Nol6ADxoCfh6mDt6tBeGmauN9GBYEfPNv
         Gljg==
X-Gm-Message-State: APjAAAWb99Pb5WRjrXY3tJQOuet8wwrjKoL9FB77ui2qj9+PIFluciTX
        dpBBFstS9udMh90dO0+2Svc=
X-Google-Smtp-Source: APXvYqxiLOU0uzqgpoBn4qc2AfapWOsdpcKwydK62dx+OoQGCiK8q5YWXfYLqO5JkBThl6ctYbsylw==
X-Received: by 2002:a17:902:9341:: with SMTP id g1mr28409829plp.81.1556047570085;
        Tue, 23 Apr 2019 12:26:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm18298380pgl.2.2019.04.23.12.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 12:26:08 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:26:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 9/9] clk: fixed-factor: Let clk framework find parent
Message-ID: <20190423192607.GA27297@roeck-us.net>
References: <20190412183150.102131-1-sboyd@kernel.org>
 <20190412183150.102131-10-sboyd@kernel.org>
 <20190423180922.GA3463@roeck-us.net>
 <155604377791.15276.4869998549466063176@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155604377791.15276.4869998549466063176@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:22:57AM -0700, Stephen Boyd wrote:
> Quoting Guenter Roeck (2019-04-23 11:09:22)
> > Hi,
> > 
> > On Fri, Apr 12, 2019 at 11:31:50AM -0700, Stephen Boyd wrote:
> > > Convert this driver to a more modern way of specifying parents now that
> > > we have a way to specify clk parents by DT index. This lets us nicely
> > > avoid a problem where a parent clk name isn't know because the parent
> > > clk hasn't been registered yet.
> > > 
> > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > 
> > This patch causes a substantial number of crashes of qemu boot tests in -next.
> > 
> > Failed tests: 
> >         arm:versatilepb:versatile_defconfig:aeabi:pci:scsi:mem128:versatile-pb:rootfs 
> >         arm:versatilepb:versatile_defconfig:aeabi:pci:mem128:versatile-pb:initrd 
> >         arm:versatileab:versatile_defconfig:mem128:versatile-ab:initrd 
> >         arm:beagle:multi_v7_defconfig:sd:mem256:omap3-beagle:rootfs 
> >         arm:beaglexm:multi_v7_defconfig:sd:mem512:omap3-beagle-xm:rootfs 
> >         arm:overo:multi_v7_defconfig:sd:mem256:omap3-overo-tobi:rootfs 
> >         arm:realview-pb-a8:realview_defconfig:realview_pb:mem512:arm-realview-pba8:initrd 
> >         arm:realview-pbx-a9:realview_defconfig:realview_pb:arm-realview-pbx-a9:initrd 
> >         arm:realview-eb:realview_defconfig:realview_eb:mem512:arm-realview-eb:initrd 
> >         arm:realview-eb-mpcore:realview_defconfig:realview_eb:mem512:arm-realview-eb-11mp-ctrevb:initrd 
> >         arm:integratorcp:integrator_defconfig:mem128:integratorcp:initrd 
> >         arm:mps2-an385:mps2_defconfig:mps2-an385:initrd
> > 
> > Most of the time the crash happens too early to generate a log,
> > but here is one:
> > 
> > [    0.000000] [<2100bd59>] (unwind_backtrace) from [<2100b11f>] (show_stack+0xb/0xc)
> > [    0.000000] [<2100b11f>] (show_stack) from [<211b2d27>] (Ldiv0_64+0x9/0x1a)
> > [    0.000000] [<211b2d27>] (Ldiv0_64) from [<21038e87>] (clocks_calc_max_nsecs+0x1d/0x62)
> > [    0.000000] [<21038e87>] (clocks_calc_max_nsecs) from [<21038fb1>] (__clocksource_update_freq_scale+0xe5/0x11c)
> > [    0.000000] [<21038fb1>] (__clocksource_update_freq_scale) from [<21038ff1>] (__clocksource_register_scale+0x9/0x40)
> > [    0.000000] [<21038ff1>] (__clocksource_register_scale) from [<212a8713>] (mps2_timer_init+0xaf/0x29c)
> > [    0.000000] [<212a8713>] (mps2_timer_init) from [<212a85b1>] (timer_probe+0x49/0x80)
> > [    0.000000] [<212a85b1>] (timer_probe) from [<2129d639>] (start_kernel+0x1c5/0x2f4)
> > [    0.000000] [<2129d639>] (start_kernel) from [<00000000>] (  (null))
> > [    0.000000] clocksource: mps2-clksrc: mask: 0xffffffff max_cycles: 0x0, max_idle_ns: 0 ns
> > [    0.000000] Division by zero in kernel.
> > 
> > Reverting the crash fixes the problem. Bisect log attached.
> > 
> 
> Thanks for the report. This was bisected yesterday by kernelci.org (see
> https://lkml.kernel.org/r/5cbe596c.1c69fb81.e252.b9d0@mx.google.com for
> more details). Can you try the latest version of clk-next and see if it
> fixes the early crashes? The one-liner patch I attached in that thread
> should be all you need.
> 
Yes, it done. Thanks for taking care of it.

> It would be even better for kernelci to find the offending patch like
> you've done here and reply to the patch on the mailing list.
> 
> Finally, can you share your qemu recipe? I can pull it into my testing
> and integration workflow so that this doesn't happen again.
> 

It is all available at https://github.com/groeck/linux-build-test/.
You would need an out-of-tree version of qemu to test mps2-an385, though;
upstream qemu rejected the patches necessary to make it work for testing
linux kernel images.

Guenter
