Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52444C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254A02070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121297;
	bh=almqlEgrShZjlwAf+YmnkiSQmi+dQpvSMs4EOo+e5No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fbmtxHCKs+gaoD8/6+EBm8+uCYPC+HIncnhRYf7OqeSKAdMv30RkdhERsHRGZhJuy
	 m48DCAPR/AiTJKNYPsknPxvyYawXuajDP6+AU7ENjyTeOZHa6mgFuInfOyhMJrmIYF
	 9oowTnK4XWnG9yWg32O/qrPf7N/hQjWB3f2psDAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405608AbfJCQsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393043AbfJCQsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:48:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394F8222C2;
        Thu,  3 Oct 2019 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121291;
        bh=almqlEgrShZjlwAf+YmnkiSQmi+dQpvSMs4EOo+e5No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rz/ibCAKMtPULoMPua+jU26ZDC/gw4iOCKrI8HTG7ABiYvhzLkr0M7RwbxY4Xe5cj
         a6PbbAYAwUjSKnqyGEP/bCWjZaa3m3dqY0eQIbgSwlohArJD0hXsO8SzzDdH8iDgYA
         mDREMDxqtCFqyS3LtqtxU/jFjuy4HaEYUe0KNoVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 189/344] ACPI: custom_method: fix memory leaks
Date:   Thu,  3 Oct 2019 17:52:34 +0200
Message-Id: <20191003154558.832715806@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
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
index b2ef4c2ec955d..fd66a736621cf 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -49,8 +49,10 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
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
@@ -70,6 +72,7 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
+	kfree(buf);
 	return count;
 }
 
-- 
2.20.1



