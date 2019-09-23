Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589AFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B92420673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfIWPJl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:09:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33177 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfIWPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:09:41 -0400
Received: from [2001:67c:670:100:79a6:a514:42de:7079] (helo=rettich)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1iCPy4-0000Kl-Uq; Mon, 23 Sep 2019 17:09:36 +0200
Received: from jlu by rettich with local (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1iCPy3-0006sW-5g; Mon, 23 Sep 2019 17:09:35 +0200
Message-ID: <8cc51d485ee016589b752426412e57c23e35a4cc.camel@pengutronix.de>
Subject: Re: [PATCH v5 0/3] Fix UART DMA freezes for i.MX SOCs
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        Adam Ford <aford173@gmail.com>
Cc:     fugang.duan@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vkoul@kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Date:   Mon, 23 Sep 2019 17:09:35 +0200
In-Reply-To: <2443c553-c593-2f23-4cca-c2f03676adc9@emlix.com>
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
         <CAHCN7xJL_x1ryOoNW+R2hOZ9dMFem9wni8Uo8QOA3wxpzKLbqQ@mail.gmail.com>
         <2443c553-c593-2f23-4cca-c2f03676adc9@emlix.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:79a6:a514:42de:7079
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-23 at 17:06 +0200, Philipp Puschmann wrote:
> Thanks for testing.
> With my local setup i still have very few tx timeouts too. But i think they have a different
> cause and especially different consequences. When the problem addressed by this series
> appear you get a whole bunch of tx timeouts (and maybe errors from Bluetooth
> layer) and monitoring received Bluetooth packets with hciconfig shows a
> complete freeze of rx counter. Only resetting the hci_uart driver and the wl1837mon then helps.
> With these patches applied the rx data shold still coming in even if a single or
> multiple tx timeout error happen. I'm not sure where the error comes from and what the
> consequences for the Bluetooth layer are.

For testing, I've used a UART connected to my development host and
configured *mismatching* baud rates. Sending /dev/urandom from the host
to the i.MX6 then triggered the DMA hang (because each character
triggers and error indication, which "uses" a full buffer).

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

