Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB96C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9D12173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390889AbfGRTAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:00:37 -0400
Received: from er-systems.de ([148.251.68.21]:51964 "EHLO er-systems.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbfGRTAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:00:37 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 15:00:36 EDT
Received: from localhost.localdomain (localhost [127.0.0.1])
        by er-systems.de (Postfix) with ESMTP id 44CC8D6005E;
        Thu, 18 Jul 2019 20:50:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by er-systems.de (Postfix) with ESMTPS id 229DAD6005A;
        Thu, 18 Jul 2019 20:50:30 +0200 (CEST)
Date:   Thu, 18 Jul 2019 20:50:29 +0200 (CEST)
From:   Thomas Voegtle <tv@lio96.de>
X-X-Sender: thomas@er-systems.de
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: network problems with r8169
Message-ID: <alpine.LSU.2.21.1907182032370.7080@er-systems.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.100.3/25514/Thu Jul 18 10:12:59 2019 signatures 58.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm having network problems with the commits on r8169 since v5.2. There 
are ping packet loss, sometimes 100%, sometimes 50%. In the end network is 
unusable.

v5.2 is fine, I bisected it down to:

a2928d28643e3c064ff41397281d20c445525032 is the first bad commit
commit a2928d28643e3c064ff41397281d20c445525032
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Sun Jun 2 10:53:49 2019 +0200

     r8169: use paged versions of phylib MDIO access functions

     Use paged versions of phylib MDIO access functions to simplify
     the code.

     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>


Reverting that commit on top of v5.2-11564-g22051d9c4a57 fixes the problem
for me (had to adjust the renaming to r8169_main.c).

I have a:
04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev
0c)
         Subsystem: Biostar Microtech Int'l Corp Device [1565:2400]
         Kernel driver in use: r8169

on a BIOSTAR H81MG motherboard.


greetings,

   Thomas

