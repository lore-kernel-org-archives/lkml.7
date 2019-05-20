Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDD6C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E524C21707
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354984;
	bh=zfS+tafhgl+KxH3yuXDCnV/5oruOSkTddix6yyBhaWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N34d6o+y8aO/njKewLLUte+Jl7yn9D9GHz+4naRFWUSBlI/4fWyMmBz7/iAX/4d5r
	 2a83r4F0fZC1ZD+zJELgkOJ9BHeyEortQT5x9ZFVnW9Vh8wr3yU5DCh4A1fGtYOv9D
	 DvdxtNjIhC9kde6daBkshmZ33A85sqV3A/EU5YKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbfETMXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfETMWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:22:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EF9E214AE;
        Mon, 20 May 2019 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354972;
        bh=zfS+tafhgl+KxH3yuXDCnV/5oruOSkTddix6yyBhaWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JP1SmMXwHoNpwRWSKTup2tZVaWgb+TeAdXsXmeDUkMz85MpL2/BJ5i2I+Byj7bxb/
         4bC/rZiGBAVIlSQ9i7UhsGXK63yizDVGR56vVhT2lzN/IQBjfswdUlabvlH0v1nNoi
         Wo2cHoSnEf/iPxDlABsaW1093BoanHQcXVuvmiYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.19 010/105] power: supply: axp288_charger: Fix unchecked return value
Date:   Mon, 20 May 2019 14:13:16 +0200
Message-Id: <20190520115247.763133797@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
References: <20190520115247.060821231@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit c3422ad5f84a66739ec6a37251ca27638c85b6be upstream.

Currently there is no check on platform_get_irq() return value
in case it fails, hence never actually reporting any errors and
causing unexpected behavior when using such value as argument
for function regmap_irq_get_virq().

Fix this by adding a proper check, a message reporting any errors
and returning *pirq*

Addresses-Coverity-ID: 1443940 ("Improper use of negative value")
Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/axp288_charger.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -832,6 +832,10 @@ static int axp288_charger_probe(struct p
 	/* Register charger interrupts */
 	for (i = 0; i < CHRG_INTR_END; i++) {
 		pirq = platform_get_irq(info->pdev, i);
+		if (pirq < 0) {
+			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
+			return pirq;
+		}
 		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
 		if (info->irq[i] < 0) {
 			dev_warn(&info->pdev->dev,


