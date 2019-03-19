Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC260C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C7920811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfCSP1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:27:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:54050 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCSP1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:27:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 08:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="143320633"
Received: from mylly.fi.intel.com (HELO [10.237.72.176]) ([10.237.72.176])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2019 08:27:44 -0700
Subject: Re: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during
 pxa2xx_spi_transfer_one()
To:     "Xiao, Jin" <jin.xiao@intel.com>, Mark Brown <broonie@kernel.org>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com, bo.he@intel.com
References: <20190307072424.18820-1-jin.xiao@intel.com>
 <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
 <20190307160924.GE6529@sirena.org.uk>
 <11f165e9-ef53-edb9-cec2-e30ad2b440b5@intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <6013a37a-ee24-e371-773c-141a54926239@linux.intel.com>
Date:   Tue, 19 Mar 2019 17:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <11f165e9-ef53-edb9-cec2-e30ad2b440b5@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jin

On 3/8/19 9:28 AM, Xiao, Jin wrote:
> 
> Yes, the spi core has de-asserted the CS before the 
> pxa2xx_spi_unprepare_transfer(). The problem on my side is that the new 
> transfer will restart the SSP in pxa2xx_spi_transfer_one(). The spi core 
> has asserted the CS again before restart the SSP.  In my test the CS 
> assert before the restart SSP can't ensure the spi transfer working 
> correctly.
> 
I wanted to ask have you found any other fix or reason than the patches 
you have sent?

I've been trying to debug why the commit d5898e19c0d7 ("spi: pxa2xx: Use 
core message processing loop") is causing the regression you are seeing.

I've been testing this by sending two or more messages each consisting 
of two 4-byte transfers through the spidev. SPI mode 3 and clock is 1 
MHz. I see only slight timing difference between a commit before and at 
d5898e19c0d7 when the chip select is active.

8ae55af38817: CS act to CLK running ~40 us. CLK idle to CS deact ~26 us
d5898e19c0d7: CS act to CLK running ~34 us. CLK idle to CS deact ~18 us

There is more difference/variability during the times when the CS is not 
active between messages. Which is understandable since there happens 
message passing from userspace, queing, etc.

At 8ae55af38817 total time over 2 messages varies from ~600 us to 1200 
~us and at d5898e19c0d7 from ~500 us to 1100 us. Then at v4.19 it goes a 
bit slover and varies between ~700 to 1600 us. Most probably due some 
other change than in SPI subsystem as there is not commit either in SPI 
core or spi-pxa2xx explaining it. Or just some random config change in 
my kernel configuration between 4.17 and 4.19.

What I don't understand why additional CS toggling makes it work for you 
in case SSP was stopped in pxa2xx_spi_unprepare_transfer() and restarted 
again in pxa2xx_spi_transfer_one(). This SSP stopping and restarting is 
not visible in the SPI signals since clock is already stopped when FIFO 
gets empty.

I guess the reason why you are seeing pxa2xx_spi_unprepare_transfer() 
only called sometimes is that in those cases where it is not called a 
new SPI message got queued while processing the current one and in other 
cases queue became empty before new message was queued.

In both cases there shouldn't be difference in CS handling. Which makes 
me scratching my head why additional CS toggling is fixing the issue in 
case there is SSP restart. And which was due more time elapsed between 
messages and queue went empty.

-- 
Jarkko
