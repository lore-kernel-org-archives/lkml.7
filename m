Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAD8C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A030214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568554202;
	bh=PtviqnG5qYLkWBpEBFMqK2U3eD8l+dTi5nm61/yRt5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SvyNNXN8KY5iZYxZsD/qDyleiF7/DeSjSWAoiDEJ/CDlaXlik8IErbpXhXZorTY+z
	 Pke7GgWJvRMP3cRl/BwCiAgBMkQIz9b+OUKhF84eVpKTa5anljH3VnGuxdjf9NnMFR
	 RJntobdhjTF8pXczAhVGFFLziqFgYuozK3KMkhR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfIONaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfIONaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:30:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2EE6214D9;
        Sun, 15 Sep 2019 13:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554201;
        bh=PtviqnG5qYLkWBpEBFMqK2U3eD8l+dTi5nm61/yRt5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jn4aGJB3xsVa8/37tgg1Z/saW0YXf9kyQndVcWE/cvGJAk/WINhE791+DKG/DAkau
         YHH+BvqjNf0eRyKR6rA7ypisBRJjqbAmTY3twgj2fLi4xQVe87GEUErx/MlHzHSPGK
         QhLs8PTl/ta8WZGHHNqVO2VID0fzjKl3NUzB8Aic=
Date:   Sun, 15 Sep 2019 14:29:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: accel: adxl372: Fix push to buffers lost
 samples
Message-ID: <20190915142956.6af93916@archlinux>
In-Reply-To: <1568126661-13318-1-git-send-email-stefan.popa@analog.com>
References: <1568126661-13318-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 17:44:21 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> One in two sample sets was lost by multiplying fifo_set_size with
> sizeof(u16). Also, the double number of available samples were pushed to
> the iio buffers.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied with same fixes tag as previous and cc stable.

> ---
> Changes in v2:
> 	- Nothing changed.
> 
>  drivers/iio/accel/adxl372.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 7de5e1b..33edca8 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -553,8 +553,7 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  			goto err;
>  
>  		/* Each sample is 2 bytes */
> -		for (i = 0; i < fifo_entries * sizeof(u16);
> -		     i += st->fifo_set_size * sizeof(u16))
> +		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
>  			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
>  	}
>  err:

