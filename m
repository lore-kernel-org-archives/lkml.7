Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406ADC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12ABD2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKQQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:16:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfDKQQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:16:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5ED6AC3D;
        Thu, 11 Apr 2019 16:16:10 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        Paul Walmsley <paul@pwsan.com>, Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v4 2/2] tty: serial: add driver for the SiFive UART
References: <20190411090027.8670-1-paul.walmsley@sifive.com>
        <20190411090027.8670-3-paul.walmsley@sifive.com>
X-Yow:  Four thousand different MAGNATES, MOGULS & NABOBS are romping in my
 gothic solarium!!
Date:   Thu, 11 Apr 2019 18:16:09 +0200
In-Reply-To: <20190411090027.8670-3-paul.walmsley@sifive.com> (Paul Walmsley's
        message of "Thu, 11 Apr 2019 02:00:30 -0700")
Message-ID: <mvmtvf4ecvq.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> +static void sifive_serial_set_termios(struct uart_port *port,
> +				      struct ktermios *termios,
> +				      struct ktermios *old)
> +{
> +	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> +	unsigned long flags;
> +	u32 v, old_v;
> +	int rate;
> +	char nstop;
> +
> +	if ((termios->c_cflag & CSIZE) != CS8) {
> +		dev_err(ssp->port.dev, "only 8-bit words supported\n");
> +		return;
> +	}
> +
> +	/* Set number of stop bits */
> +	nstop = (termios->c_cflag & CSTOPB) ? 2 : 1;
> +	__ssp_set_stop_bits(ssp, nstop);
> +
> +	/* Set line rate */
> +	rate = uart_get_baud_rate(port, termios, old, 0, ssp->clkin_rate / 16);
> +	__ssp_update_baud_rate(ssp, rate);
> +
> +	spin_lock_irqsave(&ssp->port.lock, flags);
> +
> +	/*
> +	 * Update the per-port timeout.
> +	 */
> +	uart_update_timeout(port, termios->c_cflag, rate);
> +
> +	ssp->port.read_status_mask = 0;
> +	if (termios->c_iflag & INPCK) {
> +		dev_err(ssp->port.dev, "INPCK flag not supported\n");
> +		goto ssst_out;
> +	}
> +	if (termios->c_iflag & (BRKINT | PARMRK)) {
> +		dev_err(ssp->port.dev, "BRKINT/PARMRK flag not supported\n");
> +		goto ssst_out;
> +	}

I don't think it is a good idea to print something while the port is
locked.

And I think set_termios is supposed to apply all applicable settings,
even if some of them are not supported.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
