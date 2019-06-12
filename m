Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0588221019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438278AbfFLRH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:07:29 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:36559 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbfFLRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:07:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1C359C1DC85;
        Wed, 12 Jun 2019 17:07:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: road25_23dc3a3c72a17
X-Filterd-Recvd-Size: 3267
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Jun 2019 17:07:26 +0000 (UTC)
Message-ID: <fc69912c14ead80f371e2136d43db4af1f4b72aa.camel@perches.com>
Subject: Re: [PATCH v2 5/6] serial: uartps: Do not add a trailing semicolon
 to macro
From:   Joe Perches <joe@perches.com>
To:     Michal Simek <michal.simek@xilinx.com>, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        monstr@monstr.eu
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 12 Jun 2019 10:07:25 -0700
In-Reply-To: <5d938d34c3c4710577df898dbf4b70c74d2e6730.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
         <5d938d34c3c4710577df898dbf4b70c74d2e6730.1560338079.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 13:14 +0200, Michal Simek wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch fixes this checkpatch warning:
> WARNING: macros should not use a trailing semicolon
> +#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> +		clk_rate_change_nb);
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
[]
> @@ -199,7 +199,7 @@ struct cdns_platform_data {
>  	u32 quirks;
>  };
>  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> -		clk_rate_change_nb);
> +		clk_rate_change_nb)
>  
>  /**
>   * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.

trivia:

Perhaps this is easier for humans to read with the macro
on two lines like:

#define to_cdns_uart(_nb) \
	container_of(_nb, struct cdns_uart, clk_rate_change_nb)

or just ignore the 80 column limit

#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, clk_rate_change_nb)

or because the macro is only used in one place,
just get rid of it and use container_of directly.
---
 drivers/tty/serial/xilinx_uartps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 605354fd60b1..ca5cec2b83ce 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -195,11 +195,10 @@ struct cdns_uart {
 	u32			quirks;
 	bool cts_override;
 };
+
 struct cdns_platform_data {
 	u32 quirks;
 };
-#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
-		clk_rate_change_nb);
 
 /**
  * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
@@ -489,8 +488,9 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 	int locked = 0;
 	struct clk_notifier_data *ndata = data;
 	unsigned long flags = 0;
-	struct cdns_uart *cdns_uart = to_cdns_uart(nb);
+	struct cdns_uart *cdns_uart;
 
+	cdns_uart = container_of(nb, struct cdns_uart, clk_rate_change_nb);
 	port = cdns_uart->port;
 	if (port->suspended)
 		return NOTIFY_OK;


