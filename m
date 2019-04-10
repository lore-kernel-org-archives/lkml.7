Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0179CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4DB20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbfDJOFn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:05:43 -0400
Received: from smtp.asem.it ([151.1.184.197]:59791 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732471AbfDJOFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:05:43 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003804831.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:05:38 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 16:05:38 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 10 Apr 2019 16:05:38 +0200
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
Thread-Index: AQHU75yQbkDNn+rZPkCFgi0S9cPL1qY1OMwAgAAnBxA=
Date:   Wed, 10 Apr 2019 14:05:38 +0000
Message-ID: <6eeaf42f4d3f42c58546c429194213b8@asem.it>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
 <20190410125612.GR6106@sirena.org.uk>
In-Reply-To: <20190410125612.GR6106@sirena.org.uk>
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
X-SGOP-RefID: str=0001.0A0B0204.5CADF833.004A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> On Wed, Apr 10, 2019 at 02:51:36PM +0200, Flavio Suligoi wrote:
> > With dw_dmac, sometimes the request of a DMA channel fails because
> > the DMA driver is not ready, so an explicit dependency request
> > is necessary.
> 
> While this isn't going to hurt anything and might actually help so it's
> fine doesn't this also suggest that there's an issue with deferred probe
> going on as well?

I think that the problem could be related to how the DMA channel is requested.
At the moment the function used are:

pxa2xx_spi_dma_setup --> dma_request_slave_channel_compat -->
--> __dma_request_slave_channel_compat --> dma_request_slave_channel -->
--> dma_request_chan

Actually the final function "dma_request_chan" return
the channel number or "-EPROBE_DEFER" if it's not ready.
But this information ("-EPROBE_DEFER") is lost in the penultimate function 
"dma_request_slave_channel", which return only the chann, if all is ok, or
NULL, in case of errors.
So the deferral mechanism is not used.

Flavio

