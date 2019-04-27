Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7322C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A491E208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfD0P0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:26:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34868 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727753AbfD0P0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:26:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3A-0000zM-Jf; Sat, 27 Apr 2019 16:15:36 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004Ru-LD; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "syzbot" <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paul Fulghum" <paulkf@microgate.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.535103190@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 054/202] tty/n_hdlc: fix __might_sleep warning
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Fulghum <paulkf@microgate.com>

commit fc01d8c61ce02c034e67378cd3e645734bc18c8c upstream.

Fix __might_sleep warning[1] in tty/n_hdlc.c read due to copy_to_user
call while current is TASK_INTERRUPTIBLE.  This is a false positive
since the code path does not depend on current state remaining
TASK_INTERRUPTIBLE.  The loop breaks out and sets TASK_RUNNING after
calling copy_to_user.

This patch supresses the warning by setting TASK_RUNNING before calling
copy_to_user.

[1] https://syzkaller.appspot.com/bug?id=17d5de7f1fcab794cb8c40032f893f52de899324

Signed-off-by: Paul Fulghum <paulkf@microgate.com>
Reported-by: syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/n_hdlc.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -598,6 +598,7 @@ static ssize_t n_hdlc_tty_read(struct tt
 				/* too large for caller's buffer */
 				ret = -EOVERFLOW;
 			} else {
+				__set_current_state(TASK_RUNNING);
 				if (copy_to_user(buf, rbuf->buf, rbuf->count))
 					ret = -EFAULT;
 				else

