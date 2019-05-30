Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A034EC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE9724FF4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189020;
	bh=+PorWUz6CDXhB4e4HZl+SYRrjgo07gaT0uiZuYhzznw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xx8UWzR0qsCg/8/EIq30vc95mnCJCsZeoKWw4v5s03bQWgbGCXinvZXHxvan9f4Ii
	 nXd6ijtYrjF0DDyPvFSaimwX2RU1mvIPOE0fXzCvfxsV895ijX1VZRbAI+/Uw7ZxyZ
	 N70kgQOv320VITk3+lHfpXzyBGLI/ixQM68FO4Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbfE3EDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbfE3DRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:55 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A25246F8;
        Thu, 30 May 2019 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186275;
        bh=+PorWUz6CDXhB4e4HZl+SYRrjgo07gaT0uiZuYhzznw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQJG4Fh+iFDoyEUuLG0LMD6N8IOZEVckhUX7Cj0Qrf/s12fPy1JW5EqM3bxnW7pRN
         QktszfUnuTMoTHtaTk1Z+25nW0OAUkkA8/pcDSYUtomm+JdHphQjr/tKL2f0OWnqFN
         IsEaVPQn4A+N5tdOQ5j6gfQ+bo8GhQ/N9jGE8ub4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 217/276] HID: logitech-hidpp: change low battery level threshold from 31 to 30 percent
Date:   Wed, 29 May 2019 20:06:15 -0700
Message-Id: <20190530030538.701024774@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1f87b0cd32b3456d7efdfb017fcf74d0bfe3ec29 ]

According to hidpp20_batterylevel_get_battery_info my Logitech K270
keyboard reports only 2 battery levels. This matches with what I've seen
after testing with batteries at varying level of fullness, it always
reports either 5% or 30%.

Windows reports "battery good" for the 30% level. I've captured an USB
trace of Windows reading the battery and it is getting the same info
as the Linux hidpp code gets.

Now that Linux handles these devices as hidpp devices, it reports the
battery as being low as it treats anything under 31% as low, this leads
to the user constantly getting a "Keyboard battery is low" warning from
GNOME3, which is very annoying.

This commit fixes this by changing the low threshold to anything under
30%, which I assume is what Windows does.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index edf224ad13369..e642cfaf303b4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -910,7 +910,11 @@ static int hidpp_map_battery_level(int capacity)
 {
 	if (capacity < 11)
 		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
-	else if (capacity < 31)
+	/*
+	 * The spec says this should be < 31 but some devices report 30
+	 * with brand new batteries and Windows reports 30 as "Good".
+	 */
+	else if (capacity < 30)
 		return POWER_SUPPLY_CAPACITY_LEVEL_LOW;
 	else if (capacity < 81)
 		return POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
-- 
2.20.1



