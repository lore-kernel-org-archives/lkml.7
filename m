Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8212C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF6E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520190;
	bh=oIElqBuLqOI3RfPRIwnNyVf1rIaSkOio7IkY6dvHZIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rm45chDJhTjDpmZW/xhtKu3SojdMC1BKPZGIBAe+NrC5mVt8Q+LL6tsIaPbxJYojp
	 N+Jg+VTi1jWc509gAKvP3uV2JFKlOqmd4qXVD1oyKc5X/IZV1lISMtrZxHMj7ndqsL
	 KI007t8Fffa1ScR+UPTFhfSjd5eR3ecmJUA93vik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbfLPSQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:16:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731530AbfLPSQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:16:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFDA9206EC;
        Mon, 16 Dec 2019 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520186;
        bh=oIElqBuLqOI3RfPRIwnNyVf1rIaSkOio7IkY6dvHZIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVEPc3Ty+ho8mvwPddwUyANiBMaWCzAbeDA3c5PCzSP2+bA9mHJMQfqU/hAAM8kpc
         Rn4HXcnpAVROpbpKwcPn/lhsWyuuedmrqAQuyslQXuxUMheZgyZU/5gVZ99tb9Ppb8
         m/qWJuC5xmS5Fon0YVU19AEAprYIwMo8nwNIHSp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 5.4 052/177] tpm: Switch to platform_get_irq_optional()
Date:   Mon, 16 Dec 2019 18:48:28 +0100
Message-Id: <20191216174830.514921087@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 9c8c5742b6af76a3fd93b4e56d1d981173cf9016 upstream.

platform_get_irq() calls dev_err() on an error. As the IRQ usage in the
tpm_tis driver is optional, this is undesirable.

Specifically this leads to this new false-positive error being logged:
[    5.135413] tpm_tis MSFT0101:00: IRQ index 0 not found

This commit switches to platform_get_irq_optional(), which does not log
an error, fixing this.

Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()"
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -286,7 +286,7 @@ static int tpm_tis_plat_probe(struct pla
 	}
 	tpm_info.res = *res;
 
-	tpm_info.irq = platform_get_irq(pdev, 0);
+	tpm_info.irq = platform_get_irq_optional(pdev, 0);
 	if (tpm_info.irq <= 0) {
 		if (pdev != force_pdev)
 			tpm_info.irq = -1;


