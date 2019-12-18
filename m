Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B17C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41746218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576686823;
	bh=azIV8pBwpHQvOh7DdCylw6AvV0IjKb1Sej2OFMxB2og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bV235HU+385Y9gLYEY0eIZmif2h1Cxi4pd6t2DUx7hB0JVibhbCtsgsJTizTAZmRv
	 pedV6GHDY9z/vOA0RVjGnKG87fzys9utWJIuj8mCfwfPOU7PxZgZUgMh7hoBfJU+Gh
	 C0IJmRpKNtTOBEhtOLqw9gFh+EpKwW0R9e8mw62M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLRQdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:33:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40413 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfLRQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:33:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so2146427lfo.7;
        Wed, 18 Dec 2019 08:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v8t3S0XsFVd87bQtdPnr00qBni8cIhFLCl4djFLKeaU=;
        b=iJAsIAjH8GsQ8LGInmTIjZW3UMfh8tk/kU3rDC2lZZkSTIaAmtf8iNK7N1lzuCt+2N
         D6QRcN6NWzoJqu8i/m4EBVCP8z7Zl+rrheaMccjBst8GBn/RjOcahrjbRjXT45AotYEA
         4L6LcGhzX+7vqqxw82JELofo81O1qpzLoFpbYlfrb+cMyNR6WmynH9qNaXl98PSBuDvW
         RxHcCa3BhDN0AezXZpJCYyoqcaS67Z1ZWrEPAPtQeTig6owtv8/Rsp2byQGBu+tACewB
         rlCUizO8L9NMsdID+slg2KXH/rRSmhkvhJFM1GnnBqpHHKPwKobColJPSaE35wbX1pq9
         v2iQ==
X-Gm-Message-State: APjAAAUXjeEQ3+NjPesMkuysSf+XkyfNQX7YN1mlpTr+CdLhlJTOi0If
        RX7T6TctHS78XCeFyCcGgcs=
X-Google-Smtp-Source: APXvYqzHO4DDhBaK+aLtXovadfEfB7aO3GQzuORPuoo52Mu6oWx7o+LPLyg6eO+Iw8bdp1T8Rr8PzQ==
X-Received: by 2002:a05:6512:488:: with SMTP id v8mr2275330lfq.173.1576686819364;
        Wed, 18 Dec 2019 08:33:39 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id a14sm1371033lfh.50.2019.12.18.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:33:38 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ihcGV-0005Jc-Hh; Wed, 18 Dec 2019 17:33:35 +0100
Date:   Wed, 18 Dec 2019 17:33:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] Revert "serdev: simplify Makefile"
Message-ID: <20191218163335.GM22665@localhost>
References: <20191218131154.13702-1-johan@kernel.org>
 <20191218140016.GB209514@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218140016.GB209514@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:00:16PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 18, 2019 at 02:11:54PM +0100, Johan Hovold wrote:
> > This reverts commit 54edb425346a4d5e17f7e54e8c97c0d0eac26315.
> > 
> > The offending commit caused serdev core to always be built-in, something
> > which breaks the build of dependent modules when serdev is being built
> > as a module:
> > 
> > ERROR: "__serdev_device_driver_register" [drivers/gnss/gnss-ubx.ko] undefined!
> > ...
> > make[2]: *** [/home/johan/work/omicron/src/linux/scripts/Makefile.modpost:94: __modpost] Error 1
> > 
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/tty/serdev/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Heh, give me a chance to catch up here, I would have reverted it on my
> own :)

Heh, good. :)

> I'll go queue this up now, thanks.

Johan
