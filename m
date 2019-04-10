Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5363C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6752054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfDJLrt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:47:49 -0400
Received: from smtp.asem.it ([151.1.184.197]:56840 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730920AbfDJLrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:47:48 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003804256.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 13:47:44 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 13:47:44 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 10 Apr 2019 13:47:44 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Mark Brown <broonie@kernel.org>
CC:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Thread-Topic: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Thread-Index: AQHU7h76xswpdz/DmEySUaMIIqbaa6Y1E7kAgAAzYSA=
Date:   Wed, 10 Apr 2019 11:47:43 +0000
Message-ID: <a7237e949bb643d5b49ccc5ae241bbb9@asem.it>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <20190410103250.GF6106@sirena.org.uk>
In-Reply-To: <20190410103250.GF6106@sirena.org.uk>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B020F.5CADD7E0.003F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> On Mon, Apr 08, 2019 at 05:22:44PM +0200, Flavio Suligoi wrote:
> > Add an info message for the PXA2xx device driver start-up,
> > with the indication of the transfer mode used (DMA or GPIO).
> >
> > This info is useful to individuate the timing when
> > the module starts.
> 
> Adding this sort of message to every driver is going to make boot far
> too noisy, it's one thing if we actually enumerate information about the
> physical device but this isn't really that.  There are already prints in
> the driver core for when things get probed which can be enabled if
> ordering issues need to be debugged.

You have right about to avoid too many boot messages,
but in this case, using an x86 machine and with
the spi-pxa2xx in DMA mode, so without the message: 

"no DMA channels available, using PIO",

there is absolutely no indication about the existence
of the SPI master controller.

This is the first reason for this patch.
The second reason is about the DMA/PIO mode indication. 
With the board I'm using, sometimes the spi-pxa2xx driver can't allocate
a DMA channel and works in PIO mode.

So, with the advice of Jarkko, I think that a valid solution could be:

1) remove the "no DMA channels available, using PIO" message
2) add a new message with the indications of:
	- controller mode (slave or master)
	- transfer mode (DMA or PIO)

What do you think about this?

Flavio
