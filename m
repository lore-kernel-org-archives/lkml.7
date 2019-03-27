Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305D42070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711946;
	bh=jdaNtams8p4eOFowl2JR4jKmuj/7QHq7wCJ9m5zHyJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lwxu9zVD9uYuqsD+ZJ60gGSk0T7YDEOsSdlXmEIM6vfXn8oK54S46fX1+I5g6AyPF
	 mGJZ+o4iG55X+2LIoDTw3K26wWKgUKQw4XzwdEVJYdduTH2K8+ffxGdAR84zq4XutN
	 kw3LOSoMKEULsas0sQ3KpUv0I6nqwa53su+cwlvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392060AbfC0SjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391473AbfC0SXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24BA52177E;
        Wed, 27 Mar 2019 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711002;
        bh=jdaNtams8p4eOFowl2JR4jKmuj/7QHq7wCJ9m5zHyJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXpwnCOuR36maRh+/vpI5UJrBAkzVrlFna0E+SkETdxTVw7LHBzroe3AlQyJnAvU5
         oe8+499SDeLDaFxd4suOusAYOuh5p5JFJULaxDzQrcsDFjZg8x+NTmnNur+FU7lih7
         +3hM5j+rvyhp/GGOr7TzyFai+5rMGAQBugT1tOGg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 87/87] ACPI / video: Extend chassis-type detection with a "Lunch Box" check
Date:   Wed, 27 Mar 2019 14:20:40 -0400
Message-Id: <20190327182040.17444-87-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
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
index d79e38abd6d9..ea0573176894 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2088,6 +2088,7 @@ static bool dmi_is_desktop(void)
 	case 0x05: /* Pizza Box */
 	case 0x06: /* Mini Tower */
 	case 0x07: /* Tower */
+	case 0x10: /* Lunch Box */
 	case 0x11: /* Main Server Chassis */
 		return true;
 	}
-- 
2.19.1

