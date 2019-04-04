Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ADFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED0C206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfDDJpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:45:51 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:46720 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfDDJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:45:44 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id E53883C013A;
        Thu,  4 Apr 2019 11:45:41 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UD3h-i35fCq1; Thu,  4 Apr 2019 11:45:35 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 499F13C00C3;
        Thu,  4 Apr 2019 11:45:35 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 4 Apr 2019
 11:45:34 +0200
Date:   Thu, 4 Apr 2019 11:45:31 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Simon Herkenhoff <sherkenhoff@jp.adit-jv.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] serial: sh-sci: Fix HSCIF RX sampling point calculation
Message-ID: <20190404094531.GA31244@vmlxhi-102.adit-jv.com>
References: <20190401112510.23145-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190401112510.23145-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Apr 01, 2019 at 01:25:10PM +0200, Geert Uytterhoeven wrote:
> There are several issues with the formula used for calculating the
> deviation from the intended rate:
>   1. While min_err and last_stop are signed, srr and baud are unsigned.
>      Hence the signed values are promoted to unsigned, which will lead
>      to a bogus value of deviation if min_err is negative,
>   2. Srr is the register field value, which is one less than the actual
>      sampling rate factor,
>   3. The divisions do not use rounding.
> 
> Fix this by casting unsigned variables to int, adding one to srr, and
> using a single DIV_ROUND_CLOSEST().
> 
> Fixes: 63ba1e00f178a448 ("serial: sh-sci: Support for HSCIF RX sampling point adjustment")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Anyone with a good test setup for verifying this feature actually works
> as advertised?
> ---
>  drivers/tty/serial/sh-sci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 2bdaeba5d527a6ce..8dea59edde34c224 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2522,7 +2522,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
>  			 * center of the last stop bit in sampling clocks.
>  			 */
>  			int last_stop = bits * 2 - 1;
> -			int deviation = min_err * srr * last_stop / 2 / baud;
> +			int deviation = DIV_ROUND_CLOSEST(min_err * last_stop *
> +							  (int)(srr + 1),
> +							  2 * (int)baud);
>  
>  			if (abs(deviation) >= 2) {
>  				/* At least two sampling clocks off at the

Just wanted to say thank you for your tremendous commitment and
continuity in supporting the R-Car platform (and beyond that), which
allowed us to gracefully overcome the problems encountered in the
project in the best possible time, specifically thanks to this patch.

Best regards,
Eugeniu.
