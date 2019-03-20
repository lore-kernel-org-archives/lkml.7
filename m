Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F3EC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06622146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfCTO7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:59:05 -0400
Received: from hosting.pavoucek.net ([46.28.107.168]:55592 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfCTO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:59:05 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 10:59:04 EDT
Received: from tomas.local.tbs-biometrics.cz (unknown [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 65E66102FFE;
        Wed, 20 Mar 2019 15:53:22 +0100 (CET)
Date:   Wed, 20 Mar 2019 15:53:22 +0100
From:   Tomas Novotny <tomas@novotny.cz>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: light: vcnl4000 use word writes instead of
 byte writes
Message-ID: <20190320155322.3fd9f080@tomas.local.tbs-biometrics.cz>
In-Reply-To: <20190317154802.15174-2-angus@akkea.ca>
References: <20190317154802.15174-1-angus@akkea.ca>
        <20190317154802.15174-2-angus@akkea.ca>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

On Sun, 17 Mar 2019 08:47:58 -0700
"Angus Ainslie (Purism)" <angus@akkea.ca> wrote:

> The VCNL4200 datasheet says that word read and writes should be used
> to access the registers.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/iio/light/vcnl4000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 04fd0d4b6f19..5295330b65e2 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -140,10 +140,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	data->rev = (ret >> 8) & 0xf;
>  
>  	/* Set defaults and enable both channels */
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 0x00);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 0x00);

minor note: the 0x00 looks like a byte. 0 or 0x0000 would be slightly better?
The same below.

>  	if (ret < 0)
>  		return ret;
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 0x00);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 0x00);

The VCNL4200_PS_CONF1 definition is a bit misleading with word write. Because
PS_CONF1 is only a low byte of command code 0x03. The high byte of 0x03 is
PS_CONF2. I would rename it.

>  	if (ret < 0)
>  		return ret;

Anyway, the main point is that I've tested this patch on VCNL4200 and it
works, so:
Tested-by: Tomas Novotny <tomas@novotny.cz>

T.
