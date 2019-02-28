Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4477920857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbfB1RNh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:37 -0500
Received: from smtp.asem.it ([151.1.184.197]:54367 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387689AbfB1RNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:32 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003723839.MSG 
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 18:13:28 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Thu, 28
 Feb 2019 18:13:27 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Thu, 28 Feb 2019 18:13:27 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] net: e1000e: add MAC address kernel cmd line parameter
Thread-Topic: [PATCH v3] net: e1000e: add MAC address kernel cmd line
 parameter
Thread-Index: AQHUz2za8U5Pv4cZVkOebP6EQ2CVPqX1RhaAgAAUBLD///4SgIAAFXBw
Date:   Thu, 28 Feb 2019 17:13:27 +0000
Message-ID: <6a7a37813e71420b929c769dd1e77664@asem.it>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
 <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
 <20190228153245.GA17912@lunn.ch> <b12067de92864d5db83bd3da9456e2fe@asem.it>
 <20190228163729.GB17912@lunn.ch>
In-Reply-To: <20190228163729.GB17912@lunn.ch>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.161]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B020E.5C7816B8.0036,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Andrew,
> >
> > we produce a lot of boards and we have to change the MAC address,
> > from u-boot, for every board.  So I must save in the u-boot
> > environment (SPI NOR flash) the MAC address for every board.
> 
> Hi Flavio
> 
> u-boot should be able to write the MAC address in the correct part of
> device tree. Boards have been doing this a long time.
> 
> Module parameters are considered bad. You should only do it if you
> have no other option. Here you do have another options, so it is going
> to be a hard sell getting David to access your patch.
> 
> You will have more success by adding a call to
> eth_platform_get_mac_address() to the e1000e driver.

You have right, and thanks for your suggestions, 
but with a kernel parameter I can use the same method
for any board where the NVM is missed, independently of any architecture
(with or without the device tree presence - ARM or x86 or others).

In fact slso the drivers/net/ethernet/freescale/fec_main.c provides
a kernel parameter for the MAC address, in fec_get_mac:

	/*
	 * try to get mac address in following order:
	 *
	 * 1) module parameter via kernel command line in form
	 *    fec.macaddr=0x00,0x04,0x9f,0x01,0x30,0xe0
	 */
	iap = macaddr;

Thanks,

Flavio

>    Andrew
