Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A085C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AA520665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998966;
	bh=f9GvLwt0Ne5glBUpi3HIOx+1C4PY7x9yuu4XeqMRo38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AE+VAjUEhhnvqu0dG3XcqhD4ztWzncJxlQE2qk9IAciIrPX7CFIofReaWw5FDI3gf
	 kYw45xXn5qRybTAQ5/9v/Y+8N4KKicC/Y0vcjjz2rulFMS7toJOAsktBg+llt2YL8o
	 5wGgV7JfyuW/vkSnajOgizblUgshHhomcQ69hVqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392637AbfGXUJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404989AbfGXUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:00:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F62205C9;
        Wed, 24 Jul 2019 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998443;
        bh=f9GvLwt0Ne5glBUpi3HIOx+1C4PY7x9yuu4XeqMRo38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G004fKzuVSvokJToAe0vq76yHtVvNx2wbvBwo/A/NqceiJZNHXYIJuu+yfC+zdWWh
         L+UUNTXcTNot/GhD8SUE9iykbBYtMVS5GTOauXmuXhp1yakfL4/F64lMwMWGbwd0Kd
         Y/8i6vW1VP3jcFAk9R/+KbKg6jK3BCocI8fW805s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.1 367/371] blkcg: update blkcg_print_stat() to handle larger outputs
Date:   Wed, 24 Jul 2019 21:21:59 +0200
Message-Id: <20190724191751.893451048@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
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
@@ -1005,8 +1005,12 @@ static int blkcg_print_stat(struct seq_f
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
 


