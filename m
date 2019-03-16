Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F24FC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B381218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552754158;
	bh=Ih/i8auErnWevqTqbXCcW1dnCTmu7DpAJKUmWM4uL1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZQgZzO/s4nT7c1KDYN21Rqh6jeMy2hl2Mbe6Mo4JiTGL+3EkhZjTlShick0V3uGx+
	 IC9Dzdf2vEfO4BW4ggsm1ziEzH67mpsYQuEYcxYsgn7uRbUfmG4928uGthkzkzlroz
	 c5hLQ0KWN6K4K4Fs/RCcUqlVIII3BueBuiQEcdIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCPQf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPQf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:35:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A732186A;
        Sat, 16 Mar 2019 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552754155;
        bh=Ih/i8auErnWevqTqbXCcW1dnCTmu7DpAJKUmWM4uL1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IxsuqA56AEXFVzBVGVCFL365uUPszL0tTFYt4SypBF+kJC85Wr6rAsLtF6eUnJAji
         zGZDHWKkYgRyNoCKOSaw/+f92Oxk/l/zzmjq88hF93fwqLCb0Zv9kqZzFuEj45AnZ2
         KQz0aAjXUe2oH+xAP20aW6z4edhohxq2S9xB2nY0=
Date:   Sat, 16 Mar 2019 16:35:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pms7003: sleect IIO_TRIGGERED_BUFFER
Message-ID: <20190316163550.5eeee40a@archlinux>
In-Reply-To: <20190314172733.GA23693@arch>
References: <20190314090118.312040-1-arnd@arndb.de>
        <20190314172733.GA23693@arch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 18:27:35 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Thu, Mar 14, 2019 at 10:00:52AM +0100, Arnd Bergmann wrote:
> > Without IIO_TRIGGERED_BUFFER, this driver fails to link:  
> 
> Good catch, thanks (btw, perhaps typo in subject can be fixed before
> applying patch).
> 
> Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the fixes-togreg branch of iio.git with the typo
fixed.

Thanks!

Jonathan

> 
> >
> > drivers/iio/chemical/pms7003.o: In function `pms7003_probe':
> > pms7003.c:(.text+0x21c): undefined reference to `devm_iio_triggered_buffer_setup'
> > pms7003.c:(.text+0x21c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `devm_iio_triggered_buffer_setup'
> >
> > Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/iio/chemical/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > index d5d146e9e372..6f253092a523 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -64,6 +64,7 @@ config IAQCORE
> >  config PMS7003
> >  	tristate "Plantower PMS7003 particulate matter sensor"
> >  	depends on SERIAL_DEV_BUS
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say Y here to build support for the Plantower PMS7003 particulate
> >  	  matter sensor.
> > --
> > 2.20.0
> >  

