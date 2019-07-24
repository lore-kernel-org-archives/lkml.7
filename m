Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EBDC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB5120665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997358;
	bh=RHYioeNC3dV2V+H2e0J3LjQcp19XulmQk7E8pbneulw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CpXiknbCfhnEmGiaaZBiHIiXyecGl93suJi3p9bsoNRnz/odfu2IrflQsedLRx1pi
	 aJNrTFhXPOlrvbmHby3WCwI25gh8oN48qL8SPqVkHuthbMMQqp3QOzl+WxnfHQiT0d
	 p4ao0fb0Qgjp2imktM8Dn6dp2kFJ1gMWckbr/KTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbfGXTmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390034AbfGXTme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:42:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09CD20665;
        Wed, 24 Jul 2019 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997353;
        bh=RHYioeNC3dV2V+H2e0J3LjQcp19XulmQk7E8pbneulw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TB4F+VnJ/WymhuRQr3EBM4ZIvBad9VzTtpIOHMPHsoSDNAElWjrEZItytyJWkdgp+
         mpcBJO8lT4rXa1FvO4E8knTZyWrrGJ6ZDtYtUHIKCYFK9dbc7gMCD/PYIg2kjsKikE
         zeTBmZbbyFeIKZjCIOMIfuwkGBucMhIOPI8aquwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.2 407/413] blkcg: update blkcg_print_stat() to handle larger outputs
Date:   Wed, 24 Jul 2019 21:21:38 +0200
Message-Id: <20190724191803.727475960@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit f539da82f2158916e154d206054e0efd5df7ab61 upstream.

Depending on the number of devices, blkcg stats can go over the
default seqfile buf size.  seqfile normally retries with a larger
buffer but since the ->pd_stat() addition, blkcg_print_stat() doesn't
tell seqfile that overflow has happened and the output gets printed
truncated.  Fix it by calling seq_commit() w/ -1 on possible
overflows.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 903d23f0a354 ("blk-cgroup: allow controllers to output their own stats")
Cc: stable@vger.kernel.org # v4.19+
Cc: Josef Bacik <jbacik@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-cgroup.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1006,8 +1006,12 @@ static int blkcg_print_stat(struct seq_f
 		}
 next:
 		if (has_stats) {
-			off += scnprintf(buf+off, size-off, "\n");
-			seq_commit(sf, off);
+			if (off < size - 1) {
+				off += scnprintf(buf+off, size-off, "\n");
+				seq_commit(sf, off);
+			} else {
+				seq_commit(sf, -1);
+			}
 		}
 	}
 


