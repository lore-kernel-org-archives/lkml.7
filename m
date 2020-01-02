Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F5EC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F7A2253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003471;
	bh=lSE00O/CEuOUfS3S5Xv/5UPawzE8FOPYyp+aO5AaB3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JUtU8rSdvesLi5Yezl1BBVF7zElx4MqCKcp/+g+AHz99letxZPeb5m2lY0wvHB17+
	 3b4Vyakn9tIXYGMZ7sdwBeK9lqekpG7+F7StjWylx4U6u8xYLYtMQRMmxJJZuYyyha
	 cZNOj0XvsbfMEGFsSFlJOqggLuI2v/UJa+dZNmnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgABWRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgABWRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:17:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B66B227BF;
        Thu,  2 Jan 2020 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003466;
        bh=lSE00O/CEuOUfS3S5Xv/5UPawzE8FOPYyp+aO5AaB3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjBzFkyrrBELUiILc3jCZ1uLypowdIfLGQ1vtYas4D4Z3ZY/NWgNZhCadqL8hhogw
         QonsOmWy9Mgf3qYlF4nhBZsGOwuWLoVHj0d8ZdIekf/T6vbUjAwEeTSibXDKp94K5y
         1HsG9pRPVAFubEYz7qxjf4ysCV60jHR/fMp4c824=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c732f8644185de340492@syzkaller.appspotmail.com,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 5.4 146/191] xfs: fix mount failure crash on invalid iclog memory access
Date:   Thu,  2 Jan 2020 23:07:08 +0100
Message-Id: <20200102215845.170620568@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Foster <bfoster@redhat.com>

commit 798a9cada4694ca8d970259f216cec47e675bfd5 upstream.

syzbot (via KASAN) reports a use-after-free in the error path of
xlog_alloc_log(). Specifically, the iclog freeing loop doesn't
handle the case of a fully initialized ->l_iclog linked list.
Instead, it assumes that the list is partially constructed and NULL
terminated.

This bug manifested because there was no possible error scenario
after iclog list setup when the original code was added.  Subsequent
code and associated error conditions were added some time later,
while the original error handling code was never updated. Fix up the
error loop to terminate either on a NULL iclog or reaching the end
of the list.

Reported-by: syzbot+c732f8644185de340492@syzkaller.appspotmail.com
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_log.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1495,6 +1495,8 @@ out_free_iclog:
 		prev_iclog = iclog->ic_next;
 		kmem_free(iclog->ic_data);
 		kmem_free(iclog);
+		if (prev_iclog == log->l_iclog)
+			break;
 	}
 out_free_log:
 	kmem_free(log);


