Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF328C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF999217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368353;
	bh=epHAlcIy1UWvxk0yQNj0vovJdQx4RpnPFxbyGf6ydiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdMLlSCzhIU4nAOl0+ZJlfgHtM0DDu2JK0XEqLotggIg5T5ovtN+nWYVUYR3vovii
	 Tu3Eldi6mlh+ACGQPhK3RzDq0vMArW+bkc3tq55Euty+srKnxn9ljNbdxJeLAw81Ko
	 2/NdrkixpV1uXCmvEQdca67qXDcWBJFh76RI6o18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfDDI7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731025AbfDDI7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8C421741;
        Thu,  4 Apr 2019 08:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368348;
        bh=epHAlcIy1UWvxk0yQNj0vovJdQx4RpnPFxbyGf6ydiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jw0cSj8dwsGhxeu0eOwKIMJK8JMQASaUXBAevB8GAwNefbRcOEKeD5FGO55RX6fJh
         ARgn7sfwJxmOMlX9dfDcV+bLjEJPpc5DGHWSe8BGWMflo0FtcP8Sb2YtiN8CJrkesH
         m/Kv9Dp8PkyrJhToy9HYzbnpKeFxl+SExOeZ6meU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 121/121] ACPI / video: Extend chassis-type detection with a "Lunch Box" check
Date:   Thu,  4 Apr 2019 10:48:29 +0200
Message-Id: <20190404084551.763013963@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 9f56c066227c..e39a1489cc72 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2142,6 +2142,7 @@ static bool dmi_is_desktop(void)
 	case 0x05: /* Pizza Box */
 	case 0x06: /* Mini Tower */
 	case 0x07: /* Tower */
+	case 0x10: /* Lunch Box */
 	case 0x11: /* Main Server Chassis */
 		return true;
 	}
-- 
2.19.1



