Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB75C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14320679
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="F8Qu46Ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393701AbfHVV4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:56:11 -0400
Received: from first.geanix.com ([116.203.34.67]:40756 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393690AbfHVV4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:56:11 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id D2EF3370;
        Thu, 22 Aug 2019 21:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566510953; bh=qLRAlPD3627rR29j3REKnBtsuDGN1Jwkm77I1FouPuQ=;
        h=From:To:Cc:Subject:Date;
        b=F8Qu46IreSsV7GSHXVRoSuVnY3+44+XV4/SOznT+QYsEC927NLbpyxMPC7tiM81/w
         j+Vw3h9aUBBNMTi4qeOrSyjqgjl6w4Wmy1uJna6YHpV50xHNBnHiX2uAF3+UnJZCty
         Lsha3/rRMKq1EB+qZTDWP1V/Zrf0qie0BxQ6Gg2UHItb8XKJru4N8NQFhNDdQkAINO
         JF6DjgsS3n+5sFhoY9QSLFoTt05Snj5nmGsjbYxS21a3ag0KJjbwmAWM3XDMt4tuI8
         0y8BnmfPK7D/cppc8ZIeCxiE2/z89n6kdOFUVxzDri0101co/HtPW8zdAbeXvMp2ba
         ZrQzIHYcvJHmw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCH] tty: n_gsm: avoid recursive locking with async port hangup
Date:   Thu, 22 Aug 2019 23:56:01 +0200
Message-Id: <20190822215601.9028-1-martin@geanix.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tearing down the n_gsm ldisc while one or more of its child ports
are open, a lock dep warning occurs:

[   56.254258] ======================================================
[   56.260447] WARNING: possible circular locking dependency detected
[   56.266641] 5.2.0-00118-g1fd58e20e5b0 #30 Not tainted
[   56.271701] ------------------------------------------------------
[   56.277890] cmux/271 is trying to acquire lock:
[   56.282436] 8215283a (&tty->legacy_mutex){+.+.}, at: __tty_hangup.part.0+0x58/0x27c
[   56.290128]
[   56.290128] but task is already holding lock:
[   56.295970] e9e2b842 (&gsm->mutex){+.+.}, at: gsm_cleanup_mux+0x9c/0x15c
[   56.302699]
[   56.302699] which lock already depends on the new lock.
[   56.302699]
[   56.310884]
[   56.310884] the existing dependency chain (in reverse order) is:
[   56.318372]
[   56.318372] -> #2 (&gsm->mutex){+.+.}:
[   56.323624]        mutex_lock_nested+0x1c/0x24
[   56.328079]        gsm_cleanup_mux+0x9c/0x15c
[   56.332448]        gsmld_ioctl+0x418/0x4e8
[   56.336554]        tty_ioctl+0x96c/0xcb0
[   56.340492]        do_vfs_ioctl+0x41c/0xa5c
[   56.344685]        ksys_ioctl+0x34/0x60
[   56.348535]        ret_fast_syscall+0x0/0x28
[   56.352815]        0xbe97cc04
[   56.355791]
[   56.355791] -> #1 (&tty->ldisc_sem){++++}:
[   56.361388]        tty_ldisc_lock+0x50/0x74
[   56.365581]        tty_init_dev+0x88/0x1c4
[   56.369687]        tty_open+0x1c8/0x430
[   56.373536]        chrdev_open+0xa8/0x19c
[   56.377560]        do_dentry_open+0x118/0x3c4
[   56.381928]        path_openat+0x2fc/0x1190
[   56.386123]        do_filp_open+0x68/0xd4
[   56.390146]        do_sys_open+0x164/0x220
[   56.394257]        kernel_init_freeable+0x328/0x3e4
[   56.399146]        kernel_init+0x8/0x110
[   56.403078]        ret_from_fork+0x14/0x20
[   56.407183]        0x0
[   56.409548]
[   56.409548] -> #0 (&tty->legacy_mutex){+.+.}:
[   56.415402]        __mutex_lock+0x64/0x90c
[   56.419508]        mutex_lock_nested+0x1c/0x24
[   56.423961]        __tty_hangup.part.0+0x58/0x27c
[   56.428676]        gsm_cleanup_mux+0xe8/0x15c
[   56.433043]        gsmld_close+0x48/0x90
[   56.436979]        tty_ldisc_kill+0x2c/0x6c
[   56.441173]        tty_ldisc_release+0x88/0x194
[   56.445715]        tty_release_struct+0x14/0x44
[   56.450254]        tty_release+0x36c/0x43c
[   56.454365]        __fput+0x94/0x1e8

Avoid the warning by doing the port hangup asynchronously.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d30525946892..36a3eb4ad4c5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1716,7 +1716,7 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 
-		tty_vhangup(tty);
+		tty_hangup(tty);
 
 		tty_port_tty_set(&dlci->port, NULL);
 		tty_kref_put(tty);
-- 
2.22.1

