Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B08C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9842208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfEUPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:06:58 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25909 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728137AbfEUPG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:06:57 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 11:06:56 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1558450267; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=O7d9Goh6Y9LEtfymcrLS8ajfUA6VuEjoRMXBsU2olounmbYXYjus34onw2nbVxj48+AHYOPwL3J85GaOB2FrOPdBgTbqHDJQc3x5Epdoecsha0jb0LYfco9DrdAQhRv90SjIcRZSEoPreorUyZ9Xu1DdpfFSM0eioiW0vSRZpxk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558450267; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=FnT1Xjc63AzR8n87E9oTWWxjhdggTkl7tAy4ISAQisE=; 
        b=Qntt2/4eyQjUKnUuiIxdRQcBw4DNL1HzKvZHftPfFwo2fX1CYmJaFOAv2+GSYkKWnBPGi270CMrehw8/woSDplrJaqmOW2m2iL/HqZGO7QWd3zm/PHpblCQHnhDmNbFUivKNxV+zxOXj0zUjzEuEGWWJTcBZeco9YLFT5V11AGY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (113.116.50.65 [113.116.50.65]) by mx.zoho.com.cn
        with SMTPS id 155845026352175.05708036921328; Tue, 21 May 2019 22:51:03 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Subject: [PATCH] qnx6: convert mount option checking code to test_opt()
Date:   Tue, 21 May 2019 22:50:55 +0800
Message-Id: <20190521145055.26800-1-cgxu519@zoho.com.cn>
X-Mailer: git-send-email 2.17.2
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mount option checking code to test_opt() in
qnx6_show_options().

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/qnx6/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 59cf45f6be49..c3a80700e7a6 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -46,9 +46,8 @@ static const struct super_operations qnx6_sops = {
 static int qnx6_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct super_block *sb = root->d_sb;
-	struct qnx6_sb_info *sbi = QNX6_SB(sb);
 
-	if (sbi->s_mount_opt & QNX6_MOUNT_MMI_FS)
+	if (test_opt(sb, MMI_FS))
 		seq_puts(seq, ",mmi_fs");
 	return 0;
 }
-- 
2.17.2


