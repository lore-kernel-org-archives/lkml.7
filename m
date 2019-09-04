Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DFDC3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A15423402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621237;
	bh=UbwxphCkJgqkkmqkEGI327ZtsTfNouQD7+qWRvtcpI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YVMsjPLTIMn5WuOyXBUykVdnbCGxQ57r3TF8uiZwDzisSoPV8Ofb1CzI9j590M2ZP
	 XTOoAvS/OmFLc5Vcglw3/gL/0QTrvVlhoh6q42ry8ce15efcYrodK8C0fi+YPKQnVm
	 Oe15vFI/j0FcEP/SlX7JGRErTSptLPFEOkGgZtwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbfIDSH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389302AbfIDSH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:07:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8BA520870;
        Wed,  4 Sep 2019 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620475;
        bh=UbwxphCkJgqkkmqkEGI327ZtsTfNouQD7+qWRvtcpI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stARnLWN+RtRq81hHYa2OulY7q8ZKiMxoo3ABQxJRfDDRAdTgFduGi5WKCs4D0yY0
         wBdiW/2W7hTfpofjgBFhmZbensHnq+aGr7q+iws+c5ByfNiaK5WeIf4ebfTlMLHbi+
         ftnEcKLDIAZ9vw+LpycL16+7cciiPGrzalWOtC0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 4.19 71/93] lib: logic_pio: Avoid possible overlap for unregistering regions
Date:   Wed,  4 Sep 2019 19:54:13 +0200
Message-Id: <20190904175309.207549490@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

commit 0a27142bd1ee259e24a0be2b0133e5ca5df8da91 upstream.

The code was originally written to not support unregistering logical PIO
regions.

To accommodate supporting unregistering logical PIO regions, subtly modify
LOGIC_PIO_CPU_MMIO region registration code, such that the "end" of the
registered regions is the "end" of the last region, and not the sum of
the sizes of all the registered regions.

Cc: stable@vger.kernel.org
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/logic_pio.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -35,7 +35,7 @@ int logic_pio_register_range(struct logi
 	struct logic_pio_hwaddr *range;
 	resource_size_t start;
 	resource_size_t end;
-	resource_size_t mmio_sz = 0;
+	resource_size_t mmio_end = 0;
 	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
 	int ret = 0;
 
@@ -56,7 +56,7 @@ int logic_pio_register_range(struct logi
 			/* for MMIO ranges we need to check for overlap */
 			if (start >= range->hw_start + range->size ||
 			    end < range->hw_start) {
-				mmio_sz += range->size;
+				mmio_end = range->io_start + range->size;
 			} else {
 				ret = -EFAULT;
 				goto end_register;
@@ -69,16 +69,16 @@ int logic_pio_register_range(struct logi
 
 	/* range not registered yet, check for available space */
 	if (new_range->flags == LOGIC_PIO_CPU_MMIO) {
-		if (mmio_sz + new_range->size - 1 > MMIO_UPPER_LIMIT) {
+		if (mmio_end + new_range->size - 1 > MMIO_UPPER_LIMIT) {
 			/* if it's too big check if 64K space can be reserved */
-			if (mmio_sz + SZ_64K - 1 > MMIO_UPPER_LIMIT) {
+			if (mmio_end + SZ_64K - 1 > MMIO_UPPER_LIMIT) {
 				ret = -E2BIG;
 				goto end_register;
 			}
 			new_range->size = SZ_64K;
 			pr_warn("Requested IO range too big, new size set to 64K\n");
 		}
-		new_range->io_start = mmio_sz;
+		new_range->io_start = mmio_end;
 	} else if (new_range->flags == LOGIC_PIO_INDIRECT) {
 		if (iio_sz + new_range->size - 1 > IO_SPACE_LIMIT) {
 			ret = -E2BIG;


