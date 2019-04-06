Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FDC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EC1218C3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="TPTB/FlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfDFKNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:13:41 -0400
Received: from smtp65.ord1c.emailsrvr.com ([108.166.43.65]:41570 "EHLO
        smtp65.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfDFKNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 06:13:41 -0400
Received: from smtp9.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp9.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id A0FD3201CC;
        Sat,  6 Apr 2019 06:13:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1554545619;
        bh=EetM75hJJVguFpq2OdY1G5n3ircwSgcZQZP/SRKFGeM=;
        h=Subject:To:From:Date:From;
        b=TPTB/FlP/z3QHXGIZq7VuI1Cm5orzEhIPmdT2hPRrXdYwfCqdC4/ktBy44xLT8z4z
         BKs0JD4KKoPv/aq3o713lS3oMhkEKKK2Tf+0S6m1tCh2DjTGZLsN0w6Uk3e0/ABj8r
         xgVTzTxYO61T9/L2d52L8H0Bmk/hJgh6nhJSpa44=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7A89E201C4;
        Sat,  6 Apr 2019 06:13:38 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [192.168.1.10] (redmecca.plus.com [80.229.15.156])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Sat, 06 Apr 2019 06:13:39 -0400
Subject: Re: [PATCH -next] staging: comedi: dyna_pci10xx: remove set but not
 used variables 'chan' and range'
To:     YueHaibing <yuehaibing@huawei.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190406030749.56659-1-yuehaibing@huawei.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Message-ID: <d35e91a5-d427-96ba-d164-33adb4ca73e2@mev.co.uk>
Date:   Sat, 6 Apr 2019 11:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190406030749.56659-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2019 04:07, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/comedi/drivers/dyna_pci10xx.c: In function 'dyna_pci10xx_insn_write_ao':
> drivers/staging/comedi/drivers/dyna_pci10xx.c:109:21: warning:
>   variable 'range' set but not used [-Wunused-but-set-variable]
>    unsigned int chan, range;
> 
> drivers/staging/comedi/drivers/dyna_pci10xx.c:109:15: warning:
>   variable 'chan' set but not used [-Wunused-but-set-variable]
>    unsigned int chan, range;
> 
> They are never used since introduction in commit 16a7373a8e14 ("Staging:
> comedi: add dyna_pci10xx driver")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/staging/comedi/drivers/dyna_pci10xx.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/dyna_pci10xx.c b/drivers/staging/comedi/drivers/dyna_pci10xx.c
> index 9bdd5bf2eb99..d38bfc6113e8 100644
> --- a/drivers/staging/comedi/drivers/dyna_pci10xx.c
> +++ b/drivers/staging/comedi/drivers/dyna_pci10xx.c
> @@ -106,10 +106,6 @@ static int dyna_pci10xx_insn_write_ao(struct comedi_device *dev,
>   {
>   	struct dyna_pci10xx_private *devpriv = dev->private;
>   	int n;
> -	unsigned int chan, range;
> -
> -	chan = CR_CHAN(insn->chanspec);
> -	range = range_codes_pci1050_ai[CR_RANGE((insn->chanspec))];
>   
>   	mutex_lock(&devpriv->mutex);
>   	for (n = 0; n < insn->n; n++) {

That seems fine, thanks.  The lines being removed appear to have been 
copy and pasted from dyna_pci10xx_insn_read_ai().  The AO subdevice 
supports a single range, so no 'range' code is needed.  I believe the 
card has only one analog output channel[*], so the 'chan' is irrelevant. 
  This means the 'n_chans' value in the AO subdevice configuration is 
incorrect.  I'll send a follow-up patch to correct that after Greg KH 
takes this one.

[*] Very little information seems to be available about this card 
online.  It is no longer listed on the manufacturer's web-site and I 
couldn't find any archives on archive.org.  I found part of a scientific 
paper
<http://shodhganga.inflibnet.ac.in/bitstream/10603/150646/15/15_chapter%205.pdf>
which describes the card as having a single channel D/A converter.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
