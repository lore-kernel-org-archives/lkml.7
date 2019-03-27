Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBDDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38542177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710230;
	bh=VNLS4HSPTQbL952KVVEZwFGocV4pd99IvjWdPWqZcE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q448QD2YP0mv/LF4oRrcDU0dBbzn/CJqSqdG3f9BAl0ueiRHvOhLqmqJTlVbPoQPc
	 eYxNoFprCxwZVCDZUSxQUWbKTqzghDxVqcD+p1YNgqalvISCKykI70iPgciWFoWMFA
	 rCP122ev6KeyhYH7ls1s2NfrClPkG+D+YVwa4XI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbfC0SK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388795AbfC0SKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4F62177E;
        Wed, 27 Mar 2019 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710222;
        bh=VNLS4HSPTQbL952KVVEZwFGocV4pd99IvjWdPWqZcE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wow2wc4pG0vXaOXNVZ9a0VPgxi3lyx1sEiJ8kqMxxKE510lqVkrq8iHdbuNgTYAJt
         f0Z/hhjsoy+3UslOKZWTm41hQeFkRA9IHlf5RZHfjdsUA6/HlLIOMuNyyVCLtsY76X
         nPAyAkVGbfYdEr3xoIFgdNoAmYbaT2NPcmru8bQA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 261/262] ACPI / video: Extend chassis-type detection with a "Lunch Box" check
Date:   Wed, 27 Mar 2019 14:01:56 -0400
Message-Id: <20190327180158.10245-261-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit d693c008e3ca04db5916ff72e68ce661888a913b ]

Commit 53fa1f6e8a59 ("ACPI / video: Only default only_lcd to true on
Win8-ready _desktops_") introduced chassis type detection, limiting the
lcd_only check for the backlight to devices where the chassis-type
indicates their is no builtin LCD panel.

The purpose of the lcd_only check is to avoid advertising a backlight
interface on desktops, since skylake and newer machines seem to always
have a backlight interface even if there is no LCD panel. The limiting
of this check to desktops only was done to avoid breaking backlight
support on some laptops which do not have the lcd flag set.

The Fujitsu ESPRIMO Q910 which is a compact (NUC like) desktop machine
has a chassis type of 0x10 aka "Lunch Box". Without the lcd_only check
we end up falsely advertising backlight/brightness control on this
device. This commit extend the dmi_is_desktop check to return true
for type 0x10 to fix this.

Fixes: 53fa1f6e8a59 ("ACPI / video: Only default only_lcd to true ...")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 1ab1460c4a4e..d73afb562ad9 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2143,6 +2143,7 @@ static bool dmi_is_desktop(void)
 	case 0x05: /* Pizza Box */
 	case 0x06: /* Mini Tower */
 	case 0x07: /* Tower */
+	case 0x10: /* Lunch Box */
 	case 0x11: /* Main Server Chassis */
 		return true;
 	}
-- 
2.19.1

