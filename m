Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF20B218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562176176;
	bh=ttXIOHM07+jrDNDht2eVI6jhWLKWAfy5Y5DM4IaBXxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aig9TIm+23LYbP7xdhPcX4Lmz6xgE/xidM+gJK/NNwMvdK3Z4nz0I+r/oNua4RoHP
	 bN6jQUziVqfldccJ/09dOFgtakGYqCRxU9IWPkf2iPfp2eN2PHNLtCyZvCGWzHnZj6
	 EZSio3Y23mREiQqV3Gm+cTMAHuhfRKDliHd99ec8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfGCRte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCRtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:49:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90A92189E;
        Wed,  3 Jul 2019 17:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562176170;
        bh=ttXIOHM07+jrDNDht2eVI6jhWLKWAfy5Y5DM4IaBXxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+QD98GrUF9e3DGjAz4oVc6iAjN7jdrUKYMo1rflcKYK5Gpt2mGYtWDejFvD5Ux4O
         n/M4V64hXX3JMNqGd5F8futR5a93+aURpz0bOvVVESaVjIASfWCHil2KmVPsnxj3DU
         sq/27TUEcLc7FvrXQvy+GnBndWwmC19EPkAHEHqE=
Date:   Wed, 3 Jul 2019 19:49:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch v3 1/5] AST2500 DMA UART driver
Message-ID: <20190703174926.GA12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
 <1561459476-14268-2-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561459476-14268-2-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 04:14:32PM +0530, sudheer.v wrote:
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
> 'struct uart_8250_port' serial port  is populated and registered with 8250_core.
> Rx and Tx dma channels are requested from DMA controller software Layer, which
> is part of uart driver itself.
> Interrupt service routine for DMA controller is the crucial one for Handling all
> the tx and rx data. ISRs installed for individual uarts are just dummy,and are helpful 
> only to report any spurious interrupts in hardware.
> 
> 
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
> ---
> 
> Changes in v3:
> -custom debug replaced by in kerenl dynamic debug: pr_debug 
> -change-logs added 
> 
> .../tty/serial/8250/8250_ast2500_uart_dma.c   | 1879 +++++++++++++++++
>  1 file changed, 1879 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_ast2500_uart_dma.c
> 
> diff --git a/drivers/tty/serial/8250/8250_ast2500_uart_dma.c b/drivers/tty/serial/8250/8250_ast2500_uart_dma.c
> new file mode 100644
> index 000000000000..13911a0a745a
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_ast2500_uart_dma.c
> @@ -0,0 +1,1879 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  DMA UART Driver for ASPEED BMC chip: AST2500
> + *
> + *  Copyright (C) 2019 sudheer Kumar veliseti, Aspeed technology Inc.
> + *  <open.sudheer@gmail.com>
> + *
> + */
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/clk.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/init.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
> +#include <linux/nmi.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/serial.h>
> +#include <linux/serial_8250.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>

Do you really need all of these include files?  Seems like a lot...

> +
> +#include "8250.h"
> +
> +#define DMA_BUFF_SIZE 0x1000      // 4096
> +#define SDMA_RX_BUFF_SIZE 0x10000 // 65536

We know what 0x1000 and 0x10000 is :)

Also, try to line up your defines.

> +
> +#define SDDMA_RX_FIX 1
> +/* enum ast_uart_chan_op
> + * operation codes passed to the DMA code by the user, and also used
> + * to inform the current channel owner of any changes to the system state
> + */
> +
> +enum ast_uart_chan_op {

Very odd spacing, add one above the comment and remove the one below.

> +	AST_UART_DMAOP_TRIGGER,
> +	AST_UART_DMAOP_STOP,
> +	AST_UART_DMAOP_PAUSE,
> +};
> +
> +/* ast_uart_dma_cbfn_t *  * buffer callback routine type */

Do not use _t if possible.  ANd odd placement of "*  *"

> +typedef void (*ast_uart_dma_cbfn_t)(void *dev_id, u16 len);
> +
> +struct ast_sdma_info {
> +	u8 ch_no;
> +	u8 direction;
> +	u8 enable;
> +	void *priv;
> +	char *sdma_virt_addr;
> +	dma_addr_t dma_phy_addr;
> +	/* cdriver callbacks */
> +	ast_uart_dma_cbfn_t callback_fn; /* buffer done callback */
> +};
> +
> +#define AST_UART_SDMA_CH 12
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
> +
> +
> +#define UART_TX_SDMA_EN 0x00
> +#define UART_RX_SDMA_EN 0x04
> +#define UART_SDMA_CONF 0x08
> +#define UART_SDMA_TIMER 0x0C
> +#define UART_TX_SDMA_REST 0x20
> +#define UART_RX_SDMA_REST 0x24
> +#define UART_TX_SDMA_IER 0x30
> +#define UART_TX_SDMA_ISR 0x34
> +#define UART_RX_SDMA_IER 0x38
> +#define UART_RX_SDMA_ISR 0x3C
> +#define UART_TX_R_POINT(x) (0x40 + (x * 0x20))
> +#define UART_TX_W_POINT(x) (0x44 + (x * 0x20))
> +#define UART_TX_SDMA_ADDR(x) (0x48 + (x * 0x20))
> +#define UART_RX_R_POINT(x) (0x50 + (x * 0x20))
> +#define UART_RX_W_POINT(x) (0x54 + (x * 0x20))
> +#define UART_RX_SDMA_ADDR(x) (0x58 + (x * 0x20))

Please use a tab to line these up.

> +/* UART_TX_SDMA_EN-0x00 : UART TX DMA Enable */
> +/* UART_RX_SDMA_EN-0x04 : UART RX DMA Enable */

What are these for?

> +#define SDMA_CH_EN(x) (0x1 << (x))

BIT()?

> +
> +/* UART_SDMA_CONF - 0x08 : Misc, Buffer size  */
> +#define SDMA_TX_BUFF_SIZE_MASK (0x3)
> +#define SDMA_SET_TX_BUFF_SIZE(x) (x)
> +#define SDMA_BUFF_SIZE_1KB (0x0)
> +#define SDMA_BUFF_SIZE_4KB (0x1)
> +#define SDMA_BUFF_SIZE_16KB (0x2)
> +#define SDMA_BUFF_SIZE_64KB (0x3)
> +#define SDMA_RX_BUFF_SIZE_MASK (0x3 << 2)
> +#define SDMA_SET_RX_BUFF_SIZE(x) (x << 2)
> +#define SDMA_TIMEOUT_DIS (0x1 << 4)
> +
> +/* UART_SDMA_TIMER-0x0C :  UART DMA time out timer */
> +
> +/* UART_TX_SDMA_IER			0x30	*/
> +/* UART_TX_SDMA_ISR			0x34	*/

What is this?

> +
> +#define UART_SDMA11_INT (1 << 11)
> +#define UART_SDMA10_INT (1 << 10)
> +#define UART_SDMA9_INT (1 << 9)
> +#define UART_SDMA8_INT (1 << 8)
> +#define UART_SDMA7_INT (1 << 7)
> +#define UART_SDMA6_INT (1 << 6)
> +#define UART_SDMA5_INT (1 << 5)
> +#define UART_SDMA4_INT (1 << 4)
> +#define UART_SDMA3_INT (1 << 3)
> +#define UART_SDMA2_INT (1 << 2)
> +#define UART_SDMA1_INT (1 << 1)
> +#define UART_SDMA0_INT (1 << 0)

Please use BIT()

> +
> +
> +/*
> + * Configuration:
> + *   share_irqs - whether we pass IRQF_SHARED to request_irq().  This option
> + *                is unsafe when used on edge-triggered interrupts.
> + */
> +static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
> +
> +static unsigned int nr_uarts = CONFIG_AST_RUNTIME_DMA_UARTS;
> +
> +
> +#define PASS_LIMIT 256
> +
> +#include <asm/serial.h>

Why way down here?

> +
> +#define UART_DMA_NR CONFIG_AST_NR_DMA_UARTS
> +
> +
> +struct ast_uart_priv_data {
> +
> +	unsigned short line; //index of uart port

No need for a blank line.

> +	struct uart_8250_port *up;
> +	u8 dma_ch; // dma channel number
> +	struct circ_buf rx_dma_buf;
> +	struct circ_buf tx_dma_buf;
> +	dma_addr_t dma_rx_addr; /* Mapped ADMA descr. table */
> +	dma_addr_t dma_tx_addr; /* Mapped ADMA descr. table */
> +#ifdef SDDMA_RX_FIX
> +	struct tasklet_struct rx_tasklet;
> +#else
> +	struct timer_list rx_timer;
> +#endif
> +	struct tasklet_struct tx_tasklet;
> +	spinlock_t lock;
> +	int tx_done;
> +	int tx_count;
> +};
> +
> +
> +static inline struct uart_8250_port *
> +to_uart_8250_port(struct uart_port *uart) {
> +	return container_of(uart, struct uart_8250_port, port);
> +}

