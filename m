Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD4FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BED22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kOumEtyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbfHVMIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:08:21 -0400
Received: from mout01.posteo.de ([185.67.36.65]:50721 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731326AbfHVMIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:08:21 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 17F5E160060
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 14:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1566475698; bh=Sg1Anz4zYb3hs4rsAoh/K0xqi2SEWfUCRmkWAkmoWZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=kOumEtyMQj/qTbFn8/Q1Wx/CnIekoYFiqpZEeLvU0SVwVIZKY+3NxUfaCYNIpXTXD
         sI+O6i8ztyTA1kuw4TShJbssnTUJ5Pti17/zFgAXep3rAwQdFKa41pUqo7CTITkN9q
         Q/DfKPhlP2lyohiq41WRnDnDIC7pTlTZT5arn8RnfoyNx4XyEABuZmdqdHm2AMPdqF
         KjEgiRgVLTtmpj90y/krooDNLsbEJAd6CKZgxPRo48FXRCDQbfq8gKAJFCOcEezsSL
         wKZHydtX0yCnF3XFv/mKYipjdFxMfvAUIg2Q89npET4wdRyUTzS7e7y9Ijg/8cGc5Q
         qmAakkuC2ecXQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46Djwc07lbz6tmG;
        Thu, 22 Aug 2019 14:08:16 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 22 Aug 2019 14:08:14 +0200
From:   Martin Kepplinger <martink@posteo.de>
To:     Dixit Parmar <dixitparmar19@gmail.com>
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        kuninori.morimoto.gx@renesas.com, robh@kernel.org,
        matthias.fend@wolfvision.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver:st1633: fixed multitouch incorrect coordinates
In-Reply-To: <1566209314-21767-1-git-send-email-dixitparmar19@gmail.com>
References: <1566209314-21767-1-git-send-email-dixitparmar19@gmail.com>
Message-ID: <8cfedf751fc87f5f1c660cfda69d36ce@posteo.de>
X-Sender: martink@posteo.de
User-Agent: Posteo Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.08.2019 12:08 schrieb Dixit Parmar:
> From: Dixit Parmar <dixitparmar19@gmail.com>
> 
> For Sitronix st1633 multi-touch controller driver the co-ordinates 
> reported
> for multiple fingers were wrong.
> 
> So the below mentioned bug was filed,
> Bugzilla Bug ID: 204561
> 
> While reading co-ordinates from specified I2C registers, the X & Y
> co-ordinates should be read from proper I2C address for particular 
> finger as
> specified in chip specific datasheet.
> 
> for single touch this logic is working fine. However, for multi-touch
> scenario the logic of reading data from data buffer has issues.
> 
> This patch fixes the reading logic from data buffer.
> 
> Previous logic:
> * Offset of X & Y Lower byte coordinate is increased by i no. only(by 1 
> Byte)
>   for each finger.
> 
> New logic:
> * The logic of reading X & Y Lower Byte coordinate needs to be 
> increased
>   by i+y for each time/finger.
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
>  drivers/input/touchscreen/st1232.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/st1232.c
> b/drivers/input/touchscreen/st1232.c
> index 3492339..1139714 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -81,8 +81,10 @@ static int st1232_ts_read_data(struct st1232_ts_data 
> *ts)
>  	for (i = 0, y = 0; i < ts->chip_info->max_fingers; i++, y += 3) {
>  		finger[i].is_valid = buf[i + y] >> 7;
>  		if (finger[i].is_valid) {
> -			finger[i].x = ((buf[i + y] & 0x0070) << 4) | buf[i + 1];
> -			finger[i].y = ((buf[i + y] & 0x0007) << 8) | buf[i + 2];
> +			finger[i].x = ((buf[i + y] & 0x0070) << 4) |
> +					buf[i + y + 1];
> +			finger[i].y = ((buf[i + y] & 0x0007) << 8) |
> +					buf[i + y + 2];

Seems like you're right. It's simply +1 (for x) and +2 (for y) from the 
high-byte locations.
Not sure how that went wrong.

Thank you,

Reviewed-by: Martin Kepplinger <martink@posteo.de>


> 
>  			/* st1232 includes a z-axis / touch strength */
>  			if (ts->chip_info->have_z)

