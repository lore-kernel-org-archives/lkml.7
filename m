Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017E6C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68A32054F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369380;
	bh=AIQqjf5gJzuJZR7jPxRJM/RiiLCitd2wdE4VmqdcXvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fl38i23tzmpUKshiOBx73oGcnzryTAtklUM2l8FhTYSTCj0ylp9kPVD2jnQoRD9fh
	 2NEiL7m54ok8iqifrDvHLo55VrWTkjraaFHwB5HYmbZkygCzbYQfFLG7DdrEQ8MDyQ
	 ghe+Y/YNrfGBXRN+6UJZ+JGES1NjTrY9qrJbDClk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbfDDJQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388019AbfDDJQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37DF62054F;
        Thu,  4 Apr 2019 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369373;
        bh=AIQqjf5gJzuJZR7jPxRJM/RiiLCitd2wdE4VmqdcXvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDrUWZ5gbGjMD5zmSgAvZ4+1sKqeWHX4WUQu2Md+hVQhsggm+jR4509cTAr3XNMx2
         /U9as9bhZMcwHNSgQu5xdSEmUm+LHMrcBPhPXs1Obt+Ot9lBHUi/wj76+OWccra0HQ
         +WpU3ZtM+gxWbAk/fm+fl/fcFReekLv5qgwVBjMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tristian Celestin <tristian.celestin@outlook.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= 
        <jerome.debretagne@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 199/246] platform/x86: intel-hid: Missing power button release on some Dell models
Date:   Thu,  4 Apr 2019 10:48:19 +0200
Message-Id: <20190404084626.155084939@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e97a34563d18606ee5db93e495382a967f999cd4 ]

Power button suspend for some Dell models was added in:

commit 821b85366284 ("platform/x86: intel-hid: Power button suspend on Dell Latitude 7275")

by checking against the power button press notification (0xCE) to report
the power button press event. The corresponding power button release
notification (0xCF) was caught and ignored to stop it from being reported
as an "unknown event" in the logs.

The missing button release event is creating issues on Android-x86, as
reported on the project mailing list for a Dell Latitude 5175 model, since
the events are expected in down/up pairs.

Report the power button release event to fix this issue.

Link: https://groups.google.com/forum/#!topic/android-x86/aSwZK9Nf9Ro
Tested-by: Tristian Celestin <tristian.celestin@outlook.com>
Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
[dvhart: corrected commit reference format per checkpatch]
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-hid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index e28bcf61b126..bc0d55a59015 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -363,7 +363,7 @@ wakeup:
 	 * the 5-button array, but still send notifies with power button
 	 * event code to this device object on power button actions.
 	 *
-	 * Report the power button press; catch and ignore the button release.
+	 * Report the power button press and release.
 	 */
 	if (!priv->array) {
 		if (event == 0xce) {
@@ -372,8 +372,11 @@ wakeup:
 			return;
 		}
 
-		if (event == 0xcf)
+		if (event == 0xcf) {
+			input_report_key(priv->input_dev, KEY_POWER, 0);
+			input_sync(priv->input_dev);
 			return;
+		}
 	}
 
 	/* 0xC0 is for HID events, other values are for 5 button array */
-- 
2.19.1



