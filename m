Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D4DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 09:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD2221479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567934958;
	bh=g3MzwCNbs4e/QTBt4lYQwYk1fLLibbwie2HBzi2uKSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lc/f+GlMCbqAlRggXsejXsJj5ZHeMoF+itmFBd4WtN7ovxmrdpkQRG88pCu29idTX
	 rsa80yBloCI9/j6vTC+21a6mkd4Xq45mVafmaZ7VYY37iI7lqluLiAcRQVgiG1jacE
	 y7SftpweGs+ohlBfUW6m56CB/41Q5UMK0asE/Hho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfIHJ3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 05:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfIHJ3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 05:29:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EBFE20863;
        Sun,  8 Sep 2019 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567934956;
        bh=g3MzwCNbs4e/QTBt4lYQwYk1fLLibbwie2HBzi2uKSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ixfILe8lZ19CywYVxuO2JOuSLRqrUR8pMi3EHFJiPb4E1IPioKe2bQOk4+jRO7jMf
         rSV6in/ryJZMLXdqQoJDwgTsgoG1oACM8LVZrfJxB/7yuwGw3v9DAW4rMLJ2UEGc+d
         7OFtJPVwrtodmH7qLN0xt+ghp+IN6IfAUbVLrVDA=
Date:   Sun, 8 Sep 2019 10:29:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: accel: adxl372: Fix push to buffers lost
 samples
Message-ID: <20190908102911.17981f71@archlinux>
In-Reply-To: <1567502313-10314-1-git-send-email-stefan.popa@analog.com>
References: <1567502313-10314-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 12:18:33 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> One in two sample sets was lost by multiplying fifo_set_size with
> sizeof(u16). Also, the double number of available samples were pushed to
> the iio buffers.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks right to me.   Will pick up once we've resolved the questions
on patch 1.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index adec37b..72d3f45 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -548,8 +548,7 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  			goto err;
>  
>  		/* Each sample is 2 bytes */
> -		for (i = 0; i < fifo_entries * sizeof(u16);
> -		     i += st->fifo_set_size * sizeof(u16))
> +		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
>  			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
>  	}
>  err:

