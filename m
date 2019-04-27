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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDE9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26F6208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWxl1pZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfD0K6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:58:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfD0K6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:58:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id k2so5180581lje.10;
        Sat, 27 Apr 2019 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ppuLvnOuz4HsdaKpD/occ+nAGJVBu5RDFLqv0IaqQLI=;
        b=uWxl1pZ/2/k+z/eAEvUbGZhnnwdCF/FKjhGzmod+tTT7uAjrLtcyg2sMKF+CJ7/QrG
         lYPjxQslXJVAMQ6waLUP5tBNsQA7VwersZ/pl1/gd/dcIwY5brls5tJduWDA3DRUYRYl
         vDEyc3N2PrUzs0yIwHY5MWa5B4xSDrK35JZrDbHkzTrS6Kpe7H4s8SrMCf3KvHjdOQyj
         BD+Ilqnb6ckZqUDhY4ThuWMZIsvI0JiXiqwrG6mQ8C2C6do5TOYrLZMfgJw63boxC4oL
         BPMr6AcF+NXO5G4bABg0O0C1AGkNaD4CQoPhnkjZTMpz4lKpDoZ6pbw473G6MNJi0lEM
         7xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ppuLvnOuz4HsdaKpD/occ+nAGJVBu5RDFLqv0IaqQLI=;
        b=IM1pRlt6zzgIDeuwPSt3QfORoDH++rL3f4q/p4hhlblZs4thhZX0t1uyMBOyxUc2X+
         XGt+rgUMOhE/Uj/KGCRsM6fvYJ725avBoX6S9VrRr9FdpctBiC7l9HQGtz3irTHbHoRB
         qgvL3zLZPysoFKCPCv4ITtggzhEneMKWqTl3l0Dl9Ol5vLQsF4ZL+vm9/zjfmco5Jvzr
         cuicbK95GMIvLU5l3EvUY7rc5YHH1ufVBREpoepqvCTuEYd4/RfAXHX38POoArbQJuJ3
         fzmsC3KKoQ40sqKbAP2msLleIcWFKWbcfo2X1IZMWr/AXR8RC2lsNsbt/Ysfeu4ENq51
         eq/A==
X-Gm-Message-State: APjAAAXI64uD6/L7JkP17lCKsvOMqMnapeHE+uX2XHMyAMxtdatW4Z3b
        XOu9xzNGeu0burEf49H0qRNPWL4m
X-Google-Smtp-Source: APXvYqz2GAf8tfgQ2lxSmrUXsSPr1zvsUDYhL30wuobRtXd/mcAPSPUQ3z8kO4+EZ1NMqFR/xRVxQQ==
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr27808071ljk.131.1556362692534;
        Sat, 27 Apr 2019 03:58:12 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id 5sm6201784lfy.73.2019.04.27.03.58.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Apr 2019 03:58:11 -0700 (PDT)
Date:   Sat, 27 Apr 2019 13:58:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Message-ID: <20190427105808.a4jprilad3o7h54v@mobilestation>
References: <20190424144914.10580-1-fancer.lancer@gmail.com>
 <20190426104650.30240-1-fancer.lancer@gmail.com>
 <20190427070042.GD28250@kroah.com>
 <20190427071025.hdrm3e5abnl4yock@mobilestation>
 <20190427073200.GB30973@kroah.com>
 <20190427073940.6yzhklfus4qd6ver@mobilestation>
 <20190427075323.GA31478@kroah.com>
 <20190427093110.3rx42ucv2zqjjnrp@mobilestation>
 <20190427104500.GA26765@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427104500.GA26765@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:45:00PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 27, 2019 at 12:31:11PM +0300, Serge Semin wrote:
> > On Sat, Apr 27, 2019 at 09:53:23AM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Apr 27, 2019 at 10:39:41AM +0300, Serge Semin wrote:
> > > > On Sat, Apr 27, 2019 at 09:32:00AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Sat, Apr 27, 2019 at 10:10:27AM +0300, Serge Semin wrote:
> > > > > > On Sat, Apr 27, 2019 at 09:00:42AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Fri, Apr 26, 2019 at 01:46:50PM +0300, Serge Semin wrote:
> > > > > > > > SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
> > > > > > > > state. This is the mode the hub is supposed to be to let this driver
> > > > > > > > work correctly. But a race condition might happen right after reset
> > > > > > > > is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
> > > > > > > > function. In case if the reset pin is handled by a i2c GPIO expander,
> > > > > > > > which is also placed at the same i2c-bus segment as the usb251x
> > > > > > > > SMB-interface connected to, then the hub reset clearance might
> > > > > > > > cause the CFG_SEL[0] being latched in unpredictable state. So
> > > > > > > > sometimes the hub configuration mode might be 0x1 (as expected),
> > > > > > > > but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
> > > > > > > > interface activated and consequently causes this driver failure.
> > > > > > > > 
> > > > > > > > In order to fix the problem we must make sure the GPIO-reset chip doesn't
> > > > > > > > reside the same i2c-bus segment as the SMBus-interface of the hub. If
> > > > > > > > it doesn't, we can safely block the segment for the time the reset is
> > > > > > > > cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
> > > > > > > > connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
> > > > > > > > just return an error. If we locked the i2c-bus segment and tried to
> > > > > > > > communicate with the GPIO-expander, it would cause a deadlock. If we didn't
> > > > > > > > lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.
> > > > > > > > 
> > > > > > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > 
> > > > > > > I signed off on this?  Where?  When?
> > > > > > > 
> > > > > > > never add a s-o-b line that you did not create, that implies a legal
> > > > > > > agreement.
> > > > > > > 
> > > > > > 
> > > > > > Ah, shit. Sorry. I should have added Acked-by. That's what I was going to do,
> > > > > > since you already added the first version of this into linux-next tree. But
> > > > > > apparently copy-pasted and left as is...
> > > > > 
> > > > > If I have already applied a patch, I can't apply it again (or a
> > > > > different version.)  You need to send a fix-up patch for the reported
> > > > > issue, not a whole new one as I can not go back in time and rewrite
> > > > > history.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > Ok. Should I send it in reply to this patch or as a completely separate one?
> > > 
> > > A separate one.
> > 
> > Just did this.
> > 
> > Two more questions.
> > 
> > Is there any online service or ready-to-use configs-gen-script to build
> > patchsets locally with various kernel configs before sending them for review?
> > By using this I'd most likely prevent such unfortunate mistakes in future
> > patches.
> 
> 'make allmodconfig' works for me.  Also, the 0-day bot sometimes will
> test patches sent to the mailing list before they are applied, but that
> doesn't always work.
> 
> > I suppose the situation like this isn't unique, and there are other patches
> > submitted with possible compilation problems. In this case seeing the linux-next
> > will be eventually integrated into the linux-stable, then at the point of those
> > patches the kernel source code will be build-broken corresponding config.
> > In this case wouldn't it be better to have some rebasable branch with build
> > robot service and fix the problematic patches in-place instead of
> > apply an incrementing commits? This also would keep the source code cleaner
> > at that particular commits.
> 
> As this passed the first round of 0-day testing in my rebasable branch,
> I assumed it was good enough.  But later testing found that not to be
> the case, which is pretty rare.  And I can't have public trees that are
> rebasable as people work off of them, so we can just live with fixing
> this up.
> 
> thanks,
> 
> greg k-h

Ok. Thanks for clarification. Next time I'll use the allmodconfig for a generic
build-test and, as there aren't other way, try to anticipate a possible configs
disabling issues.

-Sergey
