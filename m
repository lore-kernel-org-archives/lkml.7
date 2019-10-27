Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977AACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC4120B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210939;
	bh=ghYDmO0EhElmhKIB+3vLcdmH7zUkupfl6sJzekQaNOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=028VBY6g8G3jfRPRewahZ5VQGHPMOyzaWKsXGsBTfUGbXbaZdKuftflZGKbVvxUtk
	 MjK125151YoMabYkXydo7U5JLx3oULsvJTvyOZX+YWPsdDUHp71MjrxTZXRknxKMBM
	 3PU+3hUEvidJxDNJOH0CbTRChlw4HCejd45bMs9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfJ0VPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbfJ0VP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:15:27 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B2D208C0;
        Sun, 27 Oct 2019 21:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210926;
        bh=ghYDmO0EhElmhKIB+3vLcdmH7zUkupfl6sJzekQaNOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AseoX2W2hTk0jfbIgEEAykq7O2tYKGvsbsJTR1NR3AbRFMpyg+jIIJyIev9RmW6nF
         qqT2y7aeEBX0hrkOsxdiGtORQLxFGbSwaOSGy4T4kJbkxVlSS1SF+WCdioowALAFZE
         9l/JzzANkj6ueXrqMXzvUKKGojQ5QVVPzBwyGY2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 64/93] mmc: cqhci: Commit descriptors before setting the doorbell
Date:   Sun, 27 Oct 2019 22:01:16 +0100
Message-Id: <20191027203306.631189236@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

commit c07d0073b9ec80a139d07ebf78e9c30d2a28279e upstream.

Add a write memory barrier to make sure that descriptors are actually
written to memory, before ringing the doorbell.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/cqhci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -617,7 +617,8 @@ static int cqhci_request(struct mmc_host
 	cq_host->slot[tag].flags = 0;
 
 	cq_host->qcnt += 1;
-
+	/* Make sure descriptors are ready before ringing the doorbell */
+	wmb();
 	cqhci_writel(cq_host, 1 << tag, CQHCI_TDBR);
 	if (!(cqhci_readl(cq_host, CQHCI_TDBR) & (1 << tag)))
 		pr_debug("%s: cqhci: doorbell not set for tag %d\n",


