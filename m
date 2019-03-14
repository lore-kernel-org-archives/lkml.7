Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF7C21873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552603927;
	bh=st0n8huOzjMrnMwi0sOu0eXuetmWdRgRQHuh30jQPpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qvzPvWVpKDQfQ6Tc42A1VygPtwnQqwAEaNdSL/VEufu2T1XvFzkKT6sU8M2t3/4yu
	 lrvHBiNkvfJfpLZQ8EAqxUut8bJJbAmkTksD0zzGREo6VfLgSOQufBLZN2o8B2G63X
	 EVFQM4mAmqw+xYxS3nWAHmuL4E7O1kA3Ga243A+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfCNWwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbfCNWwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:52:06 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD7520854;
        Thu, 14 Mar 2019 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552603925;
        bh=st0n8huOzjMrnMwi0sOu0eXuetmWdRgRQHuh30jQPpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJvj5RlDqIcQn41nriRHlw2/8g+bsQPxKTc+WWz90BZVMr5AmJW/OzZVzd2JAR+pG
         7lEMTvrx1RUCPvbZij+l1qAaQiUNn/0TE0v0U6MrLGP1aAKsUw7NtFNO/5dzgiCUDl
         0dDi9vMNO8CzuO6upy0fnqYe5SOW+O+9FjTiUAe4=
Date:   Thu, 14 Mar 2019 15:52:04 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Message-ID: <20190314225204.GB1795@kroah.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552602855-26086-11-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
> Use the safer devm versions of memory mapping functions.

What is "safer" about them?

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/tty/serial/zs.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
> index b03d3e4..0b1ec2f 100644
> --- a/drivers/tty/serial/zs.c
> +++ b/drivers/tty/serial/zs.c
> @@ -984,16 +984,17 @@ static const char *zs_type(struct uart_port *uport)
>  
>  static void zs_release_port(struct uart_port *uport)
>  {
> -	iounmap(uport->membase);
> +	devm_iounmap(uport->dev, uport->membase);
>  	uport->membase = 0;
> -	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
> +	devm_release_mem_region(uport->dev, uport->mapbase, ZS_CHAN_IO_SIZE);

Isn't the whole goal of the devm* functions such that you are not
required to call "release" on them?

If so, are you sure this patchset is correct?

And also, why make the change, you aren't changing any functionality for
these old drivers at all from what I can tell (for the devm calls).
What am I missing here?

thanks,

greg k-h
