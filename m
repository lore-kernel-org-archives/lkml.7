Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D8C282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F12620870
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDGOHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 10:07:46 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42663 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDGOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 10:07:45 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3D0491BF205;
        Sun,  7 Apr 2019 14:07:42 +0000 (UTC)
Date:   Sun, 7 Apr 2019 16:07:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Antonio Ospite <ao2@ao2.it>, Harald Welte <laforge@gnumonks.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Removing pcap?
Message-ID: <20190407140741.GE7480@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Antonio, Harald,

I've had a look at the PCAP RTC driver because I'm removing a few
deprecated APIs. While doing so, I've discovered that the driver has
never worked properly because PCAP_RTC_TOD_MASK and PCAP_RTC_DAY_MASK
are both missing a bit so every day would roll over at 18:12:15 and the
whole the date would roll over in 2014.

I discussed with Arnd about 59ee93a528b9 ("ARM: pxa: remove irq_to_gpio
from ezx-pcap driver") and it seems the whole EZX support has been
broken for a while.

Is it worth fixing the RTC driver or could I remove it?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
