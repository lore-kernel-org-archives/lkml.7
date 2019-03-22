Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7DE218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfCVFXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:23:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45662 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbfCVFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-00015z-Nm; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001ol-J2; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jiri Kosina" <jkosina@suse.cz>, "Jiri Slaby" <jslaby@suse.cz>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.587002036@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 08/16] HID: debug: fix error handling in
 hid_debug_events_read()
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit 8fec02a73e31407e14986fca67dab48d4f777f0e upstream.

In the unlikely case of hdev vanishing while hid_debug_events_read() was
sleeping, we can't really break out of the case switch as with other cases,
as on the way out we'll try to remove ourselves from the hdev waitqueue.

Fix this by taking a shortcut exit path and avoiding cleanup that doesn't
make sense in case hdev doesn't exist any more anyway.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1127,7 +1127,8 @@ static ssize_t hid_debug_events_read(str
 
 				if (!list->hdev || !list->hdev->debug) {
 					ret = -EIO;
-					break;
+					set_current_state(TASK_RUNNING);
+					goto out;
 				}
 
 				/* allow O_NONBLOCK from other threads */

