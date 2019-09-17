Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2962C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC4E2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfIQK4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:56:16 -0400
Received: from smtp3.goneo.de ([85.220.129.37]:51264 "EHLO smtp3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfIQK4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:56:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 1069323F95B;
        Tue, 17 Sep 2019 12:56:13 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S55syZCSdeQD; Tue, 17 Sep 2019 12:56:11 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 4D2D623F4C1;
        Tue, 17 Sep 2019 12:56:11 +0200 (CEST)
Date:   Tue, 17 Sep 2019 12:56:09 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     David Miller <davem@davemloft.net>
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, swinslow@gmail.com,
        allison@lohutok.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, johan@kernel.org,
        Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v7 5/7] nfc: pn533: add UART phy driver
Message-ID: <20190917105609.GC18936@lem-wkst-02.lemonage>
References: <20190910093359.2110-1-poeschel@lemonage.de>
 <20190911.101732.1453519960272118746.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911.101732.1453519960272118746.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 10:17:32AM +0200, David Miller wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> Date: Tue, 10 Sep 2019 11:33:50 +0200
> 
> > +static int pn532_uart_send_ack(struct pn533 *dev, gfp_t flags)
> > +{
> > +	struct pn532_uart_phy *pn532 = dev->phy;
> > +	/* spec 7.1.1.3:  Preamble, SoPC (2), ACK Code (2), Postamble */
> > +	static const u8 ack[PN533_STD_FRAME_ACK_SIZE] = {
> > +			0x00, 0x00, 0xff, 0x00, 0xff, 0x00};
> > +	int err;
> 
> Reverse christmas tree ordering for the local variables please.

See below.

> > +static int pn532_uart_rx_is_frame(struct sk_buff *skb)
> > +{
> > +	int i;
> > +	u16 frame_len;
> > +	struct pn533_std_frame *std;
> > +	struct pn533_ext_frame *ext;
> 
> Likewise.

Ok, I will do a v8 soon with these changes.
