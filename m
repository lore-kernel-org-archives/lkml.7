Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C807E24682
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576673512;
	bh=OGeWCNrFfD3XbU8HvErvic6TR8LSAkME11zKooJQHIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aAUTDIc/eQfb7Dw9Cu37eMgy+vNk15oouEHuLux+BZsSj2sWKF9lHN5uTdnrCfw/F
	 GX+Zpjv96lPo5RX5uVU1vRxkSJnuYnZZbGWKK0DZqC5SZ/1CDgvesnWwzfr+dN4hH4
	 2flXVNWtEaHEegaKySgBGxlvsMjMbojsyiCN2q+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLRMvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:51:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37096 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfLRMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:51:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id u17so2007224lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 04:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=irtOki5drNY4QwDIOruEdgQSE/oxagWMtPYoIr3h9ZQ=;
        b=WYAiXmnk2FxuW3mUWBCo6KyP7jc5mOY+g6u0B23lR3rB932TsoM3N56lesOdA8jky8
         Ycvu06UlVYQHD+tvT3Fwt8p577EaZaixP29fWRR/u3ju9cj2+TX3WBTkV0UrI2SHbACa
         ypMaWZc7zvuot44fOKx5tX2ocqCjoKh34zrApaVq6LvewTc16tkAbG5+ztT7RUrw4IFt
         U/0iUn7eqmmfeffwt22qOvFh9ddJZ8IYQtHeCgQuuFh4V4NUQ6cPNyBXvaaGNXVBObZG
         Ohm5sqKsswDXsLF7/DjwuSboktuPkqROQOolvqBlTCRHFG5gkdXZLBIapqj9C1YoeztM
         pVrw==
X-Gm-Message-State: APjAAAVDbSGaqeQ7uc4sqA3wQrTn/vuBw7VeQTv9Gq545EmwD15BE2OP
        obZyr0z/9ag5r88kgLnlm/8=
X-Google-Smtp-Source: APXvYqy07x1FsKiDMiFWfQad7z/SsOw5OTyMCzOmEhY1SojsA04+3MKgjmQWrwGL6UlJkqY+CHtlcQ==
X-Received: by 2002:a2e:8916:: with SMTP id d22mr1621368lji.19.1576673509062;
        Wed, 18 Dec 2019 04:51:49 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id m15sm1137451ljg.4.2019.12.18.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 04:51:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ihYno-0000vP-G1; Wed, 18 Dec 2019 13:51:44 +0100
Date:   Wed, 18 Dec 2019 13:51:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] serdev: fix builds with CONFIG_SERIAL_DEV_BUS=m
Message-ID: <20191218125144.GL22665@localhost>
References: <201912181000.82Z7czbN%lkp@intel.com>
 <20191218083842.14882-1-u.kleine-koenig@pengutronix.de>
 <20191218090606.GJ22665@localhost>
 <20191218092958.tu6n452zwbpkreks@pengutronix.de>
 <20191218093806.GK22665@localhost>
 <20191218103931.kgytwzt6cc75iuud@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218103931.kgytwzt6cc75iuud@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:39:31AM +0100, Uwe Kleine-König wrote:
> Hello Johan,
> 
> On Wed, Dec 18, 2019 at 10:38:06AM +0100, Johan Hovold wrote:
> > On Wed, Dec 18, 2019 at 10:29:58AM +0100, Uwe Kleine-König wrote:
> > > On Wed, Dec 18, 2019 at 10:06:06AM +0100, Johan Hovold wrote:
> > > > On Wed, Dec 18, 2019 at 09:38:42AM +0100, Uwe Kleine-König wrote:
> > > > > Commit 54edb425346a ("serdev: simplify Makefile") broke builds with
> > > > > serdev configured as module. I don't understand it completely yet, but
> > > > > it seems that
> > > > > 
> > > > > 	obj-$(CONFIG_SERIAL_DEV_BUS) += serdev/
> > > > > 
> > > > > in drivers/tty/Makefile with CONFIG_SERIAL_DEV_BUS=m doesn't result in
> > > > > code that is added using obj-y in drivers/tty/serdev/Makefile being
> > > > > compiled. So instead of dropping $(CONFIG_SERIAL_DEV_BUS) in serdev's
> > > > > Makefile, drop it in drivers/tty/Makefile.
> > > > 
> > > > Why not simply revert the offending patch? There are some dependencies
> > > > here related to how the tty layer is built. If you're still not certain
> > > > on why things broke, I suggest just reverting for now.
> > > 
> > > I see that it is not easy to define what obj-y should do in a Makefile
> > > that is included via obj-m. Now it is the other way round and that
> > > should be safe. This construct is used in several places, so I'd say the
> > > patch is fine unless you have more concrete concerns.
> > 
> > No, and I don't have time to look into this right now.
> > 
> > It's more about the general principle that a patch should do one thing;
> 
> IMHO it does one thing: It does what 54edb425346a intended to do in the
> right way.

No, your original patch was just broken. The commit message only claimed
that

	drivers/tty/Makefile has:
        	obj-$(CONFIG_SERIAL_DEV_BUS)    += serdev/

	so in drivers/tty/serdev/Makefile CONFIG_SERIAL_DEV_BUS is
	always =y.

which is clearly false since it can be =m (as the build-bot reported).

You now suggest to change:

	obj-$(CONFIG_SERIAL_DEV_BUS)   += serdev/
	+obj-y                          += serdev/

in drivers/tty/Makefile so that make always recurse into serdev, even
when serdev is not enabled, which likewise makes no sense. And in any
case that chunk is not fixing your original patch, but introducing a
different slight regression.

> But I don't feel strong here. If you prefer to revert, that's ok, too.

Yes, I think reverting is the right thing to do here.

> Not sure I will find the motivation then, to reimplement the
> cleanup, though.

That's ok, I don't think that "cleanup" is something we want, and either
way it needs to be reviewed separately.

Johan
