Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EC3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15272075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gHdiPvs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfDKVN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:13:27 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35649 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfDKVN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:13:26 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so12050242itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6qx4oaDnhlAJm0gPbdRpHZo/sIlRW/ZqdOGZf+3EXyw=;
        b=gHdiPvs/z5uVjxn93EE9Y7hMgiKe3l23ssSQ5QcR2pSngVy9C6JkSBacoWdbgR+1DZ
         FLZd9pBlNLZsy5GlUNWYo00QOyHiG7MlTeqxuJ3Z3VPhUKpQhWDB3TaRdFIOoAA4f9Y2
         KMm4cTGFo7cg1du/FwVDao1EMuZIB4ssOezbqks5pbb+fEPzKN4PylwxLXlBYoz802V/
         PYLaQLVpmkz5YkSpjdYbcIEi2MPTHo8m39jVin+Oj1qYu8huzF6D1MswlxuqVurUUpDk
         4hLwCN0VVPl1NW5xVWbg6+ZgvCpRZPLlF/VWLKx9aDzIqSMHpmdgV+cbr0ddF/7ZutPr
         X5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6qx4oaDnhlAJm0gPbdRpHZo/sIlRW/ZqdOGZf+3EXyw=;
        b=oHYbcPz1AUAecR5pq6YBepV1QZ9Jcp/owccVj9lmdsgar9FaJGhR5AFuiiM4yZ4ysf
         GkYqDQieKrRPhEcCYHaq3moFv8ZukwaB2DAeyZfoRwLMEbKNM4r9wtJou+GpMjGUPeEc
         SDPamIkAfev9/39/qZ0Q0dn0J5AEj/KXq1CLdcu+YTiZi6mAya1h+vLO3OjNq/uGCib7
         QyVdadQ3oxIXtY8p8veRIJRnF46tc6vGKgMC7DvynKQINdo7QbdOguXYdSiS7MhTVbi0
         4zqeU/Y/vTuOwivfslXsO61dx+ADlb1cAbhockT9aVjSMgjpVYLw0/hUPGNAEn/R8Gip
         uMlw==
X-Gm-Message-State: APjAAAWMTzD/OgS82//ZdO8M2zNB12iydxL+E1Qeaeu88TN5/Y9tKpOa
        M8FIb0wUurgFcd+A3MmqjGe/Ng==
X-Google-Smtp-Source: APXvYqxLoJaQYhkEB8QLVPaPigcYEdRxkEBX2VRIdVSwPKju3j2jH3/Q+K5LfItzmtw8C4hjUHXccw==
X-Received: by 2002:a05:660c:78e:: with SMTP id h14mr10028752itk.49.1555017205762;
        Thu, 11 Apr 2019 14:13:25 -0700 (PDT)
Received: from localhost (63-238-229-145.dia.static.qwest.net. [63.238.229.145])
        by smtp.gmail.com with ESMTPSA id 67sm3261210itz.37.2019.04.11.14.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 14:13:25 -0700 (PDT)
Date:   Thu, 11 Apr 2019 14:13:24 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Andreas Schwab <schwab@suse.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        Paul Walmsley <paul@pwsan.com>, Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v4 2/2] tty: serial: add driver for the SiFive UART
In-Reply-To: <mvmtvf4ecvq.fsf@suse.de>
Message-ID: <alpine.DEB.2.21.9999.1904111412210.19990@viisi.sifive.com>
References: <20190411090027.8670-1-paul.walmsley@sifive.com> <20190411090027.8670-3-paul.walmsley@sifive.com> <mvmtvf4ecvq.fsf@suse.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Andreas Schwab wrote:

> On Apr 11 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:
> 
> > +static void sifive_serial_set_termios(struct uart_port *port,
> > +				      struct ktermios *termios,
> > +				      struct ktermios *old)
> > +{
> > +	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> > +	unsigned long flags;
> > +	u32 v, old_v;
> > +	int rate;
> > +	char nstop;
> > +
> > +	if ((termios->c_cflag & CSIZE) != CS8) {
> > +		dev_err(ssp->port.dev, "only 8-bit words supported\n");
> > +		return;
> > +	}
> > +
> > +	/* Set number of stop bits */
> > +	nstop = (termios->c_cflag & CSTOPB) ? 2 : 1;
> > +	__ssp_set_stop_bits(ssp, nstop);
> > +
> > +	/* Set line rate */
> > +	rate = uart_get_baud_rate(port, termios, old, 0, ssp->clkin_rate / 16);
> > +	__ssp_update_baud_rate(ssp, rate);
> > +
> > +	spin_lock_irqsave(&ssp->port.lock, flags);
> > +
> > +	/*
> > +	 * Update the per-port timeout.
> > +	 */
> > +	uart_update_timeout(port, termios->c_cflag, rate);
> > +
> > +	ssp->port.read_status_mask = 0;
> > +	if (termios->c_iflag & INPCK) {
> > +		dev_err(ssp->port.dev, "INPCK flag not supported\n");
> > +		goto ssst_out;
> > +	}
> > +	if (termios->c_iflag & (BRKINT | PARMRK)) {
> > +		dev_err(ssp->port.dev, "BRKINT/PARMRK flag not supported\n");
> > +		goto ssst_out;
> > +	}
> 
> I don't think it is a good idea to print something while the port is
> locked.
> 
> And I think set_termios is supposed to apply all applicable settings,
> even if some of them are not supported.

Agreed.  Thank you for your help debugging (some of which was off-list).
Clearly there should have been a build-test with lockdep enabled. 

I will send a v5.


- Paul
