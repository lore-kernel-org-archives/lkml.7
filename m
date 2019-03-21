Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0A521920
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCUO22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:28:28 -0400
Received: from hosting.pavoucek.net ([46.28.107.168]:42648 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfCUO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:28:28 -0400
Received: from tomas-nb (nat8.vcit.vutbr.net [185.62.108.74])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id AADA2102F5F;
        Thu, 21 Mar 2019 15:28:23 +0100 (CET)
Date:   Thu, 21 Mar 2019 15:28:23 +0100
From:   Tomas Novotny <tomas@novotny.cz>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: light: vcnl4000 use word writes instead of
  byte writes
Message-ID: <20190321152823.41991dae@tomas-nb>
In-Reply-To: <16a2d3e86f296fac2f56fb47e1f1afac@www.akkea.ca>
References: <20190317154802.15174-1-angus@akkea.ca>
        <20190317154802.15174-2-angus@akkea.ca>
        <20190320155322.3fd9f080@tomas.local.tbs-biometrics.cz>
        <16a2d3e86f296fac2f56fb47e1f1afac@www.akkea.ca>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

On Wed, 20 Mar 2019 13:21:58 -0700
Angus Ainslie <angus@akkea.ca> wrote:

> Hi Tomas,
> 
> On 2019-03-20 07:53, Tomas Novotny wrote:
> > Hi Angus,
> > 
> > On Sun, 17 Mar 2019 08:47:58 -0700
> > "Angus Ainslie (Purism)" <angus@akkea.ca> wrote:
> >   
> >> The VCNL4200 datasheet says that word read and writes should be used
> >> to access the registers.
> >> 
> >> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> >> ---
> >>  drivers/iio/light/vcnl4000.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/iio/light/vcnl4000.c 
> >> b/drivers/iio/light/vcnl4000.c
> >> index 04fd0d4b6f19..5295330b65e2 100644
> >> --- a/drivers/iio/light/vcnl4000.c
> >> +++ b/drivers/iio/light/vcnl4000.c
> >> @@ -140,10 +140,10 @@ static int vcnl4200_init(struct vcnl4000_data 
> >> *data)
> >>  	data->rev = (ret >> 8) & 0xf;
> >> 
> >>  	/* Set defaults and enable both channels */
> >> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 
> >> 0x00);
> >> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 
> >> 0x00);  
> > 
> > minor note: the 0x00 looks like a byte. 0 or 0x0000 would be slightly 
> > better?
> > The same below.
> >   
> >>  	if (ret < 0)
> >>  		return ret;
> >> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 
> >> 0x00);
> >> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 
> >> 0x00);  
> > 
> > The VCNL4200_PS_CONF1 definition is a bit misleading with word write. 
> > Because
> > PS_CONF1 is only a low byte of command code 0x03. The high byte of 0x03 
> > is
> > PS_CONF2. I would rename it.
> >   
> 
> As far as a base address for the register that is correct based on the 
> names in the datasheet. I suppose I could add something like:
> 
> #define VCNL4200_PS_CONF  VCNL4200_PS_CONF1
>
> and change the reference here if you think that would be more clear.

to be honest, I don't know the best practice. As there is also PS_CONF3, I
was thinking about PS_CONF1_2, but thinking again, your current name is good
enough maybe.

Tomas

> >>  	if (ret < 0)
> >>  		return ret;  
> > 
> > Anyway, the main point is that I've tested this patch on VCNL4200 and 
> > it
> > works, so:
> > Tested-by: Tomas Novotny <tomas@novotny.cz>
> > 
> > T.  
> 
> Thanks for testing it
> Angus
> 
