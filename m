Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D523CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7071A20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfJaLjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:39:42 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:41196 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfJaLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:39:42 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id CD7F8275;
        Thu, 31 Oct 2019 19:39:00 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.18.236.69])
        by smtp.263.net (postfix) whith ESMTP id P24753T140070325851904S1572521937221647_;
        Thu, 31 Oct 2019 19:39:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <679ed05f8bdd73a17973893edc03c15f>
X-RL-SENDER: yili@winhong.com
X-SENDER: yili@winhong.com
X-LOGIN-NAME: yili@winhong.com
X-FST-TO: linux-fsdevel@vger.kernel.org
X-SENDER-IP: 14.18.236.69
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Yi Li <yili@winhong.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     yili@winhong.com, Yi Li <yilikernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file: fix condition while loop
Date:   Thu, 31 Oct 2019 19:38:21 +0800
Message-Id: <1572521901-5070-1-git-send-email-yili@winhong.com>
X-Mailer: git-send-email 2.7.5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Li <yilikernel@gmail.com>

Use the break condition of loop body.
PTR_ERR has some meanings when p is illegal,and return 0 when p is null.
set the err = 0 on the next iteration if err > 0.

Signed-off-by: Yi Li <yilikernel@gmail.com>
---
 fs/seq_file.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1600034..3796d4f 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -107,9 +107,10 @@ static int traverse(struct seq_file *m, loff_t offset)
 	}
 	p = m->op->start(m, &m->index);
 	while (p) {
-		error = PTR_ERR(p);
-		if (IS_ERR(p))
+		if (IS_ERR(p)) {
+			error = PTR_ERR(p);
 			break;
+		}
 		error = m->op->show(m, p);
 		if (error < 0)
 			break;
@@ -222,10 +223,11 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	/* we need at least one record in buffer */
 	m->from = 0;
 	p = m->op->start(m, &m->index);
-	while (1) {
-		err = PTR_ERR(p);
-		if (!p || IS_ERR(p))
+	while (p) {
+		if (IS_ERR(p)) {
+			err = PTR_ERR(p);
 			break;
+		}
 		err = m->op->show(m, p);
 		if (err < 0)
 			break;
@@ -233,6 +235,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 			m->count = 0;
 		if (unlikely(!m->count)) {
 			p = m->op->next(m, p, &m->index);
+			err = 0;
 			continue;
 		}
 		if (m->count < m->size)
-- 
2.7.5



