Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE606C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E41214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430998;
	bh=wbwWhzZKRAaXl/rlWL+CNwkNSGBPiJifmzQw8fMhL7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PxV4pHamo0Zxy5h0HQX9YyJ1io8sq8vI6eHYwuUR8Ugg2daAwrLvrk6IgC8pnxzZ7
	 UuHWTXTZscClu8pxsDJGanDDtsTlDKNWvKe28XIva2PK5spMAPQZf8O5X93ffJuE6e
	 8kR7jeDt4C8S4yXwTPm5Sw9uF2je42F6/wsIicZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAGVDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:03:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgAGVDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:03:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B13E20678;
        Tue,  7 Jan 2020 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430993;
        bh=wbwWhzZKRAaXl/rlWL+CNwkNSGBPiJifmzQw8fMhL7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTjNif9C/6n72NsN5kgMUZ8sdm0kHD+YyaZNXS4ecSMhxewBytUJorcfLZwT6vmd8
         v0fkChCowYiSvAt03VZGR+PD6J0X0sHhjz2183wdpJrUhVI60l5lx15XX8TZUhwaYR
         ektVMBdjdVjou/ZRGMmbYZJHOMMMeP8Pu9YkewX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 164/191] regulator: ab8500: Remove AB8505 USB regulator
Date:   Tue,  7 Jan 2020 21:54:44 +0100
Message-Id: <20200107205341.759633123@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit 99c4f70df3a6446c56ca817c2d0f9c12d85d4e7c upstream.

The USB regulator was removed for AB8500 in
commit 41a06aa738ad ("regulator: ab8500: Remove USB regulator").
It was then added for AB8505 in
commit 547f384f33db ("regulator: ab8500: add support for ab8505").

However, there was never an entry added for it in
ab8505_regulator_match. This causes all regulators after it
to be initialized with the wrong device tree data, eventually
leading to an out-of-bounds array read.

Given that it is not used anywhere in the kernel, it seems
likely that similar arguments against supporting it exist for
AB8505 (it is controlled by hardware).

Therefore, simply remove it like for AB8500 instead of adding
an entry in ab8505_regulator_match.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191106173125.14496-1-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/ab8500.c       |   17 -----------------
 include/linux/regulator/ab8500.h |    1 -
 2 files changed, 18 deletions(-)

--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -953,23 +953,6 @@ static struct ab8500_regulator_info
 		.update_val_idle	= 0x82,
 		.update_val_normal	= 0x02,
 	},
-	[AB8505_LDO_USB] = {
-		.desc = {
-			.name           = "LDO-USB",
-			.ops            = &ab8500_regulator_mode_ops,
-			.type           = REGULATOR_VOLTAGE,
-			.id             = AB8505_LDO_USB,
-			.owner          = THIS_MODULE,
-			.n_voltages     = 1,
-			.volt_table	= fixed_3300000_voltage,
-		},
-		.update_bank            = 0x03,
-		.update_reg             = 0x82,
-		.update_mask            = 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-	},
 	[AB8505_LDO_AUDIO] = {
 		.desc = {
 			.name		= "LDO-AUDIO",
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -37,7 +37,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_AUX6,
 	AB8505_LDO_INTCORE,
 	AB8505_LDO_ADC,
-	AB8505_LDO_USB,
 	AB8505_LDO_AUDIO,
 	AB8505_LDO_ANAMIC1,
 	AB8505_LDO_ANAMIC2,


