Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4278021783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121387;
	bh=A/fluV88cdCtFiDoTo2oHXuBD3ua79iA+SvIybnQ9+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmzQfH4Or+k1vrmRC6W3D4DmZagqFCWz3ED2EQQ6PQmjUQ7MTl0bOMEmClTMGFkKD
	 UCbfSwvVCQDPSVVqZWJjT1uNMLC0qevIoy07NmWnTY/vZ56pPfkwcHUp0w2fSPzega
	 Zw7vsY0s+iXSZmfQKJscLp6iNpOkdUZr5YUEuof8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405844AbfJCQtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405291AbfJCQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:49:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC852215EA;
        Thu,  3 Oct 2019 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121375;
        bh=A/fluV88cdCtFiDoTo2oHXuBD3ua79iA+SvIybnQ9+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azPH2OGNRDCa+VnjxGO/3Sf5BEmaiRmYN+lrSjldRErIgcgtG/QpVWFBrFlU6W54O
         Mlt4EkmM3Z0DhxmhMfeGysd0Jh7oYwcQJt5uSabMcqxaCyl9c0kZJQlA1kkOsDnubw
         wJd9zs355+5KN5AZldgG9iouE7bc41CPozOtvJB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-stable@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 5.3 254/344] tpm_tis_core: Turn on the TPM before probing IRQs
Date:   Thu,  3 Oct 2019 17:53:39 +0200
Message-Id: <20191003154605.551941556@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

commit 5b359c7c43727e624eac3efc7ad21bd2defea161 upstream.

The interrupt probing sequence in tpm_tis_core cannot obviously run with
the TPM power gated. Power on the TPM with tpm_chip_start() before
probing IRQ's. Turn it off once the probing is complete.

Cc: linux-stable@vger.kernel.org
Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -980,6 +980,7 @@ int tpm_tis_core_init(struct device *dev
 			goto out_err;
 		}
 
+		tpm_chip_start(chip);
 		if (irq) {
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);
@@ -989,6 +990,7 @@ int tpm_tis_core_init(struct device *dev
 		} else {
 			tpm_tis_probe_irq(chip, intmask);
 		}
+		tpm_chip_stop(chip);
 	}
 
 	rc = tpm_chip_register(chip);


