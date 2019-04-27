Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB2C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525632087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoXcNhpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfD0JbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:31:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36972 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfD0JbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:31:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id b12so3912946lji.4;
        Sat, 27 Apr 2019 02:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2xtrX11scqh+cRzN2quAd0Uoqkpc+pKxeVEhGWEdubw=;
        b=aoXcNhpjT/x3uR1XE+bhICtvbf+ZN/NP1Cbii0AZHiHz9ohC3e8/UdYH5KKV57avxT
         U/s/rcz+9lOoKAgj9GJRF8jvgKL94FHNAwxKQyjt11ZUHFo3/IPgawMW048+iQzhW9Sg
         HcPw0Siyh/8uVZ5Df/ur68YKbZNWtGNfHgajs8Jovv/I9IYWCj+xm842jfySLhn4DC8+
         XidLCjC54PCKUZwf9NbBOo+7lbNcJzqyKEncUIoQn8RrsBnWrmNFjrfl4h7ZP2SaDpML
         bAT18kND69zPruVZ58j8bwwU4+kKymY7gFlZUx7hbEQkkuH4TMHevsUUl7pmwfekfKQT
         ThGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2xtrX11scqh+cRzN2quAd0Uoqkpc+pKxeVEhGWEdubw=;
        b=N60sBI3vJPX5IVVSyhZPGI/yisOVZpNsubdRi2k9sKWZKQeGjnC+LFYrrwGD08Iey5
         xz4vL8aAeI9bK1aR/Ej0yS17u7raqBnGIkIRvxBICH5txCbR8awYr2UqgBW31bLMwLtC
         AEVnPF63rMUWDtgRFg5rR+3xO9X42saCw8SxQqbLNulMgiWaBztgGcsdJN6/ubmzMExj
         N5sac3aGMaErdKePzQBjfyNU42kZENDfPJCiamppsY10V0uFvs34fd8yXI7HTldNXoiU
         egoPhOAvtdQ1aA/IzQBTkDwmFoxFiuNu0kvvrbn6paEW59sZ5bs23AUf2w603GzR2401
         YP6g==
X-Gm-Message-State: APjAAAWVCnSFi6GhkQ8xsuPE3I2l4hzXElwjD8C1slAnmLO+wMOsl539
        243wpi93aXVufzdgkKazRDM=
X-Google-Smtp-Source: APXvYqwHzkqNjnZDV5DPpvHkGfvCAxFI/SoNZwQMwUhAU8am92FLbLJjiP8emlawSwnmFKPb3D1oZg==
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr28021304lje.22.1556357473968;
        Sat, 27 Apr 2019 02:31:13 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id h123sm5898839lfe.96.2019.04.27.02.31.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Apr 2019 02:31:13 -0700 (PDT)
Date:   Sat, 27 Apr 2019 12:31:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Message-ID: <20190427093110.3rx42ucv2zqjjnrp@mobilestation>
References: <20190424144914.10580-1-fancer.lancer@gmail.com>
 <20190426104650.30240-1-fancer.lancer@gmail.com>
 <20190427070042.GD28250@kroah.com>
 <20190427071025.hdrm3e5abnl4yock@mobilestation>
 <20190427073200.GB30973@kroah.com>
 <20190427073940.6yzhklfus4qd6ver@mobilestation>
 <20190427075323.GA31478@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427075323.GA31478@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 09:53:23AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 27, 2019 at 10:39:41AM +0300, Serge Semin wrote:
> > On Sat, Apr 27, 2019 at 09:32:00AM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Apr 27, 2019 at 10:10:27AM +0300, Serge Semin wrote:
> > > > On Sat, Apr 27, 2019 at 09:00:42AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Apr 26, 2019 at 01:46:50PM +0300, Serge Semin wrote:
> > > > > > SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
> > > > > > state. This is the mode the hub is supposed to be to let this driver
> > > > > > work correctly. But a race condition might happen right after reset
> > > > > > is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
> > > > > > function. In case if the reset pin is handled by a i2c GPIO expander,
> > > > > > which is also placed at the same i2c-bus segment as the usb251x
> > > > > > SMB-interface connected to, then the hub reset clearance might
> > > > > > cause the CFG_SEL[0] being latched in unpredictable state. So
> > > > > > sometimes the hub configuration mode might be 0x1 (as expected),
> > > > > > but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
> > > > > > interface activated and consequently causes this driver failure.
> > > > > > 
> > > > > > In order to fix the problem we must make sure the GPIO-reset chip doesn't
> > > > > > reside the same i2c-bus segment as the SMBus-interface of the hub. If
> > > > > > it doesn't, we can safely block the segment for the time the reset is
> > > > > > cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
> > > > > > connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
> > > > > > just return an error. If we locked the i2c-bus segment and tried to
> > > > > > communicate with the GPIO-expander, it would cause a deadlock. If we didn't
> > > > > > lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.
> > > > > > 
> > > > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > 
> > > > > I signed off on this?  Where?  When?
> > > > > 
> > > > > never add a s-o-b line that you did not create, that implies a legal
> > > > > agreement.
> > > > > 
> > > > 
> > > > Ah, shit. Sorry. I should have added Acked-by. That's what I was going to do,
> > > > since you already added the first version of this into linux-next tree. But
> > > > apparently copy-pasted and left as is...
> > > 
> > > If I have already applied a patch, I can't apply it again (or a
> > > different version.)  You need to send a fix-up patch for the reported
> > > issue, not a whole new one as I can not go back in time and rewrite
> > > history.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Ok. Should I send it in reply to this patch or as a completely separate one?
> 
> A separate one.

Just did this.

Two more questions.

Is there any online service or ready-to-use configs-gen-script to build
patchsets locally with various kernel configs before sending them for review?
By using this I'd most likely prevent such unfortunate mistakes in future
patches.

I suppose the situation like this isn't unique, and there are other patches
submitted with possible compilation problems. In this case seeing the linux-next
will be eventually integrated into the linux-stable, then at the point of those
patches the kernel source code will be build-broken corresponding config.
In this case wouldn't it be better to have some rebasable branch with build
robot service and fix the problematic patches in-place instead of
apply an incrementing commits? This also would keep the source code cleaner
at that particular commits.

-Sergey
