Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A18C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312E42081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564049560;
	bh=IUiK3CXORAiXr34sRDAZiSkT7lsj9He6VEsLeWsVspE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SJsKNzoN1KLE5kOZkV2b0vRDXidkhJswkN6NK3RwATvmoipEPbsNe1sELUX+w/aPV
	 uT8MoyuJl1sla2AskzkiiEpTyq25mHQkWBA8LguXgBtiZSwp3TJgo3BOkAXzSl0SjC
	 17RvtvIWcKsqsEX92SHrEWOWOaZQ0fvJxPsx2iFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbfGYKMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387531AbfGYKMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:12:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 812992081B;
        Thu, 25 Jul 2019 10:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564049557;
        bh=IUiK3CXORAiXr34sRDAZiSkT7lsj9He6VEsLeWsVspE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6xQse2oPxw/Xj2nZ2x7z6HIhQvqU8IO306ArntESRaVmJcKmojCn5DjMvPAsfuzU
         yoaSMv/1bdEyg4fcxwKndOUdY2ON/rdm42gkTvMcp56Jz9135aey4VWlh029vPuskJ
         zHwuK05STaiTF5UNWClx4+p0IAsBo4D53ykEy2AE=
Date:   Thu, 25 Jul 2019 12:12:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Message-ID: <20190725101234.GA7550@kroah.com>
References: <20190705131528.60752-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705131528.60752-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 06:15:28AM -0700, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> ---
> v3 -> v4:
> - Add changes description.
> 
> v2 -> v3:
> - Add "full" name for author
> - Use BIT() macro for bits definition
> - Remove unnecessary WARN_ON()
> - Change debugging interface to ftrace
> - Fix indentation
> - Add NI PXIe-RS232 and PXI/PXIe-RS485 device IDs #defines
> 
> v1 -> v2:
> - Fix unintended indentation 
> 
> v1:
> - Add and rename #defines for 16550 UART Port Control Register
> - Add configuration for RS485 port.
> - Add device setup for NI PXI/PXIe-RS485 family.
> - Add PCI board attributes for NI PXIe-RS232 and PXI/PXIe-RS485 devices.
> 
>  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
>  1 file changed, 294 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index df41397de478..23fe3b7197ad 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -730,8 +730,16 @@ static int pci_ni8430_init(struct pci_dev *dev)
>  }
>  
>  /* UART Port Control Register */
> -#define NI8430_PORTCON	0x0f
> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
> +#define NI16550_PCR_OFFSET	0x0f
> +#define NI16550_PCR_RS422	0x00
> +#define NI16550_PCR_ECHO_RS485	0x01
> +#define NI16550_PCR_DTR_RS485	0x02
> +#define NI16550_PCR_AUTO_RS485	0x03
> +#define NI16550_PCR_WIRE_MODE_MASK	0x03
> +#define NI16550_PCR_TXVR_ENABLE_BIT	BIT(3)
> +#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
> +#define NI16550_ACR_DTR_AUTO_DTR	(0x2 << 3)
> +#define NI16550_ACR_DTR_MANUAL_DTR	(0x0 << 3)
>  
>  static int
>  pci_ni8430_setup(struct serial_private *priv,
> @@ -753,14 +761,123 @@ pci_ni8430_setup(struct serial_private *priv,
>  		return -ENOMEM;
>  
>  	/* enable the transceiver */
> -	writeb(readb(p + offset + NI8430_PORTCON) | NI8430_PORTCON_TXVR_ENABLE,
> -	       p + offset + NI8430_PORTCON);
> +	writeb(readb(p + offset + NI16550_PCR_OFFSET) | NI16550_PCR_TXVR_ENABLE_BIT,
> +	       p + offset + NI16550_PCR_OFFSET);
>  
>  	iounmap(p);
>  
>  	return setup_port(priv, port, bar, offset, board->reg_shift);
>  }
>  
> +static int pci_ni8431_config_rs485(struct uart_port *port,
> +	struct serial_rs485 *rs485)
> +{
> +	u8 pcr, acr;
> +
> +	struct uart_8250_port *up;

No blank lines between variable definitions please.

> +
> +	up = container_of(port, struct uart_8250_port, port);
> +
> +	acr = up->acr;
> +
> +	trace_printk("start ni16550_config_rs485\n");

This line is not needed, right?

> +
> +	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
> +	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* RS-485 */
> +		if ((rs485->flags & SER_RS485_RX_DURING_TX) &&
> +			(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> +			dev_dbg(port->dev, "Invalid 2-wire mode\n");
> +			return -EINVAL;
> +		}
> +
> +		if (rs485->flags & SER_RS485_RX_DURING_TX) {
> +			/* Echo */
> +			dev_vdbg(port->dev, "2-wire DTR with echo\n");
> +			pcr |= NI16550_PCR_ECHO_RS485;
> +			acr |= NI16550_ACR_DTR_MANUAL_DTR;
> +		} else {
> +			/* Auto or DTR */
> +			if (rs485->flags & SER_RS485_RTS_ON_SEND) {
> +				/* Auto */
> +				dev_vdbg(port->dev, "2-wire Auto\n");
> +				pcr |= NI16550_PCR_AUTO_RS485;
> +				acr |= NI16550_ACR_DTR_AUTO_DTR;
> +			} else {
> +				/* DTR-controlled */
> +				/* No Echo */
> +				dev_vdbg(port->dev, "2-wire DTR no echo\n");
> +				pcr |= NI16550_PCR_DTR_RS485;
> +				acr |= NI16550_ACR_DTR_MANUAL_DTR;
> +			}
> +		}
> +	} else {
> +		/* RS-422 */
> +		dev_vdbg(port->dev, "4-wire\n");
> +		pcr |= NI16550_PCR_RS422;
> +		acr |= NI16550_ACR_DTR_MANUAL_DTR;
> +	}
> +
> +	dev_dbg(port->dev, "write pcr: 0x%08x\n", pcr);
> +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
> +
> +	up->acr = acr;
> +	port->serial_out(port, UART_SCR, UART_ACR);
> +	port->serial_out(port, UART_ICR, up->acr);
> +
> +	/* Update the cache. */
> +	port->rs485 = *rs485;
> +
> +	trace_printk("end ni16550_config_rs485\n");

Also drop this.

thanks,

greg k-h