Use a #define for a container_of() macro please.

> +
> +struct irq_info {
> +	spinlock_t lock;
> +	struct uart_8250_port *up;
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
> +
> +/* sane hardware needs no mapping */
> +#define map_8250_in_reg(up, offset) (offset)
> +#define map_8250_out_reg(up, offset) (offset)


Why is this even needed?


> +
> +// SDMA - software Layer : (previously was in ast-uart-sdma.c)

"previously"?

> +static inline void ast_uart_sdma_write(struct ast_sdma *sdma,
> +						u32 val, u32 reg)
> +{
> +	pr_debug("uart dma write:val:%x,reg:%x\n", val, reg);

No need for debugging, use ftrace.

> +	writel(val, sdma->reg_base + reg);
> +}
> +
> +static inline u32 ast_uart_sdma_read(struct ast_sdma *sdma, u32 reg)
> +{
> +	return readl(sdma->reg_base + reg);
> +}
> +
> +struct ast_sdma ast_uart_sdma;

static?

> +
> +int ast_uart_rx_sdma_enqueue(u8 ch, dma_addr_t rx_buff)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +
> +	pr_debug("ch = %d, rx buff = %x\n", ch, rx_buff);

Remove debugging please, use ftrace.

> +
> +	local_irq_save(flags);
> +	ast_uart_sdma_write(sdma, rx_buff, UART_RX_SDMA_ADDR(ch));
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}

If these functions are not used, why are they here?



> +
> +int ast_uart_tx_sdma_enqueue(u8 ch, dma_addr_t tx_buff)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +
> +	pr_debug("ch = %d, tx buff = %x\n", ch, tx_buff);
> +
> +	local_irq_save(flags);
> +	ast_uart_sdma_write(sdma, tx_buff, UART_TX_SDMA_ADDR(ch));
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +int ast_uart_rx_sdma_ctrl(u8 ch, enum ast_uart_chan_op op)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +	struct ast_sdma_info *dma_ch = &(sdma->dma_ch->rx_dma_info[ch]);
> +
> +	pr_debug("RX DMA CTRL [ch %d]\n", ch);

Again, please remove.  Same thing everywhere in these patches.

