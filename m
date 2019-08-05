Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F117AC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA0D20644
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011664;
	bh=V7iHpQlzG47w3l0h0GnwluXQpMNb2nQBW0dYAAujHRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KEVyL/KFbxV42ZKh0fzIsEFc5cYmq7DfYUyHsZlNaYfmO+zxcY0Cuni+fVOPKOusN
	 0qWmIZaE/FKhWRBKpR5wWvxVEvVXqBmJ1l3IzRSyWHh98lkMq3n7dbxM/C1/Q9x2Aa
	 LwDSjAKF2x3U+lSE/XkdO4G5llA4t3m2UqywGyMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfHENY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730983AbfHENYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:24:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3786520651;
        Mon,  5 Aug 2019 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011460;
        bh=V7iHpQlzG47w3l0h0GnwluXQpMNb2nQBW0dYAAujHRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYg9wZgl1HTGSeuurs97afsPWjcUJuWLTGkindxODhnxjrlNlIpLjvSWVma+q7OhN
         b1VnvwhewuxmbNTMuXUT1+aGeHVbv1uL7IZL5/qAcZk+GOY8iicKt/ipGK55xDe5uC
         8eNyeuggCO85nLVVMNKaZNH2W7bHHQZsJaOwcZf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.2 096/131] i2c: at91: fix clk_offset for sama5d2
Date:   Mon,  5 Aug 2019 15:03:03 +0200
Message-Id: <20190805124958.394493325@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit b1ac6704493fa14b5dc19eb6b69a73932361a131 upstream.

In SAMA5D2 datasheet, TWIHS_CWGR register rescription mentions clock
offset of 3 cycles (compared to 4 in eg. SAMA5D3).

Cc: stable@vger.kernel.org # 5.2.x
[needs applying to i2c-at91.c instead for earlier kernels]
Fixes: 0ef6f3213dac ("i2c: at91: add support for new alternative command mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-at91-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -142,7 +142,7 @@ static struct at91_twi_pdata sama5d4_con
 
 static struct at91_twi_pdata sama5d2_config = {
 	.clk_max_div = 7,
-	.clk_offset = 4,
+	.clk_offset = 3,
 	.has_unre_flag = true,
 	.has_alt_cmd = true,
 	.has_hold_field = true,


