Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3C2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D62C217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909821;
	bh=DOMDnq5/92XMUx9rDb9dh32r3ZeTfeSGNI7IhJn8+0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zeL5EFR0YpYMRxo3QDYIOAECQKhYpmO3xT6ywq+umocnRP+ii328Tz+J0xX3Jhy1U
	 lQq1a3O1tsVHoXySTs9wv2rj91WjxKNw7Lmnv3D2Hw97OL60qUp57Nq8aRlmnNch6T
	 vd3EcRcOlOQorT8mVMC7bSQW3XR5+UmgVHBx0Jzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbfC3Bg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731821AbfC3BbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:31:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DB72184C;
        Sat, 30 Mar 2019 01:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909461;
        bh=DOMDnq5/92XMUx9rDb9dh32r3ZeTfeSGNI7IhJn8+0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGzLMqG9UZ0DUU4HYrsNeZzfXkG0b3ehmGRvVEtJ3lY28xJjb5w+7FP99BaLksovn
         I6ShNAEyGiSVkcMrVmHCD8vFVy7vRTZmFKPwEFok1UR5hMHbZ9T/MBcVISGcdk78rj
         yZGzcSrzh3UQ6GBWB8gkehNqJOI0Mzh9ltodI+fg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/37] blk-mq: protect debugfs_create_files() from failures
Date:   Fri, 29 Mar 2019 21:30:02 -0400
Message-Id: <20190330013020.379-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 36991ca68db9dd43bac7f3519f080ee3939263ef ]

If debugfs were to return a non-NULL error for a debugfs call, using
that pointer later in debugfs_create_files() would crash.

Fix that by properly checking the pointer before referencing it.

Reported-by: Michal Hocko <mhocko@kernel.org>
Reported-and-tested-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d95439154556..da0453277f7f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -791,6 +791,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 static bool debugfs_create_files(struct dentry *parent, void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
+	if (IS_ERR_OR_NULL(parent))
+		return false;
+
 	d_inode(parent)->i_private = data;
 
 	for (; attr->name; attr++) {
-- 
2.19.1

