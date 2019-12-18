Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138B0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BB524672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576661893;
	bh=0Ldgvl4opymzm7pXWle7Y2wTRncjgNXqnTNvUx/E7Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b0lDkFbyc9ZX5fKv56ry3kz+rkqp9Fi8lO4Zl19C5tiWQDdfo0PkT5ewdoAxEWbbz
	 EksUlUswxBN7M7jZH4SAFQ4VCKpG/6Ef3fHL7RkmHV5EiijXvQyE6Y6KelAyXwzPYE
	 3TVa/sNc4aIFKoG8KAV5vc6CPp12+otlOgCsuXz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLRJiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:38:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36562 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:38:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so1364467ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 01:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TD7GCCzHnuv34lsEKYa577HynVSCGDyOMnXkogsY5Oc=;
        b=Uw+l+6NlC0N+kfazsi/epqsmcY1ZaM6fqaQtDQEkEIUVZbCOhN4euo0CNHezNkAgL9
         1eESiOq0thTCSwwawuP27h5pijOAej6vqGxXDSlJ3fTSI0K5ORWr5g7zv6GxBGH8l8Bh
         YnXNYI3yeZpHTkkOze/Pd8YI8gWNlZ2U7Dsl9jLKFEdSCD/L8Rt1RIsSCRfAZTcz44yy
         NJktrV2aOnVp5CoaPkmaVL/lbbZDHle2WVzyPBgrBk/0w9uy8NeRN6SYs8DQvvJMuaW/
         kDoX7kHPLCySZlaFiz/tP00XTe0qJLpcU/LEcqWQcrVsB9x7j3fPBAL7cSkb/TTJkCMv
         f3ZQ==
X-Gm-Message-State: APjAAAUvo3JZN5aZc+KoMYqSkK6B1oM/LkWlSCQlMfoivXpBgY9DnvzZ
        esXTOAdwyDywWJcY9YOFcGPO45a7
X-Google-Smtp-Source: APXvYqykmj3bw8wckfQ0SWS8anYz3CKnkJ41kV8QHJWUqgHmnfJZLRZQAVQ0473+AVWYt51mfgk8qw==
X-Received: by 2002:a2e:8152:: with SMTP id t18mr1027347ljg.255.1576661890486;
        Wed, 18 Dec 2019 01:38:10 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id i2sm804801lfl.20.2019.12.18.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 01:38:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ihVmQ-00034b-9i; Wed, 18 Dec 2019 10:38:06 +0100
Date:   Wed, 18 Dec 2019 10:38:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] serdev: fix builds with CONFIG_SERIAL_DEV_BUS=m
Message-ID: <20191218093806.GK22665@localhost>
References: <201912181000.82Z7czbN%lkp@intel.com>
 <20191218083842.14882-1-u.kleine-koenig@pengutronix.de>
 <20191218090606.GJ22665@localhost>
 <20191218092958.tu6n452zwbpkreks@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218092958.tu6n452zwbpkreks@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:29:58AM +0100, Uwe Kleine-König wrote:
> On Wed, Dec 18, 2019 at 10:06:06AM +0100, Johan Hovold wrote:
> > On Wed, Dec 18, 2019 at 09:38:42AM +0100, Uwe Kleine-König wrote:
> > > Commit 54edb425346a ("serdev: simplify Makefile") broke builds with
> > > serdev configured as module. I don't understand it completely yet, but
> > > it seems that
> > > 
> > > 	obj-$(CONFIG_SERIAL_DEV_BUS) += serdev/
> > > 
> > > in drivers/tty/Makefile with CONFIG_SERIAL_DEV_BUS=m doesn't result in
> > > code that is added using obj-y in drivers/tty/serdev/Makefile being
> > > compiled. So instead of dropping $(CONFIG_SERIAL_DEV_BUS) in serdev's
> > > Makefile, drop it in drivers/tty/Makefile.
> > 
> > Why not simply revert the offending patch? There are some dependencies
> > here related to how the tty layer is built. If you're still not certain
> > on why things broke, I suggest just reverting for now.
> 
> I see that it is not easy to define what obj-y should do in a Makefile
> that is included via obj-m. Now it is the other way round and that
> should be safe. This construct is used in several places, so I'd say the
> patch is fine unless you have more concrete concerns.

No, and I don't have time to look into this right now.

It's more about the general principle that a patch should do one thing;
in this case unbreak the build. If you want to do cleanups as well, you
do that separately (and argue for why its needed).

Johan
