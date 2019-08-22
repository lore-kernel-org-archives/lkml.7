Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44575C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19949206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494881;
	bh=lWZcLGMxVzkLkjXVAnVVtVjDSKLQt1ZNIi+upVQUH3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OwtZDt2J0ScOleOGMm4gFDcMRJunLw6VTTlH031+/+c4z/0XAhvvsobR9NOVwUGA4
	 OJeqBN6oxlwZPNNn/H8Q+AcOtFWxQ3v+O+M79JcoX3m+tcrWsOZNKg/B/62z/vtCKf
	 ojkuhKyRj/Bjf1PtQQzREv6yTztm9AZ3fpgUTxdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404912AbfHVR14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404704AbfHVR0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:21 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4F8206DD;
        Thu, 22 Aug 2019 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494780;
        bh=lWZcLGMxVzkLkjXVAnVVtVjDSKLQt1ZNIi+upVQUH3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhS+o1MapEos+AQFTODiorujQvG2/jlgzLJVw+Sdv6rbv+NaA3Gh+ZdG5uRkuNWiD
         fv1NAPGvDPJaXP0Hp3ruX+WOnaLQuPBkNeuLfpNxGmt6AT8psfFJPm0oyW860Un4zs
         VfKAfpW/huLdAnC/cORdx6fEIKOby+4HkpflOOOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 46/85] IB/core: Add mitigation for Spectre V1
Date:   Thu, 22 Aug 2019 10:19:19 -0700
Message-Id: <20190822171733.289701089@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 61f259821dd3306e49b7d42a3f90fb5a4ff3351b ]

Some processors may mispredict an array bounds check and
speculatively access memory that they should not. With
a user supplied array index we like to play things safe
by masking the value with the array size before it is
used as an index.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20190731043957.GA1600@agluck-desk2.amr.corp.intel.com
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/user_mad.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index c34a6852d691f..a18f3f8ad77fe 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -49,6 +49,7 @@
 #include <linux/sched.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 
@@ -868,11 +869,14 @@ static int ib_umad_unreg_agent(struct ib_umad_file *file, u32 __user *arg)
 
 	if (get_user(id, arg))
 		return -EFAULT;
+	if (id >= IB_UMAD_MAX_AGENTS)
+		return -EINVAL;
 
 	mutex_lock(&file->port->file_mutex);
 	mutex_lock(&file->mutex);
 
-	if (id >= IB_UMAD_MAX_AGENTS || !__get_agent(file, id)) {
+	id = array_index_nospec(id, IB_UMAD_MAX_AGENTS);
+	if (!__get_agent(file, id)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.20.1



