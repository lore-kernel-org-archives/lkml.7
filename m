Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E42C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E12221871
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564048521;
	bh=Ejulvgb0tI7ID1t79B5eo5UmboBBOaMW9xK/DcYbYns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vc6xZcbFIDMeJ+X24CAPRkl8iKOS5pbx4JUguXbOGAU0sBD/36wdxe6FVhmg0YSAm
	 7t8Z2liixuYg7f827S0UpzbmBhrJ18YSAHUquhvHpewYlDYCWnWa+sE8llJ+OYeQ22
	 vkueiHB9ZK/I7quv7fx4Ou+Fk4uW0vwRLbMnXCo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfGYJzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYJzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:55:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1047520840;
        Thu, 25 Jul 2019 09:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564048518;
        bh=Ejulvgb0tI7ID1t79B5eo5UmboBBOaMW9xK/DcYbYns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGXDbCg10wSMc/9w83f6nT4WgtO7u3o1QbfNZR9maGnrM0V+5dYwoh7cYK8ZZSQU0
         DzicvhyssfYwiYyjEpvq3wLvQajrqro1OZFJfShuvbcBlUkn7YhLU6ku4y69uPmq2x
         MYAvH+5KpwsyMShJjLDZVkxblOs/R2BuHJ4rDfME=
Date:   Thu, 25 Jul 2019 11:55:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org,
        Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCHv3 4/4] tty: n_gsm: add ioctl to map serial device to
 mux'ed tty
Message-ID: <20190725095515.GC31845@kroah.com>
References: <20190710192656.60381-1-martin@geanix.com>
 <20190710192656.60381-4-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710192656.60381-4-martin@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 09:26:56PM +0200, Martin Hundebøll wrote:
> Guessing the first tty for a gsm0710 multiplexed serial device is not
> currently possible, which makes it racy to use with multiple modems.
> 
> Add a way to map the physical serial tty to its related mux devices
> using an ioctl.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
> 
> Changes since v2:
>  * rename IOCTL from GSMIOC_GETBASE to GSMIOC_GETFIRST
>  * return first usable line instead of private control line
>  * return uint32_t instead of int
> 
> Changes since v1:
>  * use put_user() instead of copy_to_user()
>  * add missing opening quote
> 
>  Documentation/serial/n_gsm.rst | 11 +++++++++--
>  drivers/tty/n_gsm.c            |  4 ++++
>  include/uapi/linux/gsmmux.h    |  2 ++
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/serial/n_gsm.rst b/Documentation/serial/n_gsm.rst
> index 0ba731ab00b2..286e7ff4d2d9 100644
> --- a/Documentation/serial/n_gsm.rst
> +++ b/Documentation/serial/n_gsm.rst
> @@ -18,10 +18,13 @@ How to use it
>  2. switch the serial line to using the n_gsm line discipline by using
>     TIOCSETD ioctl,
>  3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl,
> +4. obtain base gsmtty number for the used serial port,

As this file is in .rst format, do we need the enumerated list anymore?

Just a meta-comment...

>  
>  Major parts of the initialization program :
>  (a good starting point is util-linux-ng/sys-utils/ldattach.c)::
>  
> +  #include <stdio.h>
> +  #include <stdint.h>
>    #include <linux/gsmmux.h>
>    #include <linux/tty.h>
>    #define DEFAULT_SPEED	B115200
> @@ -30,6 +33,7 @@ Major parts of the initialization program :
>  	int ldisc = N_GSM0710;
>  	struct gsm_config c;
>  	struct termios configuration;
> +	uint32_t first;
>  
>  	/* open the serial port connected to the modem */
>  	fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
> @@ -58,19 +62,22 @@ Major parts of the initialization program :
>  	c.mtu = 127;
>  	/* set the new configuration */
>  	ioctl(fd, GSMIOC_SETCONF, &c);
> +	/* get first gsmtty device node */
> +	ioctl(fd, GSMIOC_GETFIRST, &first);
> +	printf("first muxed line: /dev/gsmtty%i\n", first);
>  
>  	/* and wait for ever to keep the line discipline enabled */
>  	daemon(0,0);
>  	pause();
>  
> -4. use these devices as plain serial ports.
> +5. use these devices as plain serial ports.
>  
>     for example, it's possible:
>  
>     - and to use gnokii to send / receive SMS on ttygsm1
>     - to use ppp to establish a datalink on ttygsm2
>  
> -5. first close all virtual ports before closing the physical port.
> +6. first close all virtual ports before closing the physical port.
>  
>     Note that after closing the physical port the modem is still in multiplexing
>     mode. This may prevent a successful re-opening of the port later. To avoid
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index a60be591f1fc..dac98f3ead3d 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2613,6 +2613,7 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
>  {
>  	struct gsm_config c;
>  	struct gsm_mux *gsm = tty->disc_data;
> +	unsigned int base;
>  
>  	switch (cmd) {
>  	case GSMIOC_GETCONF:
> @@ -2624,6 +2625,9 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
>  		if (copy_from_user(&c, (void *)arg, sizeof(c)))
>  			return -EFAULT;
>  		return gsm_config(gsm, &c);
> +	case GSMIOC_GETFIRST:
> +		base = mux_num_to_base(gsm);
> +		return put_user(base + 1, (uint32_t __user *)arg);




>  	default:
>  		return n_tty_ioctl_helper(tty, file, cmd, arg);
>  	}
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index 101d3c469acb..e292869245dc 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -37,5 +37,7 @@ struct gsm_netconfig {
>  #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
>  #define GSMIOC_DISABLE_NET     _IO('G', 3)
>  
> +/* get the base tty number for a configured gsmmux tty */
> +#define GSMIOC_GETFIRST		_IOR('G', 4, uint32_t)

Variables that cross the boundry from user/kernel should use the correct
type.  That would be "__u32" here.

thanks.

greg k-h
