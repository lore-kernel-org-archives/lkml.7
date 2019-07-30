Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253C7C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA592089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564501685;
	bh=v23q6sT6mo37jLw8crLVOxi87+3xb0RspTXJu+JGMbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OTbu8I9aOMePQs4/05NTBNAvvgaQTgE/8/rppXaUCHX20W3rcOTp/FkeYPM7pIYMC
	 aWeYHTrsC/rTgnjrAW9RbkA9qJTdzBxVeCJCQni1x/nTxdQbxnZ4pKaXYfvIF0e5wy
	 Pnaq9Lze3lXE4XolDXgn/YIbircYCMv0l+6BkOZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfG3PsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3PsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:48:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D37206B8;
        Tue, 30 Jul 2019 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564501681;
        bh=v23q6sT6mo37jLw8crLVOxi87+3xb0RspTXJu+JGMbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQoLs059w8Fz/xcoFtu3Ip3lOUglTg0q88z504b2bAk7QhvQOvkuf9dOu1lKd6u/f
         cfKv9QFb3kQYcpk6Hptf4IQvugrLD6WBD1ceeXBIMzEArN0Nlbsgs+vIFdHc9M6lWp
         C8/ZVJRAQwSWEhsn8bQpnN3U2IbMllpf8xrkXh0w=
Date:   Tue, 30 Jul 2019 17:47:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch v4 1/5] AST2500 DMA UART driver
Message-ID: <20190730154759.GA26425@kroah.com>
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
 <1564147640-30753-2-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564147640-30753-2-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 06:57:16PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> UART driver for Aspeed's bmc chip AST2500
> 
> Design approch:
> AST2500 has dedicated Uart DMA controller which has 12 sets of Tx and RX channels
> connected to UART controller directly.
> Since the DMA controller have dedicated buffers and registers,
> there would be little benifit in adding DMA framework overhead.
> So the software for DMA controller is included within the UART driver itself.
> 
> implementation details:
> 'struct ast_uart_port' is populated and registered with uart_core.
> code is organised into two layers UART-layer and DMA-Layer,both of them are
> in the same file.UART-layer requests Rx and Tx dma channels
> and registers callbacks with DMA controller software Layer
> Interrupt service routine for DMA controller is the crucial one for Handling all
> the tx and rx data. ISRs installed for individual uarts are just dummy,and are helpful 
> only to report any spurious interrupts in hardware.
> 
> 
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
> ---
> 
> Changes from v3->v4:
> - per port uart structures are registerd directly with uart core 
>   Instead of registering through 8250 Frame work,
>   ast_uart_port is registered using uart_add_one_port
> -SDMA_RX_FIX macro replaced with CONFIG_AST_UART_DMA_RX_INTERRUPT
> -ast_uart_sdma_isr : DMA interrupt handler code is improvised
> -replaced pr_debug with ftrace wherever appropriate
> -dev_err is used in all error return cases
> -uart driver structure ast25xx_uart_reg is modified
> -driver name changed to ast2500-uart-dma-drv
> -rx_timer initialisation and callback fn modified
> 
> Changes from v2->v3:
> -custom debug replaced by in kerenl dynamic debug: pr_debug 
> -change-logs added 
> 
> 
> .../tty/serial/8250/8250_ast2500_uart_dma.c   | 1901 +++++++++++++++++
>  1 file changed, 1901 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_ast2500_uart_dma.c
> 
> diff --git a/drivers/tty/serial/8250/8250_ast2500_uart_dma.c b/drivers/tty/serial/8250/8250_ast2500_uart_dma.c
> new file mode 100644
> index 000000000000..bc830d605372
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_ast2500_uart_dma.c
> @@ -0,0 +1,1901 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  DMA UART Driver for ASPEED BMC chip: AST2500
> + *
> + *  Copyright (C) 2019 sudheer Kumar veliseti, Aspeed technology Inc.
> + *  <open.sudheer@gmail.com>

What was the copyright on the file you copied?  Please properly
attribute that here.


> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include "8250.h"
> +
> +#define SERIAL8250_CONSOLE NULL
> +#define TTY_AST_MAJOR 204
> +#define TTY_AST_MINOR 68

