Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5986AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE9620818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfDJMBU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:01:20 -0400
Received: from smtp.asem.it ([151.1.184.197]:56986 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbfDJMBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:01:20 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003804311.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:01:16 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 14:01:15 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 10 Apr 2019 14:01:15 +0200
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
Thread-Index: AQHU7h76xswpdz/DmEySUaMIIqbaa6Y1E7kAgAAzYSD//+NxgIAAIlmw
Date:   Wed, 10 Apr 2019 12:01:15 +0000
Message-ID: <6953cafeb6bc4367842f37f567bb893f@asem.it>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <20190410103250.GF6106@sirena.org.uk>
 <a7237e949bb643d5b49ccc5ae241bbb9@asem.it>
 <20190410115431.GO6106@sirena.org.uk>
In-Reply-To: <20190410115431.GO6106@sirena.org.uk>
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
X-SGOP-RefID: str=0001.0A0B020B.5CADDB0B.0086,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Apr 10, 2019 at 11:47:43AM +0000, Flavio Suligoi wrote:
> 
> > You have right about to avoid too many boot messages,
> > but in this case, using an x86 machine and with
> > the spi-pxa2xx in DMA mode, so without the message:
> 
> > "no DMA channels available, using PIO",
> 
> > there is absolutely no indication about the existence
> > of the SPI master controller.
> 
> It's totally fine to not have a boot print for the device, the best way
> to find devices if you need them is to look in sysfs anyway.

Ok
 
> > The second reason is about the DMA/PIO mode indication.
> > With the board I'm using, sometimes the spi-pxa2xx driver can't allocate
> > a DMA channel and works in PIO mode.
> 
> > So, with the advice of Jarkko, I think that a valid solution could be:
> 
> > 1) remove the "no DMA channels available, using PIO" message
> > 2) add a new message with the indications of:
> > 	- controller mode (slave or master)
> > 	- transfer mode (DMA or PIO)
> 
> > What do you think about this?
> 
> If the system is randomly failing to assign a DMA channel when it should
> then shouldn't we just fix that?  A print which is presumably intended
> to prompt the user to reboot to try to get things working doesn't seem
> like a good solution.

Right, I'm just fix the DMA problem (I'm preparing a patch about this)

Flavio