> +
> +	local_irq_save(flags);
> +
> +	switch (op) {
> +	case AST_UART_DMAOP_TRIGGER:
> +	pr_debug("Trigger\n");
> +	dma_ch->enable = 1;
> +#ifdef SDDMA_RX_FIX

If you can not define this as a build option, then just remove it from
here.

> +#else
> +	ast_uart_set_sdma_time_out(0xffff);
> +#endif
> +	// set enable
> +	ast_uart_sdma_write(sdma,
> +			ast_uart_sdma_read(sdma, UART_RX_SDMA_EN) | (0x1 << ch),
> +			UART_RX_SDMA_EN);
> +	break;

Did you run this patch through checkpatch?  Please properly indent the
case statement blocks.

> +	case AST_UART_DMAOP_STOP:
> +	// disable engine
> +	pr_debug("STOP\n");
> +	dma_ch->enable = 0;
> +	ast_uart_sdma_write(sdma, ast_uart_sdma_read(sdma, UART_RX_SDMA_EN) &
> +				  ~(0x1 << ch),
> +			UART_RX_SDMA_EN);
> +	// set reset
> +	ast_uart_sdma_write(sdma, ast_uart_sdma_read(sdma, UART_RX_SDMA_REST) |
> +				  (0x1 << ch),
> +			UART_RX_SDMA_REST);
> +	ast_uart_sdma_write(sdma, ast_uart_sdma_read(sdma, UART_RX_SDMA_REST) &
> +				  ~(0x1 << ch),
> +			UART_RX_SDMA_REST);
> +
> +	ast_uart_sdma_write(sdma, 0, UART_RX_R_POINT(ch));
> +	ast_uart_sdma_write(sdma, dma_ch->dma_phy_addr, UART_RX_SDMA_ADDR(ch));
> +	break;
> +	case AST_UART_DMAOP_PAUSE:
> +	// disable engine
> +	dma_ch->enable = 0;
> +	ast_uart_sdma_write(sdma, ast_uart_sdma_read(sdma, UART_RX_SDMA_EN) &
> +				  ~(0x1 << ch),
> +			UART_RX_SDMA_EN);
> +	break;
> +	}
> +
> +	local_irq_restore(flags);
> +	return 0;
> +}
> +
> +int ast_uart_tx_sdma_ctrl(u8 ch, enum ast_uart_chan_op op)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +	struct ast_sdma_info *dma_ch = &(sdma->dma_ch->tx_dma_info[ch]);
> +
> +	pr_debug("TX DMA CTRL [ch %d]\n", ch);
> +
> +	local_irq_save(flags);
> +
> +	switch (op) {
> +	case AST_UART_DMAOP_TRIGGER:
> +	pr_debug("TRIGGER : Enable\n");
> +	dma_ch->enable = 1;
> +	// set enable
> +	ast_uart_sdma_write(sdma,
> +			ast_uart_sdma_read(sdma, UART_TX_SDMA_EN) | (0x1 << ch),
> +			UART_TX_SDMA_EN);
> +	break;
> +	case AST_UART_DMAOP_STOP:
> +	pr_debug("STOP : DISABLE & RESET\n");
> +	dma_ch->enable = 0;
> +	// disable engine
> +	ast_uart_sdma_write(sdma, ast_uart_sdma_read(sdma, UART_TX_SDMA_EN) &
> +				  ~(0x1 << ch),
> +			UART_TX_SDMA_EN);
> +	// set reset
> +	ast_uart_sdma_write(sdma, ast_uart_sdma_read(sdma, UART_TX_SDMA_REST) |
> +				  (0x1 << ch),
> +			UART_TX_SDMA_REST);
> +	ast_uart_sdma_write(sdma, ast_uart_sdma_read(sdma, UART_TX_SDMA_REST) &
> +				  ~(0x1 << ch),
> +			UART_TX_SDMA_REST);
> +
> +	ast_uart_sdma_write(sdma, 0, UART_TX_W_POINT(ch));
> +	break;
> +	case AST_UART_DMAOP_PAUSE:
> +	pr_debug("PAUSE : DISABLE\n");
> +	dma_ch->enable = 0;
> +	// disable engine
> +	ast_uart_sdma_write(sdma, ast_uart_sdma_read(sdma, UART_TX_SDMA_EN) &
> +				  ~(0x1 << ch),
> +			UART_TX_SDMA_EN);
> +	}
> +
> +	local_irq_restore(flags);
> +	return 0;
> +}
> +
> +u32 ast_uart_get_tx_sdma_pt(u8 ch)
> +{
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +
> +	return ast_uart_sdma_read(sdma, UART_TX_R_POINT(ch));
> +}
> +
> +int ast_uart_tx_sdma_update(u8 ch, u16 point)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +
> +	pr_debug("TX DMA CTRL [ch %d] point %d\n", ch, point);
> +	local_irq_save(flags);
> +	ast_uart_sdma_write(sdma, point, UART_TX_W_POINT(ch));
> +	local_irq_restore(flags);
> +	return 0;
> +}
> +
> +int ast_uart_tx_sdma_request(u8 ch, ast_uart_dma_cbfn_t rtn, void *id)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +	struct ast_sdma_info *dma_ch = &(sdma->dma_ch->tx_dma_info[ch]);
> +
> +	pr_debug("TX DMA REQUEST ch = %d\n", ch);
> +
> +	local_irq_save(flags);
> +
> +	if (dma_ch->enable) {
> +		local_irq_restore(flags);
> +		return -EBUSY;
> +	}
> +	dma_ch->priv = id;
> +	dma_ch->callback_fn = rtn;
> +
> +	// DMA IRQ En
> +	ast_uart_sdma_write(sdma,
> +		      ast_uart_sdma_read(sdma, UART_TX_SDMA_IER) | (1 << ch),
> +		      UART_TX_SDMA_IER);
> +
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +int ast_uart_rx_sdma_update(u8 ch, u16 point)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +
> +	pr_debug("RX DMA CTRL [ch %d] point %x\n", ch, point);
> +
> +	local_irq_save(flags);
> +	ast_uart_sdma_write(sdma, point, UART_RX_R_POINT(ch));
> +	local_irq_restore(flags);
> +	return 0;
> +}
> +
> +#ifdef SDDMA_RX_FIX
> +char *ast_uart_rx_sdma_request(u8 ch, ast_uart_dma_cbfn_t rtn, void *id)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +	struct ast_sdma_info *dma_ch = &(sdma->dma_ch->rx_dma_info[ch]);
> +
> +	pr_debug("RX DMA REQUEST ch = %d\n", ch);
> +
> +	local_irq_save(flags);
> +
> +	if (dma_ch->enable) {
> +		local_irq_restore(flags);
> +		return 0;
> +	}
> +	dma_ch->priv = id;
> +
> +	dma_ch->callback_fn = rtn;
> +
> +	// DMA IRQ En
> +	ast_uart_sdma_write(sdma,
> +		      ast_uart_sdma_read(sdma, UART_RX_SDMA_IER) | (1 << ch),
> +		      UART_RX_SDMA_IER);
> +
> +	local_irq_restore(flags);
> +
> +	return dma_ch->sdma_virt_addr;
> +}
> +
> +#else
> +char *ast_uart_rx_sdma_request(u8 ch, void *id)
> +{
> +	unsigned long flags;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +	struct ast_sdma_info *dma_ch = &(sdma->dma_ch->rx_dma_info[ch]);
> +
> +	pr_debug("RX DMA REQUEST ch = %d\n", ch);
> +
> +	local_irq_save(flags);
> +
> +	if (dma_ch->enable) {
> +		local_irq_restore(flags);
> +		return -EBUSY;
> +	}
> +	dma_ch->priv = id;
> +
> +	local_irq_restore(flags);
> +	return dma_ch->sdma_virt_addr;
> +}
> +#endif
> +
> +u16 ast_uart_get_rx_sdma_pt(u8 ch)
> +{
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +
> +	return ast_uart_sdma_read(sdma, UART_RX_W_POINT(ch));
> +}
> +
> +void ast_uart_set_sdma_time_out(u16 val)
> +{
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +
> +	ast_uart_sdma_write(sdma, val, UART_SDMA_TIMER);
> +}
> +
> +static inline void ast_sdma_bufffdone(struct ast_sdma_info *sdma_ch)
> +{
> +	u32 len;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +
> +	if (sdma_ch->enable == 0) {
> +		pr_debug("sdma Please check ch_no %x %s!!!!!\n",
> +			sdma_ch->ch_no, sdma_ch->direction ? "TX" : "RX");
> +		if (sdma_ch->direction) {
> +			ast_uart_sdma_write(sdma,
> +				ast_uart_sdma_read(sdma, UART_TX_SDMA_EN)
> +				& ~(0x1 << sdma_ch->ch_no), UART_TX_SDMA_EN);
> +		} else {
> +			ast_uart_sdma_write(sdma,
> +				ast_uart_sdma_read(sdma, UART_RX_SDMA_EN) &
> +				~(0x1 << sdma_ch->ch_no), UART_RX_SDMA_EN);
> +			ast_uart_rx_sdma_update(sdma_ch->ch_no,
> +				ast_uart_get_rx_sdma_pt(sdma_ch->ch_no));
> +			pr_debug("OFFSET : UART_RX_SDMA_EN = %x\n ",
> +				ast_uart_sdma_read(sdma, UART_RX_SDMA_EN));
> +		}
> +		return;
> +	}
> +
> +	if (sdma_ch->direction) {
> +		len = ast_uart_sdma_read(sdma, UART_TX_R_POINT(sdma_ch->ch_no));
> +		pr_debug("tx rp %x , wp %x\n",
> +		ast_uart_sdma_read(sdma, UART_TX_R_POINT(sdma_ch->ch_no)),
> +		ast_uart_sdma_read(sdma, UART_TX_W_POINT(sdma_ch->ch_no))
> +		);
> +	} else {
> +		pr_debug("rx rp %x , wp %x\n",
> +		ast_uart_sdma_read(sdma, UART_RX_R_POINT(sdma_ch->ch_no)),
> +		ast_uart_sdma_read(sdma, UART_RX_W_POINT(sdma_ch->ch_no))
> +		);
> +		len = ast_uart_sdma_read(sdma, UART_RX_W_POINT(sdma_ch->ch_no));
> +	}
> +
> +	pr_debug("<dma dwn>: ch[%d] : %s ,len : %d\n", sdma_ch->ch_no,
> +				sdma_ch->direction ? "tx" : "rx", len);
> +
> +	if (sdma_ch->callback_fn != NULL)
> +		(sdma_ch->callback_fn)(sdma_ch->priv, len);
> +}
> +
> +static irqreturn_t ast_uart_sdma_isr(int irq, void *dev_id)
> +{
> +	struct ast_sdma *sdma = (struct ast_sdma *)dev_id;
> +
> +	u32 tx_sts = ast_uart_sdma_read(sdma, UART_TX_SDMA_ISR);
> +	u32 rx_sts = ast_uart_sdma_read(sdma, UART_RX_SDMA_ISR);
> +
> +	pr_debug("tx sts : %x, rx sts : %x\n", tx_sts, rx_sts);
> +
> +	if ((tx_sts == 0) && (rx_sts == 0)) {
> +		pr_debug("SDMA IRQ ERROR !!!\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (rx_sts & UART_SDMA0_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA0_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[0]));
> +	} else if (rx_sts & UART_SDMA1_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA1_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[1]));
> +	} else if (rx_sts & UART_SDMA2_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA2_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[2]));
> +	} else if (rx_sts & UART_SDMA3_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA3_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[3]));
> +	} else if (rx_sts & UART_SDMA4_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA4_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[4]));
> +	} else if (rx_sts & UART_SDMA5_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA5_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[5]));
> +	} else if (rx_sts & UART_SDMA6_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA6_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[6]));
> +	} else if (rx_sts & UART_SDMA7_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA7_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[7]));
> +	} else if (rx_sts & UART_SDMA8_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA8_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[8]));
> +	} else if (rx_sts & UART_SDMA9_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA9_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[9]));
> +	} else if (rx_sts & UART_SDMA10_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA10_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[10]));
> +	} else if (rx_sts & UART_SDMA11_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA11_INT, UART_RX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->rx_dma_info[11]));
> +	} else {
> +
> +	}

Why a blank else {} ?

> +
> +	if (tx_sts & UART_SDMA0_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA0_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[0]));
> +	} else if (tx_sts & UART_SDMA1_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA1_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[1]));
> +	} else if (tx_sts & UART_SDMA2_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA2_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[2]));
> +	} else if (tx_sts & UART_SDMA3_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA3_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[3]));
> +	} else if (tx_sts & UART_SDMA4_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA4_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[4]));
> +	} else if (tx_sts & UART_SDMA5_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA5_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[5]));
> +	} else if (tx_sts & UART_SDMA6_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA6_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[6]));
> +	} else if (tx_sts & UART_SDMA7_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA7_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[7]));
> +	} else if (tx_sts & UART_SDMA8_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA8_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[8]));
> +	} else if (tx_sts & UART_SDMA9_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA9_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[9]));
> +	} else if (tx_sts & UART_SDMA10_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA10_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[10]));
> +	} else if (tx_sts & UART_SDMA11_INT) {
> +		ast_uart_sdma_write(sdma, UART_SDMA11_INT, UART_TX_SDMA_ISR);
> +		ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[11]));
> +	} else {
> +	}

