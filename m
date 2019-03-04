Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23515C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB44C208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687755;
	bh=CEBzWTBsXf2BuP4bR+L3j/eCNtP8D6WcWgLXYM2LxeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MjQUS4CLb68QcxC9SFrlUCI+XkTdo5+sMxXuekOG027CoZKiv4YnLpV5miIKLMVA1
	 u4wfhEHqtTFivF/eH/VHjDENUI+QFBOV7buVYcPKsydQ7MkM9Spx2PJcRDYLeJhzy8
	 SqW9iOkQABm1zVj+KkeQ8fkoo8N6gyemQI+NWZBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfCDIWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDIWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:22:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE7F20863;
        Mon,  4 Mar 2019 08:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687752;
        bh=CEBzWTBsXf2BuP4bR+L3j/eCNtP8D6WcWgLXYM2LxeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMQauq/tpSp5CTkgFHo7HIJiFBgA0Y52/Txrz4uiITu9YPSJXnOmlkhhCEw9+sL35
         byCxD7Q8ZP1aMoQcPpRUp14+T4ATadbAgsgYfEbSEJcU7y1CaXiP1ps+hueTxwLz6A
         JP+Z3ahfjLI0RCnL9NJG7CcweXZh/lZ0laEN2VEw=
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
Subject: [PATCH 4.9 01/32] Revert "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()"
Date:   Mon,  4 Mar 2019 09:21:49 +0100
Message-Id: <20190304081602.415115861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 5d3cf50105d007adc54949e0caeca1e944549723 which is
commit 628bd85947091830a8c4872adfd5ed1d515a9cf2 upstream.

It does not work properly in the 4.9.y tree and causes more problems
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
@@ -1929,10 +1929,12 @@ static long loop_control_ioctl(struct fi
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


