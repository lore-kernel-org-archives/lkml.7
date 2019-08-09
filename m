Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40B1C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABA92171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=devtank-co-uk.20150623.gappssmtp.com header.i=@devtank-co-uk.20150623.gappssmtp.com header.b="zIW8ddVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436485AbfHINSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:18:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37289 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436470AbfHINS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:18:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id b3so5836591wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=42uV7DurzBGNdoHGvTqQVRhcHK8QAjR3iIUcZK+4LkY=;
        b=zIW8ddVR27zXLKH9fZhIInf53B0Gh7iwnxOugtzCHM95gAdCzwDF13gpIHDMDlAxDG
         uCr8usHYX04M3ywP/J0JIo2qJxb9F/86DE1NRBV691y34xB+FdwlA+IrFHEL33I9RDVZ
         wTJZEiWixNjcgubZnEc0DNqZ+snRpjCjwyYqe4UOANHawkW346V+GKb7jrxlsAlCsU4W
         EyLEuQx2TYEpRlQX8b80QwT7Ox7h6z9jfom/tnVcpEf9b7zMszSNpD3qS57KfObMI5BK
         KJl330eUZ3OG9pRM5vCZk/r57nWk4hynC8W0vXJjQT5oH+HkpPhfLv6nKNjJocSjLfOl
         vXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=42uV7DurzBGNdoHGvTqQVRhcHK8QAjR3iIUcZK+4LkY=;
        b=cHOS2xjViJ5sjiwBvgQN4QidXD+8DC2hEq5Rjvc1YL/g6imIVk9Ak3moyOv3VpMR7C
         uYLxjKn8Nho83WN4RA83tQNr88UZVPIJp/PtMx+7mf7rmEKWjUmqQMbo746HcW1xe3Ip
         IrTZcb/i7JgCIJfMzXB8wNXHcvzSZCJDkkAQsSKQcBV183bUX8F/csq9Wdaz4i1z1PVU
         RfNGGJ5s6t7WuvDdpfp9OAmuPSnfhFwreLoygf5ji8pSJmjPw2q2XiwEnEDQwgYAFF0Y
         TYVKhCFemSzICQREOrAsqOrBLQCYfRN5JXyJP8mS48F2doTpCnPWS0H42TYQJ8jW9Vsm
         ggsg==
X-Gm-Message-State: APjAAAUCJgGX9Pb2Fkf/7D4UZjs50UTt0t6zfsaUCDLICIZGvzJRNieU
        3YG+9lRyEGko3+5wOM+vkgq/7chReWA=
X-Google-Smtp-Source: APXvYqwRA0Oy4xrGac8+CSZ14Q0cld46PVL/7rOY6ivBnGJYCE949LN1UmjoX6+QqoQDc0cBrqPHEA==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr23274490wrn.257.1565356706219;
        Fri, 09 Aug 2019 06:18:26 -0700 (PDT)
Received: from [192.168.200.229] ([141.105.200.141])
        by smtp.gmail.com with ESMTPSA id d17sm6187647wrm.52.2019.08.09.06.18.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:18:25 -0700 (PDT)
