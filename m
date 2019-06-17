Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1C820657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="aasxPrsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfFQN0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:26:43 -0400
Received: from smtp121.ord1c.emailsrvr.com ([108.166.43.121]:44980 "EHLO
        smtp121.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfFQN0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1560777558;
        bh=5TbJE6kgkkLp1/JINzOKzzcb0A8rBGMKS/yWgPbV0Bo=;
        h=Subject:To:From:Date:From;
        b=aasxPrsCPX9YDpRl6CZ8FO8w7OMs0IipOKSScZ3pErTJc9HuVa6NaAqBGrviIXIVB
         UhNJfVpuIuspNhY6/Q2b7ZEwRjjZzMjSVMOMQkjLnRNsJx5y87AAPhgxHWd3It//Tz
         VTpGqV09l1TxI1WKwkK3C3jUU4iHDDyBNuLJOOlg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 90654C0270;
        Mon, 17 Jun 2019 09:19:17 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 17 Jun 2019 09:19:18 -0400
Subject: Re: [PATCH][next] staging: comedi: usbdux: remove redundant
 initialization of fx2delay
To:     Colin King <colin.king@canonical.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617130358.28749-1-colin.king@canonical.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <fe0881ce-90aa-0689-7563-0d94aeebb461@mev.co.uk>
Date:   Mon, 17 Jun 2019 14:19:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617130358.28749-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2019 14:03, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable fx2delay is being initialized to a value that is never read
> and is being re-assigned a few statements later. The initialization
> is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/staging/comedi/drivers/usbdux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/usbdux.c b/drivers/staging/comedi/drivers/usbdux.c
> index b8f54b7fb34a..0350f303d557 100644
> --- a/drivers/staging/comedi/drivers/usbdux.c
> +++ b/drivers/staging/comedi/drivers/usbdux.c
> @@ -1226,7 +1226,7 @@ static int usbdux_pwm_period(struct comedi_device *dev,
>   			     unsigned int period)
>   {
>   	struct usbdux_private *devpriv = dev->private;
> -	int fx2delay = 255;
> +	int fx2delay;
>   
>   	if (period < MIN_PWM_PERIOD)
>   		return -EAGAIN;
> 

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
