Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F0C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CF6206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfHAHMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:12:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:54705 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:12:37 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: KOIO5aPBnyj78kcD+HN+oud5Hl32sOC01iATWdQpiINf+aunYA+T17ybBj6R6SPmU8+RWsXEDu
 CTHM8/wdD9a6tdnC2nox7Exyes0RUqxzW1IlcFaZLcK9pWvHOnrAE6HUXty+yNVE2EJGnQms4V
 vVXFrt7qiWoO3SbmWKY0PKRI2Jy08xwDCiCZs+C+h/VFTXd/e8sR7/6F/7po6fjE8AuOqF1vr7
 WXT8LCzLeNeq750Uk4QtJcPkSQ89LMcBhpuBFZDnVo/ZEPt2n8Xu4UNozSThA54kKoY/rbbbiU
 rSU=
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; 
   d="scan'208";a="42778277"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2019 00:12:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Aug 2019 00:12:33 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 1 Aug 2019 00:12:32 -0700
Date:   Thu, 1 Aug 2019 09:11:36 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Message-ID: <20190801071136.37yjjr3kmdhfyxna@M43218.corp.atmel.com>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20190729000123.GA23902@embeddedor>
 <20190731113216.ztxckd54a74g2lw5@M43218.corp.atmel.com>
 <201907310905.B90C6E25@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <201907310905.B90C6E25@keescook>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 09:06:07AM -0700, Kees Cook wrote:
> On Wed, Jul 31, 2019 at 01:32:16PM +0200, Ludovic Desroches wrote:
> > > drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    host->caps.need_notbusy_for_read_ops = 1;
> > >    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> > > drivers/mmc/host/atmel-mci.c:2427:2: note: here
> > >   case 0x100:
> > >   ^~~~
> > > 
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > I don't know if there is a policy in the kernel about the expression to
> > use. As this one does the job
> 
> Yup, documented here:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#implicit-switch-case-fall-through

Thanks for the pointer.

Regards

Ludovic

> 
> > Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> Thanks!
> 
> -- 
> Kees Cook