Why a blank else {} ?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ast_uart_sdma_probe(void)
> +{
> +	int i;
> +	struct device_node *node;
> +	int ret;
> +	struct ast_sdma *sdma = &ast_uart_sdma;
> +	char *rx_dma_virt_addr;
> +	dma_addr_t rx_dma_phy_addr;
> +
> +	sdma->dma_ch = kzalloc(sizeof(struct ast_sdma_ch), GFP_KERNEL);
> +	if (!sdma->dma_ch)
> +		return -ENOMEM;
> +
> +	// sdma memory mapping
> +	node = of_find_compatible_node(NULL, NULL, "aspeed,ast-uart-sdma");
> +	if (!node)
> +		return -ENODEV;
> +
> +	sdma->reg_base = of_iomap(node, 0);
> +	if (IS_ERR(sdma->reg_base))
> +		return PTR_ERR(sdma->map);
> +	rx_dma_virt_addr = dma_alloc_coherent(NULL,
> +	SDMA_RX_BUFF_SIZE * AST_UART_SDMA_CH, &rx_dma_phy_addr, GFP_KERNEL);

Properly indent things, this is impossible to read.

> +
> +	if (!rx_dma_virt_addr) {
> +		pr_debug("rx_dma_virt_addr Err:dma alloc Failed\n");
> +		return -ENOMEM;
> +	}
> +	for (i = 0; i < AST_UART_SDMA_CH; i++) {
> +		// TX ------------------------
> +		sdma->dma_ch->tx_dma_info[i].enable = 0;
> +		sdma->dma_ch->tx_dma_info[i].ch_no = i;
> +		sdma->dma_ch->tx_dma_info[i].direction = 1;
> +		ast_uart_sdma_write(sdma, 0, UART_TX_W_POINT(i));
> +		// RX ------------------------
> +		sdma->dma_ch->rx_dma_info[i].enable = 0;
> +		sdma->dma_ch->rx_dma_info[i].ch_no = i;
> +		sdma->dma_ch->rx_dma_info[i].direction = 0;
> +		sdma->dma_ch->rx_dma_info[i].sdma_virt_addr =
> +		rx_dma_virt_addr + (SDMA_RX_BUFF_SIZE * i);
> +		sdma->dma_ch->rx_dma_info[i].dma_phy_addr =
> +		rx_dma_phy_addr + (SDMA_RX_BUFF_SIZE * i);
> +		ast_uart_sdma_write(sdma,
> +			sdma->dma_ch->rx_dma_info[i].dma_phy_addr,
> +			UART_RX_SDMA_ADDR(i));
> +		ast_uart_sdma_write(sdma, 0, UART_RX_R_POINT(i));
> +	}
> +
> +	ast_uart_sdma_write(sdma, 0xffffffff, UART_TX_SDMA_REST);
> +	ast_uart_sdma_write(sdma, 0x0, UART_TX_SDMA_REST);
> +
> +	ast_uart_sdma_write(sdma, 0xffffffff, UART_RX_SDMA_REST);
> +	ast_uart_sdma_write(sdma, 0x0, UART_RX_SDMA_REST);
> +
> +	ast_uart_sdma_write(sdma, 0, UART_TX_SDMA_EN);
> +	ast_uart_sdma_write(sdma, 0, UART_RX_SDMA_EN);
> +
> +#ifdef SDDMA_RX_FIX
> +	ast_uart_sdma_write(sdma, 0x200, UART_SDMA_TIMER);
> +#else
> +	ast_uart_sdma_write(sdma, 0xffff, UART_SDMA_TIMER);
> +#endif
> +
> +	// TX
> +	ast_uart_sdma_write(sdma, 0xfff, UART_TX_SDMA_ISR);
> +	ast_uart_sdma_write(sdma, 0, UART_TX_SDMA_IER);
> +
> +	// RX
> +	ast_uart_sdma_write(sdma, 0xfff, UART_RX_SDMA_ISR);
> +	ast_uart_sdma_write(sdma, 0, UART_RX_SDMA_IER);
> +
> +	sdma->dma_irq = of_irq_get(node, 0);
> +	ret = request_irq(sdma->dma_irq, ast_uart_sdma_isr, 0,
> +						"sdma-intr", sdma);
> +	if (ret) {
> +		pr_debug("Unable to get UART SDMA IRQ %x\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	ast_uart_sdma_write(sdma, SDMA_SET_TX_BUFF_SIZE(SDMA_BUFF_SIZE_4KB) |
> +				SDMA_SET_RX_BUFF_SIZE(SDMA_BUFF_SIZE_64KB),
> +		      UART_SDMA_CONF);
> +	return 0;
> +}
> +
> +// END of SDMA Layer
> +
> +// UART Driver Layer
> +
> +static unsigned int ast_serial_in(struct uart_8250_port *up, int offset)
> +{
> +	offset = map_8250_in_reg(up, offset) << up->port.regshift;
> +	return readb(up->port.membase + offset);
> +}
> +
> +static void ast_serial_out(struct uart_8250_port  *up, int offset, int value)
> +{
> +	/* Save the offset before it's remapped */
> +	offset = map_8250_out_reg(up, offset) << up->port.regshift;
> +	writeb(value, up->port.membase + offset);
> +}
> +
> +/*
> + * We used to support using pause I/O for certain machines.  We
> + * haven't supported this for a while, but just in case it's badly
> + * needed for certain old 386 machines, I've left these #define's
> + * in....

It looks like you copied this whole thing from somewhere else, please
make it your own and do not leave things in for no good reason.


> + */
> +#define serial_inp(up, offset) ast_serial_in(up, offset)
> +#define serial_outp(up, offset, value) ast_serial_out(up, offset, value)
> +
> +/* Uart divisor latch read */
> +static inline int _serial_dl_read(struct uart_8250_port *up)
> +{
> +	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
> +}
> +
> +/* Uart divisor latch write */
> +static inline void _serial_dl_write(struct uart_8250_port *up, int value)
> +{
> +	serial_outp(up, UART_DLL, value & 0xff);
> +	serial_outp(up, UART_DLM, value >> 8 & 0xff);
> +}
> +
> +#define serial_dl_read(up) _serial_dl_read(up)
> +#define serial_dl_write(up, value) _serial_dl_write(up, value)
> +
> +static void ast_uart_tx_sdma_tasklet_func(unsigned long data)
> +{
> +
> +	struct ast_uart_priv_data *priv = (struct ast_uart_priv_data *)data;
> +	struct uart_8250_port *up = priv->up;
> +	struct circ_buf *xmit = NULL;
> +	u32 tx_pt;
> +
> +
> +	if (!up)
> +		return;
> +	xmit = &up->port.state->xmit;
> +	spin_lock(&up->port.lock);
> +	priv->tx_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	dma_sync_single_for_device(up->port.dev, priv->dma_tx_addr,
> +					UART_XMIT_SIZE, DMA_TO_DEVICE);
> +	tx_pt = ast_uart_get_tx_sdma_pt(priv->dma_ch);
> +
> +	if (tx_pt > xmit->head)	{
> +		if ((tx_pt & 0xfffc) == 0)
> +			ast_uart_tx_sdma_update(priv->dma_ch, 0xffff);
> +		else
> +			ast_uart_tx_sdma_update(priv->dma_ch, 0);
> +	} else {
> +		ast_uart_tx_sdma_update(priv->dma_ch, xmit->head);
> +	}
> +	ast_uart_tx_sdma_update(priv->dma_ch, xmit->head);
> +	spin_unlock(&up->port.lock);
> +}
> +
> +static void ast_uart_tx_buffdone(void *dev_id, u16 len)
> +{
> +
> +	struct ast_uart_priv_data *priv = (struct ast_uart_priv_data *)dev_id;
> +	struct uart_8250_port *up = priv->up;
> +	struct circ_buf *xmit;
> +
> +	if (!up)
> +		return;
> +	xmit = &(up->port.state->xmit);
> +
> +	pr_debug("line[%d] : tx len = % d\n", priv->line, len);
> +	spin_lock(&up->port.lock);
> +	xmit->tail = len;
> +	pr_debug(" line[%d], xmit->head = %d, xmit->tail = % d\n",
> +			priv->line, xmit->head, xmit->tail);
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(&up->port);
> +
> +	if (xmit->head != xmit->tail)
> +		tasklet_schedule(&priv->tx_tasklet);
> +
> +	spin_unlock(&up->port.lock);
> +}
> +
> +#ifdef SDDMA_RX_FIX
> +static void ast_uart_rx_sdma_tasklet_func(unsigned long data)
> +{
> +	struct ast_uart_priv_data *priv = (struct ast_uart_priv_data *)data;
> +	struct circ_buf *rx_ring = &priv->rx_dma_buf;
> +	struct tty_port *ttyport;
> +	int count;
> +	int copy = 0;
> +	struct uart_8250_port *up = priv->up;
> +
> +	if (!up)
> +		return;
> +
> +	ttyport = &up->port.state->port;
> +
> +	pr_debug("line[%d], rx_ring->head = % d, rx_ring->tail = % d\n",
> +			 up->port.line, rx_ring->head, rx_ring->tail);
> +	spin_lock(&up->port.lock);
> +	if (rx_ring->head > rx_ring->tail) {
> +		count = rx_ring->head - rx_ring->tail;
> +		copy = tty_insert_flip_string(ttyport,
> +				rx_ring->buf + rx_ring->tail, count);
> +	} else if (rx_ring->head < rx_ring->tail) {
> +		count = SDMA_RX_BUFF_SIZE - rx_ring->tail;
> +		copy = tty_insert_flip_string(ttyport,
> +					rx_ring->buf + rx_ring->tail, count);
> +	} else {
> +		count = 0;
> +	}
> +
> +	if (copy != count)
> +		pr_debug(" !!!!!!!!ERROR 111\n");

That's useless.  Make it a real error with dev_err() please.

> +	if (count) {
> +		rx_ring->tail += count;
> +		rx_ring->tail &= (SDMA_RX_BUFF_SIZE - 1);
> +		up->port.icount.rx += count;
> +		tty_flip_buffer_push(ttyport);
> +		ast_uart_rx_sdma_update(priv->dma_ch, rx_ring->tail);
> +	}
> +	spin_unlock(&up->port.lock);
> +}
> +
> +static void ast_uart_rx_buffdone(void *dev_id, u16 len)
> +{
> +	struct ast_uart_priv_data *priv = (struct ast_uart_priv_data *)dev_id;
> +	struct circ_buf *rx_ring = &priv->rx_dma_buf;
> +	struct uart_8250_port *up = priv->up;
> +
> +	if (!up)
> +		return;
> +	pr_debug("line[%d], head = %d,len:%d\n",
> +			 priv->line, priv->rx_dma_buf.head, len);
> +	spin_lock(&up->port.lock);
> +	rx_ring->head = len;
> +	spin_unlock(&up->port.lock);
> +	tasklet_schedule(&priv->rx_tasklet);
> +}
> +
> +#else
> +static void ast_uart_rx_timer_func(unsigned long data)
> +{
> +	struct ast_uart_priv_data *priv = (struct ast_uart_priv_data *)data;
> +	struct uart_8250_port *up = priv->up;
> +	struct tty_port *ttyport;
> +	struct circ_buf *rx_ring;
> +	struct tty_struct *tty;
> +	char flag;
> +	int count;
> +	int copy;
> +
> +
> +	if (!up)
> +		return;
> +	ttyport = &up->port.state->port;
> +	rx_ring = &up->rx_dma_buf;
> +	tty = up->port.state->port.tty;
> +
> +	pr_debug("line[%d], rx_ring->head = % d, rx_ring->tail = % d\n",
> +				up->port.line, rx_ring->head, rx_ring->tail);
> +	rx_ring->head = ast_uart_get_rx_sdma_pt(priv->dma_ch);
> +	del_timer(&up->rx_timer);
> +
> +	if (rx_ring->head > rx_ring->tail) {
> +		ast_uart_set_sdma_time_out(0xffff);
> +		count = rx_ring->head - rx_ring->tail;
> +		copy = tty_insert_flip_string(ttyport,
> +				 rx_ring->buf + rx_ring->tail, count);
> +	} else if (rx_ring->head < rx_ring->tail) {
> +		ast_uart_set_sdma_time_out(0xffff);
> +		count = SDMA_RX_BUFF_SIZE - rx_ring->tail;
> +		copy = tty_insert_flip_string(ttyport,
> +				 rx_ring->buf + rx_ring->tail, count);
> +	} else {
> +		count = 0;
> +		// pr_debug("@@--%s-- ch = 0x%x\n", __func__, ch);
> +	}
> +
> +	if (copy != count)
> +		pr_debug(" !!!!!!!!ERROR 111\n");
> +		rx_ring->tail += count;
> +		rx_ring->tail &= (SDMA_RX_BUFF_SIZE - 1);
> +
> +	if (count) {
> +		//pr_debug("\n count = % d\n", count);
> +		up->port.icount.rx += count;
> +		spin_lock(&up->port.lock);
> +		tty_flip_buffer_push(ttyport);
> +		spin_unlock(&up->port.lock);
> +		//pr_debug("update rx_ring->tail % x\n", rx_ring->tail);
> +		ast_uart_rx_sdma_update(priv->dma_ch, rx_ring->tail);
> +		priv->workaround = 1;
> +	} else {
> +		if (priv->workaround) {
> +			priv->workaround++;
> +			if (priv->workaround > 1)
> +				ast_uart_set_sdma_time_out(0);
> +			else
> +				ast_uart_set_sdma_time_out(0xffff);
> +		}
> +	}
> +	add_timer(&up->rx_timer);
> +}
> +#endif
> +
> +/*
> + * FIFO support.
> + */
> +static inline void ast25xx_uart_clear_fifos(struct uart_8250_port *p)
> +{
> +	serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO);
> +	serial_outp(p, UART_FCR,
> +	      UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
> +	serial_outp(p, UART_FCR, 0);
> +}
> +
> +/*
> + * This routine is called by rs_init() to initialize a specific serial
> + * port.
> + */
> +static void autoconfig(struct uart_8250_port *up)
> +{
> +	unsigned long flags;
> +
> +	pr_debug("line[%d]\n", up->port.line);
> +	if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
> +		return;
> +
> +	pr_debug("ttyDMA%d : autoconf (0x%04lx, 0x%p) : ", up->port.line,
> +		 up->port.iobase, up->port.membase);
> +
> +	spin_lock_irqsave(&up->port.lock, flags);
> +
> +	up->capabilities = 0;
> +	up->bugs = 0;
> +
> +	up->port.type = PORT_16550A;
> +	up->capabilities |= UART_CAP_FIFO;
> +
> +	up->port.fifosize = uart_config[up->port.type].fifo_size;
> +	up->capabilities = uart_config[up->port.type].flags;
> +	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
> +
> +	if (up->port.type == PORT_UNKNOWN)
> +		goto out;
> +
> +	/*
> +	 * Reset the UART.
> +	 */
> +	ast25xx_uart_clear_fifos(up);
> +	ast_serial_in(up, UART_RX);
> +	serial_outp(up, UART_IER, 0);
> +
> +out:
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +	pr_debug("type=%s\n", uart_config[up->port.type].name);
> +}
> +
> +static inline void __stop_tx(struct uart_8250_port *p)
> +{
> +	if (p->ier & UART_IER_THRI) {
> +		p->ier &= ~UART_IER_THRI;
> +		ast_serial_out(p, UART_IER, p->ier);
> +	}
> +}
> +
> +static void ast25xx_uart_stop_tx(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +
> +	pr_debug("line[%d]\n", up->port.line);
> +	__stop_tx(up);
> +}
> +
> +static void transmit_chars(struct uart_8250_port *up);
> +
> +static void ast25xx_uart_start_tx(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	struct ast_uart_priv_data *priv = up->port.private_data;
> +
> +	pr_debug("line[%d]\n", port->line);
> +	tasklet_schedule(&priv->tx_tasklet);
> +}
> +
> +static void ast25xx_uart_stop_rx(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +
> +	pr_debug("line[%d]\n", port->line);
> +	up->ier &= ~UART_IER_RLSI;
> +	up->port.read_status_mask &= ~UART_LSR_DR;
> +	ast_serial_out(up, UART_IER, up->ier);
> +}
> +
> +static void ast25xx_uart_enable_ms(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +
> +	pr_debug("line[%d]\n", port->line);
> +	up->ier |= UART_IER_MSI;
> +	ast_serial_out(up, UART_IER, up->ier);
> +}
> +
> +static void transmit_chars(struct uart_8250_port *up)
> +{
> +	struct circ_buf *xmit = &up->port.state->xmit;
> +	int count;
> +
> +	if (up->port.x_char) {
> +		serial_outp(up, UART_TX, up->port.x_char);
> +		up->port.icount.tx++;
> +		up->port.x_char = 0;
> +		return;
> +	}
> +	if (uart_tx_stopped(&up->port)) {
> +		ast25xx_uart_stop_tx(&up->port);
> +		return;
> +	}
> +	if (uart_circ_empty(xmit)) {
> +		__stop_tx(up);
> +		return;
> +	}
> +
> +	count = up->tx_loadsz;
> +	do {
> +		ast_serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		up->port.icount.tx++;
> +		if (uart_circ_empty(xmit))
> +			break;
> +	} while (--count > 0);
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(&up->port);
> +
> +	if (uart_circ_empty(xmit))
> +		__stop_tx(up);
> +}
> +
> +static unsigned int check_modem_status(struct uart_8250_port *up)
> +{
> +	unsigned int status = ast_serial_in(up, UART_MSR);
> +
> +	pr_debug("line[%d]\n", up->port.line);
> +	status |= up->msr_saved_flags;
> +	up->msr_saved_flags = 0;
> +	if (status & UART_MSR_ANY_DELTA && up->ier & UART_IER_MSI
> +					&& up->port.state != NULL) {
> +		if (status & UART_MSR_TERI)
> +			up->port.icount.rng++;
> +		if (status & UART_MSR_DDSR)
> +			up->port.icount.dsr++;
> +		if (status & UART_MSR_DDCD)
> +			uart_handle_dcd_change(&up->port,
> +					status & UART_MSR_DCD);
> +		if (status & UART_MSR_DCTS)
> +			uart_handle_cts_change(&up->port,
> +					status & UART_MSR_CTS);
> +
> +		wake_up_interruptible(&up->port.state->port.delta_msr_wait);
> +	}
> +
> +	return status;
> +}
> +
> +/*
> + * This handles the interrupt from one port.
> + */
> +static inline void ast25xx_uart_handle_port(struct uart_8250_port *up)
> +{
> +	unsigned int status;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&up->port.lock, flags);
> +
> +	status = serial_inp(up, UART_LSR);
> +
> +	pr_debug("status = %x\n", status);
> +
> +	check_modem_status(up);
> +	if (status & UART_LSR_THRE)
> +		transmit_chars(up);
> +
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +}
> +
> +/*
> + * This is the serial driver's interrupt routine.
> + */
> +static irqreturn_t ast_uart_interrupt(int irq, void *dev_id)
> +{
> +	struct irq_info *i = dev_id;
> +	int pass_counter = 0, handled = 0, end = 0;
> +
> +	pr_debug("(%d)-", irq);
> +	spin_lock(&i->lock);
> +
> +	do {
> +		struct uart_8250_port *up;
> +		unsigned int iir;
> +
> +		up = (struct uart_8250_port *)(i->up);
> +
> +		iir = ast_serial_in(up, UART_IIR);
> +		if (!(iir & UART_IIR_NO_INT)) {
> +			ast25xx_uart_handle_port(up);
> +			handled = 1;
> +
> +		} else
> +			end = 1;
> +
> +		if (pass_counter++ > PASS_LIMIT) {
> +			/* If we hit this, we're dead. */
> +			pr_err("ast-uart-dma:too much work for irq%d\n", irq);
> +			break;
> +		}
> +	} while (end);
> +
> +	spin_unlock(&i->lock);
> +
> +	pr_debug("-(%d)\n", irq);
> +
> +	return IRQ_RETVAL(handled);
> +}
> +
> +static unsigned int ast25xx_uart_tx_empty(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	unsigned long flags;
> +	unsigned int lsr;
> +
> +	pr_debug("line[%d]\n", up->port.line);
> +
> +	spin_lock_irqsave(&up->port.lock, flags);
> +	lsr = ast_serial_in(up, UART_LSR);
> +	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +
> +	return lsr & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
> +}
> +
> +static unsigned int ast25xx_uart_get_mctrl(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	unsigned int status;
> +	unsigned int ret;
> +
> +	status = check_modem_status(up);
> +
> +	ret = 0;
> +	if (status & UART_MSR_DCD)
> +		ret |= TIOCM_CAR;
> +	if (status & UART_MSR_RI)
> +		ret |= TIOCM_RNG;
> +	if (status & UART_MSR_DSR)
> +		ret |= TIOCM_DSR;
> +	if (status & UART_MSR_CTS)
> +		ret |= TIOCM_CTS;
> +	return ret;
> +}
> +
> +static void ast25xx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	unsigned char mcr = 0;
> +
> +	mctrl = 0;
> +
> +	if (mctrl & TIOCM_RTS)
> +		mcr |= UART_MCR_RTS;
> +	if (mctrl & TIOCM_DTR)
> +		mcr |= UART_MCR_DTR;
> +	if (mctrl & TIOCM_OUT1)
> +		mcr |= UART_MCR_OUT1;
> +	if (mctrl & TIOCM_OUT2)
> +		mcr |= UART_MCR_OUT2;
> +	if (mctrl & TIOCM_LOOP)
> +		mcr |= UART_MCR_LOOP;
> +
> +	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
> +
> +	ast_serial_out(up, UART_MCR, mcr);
> +
> +}
> +
> +static void ast25xx_uart_break_ctl(struct uart_port *port, int break_state)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&up->port.lock, flags);
> +	if (break_state == -1)
> +		up->lcr |= UART_LCR_SBC;
> +	else
> +		up->lcr &= ~UART_LCR_SBC;
> +	ast_serial_out(up, UART_LCR, up->lcr);
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +}
> +
> +static int ast25xx_uart_startup(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	// TX DMA
> +	struct circ_buf *xmit = &up->port.state->xmit;
> +	struct ast_uart_priv_data *priv = up->port.private_data;
> +	unsigned long flags;
> +	unsigned char lsr, iir;
> +	int retval;
> +	int irq_flags = up->port.flags & UPF_SHARE_IRQ ? IRQF_SHARED : 0;
> +
> +	priv->up = up;
> +	pr_debug("line[%d]\n", port->line);
> +	up->capabilities = uart_config[up->port.type].flags;
> +	up->mcr = 0;
> +	/*
> +	 * Clear the FIFO buffers and disable them.
> +	 * (they will be reenabled in set_termios())
> +	 */
> +	ast25xx_uart_clear_fifos(up);
> +	/*
> +	 * Clear the interrupt registers.
> +	 */
> +	(void)serial_inp(up, UART_LSR);
> +	(void)serial_inp(up, UART_RX);
> +	(void)serial_inp(up, UART_IIR);
> +	(void)serial_inp(up, UART_MSR);
> +
> +	ast_uart_irq[0].up = up;
> +	retval = request_irq(up->port.irq, ast_uart_interrupt, irq_flags,
> +		       "ast-uart-dma", ast_uart_irq);
> +	if (retval)
> +		return retval;
> +
> +	/*
> +	 * Now, initialize the UART
> +	 */
> +	serial_outp(up, UART_LCR, UART_LCR_WLEN8);
> +
> +	spin_lock_irqsave(&up->port.lock, flags);
> +	up->port.mctrl |= TIOCM_OUT2;
> +
> +	ast25xx_uart_set_mctrl(&up->port, up->port.mctrl);
> +
> +	/*
> +	 * Do a quick test to see if we receive an
> +	 * interrupt when we enable the TX irq.
> +	 */
> +	serial_outp(up, UART_IER, UART_IER_THRI);
> +	lsr = ast_serial_in(up, UART_LSR);
> +	iir = ast_serial_in(up, UART_IIR);
> +	serial_outp(up, UART_IER, 0);
> +
> +	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
> +		if (!(up->bugs & UART_BUG_TXEN)) {
> +			up->bugs |= UART_BUG_TXEN;
> +			pr_debug("ttyDMA%d-enabling bad tx status\n",
> +								 port->line);
> +		}
> +	} else {
> +		up->bugs &= ~UART_BUG_TXEN;
> +	}
> +
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +
> +	/*
> +	 * Clear the interrupt registers again for luck, and clear the
> +	 * saved flags to avoid getting false values from polling
> +	 * routines or the previous session.
> +	 */
> +	serial_inp(up, UART_LSR);
> +	serial_inp(up, UART_RX);
> +	serial_inp(up, UART_IIR);
> +	serial_inp(up, UART_MSR);
> +	up->lsr_saved_flags = 0;
> +	up->msr_saved_flags = 0;
> +
> +	// RX DMA
> +	priv->rx_dma_buf.head = 0;
> +	priv->rx_dma_buf.tail = 0;
> +	up->port.icount.rx = 0;
> +
> +	priv->tx_done = 1;
> +	priv->tx_count = 0;
> +
> +	priv->rx_dma_buf.head = 0;
> +	priv->rx_dma_buf.tail = 0;
> +#ifdef SDDMA_RX_FIX
> +#else
> +	priv->workaround = 0;
> +#endif
> +	// pr_debug("Sending trigger for % x\n", priv->dma_ch);
> +	ast_uart_rx_sdma_ctrl(priv->dma_ch, AST_UART_DMAOP_STOP);
> +	ast_uart_rx_sdma_ctrl(priv->dma_ch, AST_UART_DMAOP_TRIGGER);
> +#ifdef SDDMA_RX_FIX
> +#else
> +	add_timer(&priv->rx_timer);
> +#endif
> +	priv->tx_dma_buf.head = 0;
> +	priv->tx_dma_buf.tail = 0;
> +	priv->tx_dma_buf.buf = xmit->buf;
> +
> +	pr_debug("head:0x%x tail:0x%x\n", xmit->head, xmit->tail);
> +	xmit->head = 0;
> +	xmit->tail = 0;
> +
> +	priv->dma_tx_addr = dma_map_single(port->dev, priv->tx_dma_buf.buf,
> +				   UART_XMIT_SIZE, DMA_TO_DEVICE);
> +
> +	ast_uart_tx_sdma_ctrl(priv->dma_ch, AST_UART_DMAOP_STOP);
> +	ast_uart_tx_sdma_enqueue(priv->dma_ch, priv->dma_tx_addr);
> +	ast_uart_tx_sdma_update(priv->dma_ch, 0);
> +	ast_uart_tx_sdma_ctrl(priv->dma_ch, AST_UART_DMAOP_TRIGGER);
> +	return 0;
> +}
> +
> +static void ast25xx_uart_shutdown(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	struct ast_uart_priv_data *priv = up->port.private_data;
> +	unsigned long flags;
> +
> +	pr_debug("line[%d]\n", port->line);
> +	priv->up = NULL;
> +
> +	up->ier = 0;
> +	serial_outp(up, UART_IER, 0);
> +
> +	spin_lock_irqsave(&up->port.lock, flags);
> +	up->port.mctrl &= ~TIOCM_OUT2;
> +
> +	ast25xx_uart_set_mctrl(&up->port, up->port.mctrl);
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +
> +	/*
> +	 * Disable break condition and FIFOs
> +	 */
> +	ast_serial_out(up, UART_LCR, serial_inp(up, UART_LCR) & ~UART_LCR_SBC);
> +	ast25xx_uart_clear_fifos(up);
> +
> +	(void)ast_serial_in(up, UART_RX);
> +
> +	ast_uart_rx_sdma_ctrl(priv->dma_ch, AST_UART_DMAOP_PAUSE);
> +	ast_uart_tx_sdma_ctrl(priv->dma_ch, AST_UART_DMAOP_PAUSE);
> +#ifdef SDDMA_RX_FIX
> +#else
> +	del_timer_sync(&up->rx_timer);
> +#endif
> +
> +	// Tx buffer will free by serial_core.c
> +	free_irq(up->port.irq, ast_uart_irq);
> +}
> +
> +static unsigned int ast25xx_uart_get_divisor(struct uart_port *port,
> +					   unsigned int baud)
> +{
> +	unsigned int quot;
> +
> +	quot = uart_get_divisor(port, baud);
> +
> +	return quot;
> +}
> +
> +static void ast25xx_uart_set_termios(struct uart_port *port,
> +				   struct ktermios *termios,
> +				   struct ktermios *old)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	unsigned char cval, fcr = 0;
> +	unsigned long flags;
> +	unsigned int baud, quot;
> +
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS5:
> +		cval = UART_LCR_WLEN5;
> +		break;
> +	case CS6:
> +		cval = UART_LCR_WLEN6;
> +		break;
> +	case CS7:
> +		cval = UART_LCR_WLEN7;
> +		break;
> +	default:
> +	case CS8:
> +		cval = UART_LCR_WLEN8;
> +		break;
> +	}
> +
> +	if (termios->c_cflag & CSTOPB)
> +		cval |= UART_LCR_STOP;
> +	if (termios->c_cflag & PARENB)
> +		cval |= UART_LCR_PARITY;
> +	if (!(termios->c_cflag & PARODD))
> +		cval |= UART_LCR_EPAR;
> +#ifdef CMSPAR
> +	if (termios->c_cflag & CMSPAR)
> +		cval |= UART_LCR_SPAR;
> +#endif
> +
> +	/*
> +	 * Ask the core to calculate the divisor for us.
> +	 */
> +	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
> +	quot = ast25xx_uart_get_divisor(port, baud);
> +
> +	if (up->capabilities & UART_CAP_FIFO && up->port.fifosize > 1) {
> +		if (baud < 2400)
> +			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
> +		else
> +			fcr = uart_config[up->port.type].fcr;
> +	}
> +
> +	/*
> +	 * Ok, we're now changing the port state.  Do it with
> +	 * interrupts disabled.
> +	 */
> +	spin_lock_irqsave(&up->port.lock, flags);
> +
> +	/*
> +	 * Update the per-port timeout.
> +	 */
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	up->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
> +	if (termios->c_iflag & INPCK)
> +		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		up->port.read_status_mask |= UART_LSR_BI;
> +
> +	/*
> +	 * Characteres to ignore
> +	 */
> +	up->port.ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		up->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
> +	if (termios->c_iflag & IGNBRK) {
> +		up->port.ignore_status_mask |= UART_LSR_BI;
> +	/*
> +	 * If we're ignoring parity and break indicators,
> +	 * ignore overruns too (for real raw support).
> +	 */
> +	if (termios->c_iflag & IGNPAR)
> +		up->port.ignore_status_mask |= UART_LSR_OE;
> +	}
> +
> +	/*
> +	 * ignore all characters if CREAD is not set
> +	 */
> +	if ((termios->c_cflag & CREAD) == 0)
> +		up->port.ignore_status_mask |= UART_LSR_DR;
> +
> +	/*
> +	 * CTS flow control flag and modem status interrupts
> +	 */
> +	up->ier &= ~UART_IER_MSI;
> +	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
> +		up->ier |= UART_IER_MSI;
> +
> +	ast_serial_out(up, UART_IER, up->ier);
> +
> +	serial_outp(up, UART_LCR, cval | UART_LCR_DLAB); /* set DLAB */
> +
> +	serial_dl_write(up, quot);
> +
> +	/*
> +	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
> +	 * is written without DLAB set, this mode will be disabled.
> +	 */
> +
> +	serial_outp(up, UART_LCR, cval); /* reset DLAB */
> +	up->lcr = cval;                  /* Save LCR */
> +	if (fcr & UART_FCR_ENABLE_FIFO) {
> +	/* emulated UARTs (Lucent Venus 167x) need two steps */
> +		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
> +	}
> +	serial_outp(up, UART_FCR, fcr); /* set fcr */
> +	ast25xx_uart_set_mctrl(&up->port, up->port.mctrl);
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +	/* Don't rewrite B0 */
> +	if (tty_termios_baud_rate(termios))
> +		tty_termios_encode_baud_rate(termios, baud, baud);
> +}
> +
> +/*
> + * Resource handling.
> + */
> +static int ast25xx_uart_request_std_resource(struct uart_8250_port  *up)
> +{
> +	unsigned int size = 8 << up->port.regshift;
> +	int ret = 0;
> +
> +	if (!up->port.mapbase)
> +		return ret;
> +
> +	if (!request_mem_region(up->port.mapbase, size, "ast-uart-dma")) {
> +		ret = -EBUSY;
> +		return ret;
> +	}
> +
> +	if (up->port.flags & UPF_IOREMAP) {
> +		up->port.membase = ioremap_nocache(up->port.mapbase, size);
> +		if (!up->port.membase) {
> +			release_mem_region(up->port.mapbase, size);
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static void ast25xx_uart_release_std_resource(struct uart_8250_port *up)
> +{
> +	unsigned int size = 8 << up->port.regshift;
> +
> +	if (!up->port.mapbase)
> +		return;
> +
> +	if (up->port.flags & UPF_IOREMAP) {
> +		iounmap(up->port.membase);
> +		up->port.membase = NULL;
> +	}
> +
> +	release_mem_region(up->port.mapbase, size);
> +}
> +
> +static void ast25xx_uart_release_port(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +
> +	ast25xx_uart_release_std_resource(up);
> +}
> +
> +static int ast25xx_uart_request_port(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	int ret;
> +
> +	ret = ast25xx_uart_request_std_resource(up);
> +	if (ret == 0)
> +		ast25xx_uart_release_std_resource(up);
> +
> +	return ret;
> +}
> +
> +static void ast25xx_uart_config_port(struct uart_port *port, int flags)
> +{
> +	struct uart_8250_port *up = to_uart_8250_port(port);
> +	int ret;
> +
> +	/*
> +	 * Find the region that we can probe for.  This in turn
> +	 * tells us whether we can probe for the type of port.
> +	 */
> +	ret = ast25xx_uart_request_std_resource(up);
> +	if (ret < 0)
> +		return;
> +
> +	if (flags & UART_CONFIG_TYPE)
> +		autoconfig(up);
> +
> +	if (up->port.type == PORT_UNKNOWN)
> +		ast25xx_uart_release_std_resource(up);
> +}
> +
> +static int ast25xx_uart_verify_port(struct uart_port *port,
> +				  struct serial_struct *ser)
> +{
> +	return 0;
> +}
> +
> +static const char *ast25xx_uart_type(struct uart_port *port)
> +{
> +	int type = port->type;
> +
> +	if (type >= ARRAY_SIZE(uart_config))
> +		type = 0;
> +	return uart_config[type].name;
> +}
> +
> +
> +
> +static unsigned int ast25xx_uart_serial_in(struct uart_port *port, int offset)
> +{
> +	offset = offset << port->regshift;
> +	return readb(port->membase + offset);
> +
> +}
> +
> +
> +static void ast25xx_uart_serial_out(struct uart_port *port,
> +						 int offset, int value)
> +{
> +	offset =  offset << port->regshift;
> +	writeb(value, port->membase + offset);
> +}
> +
> +static const struct uart_ops ast25xx_uart_pops = {
> +	.tx_empty = ast25xx_uart_tx_empty,
> +	.set_mctrl = ast25xx_uart_set_mctrl,
> +	.get_mctrl = ast25xx_uart_get_mctrl,
> +	.stop_tx = ast25xx_uart_stop_tx,
> +	.start_tx = ast25xx_uart_start_tx,
> +	.stop_rx = ast25xx_uart_stop_rx,
> +	.enable_ms = ast25xx_uart_enable_ms,
> +	.break_ctl = ast25xx_uart_break_ctl,
> +	.startup = ast25xx_uart_startup,
> +	.shutdown = ast25xx_uart_shutdown,
> +	.set_termios = ast25xx_uart_set_termios,
> +	.type = ast25xx_uart_type,
> +	.release_port = ast25xx_uart_release_port,
> +	.request_port = ast25xx_uart_request_port,
> +	.config_port = ast25xx_uart_config_port,
> +	.verify_port = ast25xx_uart_verify_port,
> +};
> +
> +
> +
> +/*
> + * Register a set of serial devices attached to a platform device.  The
> + * list is terminated with a zero flags entry, which means we expect
> + * all entries to have at least UPF_BOOT_AUTOCONF set.
> + */
> +struct clk *clk;

static?


> +
> +static int ast25xx_uart_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct ast_uart_priv_data *priv;
> +	struct uart_8250_port port_8250;
> +	struct uart_8250_port *up;
> +	int ret;
> +	u32 read, dma_channel = 0;
> +	struct resource *res;
> +
> +	if (UART_XMIT_SIZE > DMA_BUFF_SIZE)
> +		pr_debug("UART_XMIT_SIZE > DMA_BUFF_SIZE : Please Check\n");
> +
> +	priv = (struct ast_uart_priv_data *)devm_kzalloc(&pdev->dev,
> +			sizeof(struct ast_uart_priv_data), GFP_KERNEL);
> +	if (priv == NULL)
> +		return -ENOMEM;
> +
> +	up = &port_8250;
> +	memset(up, 0, sizeof(struct uart_8250_port));
> +	up->port.flags = UPF_IOREMAP;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "IRQ resource not found");
> +		return -ENODEV;
> +	}
> +	up->port.irq = res->start;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Register base not found");
> +		return -ENODEV;
> +	}
> +	up->port.mapbase = res->start;
> +
> +	ret = ast25xx_uart_request_std_resource(up);
> +	if (ret) {
> +		dev_err(&pdev->dev, "ioremap_nocache Failed");
> +		return ret;
> +	}
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		dev_err(&pdev->dev, "missing controller clock");
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to enable DMA UART Clk");
> +
> +	up->port.uartclk = clk_get_rate(clk);
> +
> +	if (of_property_read_u32(np, "reg-shift", &read) == 0)
> +		up->port.regshift = read;
> +	if (of_property_read_u32(np, "dma-channel", &read) == 0) {
> +		dma_channel = read;
> +		priv->dma_ch = dma_channel;
> +	}
> +	up->port.iotype = UPIO_MEM;
> +	up->port.flags |= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
> +	up->port.dev        = &pdev->dev;
> +	if (share_irqs)
> +		up->port.flags |= UPF_SHARE_IRQ;
> +	up->port.fifosize = uart_config[up->port.type].fifo_size;
> +	up->port.type = PORT_16550;
> +	up->port.iotype = UPIO_MEM;
> +	up->port.flags =  UPF_FIXED_TYPE;
> +	up->port.startup = ast25xx_uart_startup;
> +	up->port.shutdown = ast25xx_uart_shutdown;
> +	up->port.set_termios = ast25xx_uart_set_termios;
> +	up->port.set_mctrl = ast25xx_uart_set_mctrl;
> +	up->port.serial_in = ast25xx_uart_serial_in;
> +	up->port.serial_out = ast25xx_uart_serial_out;
> +	up->capabilities = uart_config[up->port.type].flags;
> +	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
> +	up->capabilities |= UART_CAP_FIFO;
> +
> +	up->port.private_data = priv;
> +
> +	ret = serial8250_register_8250_port(up);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +		"unable to registr port (IO%lx MEM%llx IRQ%d):%d\n",
> +			up->port.iobase, (unsigned long long)up->port.mapbase,
> +							 up->port.irq, ret);
> +		return ret;
> +	}
> +	priv->line = ret;
> +
> +	tasklet_init(&priv->tx_tasklet, ast_uart_tx_sdma_tasklet_func,
> +							 (unsigned long)priv);
> +#ifdef SDDMA_RX_FIX
> +	tasklet_init(&priv->rx_tasklet, ast_uart_rx_sdma_tasklet_func,
> +							 (unsigned long)priv);
> +#else
> +	uart->rx_timer.data = (unsigned long)port;
> +	uart->rx_timer.expires = jiffies + (HZ);
> +	uart->rx_timer.function = ast_uart_rx_timer_func;
> +	init_timer(&priv->rx_timer);
> +#endif
> +
> +//DMA request
> +#ifdef SDDMA_RX_FIX
> +	priv->rx_dma_buf.buf =
> +	ast_uart_rx_sdma_request(priv->dma_ch, ast_uart_rx_buffdone,
> +			      priv);
> +	if (priv->rx_dma_buf.buf < 0) {
> +		pr_debug("Error : failed to get rx dma channel[%d]\n",
> +						 priv->dma_ch);
> +		return -EBUSY;
> +}
> +#else
> +	priv->rx_dma_buf.buf = ast_uart_rx_sdma_request(
> +	priv->dma_ch, priv);
> +	if (priv->rx_dma_buf.buf < 0) {
> +		pr_debug("Error : failed to get rx dma channel[%d]\n",
> +						 priv->dma_ch);
> +		return -EBUSY;
> +	}
> +#endif
> +	if (ast_uart_tx_sdma_request(
> +			priv->dma_ch, ast_uart_tx_buffdone, priv) < 0) {
> +		pr_debug("Error : failed to get tx dma channel[%d]\n",
> +						 priv->dma_ch);
> +		return -EBUSY;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +	return 0;
> +}
> +
> +/*
> + * Remove serial ports registered against a platform device.
> + */
> +static int ast25xx_uart_remove(struct platform_device *pdev)
> +{
> +	struct ast_uart_priv_data *priv;
> +
> +	priv = platform_get_drvdata(pdev);
> +	serial8250_unregister_port(priv->line);
> +	return 0;
> +}
> +
> +static int ast25xx_uart_suspend(struct platform_device *pdev,
> +			      pm_message_t state)
> +{
> +	struct ast_uart_priv_data *priv;
> +
> +	priv = platform_get_drvdata(pdev);
> +	serial8250_suspend_port(priv->line);
> +	return 0;
> +}
> +
> +static int ast25xx_uart_resume(struct platform_device *pdev)
> +{
> +	struct ast_uart_priv_data *priv;
> +
> +	priv = platform_get_drvdata(pdev);
> +	serial8250_resume_port(priv->line);
> +	return 0;
> +}
> +
> +static const struct of_device_id ast_serial_dt_ids[] = {
> +	{ .compatible = "aspeed,ast-sdma-uart", },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver ast25xx_uart_driver = {
> +	.probe = ast25xx_uart_probe,
> +	.remove = ast25xx_uart_remove,
> +	.suspend = ast25xx_uart_suspend,
> +	.resume = ast25xx_uart_resume,
> +	.driver = {
> +	    .name = "ast-uart-dma",
> +	    .of_match_table = of_match_ptr(ast_serial_dt_ids),

Indent properly.

This whole file looks like it can be made smaller, please remove the
unneeded and unused code for your next submission.

thanks,

greg k-h
