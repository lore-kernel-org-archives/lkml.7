Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF66C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED17C22D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfHTVFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:05:34 -0400
Received: from atlmailgw2.ami.com ([63.147.10.42]:52819 "EHLO
        atlmailgw2.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:05:34 -0400
X-AuditID: ac10606f-d27ff70000003324-96-5d5c609dc94e
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw2.ami.com (Symantec Messaging Gateway) with SMTP id 07.00.13092.D906C5D5; Tue, 20 Aug 2019 17:05:33 -0400 (EDT)
Received: from hongweiz-Ubuntu-AMI.us.megatrends.com (172.16.98.93) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 20 Aug 2019 17:05:31 -0400
From:   Hongwei Zhang <hongweiz@ami.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Hongwei Zhang <hongweiz@ami.com>, Joel Stanley <joel@jms.id.au>,
        <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [v8]  gpio: aspeed: Add SGPIO driver
Date:   Tue, 20 Aug 2019 17:05:27 -0400
Message-ID: <1566335128-31498-1-git-send-email-hongweiz@ami.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.93]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRiBhgu7chJhYgzevJC12Xeaw+DL3FIvF
        /CPnWC1+n//LbDHlz3Imi02Pr7FaNK8+x2yxef4fRovLu+awWSy9fpHJonXvEXYHbo+r7bvY
        PdbMW8Po8f5GK7vHxY/HmD02repk87hzbQ+bx+Yl9R7nZyxk9Pi8SS6AM4rLJiU1J7MstUjf
        LoErY83Hp4wFH9kr/nTPYW1g7GLrYuTkkBAwkWjZ9JW9i5GLQ0hgF5NE895dzBDOYUaJtbP3
        MYFUsQmoSezdPAfMFhHIkzi8/i0rSBGzwCkmiRn7OllBEsICuhJzT99gBrFZBFQlvi7ZwwJi
        8wo4SMzrX8QOsU5O4ua5TmaIuKDEyZlPwGqYBSQkDr54ARYXEpCVuHXoMRNEvYLE877HLBMY
        +WYhaZmFpGUBI9MqRqHEkpzcxMyc9HIjvcTcTL3k/NxNjJAwz9/B+PGj+SFGJg7GQ4wSHMxK
        IrwVc6JihXhTEiurUovy44tKc1KLDzFKc7AoifOuWvMtRkggPbEkNTs1tSC1CCbLxMEp1cB4
        42BnLHv5g70MSy2WzQ4v/H3l96nHfpd3JGdMVjmR6rzsmNCVH7x/LzGkfrlsez5T5pTaVsM/
        bX/LbOoM7XZ+vMr2vv/as6yvh5WFC7sNJQyVGN/5bP/DfchekfnKp2PnXI88S1mV9Fv9Z8PX
        Pv+rOTcDpjlHR4lPytwtzVG+zaXtLn+c47owJZbijERDLeai4kQARbmDwmECAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This short series introduce dt-binding document and a driver for the 
Aspeed AST2500 SGPIO controller. Please review.

[v8]:   Changes between v7 and v8:
        - v7 updates based on Linus' feedback 
        - since Linus has already merged sgpio-aspeed.txt, I only include
	  the driver here to avoid confusion.

[v7]:   Changes between v6 and v7:
        - fix missing variable 'reg' assign issue in aspeed_sgpio_set()
        - v6 feedback updates

[v6]:   Changes between v5 and v6:
        - fix a bug in aspeed_sgpio_dir_out()
        - v5 feedback updates, some comments cleanup

The related SGPM pinmux dt-binding document, dts, and pinctrl driver
updates have been accepted and merged:
_http://patchwork.ozlabs.org/patch/1110210/

Hongwei Zhang (1):
  gpio: aspeed: Add SGPIO driver

 drivers/gpio/sgpio-aspeed.c | 533 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 533 insertions(+)
 create mode 100644 drivers/gpio/sgpio-aspeed.c

-- 
2.7.4

