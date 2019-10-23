Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA1FCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05F6214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="BXvd9oNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390740AbfJWJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:14:03 -0400
Received: from smtp86.ord1d.emailsrvr.com ([184.106.54.86]:51309 "EHLO
        smtp86.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732361AbfJWJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:14:03 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2019 05:14:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1571821592;
        bh=OegGS/GRixpjinYAdFnaxb8OEXr2UIj9Qvl4F/12miI=;
        h=Subject:To:From:Date:From;
        b=BXvd9oNTpVecEoseU+lgJdvLtTENOEg+nAXG77Djswpvi9Qkovbkxgsw5u8nND2ih
         onXmzFSvI1PlxN8ilcbq4RqNvd2X0s+E5H+rbok4ifCeDRbTEXKZ0dvVCcYCIyh0WG
         2ccuX3JTanTZoHOwmOKV0j6WHaKbXkzKZwhD2WrA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 2B1AD60080;
        Wed, 23 Oct 2019 05:06:32 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 23 Oct 2019 05:06:32 -0400
Subject: Re: [PATCH -next] staging: comedi: dt2814: remove set but not used
 variables 'data'
To:     YueHaibing <yuehaibing@huawei.com>, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20191023074827.33264-1-yuehaibing@huawei.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <39229719-55d4-4a71-f698-95ce491496b4@mev.co.uk>
Date:   Wed, 23 Oct 2019 10:06:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023074827.33264-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2019 08:48, YueHaibing wrote:
> drivers/staging/comedi/drivers/dt2814.c:193:6:
>   warning: variable data set but not used [-Wunused-but-set-variable]
> 
> It is never used, so can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/staging/comedi/drivers/dt2814.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/dt2814.c b/drivers/staging/comedi/drivers/dt2814.c
> index d2c7157..e7c6787 100644
> --- a/drivers/staging/comedi/drivers/dt2814.c
> +++ b/drivers/staging/comedi/drivers/dt2814.c
> @@ -186,21 +186,17 @@ static int dt2814_ai_cmd(struct comedi_device *dev, struct comedi_subdevice *s)
>   
>   static irqreturn_t dt2814_interrupt(int irq, void *d)
>   {
> -	int lo, hi;
>   	struct comedi_device *dev = d;
>   	struct dt2814_private *devpriv = dev->private;
>   	struct comedi_subdevice *s = dev->read_subdev;
> -	int data;
>   
>   	if (!dev->attached) {
>   		dev_err(dev->class_dev, "spurious interrupt\n");
>   		return IRQ_HANDLED;
>   	}
>   
> -	hi = inb(dev->iobase + DT2814_DATA);
> -	lo = inb(dev->iobase + DT2814_DATA);
> -
> -	data = (hi << 4) | (lo >> 4);
> +	inb(dev->iobase + DT2814_DATA);
> +	inb(dev->iobase + DT2814_DATA);
>   
>   	if (!(--devpriv->ntrig)) {
>   		int i;
> 

Those variables are currently unused due to a bug that I need to fix.


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
