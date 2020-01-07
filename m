Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9110C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34BE206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432323;
	bh=xfY0Bi9UHxCB8JaSZ+qYTGH4RoqOvqbb5ZXpEwB30YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZ5PnQQHVYcTRVBuroKlG59IQaQZtqZlNkMwfGhU+nnSytljqcMWxkBoz+hXW+beI
	 NopmElbJTiUn9chjmxFxz5m2hDph7T+OPnS+uPWLE3Aa/Y7t3QrxtikpNIZdzNeR3j
	 4LELKA1BL0gYggh5CDMBEtwoKTVVyNKsOyfYUwWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgAGVAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgAGVAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F77520880;
        Tue,  7 Jan 2020 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430802;
        bh=xfY0Bi9UHxCB8JaSZ+qYTGH4RoqOvqbb5ZXpEwB30YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7lRp223wrTv1e+fdkuCGCCScZFLRr9k+pSYtoNW4fhvzAybG8APGiIjBfqcHizXH
         G1oXEFvLuw/Q89ZZJCRHj5Vr+k/jpASSFzuMQHwDrfJwnQiMfD7s/qhQLPgJfn+n0K
         ERVFdIUHOaOqZcDAFv6eZPpiwA3YJU2Vj7MVhcLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 102/191] compat_ioctl: block: handle BLKREPORTZONE/BLKRESETZONE
Date:   Tue,  7 Jan 2020 21:53:42 +0100
Message-Id: <20200107205338.451108570@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 673bdf8ce0a387ef585c13b69a2676096c6edfe9 upstream.

These were added to blkdev_ioctl() but not blkdev_compat_ioctl,
so add them now.

Cc: <stable@vger.kernel.org> # v4.10+
Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/compat_ioctl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -355,6 +355,8 @@ long compat_blkdev_ioctl(struct file *fi
 	 * but we call blkdev_ioctl, which gets the lock for us
 	 */
 	case BLKRRPART:
+	case BLKREPORTZONE:
+	case BLKRESETZONE:
 		return blkdev_ioctl(bdev, mode, cmd,
 				(unsigned long)compat_ptr(arg));
 	case BLKBSZSET_32:


