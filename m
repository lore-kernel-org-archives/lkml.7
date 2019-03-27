Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F13FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6002064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714221;
	bh=Z6IzR8lFTOsHcZF+2cPPUcdxhjRNeMfvf62yGLVB3o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e5GlB0Agjmj4a6oEvoY5c3MogNF6gUj9ZYABlXRuRi7I+ojFIXjdKMmRrrRtMV6D8
	 rI+H42rTQQ83QOa/BLgl1M0I/eo9dpZOr3jVoae+OP6bTqz4GulKn0/twnPYH6IGNS
	 8UuSul37qZWjwhY0P3/2xjzzVgYFoP7cGXeQjwII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbfC0SI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388436AbfC0SIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4C32063F;
        Wed, 27 Mar 2019 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710133;
        bh=Z6IzR8lFTOsHcZF+2cPPUcdxhjRNeMfvf62yGLVB3o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYagz+GrDahWJ85k8Ds8kVJklasrA/WOzwi190fVMkHplt8p37f9WLjvkrdT9Y1Bo
         0I9N8kqwqfwfKuc1NFk+VcNlee9eJH1yIvPgRW1tlB6SQZvd4IPwYRFr24ew7leWwo
         jIVogb8NY7oBpPkLjv5xcE7bM68rIMFk3Mej7pv8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= 
        <jerome.debretagne@gmail.com>, Darren Hart <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 211/262] platform/x86: intel-hid: Missing power button release on some Dell models
Date:   Wed, 27 Mar 2019 14:01:06 -0400
Message-Id: <20190327180158.10245-211-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

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
@@ -363,7 +363,7 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	 * the 5-button array, but still send notifies with power button
 	 * event code to this device object on power button actions.
 	 *
-	 * Report the power button press; catch and ignore the button release.
+	 * Report the power button press and release.
 	 */
 	if (!priv->array) {
 		if (event == 0xce) {
@@ -372,8 +372,11 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
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

