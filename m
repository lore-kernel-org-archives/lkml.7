Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C9C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE9E2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfEFPCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:02:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:42864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728086AbfEFOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:40:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DECADAEAE;
        Mon,  6 May 2019 14:40:47 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.org, dan.carpenter@oracle.com,
        stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 3/3] staging: vchiq: make wait events interruptible
Date:   Mon,  6 May 2019 16:40:30 +0200
Message-Id: <20190506144030.29056-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506144030.29056-1-nsaenzjulienne@suse.de>
References: <20190506144030.29056-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The killable version of wait_event() is meant to be used on situations
where it should not fail at all costs, but still have the convenience of
being able to kill it if really necessary. Wait events in VCHIQ doesn't
fit this criteria, as it's mainly used as an interface to V4L2 and ALSA
devices.

Fixes: 852b2876a8a8 ("staging: vchiq: rework remove_event handling")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c     | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 50189223f05b..9676f83dcf78 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -425,13 +425,21 @@ remote_event_create(wait_queue_head_t *wq, struct remote_event *event)
 	init_waitqueue_head(wq);
 }
 
+/*
+ * All the event waiting routines in VCHIQ used a custom semaphore
+ * implementation that filtered most signals. This achieved a behaviour similar
+ * to the "killable" family of functions. While cleaning up this code all the
+ * routines where switched to the "interruptible" family of functions, as the
+ * former was deemed unjustified and the use "killable" set all VCHIQ's
+ * threads in D state.
+ */
 static inline int
 remote_event_wait(wait_queue_head_t *wq, struct remote_event *event)
 {
 	if (!event->fired) {
 		event->armed = 1;
 		dsb(sy);
-		if (wait_event_killable(*wq, event->fired)) {
+		if (wait_event_interruptible(*wq, event->fired)) {
 			event->armed = 0;
 			return 0;
 		}
-- 
2.21.0

