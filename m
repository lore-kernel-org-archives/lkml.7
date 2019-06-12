Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D61C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A535220665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393240AbfFMRAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:00:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:49148 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbfFLX56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:57:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CNvXVL016754;
        Wed, 12 Jun 2019 18:57:34 -0500
Message-ID: <28912f8d0a39de519653472a3686fbd7317d18d3.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Shenhar, Talel" <talel@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
Date:   Thu, 13 Jun 2019 09:57:33 +1000
In-Reply-To: <20190612122504.GI32652@zn.tnic>
References: <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
         <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
         <20190611115651.GD31772@zn.tnic>
         <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
         <20190612034813.GA32652@zn.tnic>
         <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
         <20190612074242.53a4cf56@coco.lan> <20190612110039.GH32652@zn.tnic>
         <20190612084213.4fb9e054@coco.lan>
         <7705227ea831793cc9e45af32e0da8f5547cb14d.camel@kernel.crashing.org>
         <20190612122504.GI32652@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 14:25 +0200, Borislav Petkov wrote:
> > But for the main case that really needs to be in the kernel, which is
> > DRAM, the recovery can usually be contained to the MC driver anyway.
> 
> Right, if that is enough to handle the error properly.
> 
> The memory-failure.c example I gave before is the error reporting
> mechanism (x86 MCA) calling into the mm subsystem to poison and isolate
> page frames which are known to contain errors. So you have two things
> talking to each other.

And none of them is an EDAC driver...

I mean yes, the network drivers talk to the network stack, or even the
memory allocator :-)

I still don't see how that requires a big platform coordinator...

Ben.


