Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D278C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="g0zbp/IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfCTUWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:22:01 -0400
Received: from node.akkea.ca ([192.155.83.177]:39200 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfCTUWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:22:00 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id CB9AC4E204B; Wed, 20 Mar 2019 20:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553113318; bh=28gJDAeYHl4IhB3qxEV8or3e+uBqMpDNryGUZGJTh0U=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=g0zbp/INYUXZ7KaF44V2ZyGF2VafHp3GOqV9DXOjNHC7ycuPdZoJGSOscxZ1KoFBG
         9BhT0+lM6f+6R4ZSABVBpQW7591xvwuoy3JpcjhbiJUmTHeZPkU03eRy+XEjQIC7vC
         4PBNngxWz00dCkzJMbG0BP/p+7sQR9jIWlOUBodg=
To:     Tomas Novotny <tomas@novotny.cz>
Subject: Re: [PATCH v2 1/5] iio: light: vcnl4000 use word writes instead of  byte writes
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Mar 2019 13:21:58 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190320155322.3fd9f080@tomas.local.tbs-biometrics.cz>
References: <20190317154802.15174-1-angus@akkea.ca>
 <20190317154802.15174-2-angus@akkea.ca>
 <20190320155322.3fd9f080@tomas.local.tbs-biometrics.cz>
Message-ID: <16a2d3e86f296fac2f56fb47e1f1afac@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On 2019-03-20 07:53, Tomas Novotny wrote:
> Hi Angus,
> 
> On Sun, 17 Mar 2019 08:47:58 -0700
> "Angus Ainslie (Purism)" <angus@akkea.ca> wrote:
> 
>> The VCNL4200 datasheet says that word read and writes should be used
>> to access the registers.
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>  drivers/iio/light/vcnl4000.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iio/light/vcnl4000.c 
>> b/drivers/iio/light/vcnl4000.c
>> index 04fd0d4b6f19..5295330b65e2 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -140,10 +140,10 @@ static int vcnl4200_init(struct vcnl4000_data 
>> *data)
>>  	data->rev = (ret >> 8) & 0xf;
>> 
>>  	/* Set defaults and enable both channels */
>> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 
>> 0x00);
>> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 
>> 0x00);
> 
> minor note: the 0x00 looks like a byte. 0 or 0x0000 would be slightly 
> better?
> The same below.
> 
>>  	if (ret < 0)
>>  		return ret;
>> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 
>> 0x00);
>> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 
>> 0x00);
> 
> The VCNL4200_PS_CONF1 definition is a bit misleading with word write. 
> Because
> PS_CONF1 is only a low byte of command code 0x03. The high byte of 0x03 
> is
> PS_CONF2. I would rename it.
> 

As far as a base address for the register that is correct based on the 
names in the datasheet. I suppose I could add something like:

#define VCNL4200_PS_CONF  VCNL4200_PS_CONF1

and change the reference here if you think that would be more clear.

>>  	if (ret < 0)
>>  		return ret;
> 
> Anyway, the main point is that I've tested this patch on VCNL4200 and 
> it
> works, so:
> Tested-by: Tomas Novotny <tomas@novotny.cz>
> 
> T.

Thanks for testing it
Angus
