Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87509C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6169121655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498053;
	bh=pc99F0Jd2Vg9JY50ObVWgymOB0Sgeg2O/tcimhadOd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Trx6lI8JDMLjKUxqZEW6jEw1k6yJ4m3t0Ng87smNHcoiyJjP6hqFvFfuJ+exKlX3s
	 lgDT7RVB/LNw7WD6TFZkDzVvPjMlgrGI+r9ewHpBrx6bPQXGiADxLKxsKp60A3+eJX
	 C6NexQkscmazIDSNXocDzjEERzj7xZTJgqU5aGcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfKKSrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:47:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbfKKSr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:47:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307A7204FD;
        Mon, 11 Nov 2019 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498048;
        bh=pc99F0Jd2Vg9JY50ObVWgymOB0Sgeg2O/tcimhadOd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1b7GdOUgt84Xm6IfUJ5/wrkKA1zlk2UL2GK4c5GYeyEsYv8EqK2EPqh3+iNHUIOL6
         GThRALhfujlasq+eda6fyagEvXF+UH1OhVmCDNGZBSX405lTho306chIetr8dgwdtM
         /Psi4y/v1Lj+PSBRYOKMrQntOvB3xQ3QvFJ6gAko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 120/125] pinctrl: cherryview: Fix irq_valid_mask calculation
Date:   Mon, 11 Nov 2019 19:29:19 +0100
Message-Id: <20191111181455.764494754@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 63bdef6cd6941917c823b9cc9aa0219d19fcb716 ]

Commit 03c4749dd6c7 ("gpio / ACPI: Drop unnecessary ACPI GPIO to Linux
GPIO translation") has made the cherryview gpio numbers sparse, to get
a 1:1 mapping between ACPI pin numbers and gpio numbers in Linux.

This has greatly simplified things, but the code setting the
irq_valid_mask was not updated for this, so the valid mask is still in
the old "compressed" numbering with the gaps in the pin numbers skipped,
which is wrong as irq_valid_mask needs to be expressed in gpio numbers.

This results in the following error on devices using pin 24 (0x0018) on
the north GPIO controller as an ACPI event source:

[    0.422452] cherryview-pinctrl INT33FF:01: Failed to translate GPIO to IRQ

This has been reported (by email) to be happening on a Caterpillar CAT T20
tablet and I've reproduced this myself on a Medion Akoya e2215t 2-in-1.

This commit uses the pin number instead of the compressed index into
community->pins to clear the correct bits in irq_valid_mask for GPIOs
using GPEs for interrupts, fixing these errors and in case of the
Medion Akoya e2215t also fixing the LID switch not working.

Cc: stable@vger.kernel.org
Fixes: 03c4749dd6c7 ("gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 227646eb817c8..9eab508395814 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1595,7 +1595,7 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
 		intsel >>= CHV_PADCTRL0_INTSEL_SHIFT;
 
 		if (need_valid_mask && intsel >= community->nirqs)
-			clear_bit(i, chip->irq.valid_mask);
+			clear_bit(desc->number, chip->irq.valid_mask);
 	}
 
 	/*
-- 
2.20.1



