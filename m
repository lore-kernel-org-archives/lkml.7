Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B598C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB90020675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SpTxWnNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfD2RHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:07:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37670 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfD2RHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:07:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id b12so8885193lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YeKK3tAfy5x+3pFMDByyIL1i7Necl4Ot8V4uzh6dPdI=;
        b=SpTxWnNXCT+s7eNFLiBVrhtEPFWtmdu0QV5L9p4KNsv8soOLUaV7vq7TgE8vGgM+sc
         //ZqQu3TjxSrZycLZJXRoccECIY2xm9wxF92OvuZrTbZ7qqLlFjsp6LR5ixPsPAukXXw
         cWBjtTSRskVqm6pjgQsYuPUQ18Zw2ywbwr5mTOX2X/OXIqdRhKT/rR0QfvGYhF6/MA3P
         mfZ1+2b4XfT0zwXc/FzIlna+GiQ0pnsstcwAFj79OddVAskq1Y/vBPe3ghVRQjuRlAxD
         7KwSilnAsQjLlGU+5fxwimueGL8UCDf4rpFTDZRQhg9UvCwus5/SU6uK6iWjxQhq4Hxc
         9uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YeKK3tAfy5x+3pFMDByyIL1i7Necl4Ot8V4uzh6dPdI=;
        b=DKPDcDv9Mf20MiJnnnFJbthQMiGw1mMKw3/8q5FPHfl7ttrRWAy16Pj8KLX9EOHL0J
         +oQ8ORM63feJy8AuqtKGAsDowdnIYsdpc3BjlP3pHaWoMz6akBUhws6Lv21Mg9xD4jaZ
         KQ31eCLxu5a1H7UuMBzxMMD7LEdBdqknf3bQWvsfiT8mrhPM05ezjtmToNFVlzqXopQd
         NlhMzDRdqV5wvESTI4vZH6jDO6XbSfc/kfMOu6AeOMbVdWnGvzNuXLg6fo73MCKt2OBq
         r/Wy+UHZUpNWpGRiS6+jVD4w9OG8C9I2E9Cz1hmEB0Ex5eTy36TpYlpPyat56LlaLjO2
         oUmg==
X-Gm-Message-State: APjAAAVNNbj42cweMjyfpF2BQ1wuUi5VjRJqQQXheGdjku/q3IUdaFAC
        4Bw3oGpYDTIIByJYMJpF6pa/3g==
X-Google-Smtp-Source: APXvYqxr2kAiL2bmKb1U2ragx5zvjsV94YGmZpTib0GYs7NAZyHDj9Or280CmF4buq1qXwRq5LKh4Q==
X-Received: by 2002:a2e:7503:: with SMTP id q3mr32471107ljc.190.1556557665256;
        Mon, 29 Apr 2019 10:07:45 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id h14sm6902864ljg.10.2019.04.29.10.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:07:43 -0700 (PDT)
Date:   Mon, 29 Apr 2019 09:31:27 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Patrick Venture <venture@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>
Subject: Re: [PATCH] soc: add aspeed folder and misc drivers
Message-ID: <20190429163127.r6k7yfriz5ha5xul@localhost>
References: <20190422173838.182736-1-venture@google.com>
 <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
 <CAO=notxuYsBzWBnNran5jH0RujSBeti6-HsjasCRP6Sq0MwGNA@mail.gmail.com>
 <CAK8P3a24h=0JLZnZWOmzRqM70uhw3QZ_HcYDXST7F6TgSuW6YA@mail.gmail.com>
 <CAO=noty2QN6H_x3RMjqOrY9b0xLLz=MBk6Fb6yCdW9+J0a-bSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO=noty2QN6H_x3RMjqOrY9b0xLLz=MBk6Fb6yCdW9+J0a-bSA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 08:40:25AM -0700, Patrick Venture wrote:
> On Tue, Apr 23, 2019 at 8:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Apr 23, 2019 at 4:24 PM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Tue, Apr 23, 2019 at 1:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Mon, Apr 22, 2019 at 7:38 PM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > currently present into this folder.  These drivers are not generic part
> > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > >
> > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > >
> > > > Looks ok, but please resend to arm@kernel.org or soc@kernel.org
> > > > so we can track the submission and make sure it gets applied if
> > > > you want this to go through the arm-soc tree.
> > >
> > > Thanks, I didn't see those come up in the get_maintainers output.
> > >
> > > I had a longer question related to this patch progression -- if I am
> > > moving the aspeed gpio driver to the soc folder, the soc tree may have
> > > the soc/aspeed folder in their next, but the gpio tree wouldn't
> > > necessarily.  I know the branches sync up when things are merged at
> > > the top, but I wasn't sure if there was another mechanism for this?
> >
> > We can generally deal with merge conflicts like this, or you can ask
> > the respective maintainers about it and let us figure something out.
> 
> Thanks for explaining that.
> 
> >
> > In this particular case, why would you move the gpio driver into
> > the soc folder? If there is a proper subsystem for a driver, it should
> > not be in drivers/misc or drivers/soc.
> 
> Ok, that makes sense. I was trying to get a sense of what belonged in
> soc versus the subsystem folders.  My thinking from the limited
> reading was the purpose of a SoC folder was to contain the drivers
> that were only associated with a system-on-a-chip and not a part you
> could buy and place on any board.  A tmp421 sensor is just a generic
> part, versus the pwm controller, which is only for the specific SoCs.
> 
> That said, there are quite a few misc drivers associated with the
> Aspeed parts -- and there are two under review now, so there's a
> strong motivation to move those at least into the soc/aspeed folder.
> Thanks for these clarifying remarks.

drivers/soc is more about platform-level glue and SoC configuration, etc.
Specific IP blocks and drivers normally don't go into there, unless it's
a shared resource that a lot of drivers need access to.

So, for most of the small drivers around the SoC, other directories than
drivers/soc are still the best answer.


-Olof
