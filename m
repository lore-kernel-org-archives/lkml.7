Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52FFC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2E621835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005608;
	bh=IMnRsSSckyMOsSAOuTqewPq4T1YIvHzAbfUt8u6pdeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YfOz4/noc7ZakMOqwh6+dQD3wtsECm+HDAgJjYxW2Eknkqph7MVxhMD6uFNya44OG
	 ZzrEEBX7O6FYR7jNXkB8suW1ZBZv3Q39F6IAk2TnyZALVgbmBICzmXDrJk34bO3kFx
	 aqUG5PFrPGEPcToB+3SNP+ODJLptZDrQaxeyAl/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgABWVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgABWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:21:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA5E520863;
        Thu,  2 Jan 2020 22:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003704;
        bh=IMnRsSSckyMOsSAOuTqewPq4T1YIvHzAbfUt8u6pdeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwXloE12DRKMzD4hDy+CSzS2w1lcbs7h7QcLaHqhdsqvmkjYde0Yc7cgjSb5hNIHP
         groPbA9YZAb2k/865zWKQASXH1NVyO8zMXuo0lXN1D5jq5WT1+MWue4Ac9BI9XxC+P
         wtzpbZ2eyVAMzJ5N0s+GPjnR4rKn3LGD4SurC1jA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/114] HID: logitech-hidpp: Silence intermittent get_battery_capacity errors
Date:   Thu,  2 Jan 2020 23:06:58 +0100
Message-Id: <20200102220033.733967047@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 61005d65b6c7dcf61c19516e6ebe5acc02d2cdda ]

My Logitech M185 (PID:4038) 2.4 GHz wireless HID++ mouse is causing
intermittent errors like these in the log:

[11091.034857] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
[12388.031260] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
[16613.718543] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
[23529.938728] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09

We are already silencing error-code 0x09 (HIDPP_ERROR_RESOURCE_ERROR)
errors in other places, lets do the same in
hidpp20_batterylevel_get_battery_capacity to remove these harmless,
but scary looking errors from the dmesg output.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 034c883e57fa..504e8917b06f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -978,6 +978,9 @@ static int hidpp20_batterylevel_get_battery_capacity(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 					  CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_LEVEL_STATUS,
 					  NULL, 0, &response);
+	/* Ignore these intermittent errors */
+	if (ret == HIDPP_ERROR_RESOURCE_ERROR)
+		return -EIO;
 	if (ret > 0) {
 		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
 			__func__, ret);
-- 
2.20.1



