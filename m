Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD012184B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367921;
	bh=hdxTWI0SJ09axRNEQIAzjbkDwWMYWQHfIAdHVW1xEBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tnGMNEDCmIzgqfDgHapRUIOcW8i6pJk7R+8psngnyt6f1WFcDdMiEVau9oHoaQ6eE
	 fKUPiERD6dfy+vmHEF6+NFPbGlmyFKoDgkoRh0J00+RJkJI2Zm5Frl8GL9dRx4yu6m
	 R1iNxRmPNXKcQXQwr0GsBPDAbLwvRR5COuPo9vtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfDDIv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbfDDIvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:51:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4DD217D9;
        Thu,  4 Apr 2019 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367910;
        bh=hdxTWI0SJ09axRNEQIAzjbkDwWMYWQHfIAdHVW1xEBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqZzURWI1NfFIF/L3zqq7lBmNQxwqf9r3IYwrYWxyT1YHR9edEGaACirST+zsapgM
         0e1CJtlDR7sqeex7mixUK9Xjwy+zjXjG11CXITaqEOdaoKXmcCrXXMMeDQTA2/OkbR
         gdvoCjPdB3tORRwsQ8y5fD91+3FCdf3r5/C15PTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 59/91] bcache: fix input overflow to sequential_cutoff
Date:   Thu,  4 Apr 2019 10:47:43 +0200
Message-Id: <20190404084538.852797329@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8c27a3953e92eb0b22dbb03d599f543a05f9574e ]

People may set sequential_cutoff of a cached device via sysfs file,
but current code does not check input value overflow. E.g. if value
4294967295 (UINT_MAX) is written to file sequential_cutoff, its value
is 4GB, but if 4294967296 (UINT_MAX + 1) is written into, its value
will be 0. This is an unexpected behavior.

This patch replaces d_strtoi_h() by sysfs_strtoul_clamp() to convert
input string to unsigned integer value, and limit its range in
[0, UINT_MAX]. Then the input overflow can be fixed.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 87daccbbc61b..463ce6757338 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -215,7 +215,9 @@ STORE(__cached_dev)
 	d_strtoul(writeback_rate_d_term);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
 
-	d_strtoi_h(sequential_cutoff);
+	sysfs_strtoul_clamp(sequential_cutoff,
+			    dc->sequential_cutoff,
+			    0, UINT_MAX);
 	d_strtoi_h(readahead);
 
 	if (attr == &sysfs_clear_stats)
-- 
2.19.1



