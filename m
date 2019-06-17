Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A42C31E5E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7180C20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IyPfPrYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfFQWLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:11:50 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51579 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfFQWLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:11:46 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 025A6886BF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:11:43 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1560809503;
        bh=DSLbrc5ukZCi8kilt1qLlyon/yI7IWOwk3BYxT6iAaE=;
        h=From:To:CC:Subject:Date:References;
        b=IyPfPrYPj2M2iG5aK4Gr1B2AilDoXhov+KIGUyS8MjUbMuYP13MQ3XvYcA+R3hoaE
         iYyPNsC+GeS+8Ii/wZLwPUwn37q+d/HLZ0SHkHlXRdpKQxuTu4LFXsmTp4R3c1MXpF
         jfW7f/k1xAa2k4IZHhamPdSLgEX8nV+Jd3gXzev6xkzAkJzc/sxtBmEnT9S+I8qg7k
         VGXvR8qoQw+Ibv7/vBvQ/dwxwgThSgPeaaOhKi+j/1Qn2WUopoQn3/WNbc9qpjRmWB
         VHY7a1DBaE8c9OotRkXbFdFmSx0LQedaWOdU4l+2I1V9jmHTZA/kSTF9LDhKzzKLU4
         d0adHAE46YiIQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d08101f0001>; Tue, 18 Jun 2019 10:11:43 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Tue, 18 Jun 2019 10:11:42 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 18 Jun 2019 10:11:42 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: concat: refactor concat_lock/concat_unlock
Thread-Topic: [PATCH v2 1/2] mtd: concat: refactor concat_lock/concat_unlock
Thread-Index: AQHVEPTbCX8jgKCQ/EWiWr4BFnYFGQ==
Date:   Mon, 17 Jun 2019 22:11:42 +0000
Message-ID: <365a80987504424f8685faaceb23b468@svr-chch-ex1.atlnz.lc>
References: <20190522231948.17559-1-chris.packham@alliedtelesis.co.nz>
 <355dad1321ed46baa98ca6f47b4d00b5@svr-chch-ex1.atlnz.lc>
 <CAFLxGvwNNWKzbfKvDjAK6rujbr5qtmVAWCDD5aULO4BVKutRKw@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/19 10:08 AM, Richard Weinberger wrote:=0A=
> On Fri, Jun 14, 2019 at 5:26 AM Chris Packham=0A=
> <Chris.Packham@alliedtelesis.co.nz> wrote:=0A=
>>=0A=
>> Hi All,=0A=
>>=0A=
>> Ping?=0A=
> =0A=
> Your patch is not lost. We start soon with collecting all material for=0A=
> the merge window. :-)=0A=
> =0A=
=0A=
OK thanks for the confirmation and sorry for the noise.=0A=
