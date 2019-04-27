Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56379C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2C42077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyNhqd7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfD0Hjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:39:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38915 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0Hjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:39:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id q10so4946553ljc.6;
        Sat, 27 Apr 2019 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fXcEH7OJ8FWzh8s3XkFV877uoQzt44Jmxr57/NuoqxM=;
        b=ZyNhqd7JRBxFpNhUKrqtVU3AKBA4k6nvnMVwa6TQm0tiXAt2fN0iJjp/UNrTT7L6bm
         qcne//Bt4htVOofI/b61DA7CYB9x/kmAqGkD6QSzvSuXUjV+X3njqj0N1F8f3DChKS5k
         s44XPmTG3GHOxIKlGs0N1Vl/6GiAp7RRfdphL3GyMUlTAIDWqbSfW8rogB5bT3a9jANA
         HT7mMpmUo/Grkd2ML4DhAi2g/mjRYNLX3rSCHNzCshLxw3qF7lnEJaZpnsBXAcexmccn
         ZwWTKAs3/pM55ZG91aofhcacseg/oyzaX7N6JjpMTDkKqs+TjtFc27FAuHAnOrMRq+Xr
         KlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXcEH7OJ8FWzh8s3XkFV877uoQzt44Jmxr57/NuoqxM=;
        b=Bh9uN2esMKdIfTpaficECtSpJP5JB03lsVCM6CD8JJVjAHmxodjw8QioiDdtghMD6I
         rlyqbHyi0729LfPMaPC6YEwQyS8Iko7vkGeSCrNFUgIDiQcPUUD4YRapbDKTZzWaqHtx
         bDJyyM4z6URXk3BN60jhe6X49QhtzHri+GJKfaV6IA+KQRJrE2t/MG1VJfC6NIzzPpiw
         v5RZkhVZbk9uL5OcS2NssXPhza8SsotpShgn3nAPW8HKv2LRV65Lrjas1CYZhk4UFyWj
         wLZGK/FxOagxBAX5ZvRtMRNcxJWvMgo90jEeZzQR6IsPt8BZt3Wrzz4HhR0j9UrXT58Z
         dyHg==
X-Gm-Message-State: APjAAAWzAF5N1ObizsMQ/Jf42Glu4MIMW/LD6HHq5yPOgQbQQKyK5akG
        pbQj09HLgRx8TOSzyCwVMro=
X-Google-Smtp-Source: APXvYqwktXzIxlW1qCq4po2h/4I0c4zGJ1GNi6o3gGG8FTbeR35vFn66pSlFk/E6X+6iUs9FBB7Q+Q==
X-Received: by 2002:a05:651c:106:: with SMTP id a6mr1529672ljb.157.1556350784138;
        Sat, 27 Apr 2019 00:39:44 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id f25sm6116354lfc.46.2019.04.27.00.39.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Apr 2019 00:39:43 -0700 (PDT)
Date:   Sat, 27 Apr 2019 10:39:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Message-ID: <20190427073940.6yzhklfus4qd6ver@mobilestation>
References: <20190424144914.10580-1-fancer.lancer@gmail.com>
 <20190426104650.30240-1-fancer.lancer@gmail.com>
 <20190427070042.GD28250@kroah.com>
 <20190427071025.hdrm3e5abnl4yock@mobilestation>
 <20190427073200.GB30973@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427073200.GB30973@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 09:32:00AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 27, 2019 at 10:10:27AM +0300, Serge Semin wrote:
> > On Sat, Apr 27, 2019 at 09:00:42AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 26, 2019 at 01:46:50PM +0300, Serge Semin wrote:
> > > > SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
> > > > state. This is the mode the hub is supposed to be to let this driver
> > > > work correctly. But a race condition might happen right after reset
> > > > is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
> > > > function. In case if the reset pin is handled by a i2c GPIO expander,
> > > > which is also placed at the same i2c-bus segment as the usb251x
> > > > SMB-interface connected to, then the hub reset clearance might
> > > > cause the CFG_SEL[0] being latched in unpredictable state. So
> > > > sometimes the hub configuration mode might be 0x1 (as expected),
> > > > but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
> > > > interface activated and consequently causes this driver failure.
> > > > 
> > > > In order to fix the problem we must make sure the GPIO-reset chip doesn't
> > > > reside the same i2c-bus segment as the SMBus-interface of the hub. If
> > > > it doesn't, we can safely block the segment for the time the reset is
> > > > cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
> > > > connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
> > > > just return an error. If we locked the i2c-bus segment and tried to
> > > > communicate with the GPIO-expander, it would cause a deadlock. If we didn't
> > > > lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.
> > > > 
> > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > I signed off on this?  Where?  When?
> > > 
> > > never add a s-o-b line that you did not create, that implies a legal
> > > agreement.
> > > 
> > 
> > Ah, shit. Sorry. I should have added Acked-by. That's what I was going to do,
> > since you already added the first version of this into linux-next tree. But
> > apparently copy-pasted and left as is...
> 
> If I have already applied a patch, I can't apply it again (or a
> different version.)  You need to send a fix-up patch for the reported
> issue, not a whole new one as I can not go back in time and rewrite
> history.
> 
> thanks,
> 
> greg k-h

Ok. Should I send it in reply to this patch or as a completely separate one?

-Sergey
