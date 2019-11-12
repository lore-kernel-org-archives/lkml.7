Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798AEC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDB4222CD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573597468;
	bh=CtCTGCjvAQEarrms2zb+0HcUcCEUZqvhzR3QZ6FlWpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NyoqfeIly1QJ+r6SAyzi68Lk+0LgHf/tR+E/hEFosWZrB6JrY74Tl0ixv0LG2u8Dg
	 TjlBqvBEqLEZdxHaUGgHuJFEoRB1ctKlV73VlOsX15y5eVNyEeVVYERbZvIvzWLQKM
	 1esG9KqUMkzJyxF8+ozOQWE+T1JFDoAIgw6j0cbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKLWY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:24:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32997 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLWYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:24:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so113659pfb.0;
        Tue, 12 Nov 2019 14:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ry7MlWHWsPiTlOdYnNj9Sx46aKAp4p8fIGij3YUbq4o=;
        b=RTCM3YsuRrBW1rSeGPMHQg1g+lNT6bOGCkb3Q07RPmw6sh5OfeM386QRjVFgVu/kLi
         oe7ucjtMpCMjw8BhzrZ9AM+8/+KUFtitMxXsG03P2p1hg74YHqnKVpRUxS9J5I19z0IA
         w8IH9+5SaJUwCjJHnaIUeGwOwmW8C4vLFzIJnQUD89npc+soZcURMXAu7o4rwhlb8V1u
         x0XMVTpxekcpRvezoBqC1noTgjCShaVbRzxGphO+GcYC6Lujv/gBL3pD6JXcdUJOQvQU
         DujfpatjoFJ1wsu0sDCdCoebrr4CFGUZ3VYFVCP2BFTKqBK8K+OarHiLQOeR4hDDmYkG
         PeNQ==
X-Gm-Message-State: APjAAAVZ+0iNipGWuqD3ZZpdYKT13SXPwxED9f4J5HbAgqFWWqxbzNI/
        4G43OlA0WDB/q2Mb7DtM+c4=
X-Google-Smtp-Source: APXvYqyQjg0WJFTXJX4TDREGWX/l6oBydGPSLvZPR83Gb1S+0oI6F/VbuxNKlHHytBATO8Dg89NbeA==
X-Received: by 2002:a63:d258:: with SMTP id t24mr37597711pgi.289.1573597465040;
        Tue, 12 Nov 2019 14:24:25 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c6sm20600076pfj.59.2019.11.12.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:24:23 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4625B403DC; Tue, 12 Nov 2019 22:24:23 +0000 (UTC)
Date:   Tue, 12 Nov 2019 22:24:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Juergen Gross <jgross@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tuowen Zhao <ztuowen@gmail.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Roman Gilg <subdiff@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] video: fbdev: atyfb: only use ioremap_uc() on i386 and
 ia64
Message-ID: <20191112222423.GO11244@42.do-not-panic.com>
References: <20191111192258.2234502-1-arnd@arndb.de>
 <20191112105507.GA7122@lst.de>
 <CAKMK7uEEz1n+zuTs29rbPHU74Dspaib=prpMge63L_-rUk_o4A@mail.gmail.com>
 <20191112140631.GA10922@lst.de>
 <CAKMK7uFaA607rOS6x_FWjXQ2+Qdm8dQ1dQ+Oi-9if_Qh_wHWPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFaA607rOS6x_FWjXQ2+Qdm8dQ1dQ+Oi-9if_Qh_wHWPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:26:35PM +0100, Daniel Vetter wrote:
> On Tue, Nov 12, 2019 at 3:06 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Tue, Nov 12, 2019 at 02:04:16PM +0100, Daniel Vetter wrote:
> > > Wut ... Maybe I'm missing something, but from how we use mtrr in other
> > > gpu drivers it's a) either you use MTRR because that's all you got or
> > > b) you use pat. Mixing both sounds like a pretty bad idea, since if
> > > you need MTRR for performance (because you dont have PAT) then you
> > > can't fix the wc with the PAT-based ioremap_uc. And if you have PAT,
> > > then you don't really need an MTRR to get wc.
> > >
> > > So I'd revert this patch from Luis and ...
> >
> > Sounds great to me..
> >
> > > ... apply this one. Since the same reasoning should apply to anything
> > > that's running on any cpu with PAT.
> >
> > Can you take a look at "mfd: intel-lpss: Use devm_ioremap_uc for MMIO"
> > in linux-next, which also looks rather fishy to me?  Can't we use
> > the MTRR APIs to override the broken BIOS MTRR setup there as well?
> 
> Hm so that's way out of my knowledge, but I think mtrr_cleanup() was
> supposed to fix up messy/broken MTRR setups by the bios. So maybe they
> simply didn't enable that in their .config with CONFIG_MTRR_SANITIZER.

I had originally suggested to just make the driver build on x86, but an
atlternative was to provide the call for the missing architecture.

> An explicit cleanup is currently not possible for drivers, since the
> only interface exported to drivers is arch_phys_wc_add/del (which
> short-circuits if pat works since you don't need mtrr in that case).

Right, the goal was to not call MTRR directly.

> Adding everyone from that commit, plus Luis. Drivers really shouldn't
> assume/work around the bios setting up superflous/wrong MTRR.

Such things are needed, otherwise some systems may not boot...

> > With that we could kill ioremap_uc entirely.
> 
> So yeah removing that seems definitely like the right thing.

I think this would be possible if we could flop ioremap_nocache() to UC
instead of UC- on x86. Otherwise, I can't see how we can remove this by
still not allowing direct MTRR calls.

  Luis
