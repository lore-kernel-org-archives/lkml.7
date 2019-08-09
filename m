Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360ABC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DFB2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565357295;
	bh=5H5b7y+4EokoM0HkClMwlRbqVVUaENMdf+M7pdtzgA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JjCeP4D6IV0/+RGuevd2AKMSX+o7ZmYWEGS4A00VIYiFF+Lp12kqMvJycbnZLwBu6
	 XckdDHSjuyrC3a4BHJr4u8hlWDTS+fImNUTIot+kTwMKPhxwplQs7rzWdmhW4HS7EA
	 gCqT3nGA1lRfAhupVvPb6WyQ+ChfkfCw83JKCQWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407084AbfHIN2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfHIN2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:28:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DDE1214C6;
        Fri,  9 Aug 2019 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565357292;
        bh=5H5b7y+4EokoM0HkClMwlRbqVVUaENMdf+M7pdtzgA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxB3Emcyz8XTPMJKE3Y0ERvCS3wx3MpN4HaZYeFBjqS8FG4CZT8m8P1NeKaiqiw2g
         a9zHd52yoo+fRNoy4aQfLm9DfU2BVXZj8f81DtNHf+dtP4quAWeOFSci/xnCEVebMm
         NME5uEl0BR2gU5/vRVgQhTn4PmcIyOQZq4sUTsYg=
Date:   Fri, 9 Aug 2019 15:28:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add optional chip erase functionality to AT25 EEPROM
 driver.
Message-ID: <20190809132809.GA30876@kroah.com>
References: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
 <20190809130005.GA13962@kroah.com>
 <d6534808-aa41-0bf0-a516-cee9bbd8e97a@devtank.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6534808-aa41-0bf0-a516-cee9bbd8e97a@devtank.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 02:18:24PM +0100, Joe Burmeister wrote:
> Hi Greg,
> 
> On 09/08/2019 14:00, Greg Kroah-Hartman wrote:
> > On Fri, Aug 09, 2019 at 01:53:55PM +0100, Joe Burmeister wrote:
> > > +static void _eeprom_at25_store_erase_locked(struct at25_data *at25)
> > > +{
> > > +	unsigned long	timeout, retries;
> > > +	int				sr, status;
> > > +	u8	cp;
> > > +
> > > +	cp = AT25_WREN;
> > > +	status = spi_write(at25->spi, &cp, 1);
> > > +	if (status < 0) {
> > > +		dev_dbg(&at25->spi->dev, "ERASE WREN --> %d\n", status);
> > > +		return;
> > > +	}
> > > +	cp = at25->erase_instr;
> > > +	status = spi_write(at25->spi, &cp, 1);
> > > +	if (status < 0) {
> > > +		dev_dbg(&at25->spi->dev, "CHIP_ERASE --> %d\n", status);
> > > +		return;
> > > +	}
> > > +	/* Wait for non-busy status */
> > > +	timeout = jiffies + msecs_to_jiffies(ERASE_TIMEOUT);
> > > +	retries = 0;
> > > +	do {
> > > +		sr = spi_w8r8(at25->spi, AT25_RDSR);
> > > +		if (sr < 0 || (sr & AT25_SR_nRDY)) {
> > > +			dev_dbg(&at25->spi->dev,
> > > +				"rdsr --> %d (%02x)\n", sr, sr);
> > > +			/* at HZ=100, this is sloooow */
> > > +			msleep(1);
> > > +			continue;
> > > +		}
> > > +		if (!(sr & AT25_SR_nRDY))
> > > +			return;
> > > +	} while (retries++ < 200 || time_before_eq(jiffies, timeout));
> > > +
> > > +	if ((sr < 0) || (sr & AT25_SR_nRDY)) {
> > > +		dev_err(&at25->spi->dev,
> > > +			"chip erase, timeout after %u msecs\n",
> > > +			jiffies_to_msecs(jiffies -
> > > +				(timeout - ERASE_TIMEOUT)));
> > > +		status = -ETIMEDOUT;
> > > +		return;
> > > +	}
> > > +}
> > > +
> > > +
> > No need for 2 lines :(
> 
> Sorry, other coding conventions I'm used to.

checkpatch.pl should have warned you about this, you did run that before
sending your patch out, right?

> > > +static ssize_t eeprom_at25_store_erase(struct device *dev,
> > > +					 struct device_attribute *attr,
> > > +					 const char *buf, size_t count)
> > > +{
> > > +	struct at25_data *at25 = dev_get_drvdata(dev);
> > > +	int erase = 0;
> > > +
> > > +	sscanf(buf, "%d", &erase);
> > > +	if (erase) {
> > > +		mutex_lock(&at25->lock);
> > > +		_eeprom_at25_store_erase_locked(at25);
> > > +		mutex_unlock(&at25->lock);
> > > +	}
> > > +
> > > +	return count;
> > > +}
> > > +
> > > +static DEVICE_ATTR(erase, S_IWUSR, NULL, eeprom_at25_store_erase);
> > > +
> > > +
> > Same here.
> > 
> > Also, where is the Documentation/ABI/ update for the new sysfs file?
> 
> There isn't anything for the existing SPI EEPROM stuff I can see.
> 
> Would I have to document what was already there to add my bit?

Yes, someone has to, sorry :)

thanks,

greg k-h
