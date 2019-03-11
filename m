Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3113EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09445206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCKMrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:47:16 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:38802 "EHLO
        11.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCKMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:47:16 -0400
X-Greylist: delayed 13101 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 08:47:15 EDT
Received: from player799.ha.ovh.net (unknown [10.109.143.146])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 64082223F0D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:08:53 +0100 (CET)
Received: from jwilk.net (ip-5-172-255-202.free.aero2.net.pl [5.172.255.202])
        (Authenticated sender: jwilk@jwilk.net)
        by player799.ha.ovh.net (Postfix) with ESMTPSA id 5235B3865985;
        Mon, 11 Mar 2019 09:08:49 +0000 (UTC)
From:   Jakub Wilk <jwilk@jwilk.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] vt: use /dev/vcs (not /dev/vcs0) in comment
Date:   Mon, 11 Mar 2019 10:08:45 +0100
Message-Id: <20190311090845.5976-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2712574350864013173
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeeigddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both /dev/vcs and /dev/vcs0 were in use in the past, but these days
/dev/vcs0 is mostly historical curiosity.

* "/dev/vcs" is the name that has always been in the Linux allocated
devices list.

* "vcs" is the device name in sysfs since Linux v2.6.12.

* MAKEDEV(1) in Debian used to create /dev/vcs0 only, but /dev/vcs was
  added in 1999: https://bugs.debian.org/45698

* MAKEDEV(1) in RedHat switched from /dev/vcs0 to /dev/vcs in 2000:

    * Fri Oct 20 2000 Nalin Dahyabhai <nalin@redhat.com>
      - change vcs0 to vcs (ditto for vcsa0)

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 drivers/tty/vt/vc_screen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 160f46115aaa..1f042346e722 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Provide access to virtual console memory.
- * /dev/vcs0: the screen as it is being viewed right now (possibly scrolled)
+ * /dev/vcs: the screen as it is being viewed right now (possibly scrolled)
  * /dev/vcsN: the screen of /dev/ttyN (1 <= N <= 63)
  *            [minor: N]
  *
-- 
2.20.1

