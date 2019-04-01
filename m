Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6F62082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UpgawT9v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UFt6IEPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDAMMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:12:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDAMMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:12:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 84FC76079C; Mon,  1 Apr 2019 12:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554120748;
        bh=63lf0uKIjQ4rX5WBWvMIiH8gLdAuxrN0svjXwnrOCiM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UpgawT9vNKRWXRhR7FzL2L7c4nJIrj36F73r3lGr/jMN1Sz6WdRmsoZDMAWGCSY0M
         3c5kM0N1p7yKDrG6eBRHfi4XR6fIl0VfJnsVqfmcJEk6PNKu7KNIlndxJifrmV70vJ
         +dybDm7ISEWf88Fz7Fv2SjqToV0YexBaCHKkh2ew=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C32E56079C;
        Mon,  1 Apr 2019 12:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554120745;
        bh=63lf0uKIjQ4rX5WBWvMIiH8gLdAuxrN0svjXwnrOCiM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UFt6IEPNjQqobcPV4gyJ/CXjL1k4wREl+gUmb2PxrYPtBWhTNmn6OLBn15xFfL2kT
         JIjkrCIRtRRHLOnacVL4Yo9CQd+xN9o6g72IefendWUIubacTBc0R+Q0EiQ7FrOgtP
         W14y17KA4Oq2z6ZL88gUnv0SXAX6fBxTunO/kbik=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C32E56079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] serial: sh-sci: Fix HSCIF RX sampling point calculation
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190401112510.23145-1-geert+renesas@glider.be>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3361fcd0-12e6-aaf8-33c2-54a99bac1900@codeaurora.org>
Date:   Mon, 1 Apr 2019 17:42:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401112510.23145-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 4:55 PM, Geert Uytterhoeven wrote:
> There are several issues with the formula used for calculating the
> deviation from the intended rate:
>    1. While min_err and last_stop are signed, srr and baud are unsigned.
>       Hence the signed values are promoted to unsigned, which will lead
>       to a bogus value of deviation if min_err is negative,
>    2. Srr is the register field value, which is one less than the actual
>       sampling rate factor,
>    3. The divisions do not use rounding.
>
> Fix this by casting unsigned variables to int, adding one to srr, and
> using a single DIV_ROUND_CLOSEST().
>
> Fixes: 63ba1e00f178a448 ("serial: sh-sci: Support for HSCIF RX sampling point adjustment")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
> Anyone with a good test setup for verifying this feature actually works
> as advertised?
> ---
>   drivers/tty/serial/sh-sci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 2bdaeba5d527a6ce..8dea59edde34c224 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2522,7 +2522,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
>   			 * center of the last stop bit in sampling clocks.
>   			 */
>   			int last_stop = bits * 2 - 1;
> -			int deviation = min_err * srr * last_stop / 2 / baud;
> +			int deviation = DIV_ROUND_CLOSEST(min_err * last_stop *
> +							  (int)(srr + 1),
> +							  2 * (int)baud);
>   
>   			if (abs(deviation) >= 2) {
>   				/* At least two sampling clocks off at the
