Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA08C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682E521743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565355610;
	bh=iDWm4tx1wC6eLb9RWMaVgsIMEJY2hF+w7j8VkSayoo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p1garxFvawvK3UcaG5Epim5s3kP2QQhTXeU7JxStXuZk+nQBA/gbOUy+Mv2ZznU2y
	 ZLXm62eLF/nfA5Ru48I1cEgp3sKek+yDxxZ1iBZxGAjCIJqoYfRVyAU9UgPgWFOVnX
	 IKgbUzoSeEQpJC5wxm5sfsZbIKZIUnHauHtOoBqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406979AbfHINAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHINAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:00:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCF020B7C;
        Fri,  9 Aug 2019 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565355607;
        bh=iDWm4tx1wC6eLb9RWMaVgsIMEJY2hF+w7j8VkSayoo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZK6BTSHaAol78GPo+Y5GRnYjKPVwg3rODZUsyUhYlZ5M85m65KYBBe3xgYzevA81
         BySmSkonFQQiLBQX4n7PX5CZHLSdLYqP8Oe6LWMTsSfFKgwWnLzjIIslNgKGVPNDOW
         nIpYL1s1RL1gPqpxZw0yCwtywrc+Vtx0Q8ocJiXY=
Date:   Fri, 9 Aug 2019 15:00:05 +0200
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
Message-ID: <20190809130005.GA13962@kroah.com>
References: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:53:55PM +0100, Joe Burmeister wrote:
> +static void _eeprom_at25_store_erase_locked(struct at25_data *at25)
> +{
> +	unsigned long	timeout, retries;
> +	int				sr, status;
> +	u8	cp;
> +
> +	cp = AT25_WREN;
> +	status = spi_write(at25->spi, &cp, 1);
> +	if (status < 0) {
> +		dev_dbg(&at25->spi->dev, "ERASE WREN --> %d\n", status);
> +		return;
> +	}
> +	cp = at25->erase_instr;
> +	status = spi_write(at25->spi, &cp, 1);
> +	if (status < 0) {
> +		dev_dbg(&at25->spi->dev, "CHIP_ERASE --> %d\n", status);
> +		return;
> +	}
> +	/* Wait for non-busy status */
> +	timeout = jiffies + msecs_to_jiffies(ERASE_TIMEOUT);
> +	retries = 0;
> +	do {
> +		sr = spi_w8r8(at25->spi, AT25_RDSR);
> +		if (sr < 0 || (sr & AT25_SR_nRDY)) {
> +			dev_dbg(&at25->spi->dev,
> +				"rdsr --> %d (%02x)\n", sr, sr);
> +			/* at HZ=100, this is sloooow */
> +			msleep(1);
> +			continue;
> +		}
> +		if (!(sr & AT25_SR_nRDY))
> +			return;
> +	} while (retries++ < 200 || time_before_eq(jiffies, timeout));
> +
> +	if ((sr < 0) || (sr & AT25_SR_nRDY)) {
> +		dev_err(&at25->spi->dev,
> +			"chip erase, timeout after %u msecs\n",
> +			jiffies_to_msecs(jiffies -
> +				(timeout - ERASE_TIMEOUT)));
> +		status = -ETIMEDOUT;
> +		return;
> +	}
> +}
> +
> +

No need for 2 lines :(

> +static ssize_t eeprom_at25_store_erase(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct at25_data *at25 = dev_get_drvdata(dev);
> +	int erase = 0;
> +
> +	sscanf(buf, "%d", &erase);
> +	if (erase) {
> +		mutex_lock(&at25->lock);
> +		_eeprom_at25_store_erase_locked(at25);
> +		mutex_unlock(&at25->lock);
> +	}
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(erase, S_IWUSR, NULL, eeprom_at25_store_erase);
> +
> +

Same here.

Also, where is the Documentation/ABI/ update for the new sysfs file?

>  static int at25_probe(struct spi_device *spi)
>  {
>  	struct at25_data	*at25 = NULL;
> @@ -311,6 +379,7 @@ static int at25_probe(struct spi_device *spi)
>  	int			err;
>  	int			sr;
>  	int			addrlen;
> +	int			has_erase;
>  
>  	/* Chip description */
>  	if (!spi->dev.platform_data) {
> @@ -352,6 +421,9 @@ static int at25_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, at25);
>  	at25->addrlen = addrlen;
>  
> +	/* Optional chip erase instruction */
> +	device_property_read_u8(&spi->dev, "chip_erase_instruction", &at25->erase_instr);
> +
>  	at25->nvmem_config.name = dev_name(&spi->dev);
>  	at25->nvmem_config.dev = &spi->dev;
>  	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
> @@ -370,17 +442,22 @@ static int at25_probe(struct spi_device *spi)
>  	if (IS_ERR(at25->nvmem))
>  		return PTR_ERR(at25->nvmem);
>  
> -	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u\n",
> +	has_erase = (!(chip.flags & EE_READONLY) && at25->erase_instr);
> +
> +	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u%s\n",
>  		(chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
>  		(chip.byte_len < 1024) ? "Byte" : "KByte",
>  		at25->chip.name,
>  		(chip.flags & EE_READONLY) ? " (readonly)" : "",
> -		at25->chip.page_size);
> +		at25->chip.page_size, (has_erase)?" <has erase>":"");
> +
> +	if (has_erase && device_create_file(&spi->dev, &dev_attr_erase))
> +		dev_err(&spi->dev, "can't create erase interface\n");

You just raced with userspace and lost :(

Please create an attribute group and add it to the .dev_groups pointer
in struct driver so it can be created properly in a race-free manner.

See the thread at:
	https://lore.kernel.org/r/20190731124349.4474-2-gregkh@linuxfoundation.org
for the details on how to do that.

thanks,

greg k-h
