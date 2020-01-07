Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB45C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C782072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431544;
	bh=Sz4u2+3x7rV+qTd3T5LO3bq1Ota15txsjXkvkIJ+ESM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=leibo3fNA4+Vn8A5lDTStVeCm46+jp0sXlNtNKb5SWiSa0kT8NertuopJRVwuaZa4
	 O99Cjbxl4eh0WURTjZjSLiUqv8AJWWM+WEZ3aiPvK8pF0SJpcBv4kHNl616v6YRsp+
	 sPKW9PyLWgI1nSwc60zF+zYn+jkFiBoxdWONGSyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgAGVMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730035AbgAGVLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:11:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556622080A;
        Tue,  7 Jan 2020 21:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431468;
        bh=Sz4u2+3x7rV+qTd3T5LO3bq1Ota15txsjXkvkIJ+ESM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yi6tN94EYP0GL48fzXa525z9O30upx8q9FtsfUa7Vjx1q/gBFxoaLC+vAM6IvU8rz
         vMrsNtmkQebpqBY1fQGcvGPDU1iys5+9GjAikwVvn3YPIBI3ddgwSfIxEjS4MD6Ydy
         98SOcgbO0DaQ8tx3/yHMFb9V7yBwHDz+v2E6OeIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 4.14 32/74] locks: print unsigned ino in /proc/locks
Date:   Tue,  7 Jan 2020 21:54:57 +0100
Message-Id: <20200107205202.614945650@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

commit 98ca480a8f22fdbd768e3dad07024c8d4856576c upstream.

An ino is unsigned, so display it as such in /proc/locks.

Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/locks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2691,7 +2691,7 @@ static void lock_get_status(struct seq_f
 	}
 	if (inode) {
 		/* userspace relies on this representation of dev_t */
-		seq_printf(f, "%d %02x:%02x:%ld ", fl_pid,
+		seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
 				MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino);
 	} else {


