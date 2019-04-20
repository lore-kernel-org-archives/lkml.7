Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6632DC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363962183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfDTCPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 22:15:48 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:42374
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfDTCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 22:15:48 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 22:15:47 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ACAAAffrpc/zXSMGcNWRkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEBAQEBgVIDAQEBAQELAYQkhA6TegaBCAglg12Fa48DgXuEfQK?=
 =?us-ascii?q?GPDUIDgEDAQEBBAEBAQEChl8BAQEBAgEjBBFBBQsLDQsCAiYCAlcGDQYCAQG?=
 =?us-ascii?q?DHoF1BaVPcXwzGoUthGaBCycBgVyKBHiBB4E4DIJfPodOglcEkliTeQmCCpI?=
 =?us-ascii?q?kIYwIA4kGojQBggwzGggoCIMnghoXjjFgkHIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2ACAAAffrpc/zXSMGcNWRkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgVIDAQEBAQELAYQkhA6TegaBCAglg12Fa48DgXuEfQKGPDUIDgEDAQEBB?=
 =?us-ascii?q?AEBAQEChl8BAQEBAgEjBBFBBQsLDQsCAiYCAlcGDQYCAQGDHoF1BaVPcXwzG?=
 =?us-ascii?q?oUthGaBCycBgVyKBHiBB4E4DIJfPodOglcEkliTeQmCCpIkIYwIA4kGojQBg?=
 =?us-ascii?q?gwzGggoCIMnghoXjjFgkHIBAQ?=
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; 
   d="scan'208";a="184298678"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 20 Apr 2019 10:06:27 +0800
Subject: Re: [PATCH 5/6] ARM: ks8695, serial: skip manual tx IRQ ack
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190415202501.941196-1-arnd@arndb.de>
 <20190415202501.941196-5-arnd@arndb.de>
From:   Greg Ungerer <gerg@uclinux.org>
Message-ID: <c928a87f-9311-d70a-f2df-ce9621ab8716@uclinux.org>
Date:   Sat, 20 Apr 2019 12:06:26 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415202501.941196-5-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 16/4/19 6:24 am, Arnd Bergmann wrote:
> The TX interrupt is marked as edge triggered, so it will
> already be acked by the top-level irq code, and does not
> need the ack in the driver.
> 
> Removing this avoids a nasty dependency on the regs-irq.h
> file that is otherwise reserved for the interrupt controller
> driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/tty/serial/serial_ks8695.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
> index b461d791188c..6c5e9900e69d 100644
> --- a/drivers/tty/serial/serial_ks8695.c
> +++ b/drivers/tty/serial/serial_ks8695.c
> @@ -21,7 +21,6 @@
>   #include <asm/mach/irq.h>
>   
>   #include <mach/regs-uart.h>
> -#include <mach/regs-irq.h>
>   
>   #if defined(CONFIG_SERIAL_KS8695_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
>   #define SUPPORT_SYSRQ
> @@ -52,8 +51,6 @@
>   #define UART_GET_BRDR(p)	__raw_readl((p)->membase + KS8695_URBD)
>   #define UART_PUT_BRDR(p, c)	__raw_writel((c), (p)->membase + KS8695_URBD)
>   
> -#define KS8695_CLR_TX_INT()	__raw_writel(1 << KS8695_IRQ_UART_TX, KS8695_IRQ_VA + KS8695_INTST)
> -
>   #define UART_DUMMY_LSR_RX	0x100
>   #define UART_PORT_SIZE		(KS8695_USR - KS8695_URRB + 4)
>   
> @@ -207,7 +204,6 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
>   	unsigned int count;
>   
>   	if (port->x_char) {
> -		KS8695_CLR_TX_INT();
>   		UART_PUT_CHAR(port, port->x_char);
>   		port->icount.tx++;
>   		port->x_char = 0;
> @@ -221,7 +217,6 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
>   
>   	count = 16;	/* fifo size */
>   	while (!uart_circ_empty(xmit) && (count-- > 0)) {
> -		KS8695_CLR_TX_INT();

I haven't looked at the ks8695 in quite a while...
But I recall that this was very problematic at the time. Without this being
done after each character it was very easy to get the transmitter to "hang" -
and stop wanting to send any more characters.

I'd like to test this before acking.

Regards
Greg


>   		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
>   
>   		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> 
