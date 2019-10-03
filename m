Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB24C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050FD20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122553;
	bh=4RZYoUsuUQLZ4s568q0GUzU5T/LBcXRptdcGVSEtYSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=coB8w2nZB8BM22Pa6hS5MPtaAYeCmJW5SfoY3d6Y9ZB3UnjWnyFKweisRjL8xuLP7
	 o/sdUCQ7iUULIi2cD/pg6Pf7n3OS5Mk/9bgAcqWTXJ1TMwOiLNtZYHPWeP7w1m5zLq
	 mfcA0g6KgaLg//W8B+DRlWE1QpkOxn3E4hGS9pSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393362AbfJCRJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404179AbfJCQeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:34:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1645420830;
        Thu,  3 Oct 2019 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120470;
        bh=4RZYoUsuUQLZ4s568q0GUzU5T/LBcXRptdcGVSEtYSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJSHcWNcp+AF7Tmzmjop2V35BA2v6/Xo2qRJsDCXKf5v/JtN9MvdLU2dFXDoxAdsH
         OYEQghwSiEWvorLTppkHnr93UOHKaXbUZ1jN2iy1PwjLbuogjJdJhzn/2t2oSIuJW5
         EOl8lsopPYqorRb/pGySUC2sbJYWQ6+yUNFAhVfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-stable@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 5.2 233/313] tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
Date:   Thu,  3 Oct 2019 17:53:31 +0200
Message-Id: <20191003154555.951169029@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

commit 1ea32c83c699df32689d329b2415796b7bfc2f6e upstream.

The tpm_tis_core has to set the TPM_CHIP_FLAG_IRQ before probing for
interrupts since there is no other place in the code that would set
it.

Cc: linux-stable@vger.kernel.org
Fixes: 570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -981,6 +981,7 @@ int tpm_tis_core_init(struct device *dev
 		}
 
 		tpm_chip_start(chip);
+		chip->flags |= TPM_CHIP_FLAG_IRQ;
 		if (irq) {
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);


