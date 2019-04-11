Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5057BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B22070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDKHOO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:14:14 -0400
Received: from smtp.asem.it ([151.1.184.197]:59119 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfDKHON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:14:13 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003806042.MSG 
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:14:07 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Thu, 11
 Apr 2019 09:14:06 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Thu, 11 Apr 2019 09:14:06 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Mark Brown <broonie@kernel.org>
CC:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Thread-Topic: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Thread-Index: AQHU75yQbkDNn+rZPkCFgi0S9cPL1qY1OMwAgAAnBxCAAAN6AIABJ5/A
Date:   Thu, 11 Apr 2019 07:14:06 +0000
Message-ID: <7ad025c8049e4e828ce75ef1e41dcbfd@asem.it>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
 <20190410125612.GR6106@sirena.org.uk>
 <6eeaf42f4d3f42c58546c429194213b8@asem.it>
 <20190410152820.GT6106@sirena.org.uk>
In-Reply-To: <20190410152820.GT6106@sirena.org.uk>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: hardfail smtp.helo=webmail.asem.it (does not match 172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B020A.5CAEE93F.002F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think that the problem could be related to how the DMA channel is
> requested.
> > At the moment the function used are:
> 
> > pxa2xx_spi_dma_setup --> dma_request_slave_channel_compat -->
> > --> __dma_request_slave_channel_compat --> dma_request_slave_channel -->
> > --> dma_request_chan
> 
> > Actually the final function "dma_request_chan" return
> > the channel number or "-EPROBE_DEFER" if it's not ready.
> > But this information ("-EPROBE_DEFER") is lost in the penultimate
> function
> > "dma_request_slave_channel", which return only the chann, if all is ok,
> or
> > NULL, in case of errors.
> > So the deferral mechanism is not used.
> 
> Right, yes - that analysis seems correct.  The interfaces seem a bit
> weird here but fixing them looks like the most complete and robust fix.

Ok Mark, I'll fix this problem as soon as I can, using EPROBE_DEFER.
For now, in my application, I use the patch that I already sent,
with the "softdep" workaround:

MODULE_SOFTDEP("pre: dw_dmac");

I tested it a lot, with more than 2000 cold reboot (automatic
switch on/off using a controlled power supply) and it always worked good.

Thanks for your help!

Flavio
