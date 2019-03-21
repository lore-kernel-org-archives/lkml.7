Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B190FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A362190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553189932;
	bh=C7iD2l6U3+bXbfetdCeQyXVq9YDemrRkixz6M6zrTSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uXugPjD5cvRkm3LQTjDWxMQ7UvzCYbvyrGOUdydLHA84pY3MdXZGoYM4Nz5mg+ngE
	 07On6QOrzFExXiVku1sPcgC5ROLIMimpwoVBcItQVB86A307gHh94PcUZuoAxuo6xE
	 +wMMYsdDqPPu/f7xYYF4kTmGG/NYjB8V0sFkIB/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfCURiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfCURiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:38:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81E321874;
        Thu, 21 Mar 2019 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553189930;
        bh=C7iD2l6U3+bXbfetdCeQyXVq9YDemrRkixz6M6zrTSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yj8wP2EBwSOFOs4dM6tjyxMsacqwQFEKIBlvQZphyMCX43+xNphXkRlnoiSn+crCA
         lWuqoFqJcIA1BoKpPEAh2skfMpt4i1XNUTjwCGG1D01+SG5jkHxTxWKgZoEqJuR9D3
         7+nXGt84hP80TaxP+7ohAHlKI8guLdgR3FjXwGjU=
Date:   Thu, 21 Mar 2019 18:38:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] tty: fix NULL pointer issue when tty_port ops is not set
Message-ID: <20190321173847.GA7032@kroah.com>
References: <1553183006-12820-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553183006-12820-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:43:26PM +0100, Fabien Dessenne wrote:
> Unlike 'client_ops' which is initialized to 'default_client_ops', the
> port operations 'ops' may be left to NULL.
> Check the 'ops' value before checking the 'ops->x' value.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  drivers/tty/tty_port.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 044c3cb..a9e12b3 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -325,7 +325,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
>  		if (tty && C_HUPCL(tty))
>  			tty_port_lower_dtr_rts(port);
>  
> -		if (port->ops->shutdown)
> +		if (port->ops && port->ops->shutdown)
>  			port->ops->shutdown(port);
>  	}
>  out:
> @@ -398,7 +398,7 @@ EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
>   */
>  int tty_port_carrier_raised(struct tty_port *port)
>  {
> -	if (port->ops->carrier_raised == NULL)
> +	if (!port->ops || !port->ops->carrier_raised)
>  		return 1;
>  	return port->ops->carrier_raised(port);
>  }
> @@ -414,7 +414,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
>   */
>  void tty_port_raise_dtr_rts(struct tty_port *port)
>  {
> -	if (port->ops->dtr_rts)
> +	if (port->ops && port->ops->dtr_rts)
>  		port->ops->dtr_rts(port, 1);
>  }
>  EXPORT_SYMBOL(tty_port_raise_dtr_rts);
> @@ -429,7 +429,7 @@ EXPORT_SYMBOL(tty_port_raise_dtr_rts);
>   */
>  void tty_port_lower_dtr_rts(struct tty_port *port)
>  {
> -	if (port->ops->dtr_rts)
> +	if (port->ops && port->ops->dtr_rts)
>  		port->ops->dtr_rts(port, 0);
>  }
>  EXPORT_SYMBOL(tty_port_lower_dtr_rts);
> @@ -684,7 +684,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
>  
>  	if (!tty_port_initialized(port)) {
>  		clear_bit(TTY_IO_ERROR, &tty->flags);
> -		if (port->ops->activate) {
> +		if (port->ops && port->ops->activate) {
>  			int retval = port->ops->activate(port, tty);
>  			if (retval) {
>  				mutex_unlock(&port->mutex);
> -- 
> 2.7.4
> 

Can you hit this today with any in-kernel drivers?  Or is this only for
your new code you are adding?

thanks,

greg k-h
