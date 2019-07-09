Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623AC73C55
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AF921670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfGIPWg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:22:36 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:48284 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGIPWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:22:36 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x69FMLr7021205;
        Tue, 9 Jul 2019 16:22:21 +0100
Date:   Tue, 9 Jul 2019 16:22:21 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Sean =?UTF-8?B?Tnlla2o=?= =?UTF-8?B?w6Zy?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH 4/4] tty: n_gsm: add ioctl to map serial device to
 mux'ed tty
Message-ID: <20190709162221.623f99ce@alans-desktop>
In-Reply-To: <20190708190252.24628-4-martin@geanix.com>
References: <20190708190252.24628-1-martin@geanix.com>
        <20190708190252.24628-4-martin@geanix.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Jul 2019 21:02:52 +0200
Martin Hundebøll <martin@geanix.com> wrote:

> Guessing the base tty for a gsm0710 multiplexed serial device is not
> currently possible, which makes it racy to use with multiple modems.
> 
> Add a way to map the physical serial tty to its related mux devices
> using a ioctl.

That looks very sensible

> +	int base;
>  
>  	/* open the serial port connected to the modem */
>  	fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
> @@ -58,6 +61,11 @@ Major parts of the initialization program :
>  	c.mtu = 127;
>  	/* set the new configuration */
>  	ioctl(fd, GSMIOC_SETCONF, &c);
> +	/* get and print base gsmtty device node */
> +	ioctl(fd, GSMIOC_GETBASE, &base);

Can we at least use a specific sized type ? uint32_t or whatever is fine.

Alan
