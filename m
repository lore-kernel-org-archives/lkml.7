Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A89C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345B42339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567582214;
	bh=5xqiHoV5WB2W4rba1WWGKOrKhhr69bfkObJaVnV9ThA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1WVi1e7Pr3MBKMD55VzMnds0hMqOGQR61sJNt7Nu6nhFGonBlUdbtBKluqK3ggfx1
	 1WG73qWANkTWsLfgPNtvzNEBBKW6gFVF9fh0zpsQfCICeEYm2oStBXcfIYT8jrMIkH
	 SG96a/oNYdp3nB4vGcEarJVseg+XqbvcGcgFNTms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfIDHaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDHaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:30:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F6C722CEA;
        Wed,  4 Sep 2019 07:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567582212;
        bh=5xqiHoV5WB2W4rba1WWGKOrKhhr69bfkObJaVnV9ThA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6QiOXgXTYoe+zupG53Gj5ankPf4IwoASwcHtnZ95MjY5gJ38LbkYEm9fYUBC6FEm
         5gpwjvhrR6MF61UaNKrPv6qik3l8jgFs34Ec9jlXp6wCyWAHIO4kl5wuzZ3kEnSVrf
         rJZoLWtikD7/Ylhw/m1X/VhRZ1Iru/Lr8aLVniC8=
Date:   Wed, 4 Sep 2019 09:30:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph =?iso-8859-1?Q?Vogtl=E4nder?= 
        <Christoph.Vogtlaender@sigma-surface-science.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: max310x: Properly set flags in AutoCTS mode
Message-ID: <20190904073009.GA9729@kroah.com>
References: <47a1918df72a4b28b124a53e055e045a@SSSDEEX.i.sigma-surface-science.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47a1918df72a4b28b124a53e055e045a@SSSDEEX.i.sigma-surface-science.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 09:58:34AM +0000, Christoph Vogtländer wrote:
> Commit 391f93f2ec9f ("serial: core: Rework hw-assisted flow control
> support") has changed the way the AutoCTS mode is handled.
> 
> According to that change, serial drivers which enable H/W AutoCTS mode must
> set UPSTAT_AUTORTS, UPSTAT_AUTOCTS and UPSTAT_AUTOXOFF to prevent the
> serial core from inadvertently disabling RX or TX. This patch adds proper
> handling of UPSTAT_AUTORTS, UPSTAT_AUTOCTS and UPSTAT_AUTOXOFF flags.
> 
> Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
> ---
>  drivers/tty/serial/max310x.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 0e24235..fb5a7e0 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -859,15 +859,23 @@ static void max310x_set_termios(struct uart_port *port,
>  /* Configure flow control */
>  max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
>  max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
> -if (termios->c_cflag & CRTSCTS)
> +
> +port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
> +
> +if (termios->c_cflag & CRTSCTS) {
> +/* Enable AUTORTS and AUTOCTS */
> +port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
>  flow |= MAX310X_FLOWCTRL_AUTOCTS_BIT |
>  MAX310X_FLOWCTRL_AUTORTS_BIT;
> +}
>  if (termios->c_iflag & IXON)
>  flow |= MAX310X_FLOWCTRL_SWFLOW3_BIT |
>  MAX310X_FLOWCTRL_SWFLOWEN_BIT;
> -if (termios->c_iflag & IXOFF)
> +if (termios->c_iflag & IXOFF) {
> +port->status |= UPSTAT_AUTOXOFF;
>  flow |= MAX310X_FLOWCTRL_SWFLOW1_BIT |
>  MAX310X_FLOWCTRL_SWFLOWEN_BIT;
> +}
>  max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);
> 
>  /* Get baud rate generator configuration */
> --
> 2.7.4

Your email client ate all of the leading spaces and tabs and spit out a
patch that is impossible to apply :(

Please fix that up and resend.

thanks,

greg k-h
