Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B350C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C8B218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfCVFX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:23:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45666 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727516AbfCVFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-000161-PH; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001or-Jn; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jiri Kosina" <jkosina@suse.cz>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.422830695@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 09/16] HID: debug: improve hid_debug_event()
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

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 92529623d242cea4440958d7bcebdf291f4ab15e upstream.

The code in hid_debug_event() causes horrible code generation. First,
we do a strlen() call for every byte we copy (we're doing a store to
global memory, so gcc has no way of proving that strlen(buf) doesn't
change). Second, since both i, list->tail and HID_DEBUG_BUFSIZE have
signed type, the modulo computation has to take into account the
possibility that list->tail+i is negative, so it's not just a simple
and.

Fix the former by simply not doing strlen() at all (we have to load
buf[i] anyway, so testing it is almost free) and the latter by
changing i to unsigned. This cuts 29% (69 bytes) of the size of the
function.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -658,13 +658,13 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
 /* enqueue string to 'events' ring buffer */
 void hid_debug_event(struct hid_device *hdev, char *buf)
 {
-	int i;
+	unsigned i;
 	struct hid_debug_list *list;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hdev->debug_list_lock, flags);
 	list_for_each_entry(list, &hdev->debug_list, node) {
-		for (i = 0; i < strlen(buf); i++)
+		for (i = 0; buf[i]; i++)
 			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
 				buf[i];
 		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;

