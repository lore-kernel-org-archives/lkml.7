Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEDCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702D821655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408545AbfJXGZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:25:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20039 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406959AbfJXGZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:25:16 -0400
X-UUID: c5633a19188840049de99bd3b1aea82e-20191024
X-UUID: c5633a19188840049de99bd3b1aea82e-20191024
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <luhua.xu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1276930666; Thu, 24 Oct 2019 14:25:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Oct 2019 14:25:08 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Oct 2019 14:25:07 +0800
Message-ID: <1571898319.4311.3.camel@mbjsdccf07>
Subject: Re: [PATCH 1/1] spi: mediatek: add power control when set_cs
From:   luhua xu <luhua.xu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 24 Oct 2019 14:25:19 +0800
In-Reply-To: <20191023151121.GC5723@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
         <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
         <20191023151121.GC5723@sirena.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-23 at 16:11 +0100, Mark Brown wrote:
> On Wed, Oct 23, 2019 at 08:38:42AM -0400, Luhua Xu wrote:
> > From: "luhua.xu" <luhua.xu@mediatek.com>
> 
> > Use runtime PM to power spi when set_cs
> > As set_cs may be called from interrupt context,
> > set runtime PM IRQ safe for spi.
> 
> Why might we be trying to set the chip select state while the device is
> runtime idle?  It seems like whatever is trying to set the chip select
> should be dealing with this, not the chip select operation itself since
> that's unlikely to be happening in isolation.

Hi Mark,
Spi framework provideds  spi_setup() to modify spi settings for spi
device (maybe spi is runtime idle now), and this will call
spi_controller->set_cs() accessing registers.
Other spi_controller callbacks that need to access hardware registers,
are triggered by spi transfer. Spi framework will get and put runtime
power in __spi_pump_message().

