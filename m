Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A90C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 00:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C51B20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 00:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390723AbfIJAe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 20:34:59 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:41730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390656AbfIJAe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 20:34:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E444A1802972A;
        Tue, 10 Sep 2019 00:34:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: camp25_6560f4e3d733e
X-Filterd-Recvd-Size: 2008
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Sep 2019 00:34:56 +0000 (UTC)
Message-ID: <65a3989d97b1ae60cfb0749f3ee8bbd625c7beb6.camel@perches.com>
Subject: Re: [PATCH 3/3] iio: adc: hx711: remove unnecessary returns
From:   Joe Perches <joe@perches.com>
To:     Andreas Klinger <ak@it-klinger.de>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Sep 2019 17:34:55 -0700
In-Reply-To: <20190907101848.hl4vgaostftr4ddj@arbad>
References: <20190907101848.hl4vgaostftr4ddj@arbad>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 12:18 +0200, Andreas Klinger wrote:
> Optimize use of return in hx711_set_gain_for_channel().

I believe this change is not an optimization but
this change does make the code harder to read.

> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
[]
> @@ -213,7 +213,7 @@ static int hx711_reset(struct hx711_data *hx711_data)
>  
>  static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  {
> -	int ret;
> +	int ret = 0;
>  
>  	if (chan == 0) {
>  		if (hx711_data->gain_set == 32) {
> @@ -224,8 +224,6 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  				return ret;
>  
>  			ret = hx711_wait_for_ready(hx711_data);
> -			if (ret)
> -				return ret;
>  		}
>  	} else {
>  		if (hx711_data->gain_set != 32) {
> @@ -236,12 +234,10 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  				return ret;
>  
>  			ret = hx711_wait_for_ready(hx711_data);
> -			if (ret)
> -				return ret;
>  		}
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int hx711_reset_read(struct hx711_data *hx711_data, int chan)

