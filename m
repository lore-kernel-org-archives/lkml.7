Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36255C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C532081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098803;
	bh=Gg4ME2opx0ls3JAG2sUjjvBheibBOhlnUuLj5kIo0Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gnlZy5un7twEUwomkWm1lNEcEp81bioNaQj4yBHRktqT/iHTAwLw8pSWg1QNSo1b3
	 fC+IkexHI93lPEDR9tQ8w3ahVeQchbxvBmvMUQHLT68CMswq6yxPfpdU9Gp+yTvzmT
	 kJLqWK48sCVKiu1ebQCNR6NZh9lL3doI4laYx6Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfFIQqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbfFIQqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 761722081C;
        Sun,  9 Jun 2019 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098798;
        bh=Gg4ME2opx0ls3JAG2sUjjvBheibBOhlnUuLj5kIo0Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvVu9DvvWEzsxiBdpWIJ1pq4mRBylzThVXVAjNkhlPZi6L2jKOAKDaOL5YjYlHssj
         cQWzXTzZftUMhi57vaID7kcZDIDe/v0FEKwrIqadZgea5frgXBNpAgCHAUVvqq5eac
         heDTZQ+9GpPWWHIA4gfbMUvbGKYWt3juLlHF6CYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.1 38/70] mmc: sdhci_am654: Fix SLOTTYPE write
Date:   Sun,  9 Jun 2019 18:41:49 +0200
Message-Id: <20190609164130.391292539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

commit 7397993145872c74871ab2aa7fa26a427144088a upstream.

In the call to regmap_update_bits() for SLOTTYPE, the mask and value
fields are exchanged. Fix this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Fixes: 41fd4caeb00b ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci_am654.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -209,7 +209,7 @@ static int sdhci_am654_init(struct sdhci
 		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
 
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
-			   ctl_cfg_2, SLOTTYPE_MASK);
+			   SLOTTYPE_MASK, ctl_cfg_2);
 
 	return sdhci_add_host(host);
 }