Subject: Re: [PATCH] Add optional chip erase functionality to AT25 EEPROM
 driver.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
 <20190809130005.GA13962@kroah.com>
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Message-ID: <d6534808-aa41-0bf0-a516-cee9bbd8e97a@devtank.co.uk>
Date:   Fri, 9 Aug 2019 14:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809130005.GA13962@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/08/2019 14:00, Greg Kroah-Hartman wrote:
> On Fri, Aug 09, 2019 at 01:53:55PM +0100, Joe Burmeister wrote:
>> +static void _eeprom_at25_store_erase_locked(struct at25_data *at25)
>> +{
>> +	unsigned long	timeout, retries;
>> +	int				sr, status;
>> +	u8	cp;
>> +
>> +	cp = AT25_WREN;
>> +	status = spi_write(at25->spi, &cp, 1);
>> +	if (status < 0) {
>> +		dev_dbg(&at25->spi->dev, "ERASE WREN --> %d\n", status);
>> +		return;
>> +	}
>> +	cp = at25->erase_instr;
>> +	status = spi_write(at25->spi, &cp, 1);
>> +	if (status < 0) {
>> +		dev_dbg(&at25->spi->dev, "CHIP_ERASE --> %d\n", status);
>> +		return;
>> +	}
>> +	/* Wait for non-busy status */
>> +	timeout = jiffies + msecs_to_jiffies(ERASE_TIMEOUT);
>> +	retries = 0;
>> +	do {
>> +		sr = spi_w8r8(at25->spi, AT25_RDSR);
>> +		if (sr < 0 || (sr & AT25_SR_nRDY)) {
>> +			dev_dbg(&at25->spi->dev,
>> +				"rdsr --> %d (%02x)\n", sr, sr);
>> +			/* at HZ=100, this is sloooow */
>> +			msleep(1);
>> +			continue;
>> +		}
>> +		if (!(sr & AT25_SR_nRDY))
>> +			return;
>> +	} while (retries++ < 200 || time_before_eq(jiffies, timeout));
>> +
>> +	if ((sr < 0) || (sr & AT25_SR_nRDY)) {
>> +		dev_err(&at25->spi->dev,
>> +			"chip erase, timeout after %u msecs\n",
>> +			jiffies_to_msecs(jiffies -
>> +				(timeout - ERASE_TIMEOUT)));
>> +		status = -ETIMEDOUT;
>> +		return;
>> +	}
>> +}
>> +
>> +
> No need for 2 lines :(

Sorry, other coding conventions I'm used to.


>> +static ssize_t eeprom_at25_store_erase(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 const char *buf, size_t count)
>> +{
>> +	struct at25_data *at25 = dev_get_drvdata(dev);
>> +	int erase = 0;
>> +
>> +	sscanf(buf, "%d", &erase);
>> +	if (erase) {
>> +		mutex_lock(&at25->lock);
>> +		_eeprom_at25_store_erase_locked(at25);
>> +		mutex_unlock(&at25->lock);
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR(erase, S_IWUSR, NULL, eeprom_at25_store_erase);
>> +
>> +
> Same here.
>
> Also, where is the Documentation/ABI/ update for the new sysfs file?

There isn't anything for the existing SPI EEPROM stuff I can see.

Would I have to document what was already there to add my bit?


>>   static int at25_probe(struct spi_device *spi)
>>   {
>>   	struct at25_data	*at25 = NULL;
>> @@ -311,6 +379,7 @@ static int at25_probe(struct spi_device *spi)
>>   	int			err;
>>   	int			sr;
>>   	int			addrlen;
>> +	int			has_erase;
>>   
>>   	/* Chip description */
>>   	if (!spi->dev.platform_data) {
>> @@ -352,6 +421,9 @@ static int at25_probe(struct spi_device *spi)
>>   	spi_set_drvdata(spi, at25);
>>   	at25->addrlen = addrlen;
>>   
>> +	/* Optional chip erase instruction */
>> +	device_property_read_u8(&spi->dev, "chip_erase_instruction", &at25->erase_instr);
>> +
>>   	at25->nvmem_config.name = dev_name(&spi->dev);
>>   	at25->nvmem_config.dev = &spi->dev;
>>   	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
>> @@ -370,17 +442,22 @@ static int at25_probe(struct spi_device *spi)
>>   	if (IS_ERR(at25->nvmem))
>>   		return PTR_ERR(at25->nvmem);
>>   
>> -	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u\n",
>> +	has_erase = (!(chip.flags & EE_READONLY) && at25->erase_instr);
>> +
>> +	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u%s\n",
>>   		(chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
>>   		(chip.byte_len < 1024) ? "Byte" : "KByte",
>>   		at25->chip.name,
>>   		(chip.flags & EE_READONLY) ? " (readonly)" : "",
>> -		at25->chip.page_size);
>> +		at25->chip.page_size, (has_erase)?" <has erase>":"");
>> +
>> +	if (has_erase && device_create_file(&spi->dev, &dev_attr_erase))
>> +		dev_err(&spi->dev, "can't create erase interface\n");
> You just raced with userspace and lost :(
>
> Please create an attribute group and add it to the .dev_groups pointer
> in struct driver so it can be created properly in a race-free manner.
>
> See the thread at:
> 	https://lore.kernel.org/r/20190731124349.4474-2-gregkh@linuxfoundation.org
> for the details on how to do that.

Clearly I didn't know about that. I'll do some reading when I've got a 
bit of time and try a again.


> thanks,
>
> greg k-h

Cheers,

Joe

