Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19673C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50D020709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbfKTPoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:44:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52618 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729732AbfKTPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:40:17 -0500
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iXS5U-0004b5-Gv; Wed, 20 Nov 2019 15:40:12 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iXS5T-0004Hf-Ih; Wed, 20 Nov 2019 15:40:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>, "Wenwen Wang" <wenwen@cs.uga.edu>
Date:   Wed, 20 Nov 2019 15:37:38 +0000
Message-ID: <lsq.1574264230.434409241@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 28/83] sound: fix a memory leak bug
In-Reply-To: <lsq.1574264230.280218497@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.78-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wenwen@cs.uga.edu>

commit c7cd7c748a3250ca33509f9235efab9c803aca09 upstream.

In sound_insert_unit(), the controlling structure 's' is allocated through
kmalloc(). Then it is added to the sound driver list by invoking
__sound_insert_unit(). Later on, if __register_chrdev() fails, 's' is
removed from the list through __sound_remove_unit(). If 'index' is not less
than 0, -EBUSY is returned to indicate the error. However, 's' is not
deallocated on this execution path, leading to a memory leak bug.

To fix the above issue, free 's' before -EBUSY is returned.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/sound_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -287,7 +287,8 @@ retry:
 				goto retry;
 			}
 			spin_unlock(&sound_loader_lock);
-			return -EBUSY;
+			r = -EBUSY;
+			goto fail;
 		}
 	}
 