Where did you get this minor number from?

> +
> +#define DMA_BUFF_SIZE		0x1000
> +#define SDMA_RX_BUFF_SIZE	0x10000
> +#define PASS_LIMIT 256
> +#define UART_DMA_NR CONFIG_AST_NR_DMA_UARTS
> +#define AST_UART_SDMA_CH 12
> +
> +/* enum ast_uart_chan_op
> + * operation codes passed to the DMA code by the user, and also used
> + * to inform the current channel owner of any changes to the system state
> + */
> +enum ast_uart_chan_op {
> +	AST_UART_DMAOP_TRIGGER,
> +	AST_UART_DMAOP_STOP,
> +	AST_UART_DMAOP_PAUSE,
> +};
> +
> +/* ast_uart_dma_cbfn: buffer callback routinei type */
> +typedef void (*ast_uart_dma_cbfn)(void *dev_id, u16 len);
> +
> +struct ast_sdma_info {
> +	u8 ch_no;
> +	u8 direction;
> +	u8 enable;
> +	void *priv;
> +	char *sdma_virt_addr;
> +	dma_addr_t dma_phy_addr;
> +	/* cdriver callbacks */
> +	ast_uart_dma_cbfn callback_fn; /* buffer done callback */
> +};
> +
> +struct ast_sdma_ch {
> +	struct ast_sdma_info tx_dma_info[AST_UART_SDMA_CH];
> +	struct ast_sdma_info rx_dma_info[AST_UART_SDMA_CH];
> +};
> +
> +struct ast_sdma {
> +	void __iomem *reg_base;
> +	int dma_irq;
> +	struct ast_sdma_ch *dma_ch;
> +	struct regmap *map;
> +};
> +
> +#define UART_TX_SDMA_EN		0x00
> +#define UART_RX_SDMA_EN		0x04
> +#define UART_SDMA_CONF		0x08 /* Misc, Buffer size  */
> +#define UART_SDMA_TIMER		0x0C
> +#define UART_TX_SDMA_REST	0x20
> +#define UART_RX_SDMA_REST	0x24
> +#define UART_TX_SDMA_IER	0x30
> +#define UART_TX_SDMA_ISR	0x34
> +#define UART_RX_SDMA_IER	0x38
> +#define UART_RX_SDMA_ISR	0x3C
> +#define UART_TX_R_POINT(x)	(0x40 + ((x) * 0x20))
> +#define UART_TX_W_POINT(x)	(0x44 + ((x) * 0x20))
> +#define UART_TX_SDMA_ADDR(x)	(0x48 + ((x) * 0x20))
> +#define UART_RX_R_POINT(x)	(0x50 + ((x) * 0x20))
> +#define UART_RX_W_POINT(x)	(0x54 + ((x) * 0x20))
> +#define UART_RX_SDMA_ADDR(x)	(0x58 + ((x) * 0x20))
> +#define SDMA_CH_EN(x)		BIT(x)
> +
> +#define SDMA_TX_BUFF_SIZE_MASK	(0x3)
> +#define SDMA_SET_TX_BUFF_SIZE(x)(x)
> +#define SDMA_BUFF_SIZE_1KB	(0x0)
> +#define SDMA_BUFF_SIZE_4KB	(0x1)
> +#define SDMA_BUFF_SIZE_16KB	(0x2)
> +#define SDMA_BUFF_SIZE_64KB	(0x3)
> +#define SDMA_RX_BUFF_SIZE_MASK	(0x3 << 2)
> +#define SDMA_SET_RX_BUFF_SIZE(x)((x) << 2)
> +#define SDMA_TIMEOUT_DIS	BIT(4)
> +
> +#define UART_SDMA11_INT		BIT(11)
> +#define UART_SDMA10_INT		BIT(10)
> +#define UART_SDMA9_INT		BIT(9)
> +#define UART_SDMA8_INT		BIT(8)
> +#define UART_SDMA7_INT		BIT(7)
> +#define UART_SDMA6_INT		BIT(6)
> +#define UART_SDMA5_INT		BIT(5)
> +#define UART_SDMA4_INT		BIT(4)
> +#define UART_SDMA3_INT		BIT(3)
> +#define UART_SDMA2_INT		BIT(2)
> +#define UART_SDMA1_INT		BIT(1)
> +#define UART_SDMA0_INT		BIT(0)
> +
> +/*
> + * Configuration:
> + *   share_irqs - whether we pass IRQF_SHARED to request_irq().
> + *   This option is unsafe when used on edge-triggered interrupts.
> + */
> +static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
> +
> +static unsigned int nr_uarts = CONFIG_AST_RUNTIME_DMA_UARTS;
> +
> +struct ast_uart_port {
> +	struct uart_port port;
> +	unsigned short capabilities; /* port capabilities */
> +	unsigned short bugs;         /* port bugs */
> +	unsigned int tx_loadsz;      /* transmit fifo load size */
> +	unsigned char acr;
> +	unsigned char ier;
> +	unsigned char lcr;
> +	unsigned char mcr;
> +	unsigned char mcr_mask;  /* mask of user bits */
> +	unsigned char mcr_force; /* mask of forced bits */
> +	struct circ_buf rx_dma_buf;
> +	struct circ_buf tx_dma_buf;
> +	unsigned char dma_channel;
> +	dma_addr_t dma_rx_addr; /* Mapped ADMA descr. table */
> +	dma_addr_t dma_tx_addr; /* Mapped ADMA descr. table */
> +#ifdef CONFIG_AST_UART_DMA_RX_INTERRUPT
> +	struct tasklet_struct rx_tasklet;
> +#else
> +	struct timer_list rx_timer;
> +	unsigned int workaround;
> +#endif
> +	struct tasklet_struct tx_tasklet;
> +	spinlock_t lock;
> +	int tx_done;
> +	int tx_count;
> +	struct platform_device *ast_uart_pdev;
> +/*
> + * Some bits in registers are cleared on a read, so they must
> + * be saved whenever the register is read but the bits will not
> + * be immediately processed.
> + */
> +#define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
> +	unsigned char lsr_saved_flags;
> +#define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
> +	unsigned char msr_saved_flags;
> +
> +	/*
> +	 * We provide a per-port pm hook.
> +	 */
> +	void (*pm)(struct uart_port *port, unsigned int state,
> +						 unsigned int old);
> +};
> +
> +static struct ast_uart_port ast_uart_ports[UART_DMA_NR];
> +
> +#define GET_DEV(ast_uart_port_priv_ptr)\
> +		(ast_uart_port_priv_ptr->ast_uart_pdev->dev)
> +
> +static inline struct ast_uart_port *
> +to_ast_dma_uart_port(struct uart_port *uart) {
> +	return container_of(uart, struct ast_uart_port, port);
> +}
> +
> +struct irq_info {
> +	spinlock_t lock;
> +	struct ast_uart_port *up;
> +};
> +
> +static struct irq_info ast_uart_irq[1];
> +static DEFINE_MUTEX(ast_uart_mutex);
> +
> +/*
> + * Here we define the default xmit fifo size used for each type of UART.
> + */
> +static const struct serial8250_config uart_config[] = {
> +	[PORT_UNKNOWN] = {
> +		.name		= "unknown",
> +		.fifo_size	= 1,
> +		.tx_loadsz	= 1,
> +	},
> +	[PORT_8250] = {
> +		.name		= "8250",
> +		.fifo_size	= 1,
> +		.tx_loadsz	= 1,
> +	},
> +	[PORT_16450] = {
> +		.name		= "16450",
> +		.fifo_size	= 1,
> +		.tx_loadsz	= 1,
> +	},
> +	[PORT_16550] = {
> +		.name		= "16550",
> +		.fifo_size	= 1,
> +		.tx_loadsz	= 1,
> +	},
> +	[PORT_16550A] = {
> +		.name		= "16550A",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10
> +							| UART_FCR_DMA_SELECT,
> +		.flags		= UART_CAP_FIFO,
> +	},
> +};

I doubt you need all of these port types, right?  You only have one type
of device, please strip out _ALL_ of the unneeded code in here.  You did
a wholesale copy of the old driver, to get away with that you then need
to customize it to work properly with your hardware _AND_ take away all
code that is not needed for your hardware.

Lots of this file can be removed, please do so.

thanks,

greg k-h
