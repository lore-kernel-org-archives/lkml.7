Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FDEC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4C120865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123169;
	bh=eAjUJp1E2xHVDiwJ3NWPs36uLgMPOkY1v8U/SjReQOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YseOoqhmyyaehx/Ozf9M3yVYaRhXasJrV0AfiqIbjxvwqqDLM+ucbtDnuXFoNMJuR
	 hlvkNLu0fxdXPxvYJqtXKY++d5mQN6+xUnhdB2UIcViR09a6DD9Kdrz0BrwXlYHKE1
	 X/QjDXc/3oM5+RvBiRxyP2k+P5JY6FiU3N0hDliM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390562AbfJCRT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389757AbfJCQTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8C8222BE;
        Thu,  3 Oct 2019 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119588;
        bh=eAjUJp1E2xHVDiwJ3NWPs36uLgMPOkY1v8U/SjReQOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyezlc1p+nukOrnNINaYzzjN5sXpU5VFhfAdI2mNHVec11TB/WU3cnEMGBdGLcfrU
         UIzdW/Y9gYv8UZjh1C0uSkFol08iMEE78JmO8qBJvYPnZaRoXj2VkPmsktNhjBoPrc
         mLesUFH0niQNmjolk20P0Cf28lXDGapJjKrSg6dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 121/211] ACPI: custom_method: fix memory leaks
Date:   Thu,  3 Oct 2019 17:53:07 +0200
Message-Id: <20191003154514.756957114@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 03d1571d9513369c17e6848476763ebbd10ec2cb ]

In cm_write(), 'buf' is allocated through kzalloc(). In the following
execution, if an error occurs, 'buf' is not deallocated, leading to memory
leaks. To fix this issue, free 'buf' before returning the error.

Fixes: 526b4af47f44 ("ACPI: Split out custom_method functionality into an own driver")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/custom_method.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index e967c1173ba32..222ea3f12f41e 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -48,8 +48,10 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	if ((*ppos > max_size) ||
 	    (*ppos + count > max_size) ||
 	    (*ppos + count < count) ||
-	    (count > uncopied_bytes))
+	    (count > uncopied_bytes)) {
+		kfree(buf);
 		return -EINVAL;
+	}
 
 	if (copy_from_user(buf + (*ppos), user_buf, count)) {
 		kfree(buf);
@@ -69,6 +71,7 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
+	kfree(buf);
 	return count;
 }
 
-- 
2.20.1



