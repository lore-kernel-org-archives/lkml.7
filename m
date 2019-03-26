Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C718AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905A42070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582605;
	bh=nX8iWKjKs3Ai/Uf+X/waG2Kg4avhq+kfFHWRRSGXTw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+qOD579g7m0C+iV+xx+Kd4yC+ycyBP5g6aIKqA+ujCUc5Gzj6Gql7RTTuqzAnGP+
	 MuXZdJ8ZbWUOTclNn9qZ+WVWkw8HEKIEjzUWWcZhKsCdCQ3WEDW3jakr6nvx3/91zq
	 bRXO7GNhqXYUpNERbjHkqlHTHr45Xmbp1/51jOnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfCZGhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731291AbfCZGhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:37:37 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A142070B;
        Tue, 26 Mar 2019 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582256;
        bh=nX8iWKjKs3Ai/Uf+X/waG2Kg4avhq+kfFHWRRSGXTw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWe3yS+fQIkgENGHwCVF+ZKWzcfHQHIagncupqKL4SHf0FtEe5VSVse84qB615kN0
         M5k0Ae1qRH8kYO0pV1ayNGOsbSb7gVo/5AxCQIXZbLQuu8PmSVzZ/tyk0NhQuvNaK6
         bOKO1Uh7jIEnWf3gk/CJGyPKapOaZE9YXJu5zzDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 38/45] loop: access lo_backing_file only when the loop device is Lo_bound
Date:   Tue, 26 Mar 2019 15:30:21 +0900
Message-Id: <20190326042704.717688751@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dongli Zhang <dongli.zhang@oracle.com>

commit f7c8a4120eedf24c36090b7542b179ff7a649219 upstream.

Commit 758a58d0bc67 ("loop: set GENHD_FL_NO_PART_SCAN after
blkdev_reread_part()") separates "lo->lo_backing_file = NULL" and
"lo->lo_state = Lo_unbound" into different critical regions protected by
loop_ctl_mutex.

However, there is below race that the NULL lo->lo_backing_file would be
accessed when the backend of a loop is another loop device, e.g., loop0's
backend is a file, while loop1's backend is loop0.

loop0's backend is file            loop1's backend is loop0

__loop_clr_fd()
  mutex_lock(&loop_ctl_mutex);
  lo->lo_backing_file = NULL; --> set to NULL
  mutex_unlock(&loop_ctl_mutex);
                                   loop_set_fd()
                                     mutex_lock_killable(&loop_ctl_mutex);
                                     loop_validate_file()
                                       f = l->lo_backing_file; --> NULL
                                         access if loop0 is not Lo_unbound
  mutex_lock(&loop_ctl_mutex);
  lo->lo_state = Lo_unbound;
  mutex_unlock(&loop_ctl_mutex);

lo->lo_backing_file should be accessed only when the loop device is
Lo_bound.

In fact, the problem has been introduced already in commit 7ccd0791d985
("loop: Push loop_ctl_mutex down into loop_clr_fd()") after which
loop_validate_file() could see devices in Lo_rundown state with which it
did not count. It was harmless at that point but still.

Fixes: 7ccd0791d985 ("loop: Push loop_ctl_mutex down into loop_clr_fd()")
Reported-by: syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -657,7 +657,7 @@ static int loop_validate_file(struct fil
 			return -EBADF;
 
 		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
-		if (l->lo_state == Lo_unbound) {
+		if (l->lo_state != Lo_bound) {
 			return -EINVAL;
 		}
 		f = l->lo_backing_file;


