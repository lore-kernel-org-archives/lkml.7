Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB466C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF021217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfFNUdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:33:42 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:56883 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFNUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:33:37 -0400
Received: from localhost (unknown [37.205.120.66])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B9D67200009;
        Fri, 14 Jun 2019 20:33:30 +0000 (UTC)
Date:   Fri, 14 Jun 2019 22:33:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ken Sloat <KSloat@aampglobal.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] watchdog: atmel: atmel-sama5d4-wdt: Disable
 watchdog on system suspend
Message-ID: <20190614203327.GE3369@piout.net>
References: <20190614125310.29458-1-ksloat@aampglobal.com>
 <20190614164609.GA29814@roeck-us.net>
 <BL0PR07MB4115E99D065FD9BEA4C43BB5ADEE0@BL0PR07MB4115.namprd07.prod.outlook.com>
 <20190614180826.GD3369@piout.net>
 <BL0PR07MB4115D5ECDEDCC028197637E5ADEE0@BL0PR07MB4115.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR07MB4115D5ECDEDCC028197637E5ADEE0@BL0PR07MB4115.namprd07.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2019 18:43:22+0000, Ken Sloat wrote:
> Well I'm a little confused still because there are two separate comments
> in these statements. The first within resume implies that the init should
> be called because we might have lost register values for some reason
> unexplained.

The sama5d2 has a suspend mode where power to the core is completely
cut. Only a few IPs remain powered (in the backup power domain).
Unfortunately, the watchdog is not in that domain and may lose its
registers.

> Then within the init it says that the bootloader might have
> modified the registers so we should check them and then update it or
> otherwise disable it. I'm not trying to pick apart the logic or anything, 
> I'm just readily assuming it is good as it was already reviewed before. 
> 

The bootloaders may have started the watchdog (this makes sense if you
really care about reliability) and so we need to be careful to keep the
proper parameters.

> So without digging into that too much, if we don't know if any of the runtime
> situations above might have occurred, then isn't it best to leave my patch
> as is? Yes this has the side effect of resetting the timer count, but if 
> the init call is needed and we don't have any way to know if any
> of the situations occurred, then we have no choice right?
> 

Until we can differentiate between suspend modes, we have no other
choice.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
