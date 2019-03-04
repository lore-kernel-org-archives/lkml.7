Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5DD208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687858;
	bh=xJ0vLH6GZ8If+DhLBc4rIWmPQSv2HHiw+yZVDCqCLx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e6J9JDMIuqJJquigqFtYeev6g09LwyDCB/0taDevdPnYwogdIF2X2gACSyuRk/ms0
	 AaDzFMLBvYq+XwLgCRzoc6XFwUdETfsmdqEx9jl6t9CoFC5v0BOwdDz0zyQj7TMx9l
	 2KHyWnp/2bIH70Ckk2qFSYRuQ5kRr/J9eHop54Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCDIYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfCDIYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A297F20823;
        Mon,  4 Mar 2019 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687852;
        bh=xJ0vLH6GZ8If+DhLBc4rIWmPQSv2HHiw+yZVDCqCLx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uco+iMjnw4msMazEpRRI/mBeNrhv4ZoWNp5U1SLrFTHwtPfKQGdH06od8QN5wDTOr
         1xi7SjX6aeLnUYgLllK5Kp4BtNjXayZiRRW0027nUGUkg+N9KNNP66/b/l/tSLSpQ9
         WmNUzAqcPTlmkFUZpoRIisp+vexL3DLbQ8kjBgTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Jan Kara <jack@suse.cz>,
        syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 01/52] Revert "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()"
Date:   Mon,  4 Mar 2019 09:21:59 +0100
Message-Id: <20190304081617.240319884@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit d2762edcb6af99fc9322bab0b1d4e71a427760e8 which is
commit 628bd85947091830a8c4872adfd5ed1d515a9cf2 upstream.

It does not work properly in the 4.14.y tree and causes more problems
than it fixes, so revert it.

Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Reported-by: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1996,10 +1996,12 @@ static long loop_control_ioctl(struct fi
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
+			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
+			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;


