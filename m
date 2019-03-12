Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F942C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F90214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410688;
	bh=HuHjYqOnVWr76QnTBR12RjR26g7G8LjnJtx7twIcrBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a9lRnqh8HZzxOsO51Z/VfLPFsQWiWkF1TbBP8aoV+TVFdIe2G/9CSrtnydqwflHGT
	 qX85MIr+IVbOyTwuCJOdBJLMhhyWypwSOI8CYKXHnxSwKQyl020JXODn0/l24VW6Rr
	 xTUKkZ8PBk9L4FX5cOynTAqpMIFIlH19M+pQ6EYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfCLRL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfCLRLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:25 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 651CE2087C;
        Tue, 12 Mar 2019 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410684;
        bh=HuHjYqOnVWr76QnTBR12RjR26g7G8LjnJtx7twIcrBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWG7YWd1B7vqA/VbsRu6nq+N42TOmNj50U4s1XkUzHUZkV7aOyf3eH73utyYM5eKY
         kpprN96HR6I9E+bZV6oBUd8IUBs0fpXM5aWyLtDSGQheENS9DLu7Gu2UdCOycGFq7E
         pmIrsiwSxiYLIRhnmEbqRyqgZ5q7WnOO3j40YpfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Holpert <christian@holpert.de>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 14/25] media: Revert "media: rc: some events are dropped by userspace"
Date:   Tue, 12 Mar 2019 10:08:52 -0700
Message-Id: <20190312170404.596258547@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

From: Sean Young <sean@mess.org>

commit 05f0edadcc5fccdfc0676825b3e70e75dc0a8a84 upstream.

When an rc device is created, we do not know what key codes it will
support, since a new keymap might be loaded at some later point. So,
we set all keybit in the input device.

The uevent for the input device includes all the key codes, of which
there are now 768. This overflows the size of the uevent
(UEVENT_BUFFER_SIZE) and no event is generated.

Revert for now until we figure out a different solution.

This reverts commit fec225a04330d0f222d24feb5bea045526031675.

Cc: <stable@vger.kernel.org> # 4.20+
Reported-by: Christian Holpert <christian@holpert.de>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/rc/rc-main.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -274,6 +274,7 @@ static unsigned int ir_update_mapping(st
 				      unsigned int new_keycode)
 {
 	int old_keycode = rc_map->scan[index].keycode;
+	int i;
 
 	/* Did the user wish to remove the mapping? */
 	if (new_keycode == KEY_RESERVED || new_keycode == KEY_UNKNOWN) {
@@ -288,9 +289,20 @@ static unsigned int ir_update_mapping(st
 			old_keycode == KEY_RESERVED ? "New" : "Replacing",
 			rc_map->scan[index].scancode, new_keycode);
 		rc_map->scan[index].keycode = new_keycode;
+		__set_bit(new_keycode, dev->input_dev->keybit);
 	}
 
 	if (old_keycode != KEY_RESERVED) {
+		/* A previous mapping was updated... */
+		__clear_bit(old_keycode, dev->input_dev->keybit);
+		/* ... but another scancode might use the same keycode */
+		for (i = 0; i < rc_map->len; i++) {
+			if (rc_map->scan[i].keycode == old_keycode) {
+				__set_bit(old_keycode, dev->input_dev->keybit);
+				break;
+			}
+		}
+
 		/* Possibly shrink the keytable, failure is not a problem */
 		ir_resize_table(dev, rc_map, GFP_ATOMIC);
 	}
@@ -1750,7 +1762,6 @@ static int rc_prepare_rx_device(struct r
 	set_bit(EV_REP, dev->input_dev->evbit);
 	set_bit(EV_MSC, dev->input_dev->evbit);
 	set_bit(MSC_SCAN, dev->input_dev->mscbit);
-	bitmap_fill(dev->input_dev->keybit, KEY_CNT);
 
 	/* Pointer/mouse events */
 	set_bit(EV_REL, dev->input_dev->evbit);


