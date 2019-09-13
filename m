Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D649CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D11206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381022;
	bh=u4AEQA8IMkb9shpP6sxLQkQqMEc8olY3grzDr/FTydM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZPnCfZWA9tqTd/bx9NRiKdsKeUP4o8fUp78ljsl23AYj+NJmpSKJYKfHuNoHyL/a
	 CLvhHgUGNDJXhc87JozO0fGldCfIy0ZW9lHtJixP+8hi+1oivhQ7o9+1AOaim3EhaW
	 CmrANtb7n0D2AgenvwsZQWmErMYxfWTmZuzRYbvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbfIMNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390644AbfIMNUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:20:54 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9F920CC7;
        Fri, 13 Sep 2019 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380853;
        bh=u4AEQA8IMkb9shpP6sxLQkQqMEc8olY3grzDr/FTydM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKKREadKE1+7XQgrfaUsvFymolTMYFpvOzvRJdCMP2M/PwF5tjtiUoUFK5i4+FAd8
         xm09F45kxbnEojerLTk7/8QQO+KkOpgu+arRN4JnobXh8QjJ4HUeHiAWfKyg8Dqc6+
         l7RY+pGcWx/hcAvQaTL/dmACoBmxuYykdoRCF/dI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Jander <david@protonic.nl>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5.2 02/37] gpio: pca953x: use pca953x_read_regs instead of regmap_bulk_read
Date:   Fri, 13 Sep 2019 14:07:07 +0100
Message-Id: <20190913130511.432521598@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
References: <20190913130510.727515099@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

commit 438b6c20e6161a1a7542490baa093c86732f77d6 upstream.

The register number needs to be translated for chips with more than 8
ports. This patch fixes a bug causing all chips with more than 8 GPIO pins
to not work correctly.

Fixes: 0f25fda840a9 ("gpio: pca953x: Zap ad-hoc reg_direction cache")
Cc: Cc: <stable@vger.kernel.org>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-pca953x.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -606,8 +606,7 @@ static void pca953x_irq_bus_sync_unlock(
 	u8 invert_irq_mask[MAX_BANK];
 	u8 reg_direction[MAX_BANK];
 
-	regmap_bulk_read(chip->regmap, chip->regs->direction, reg_direction,
-			 NBANK(chip));
+	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
 
 	if (chip->driver_data & PCA_PCAL) {
 		/* Enable latch on interrupt-enabled inputs */
@@ -710,8 +709,7 @@ static bool pca953x_irq_pending(struct p
 		return false;
 
 	/* Remove output pins from the equation */
-	regmap_bulk_read(chip->regmap, chip->regs->direction, reg_direction,
-			 NBANK(chip));
+	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
 	for (i = 0; i < NBANK(chip); i++)
 		cur_stat[i] &= reg_direction[i];
 
@@ -789,8 +787,7 @@ static int pca953x_irq_setup(struct pca9
 	 * interrupt.  We have to rely on the previous read for
 	 * this purpose.
 	 */
-	regmap_bulk_read(chip->regmap, chip->regs->direction, reg_direction,
-			 NBANK(chip));
+	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
 	for (i = 0; i < NBANK(chip); i++)
 		chip->irq_stat[i] &= reg_direction[i];
 	mutex_init(&chip->irq_lock);


