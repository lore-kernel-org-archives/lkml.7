Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E59ECE596
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5C6218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697739;
	bh=WmQ6xVhy6F1VzCuXT88er8kQuWfHDNle5G7/6tY/DhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RnfOcjCHtjfXOqtmlh11tCEe+nYeZPOj9Z6VevxmujkAEJyfbmE7MjZYJIMeSv+xS
	 3jj2i/IUdLs0V1aj75ci8xO+8BMW5SDvb1jf4BpBzyXb5vXqioLPG/0DyIWzUwRNXr
	 gZuCyRoRRLBtmNvOE4tMDorpaALT74KqMfamHj8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbfJJItU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388852AbfJJItL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:49:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE1321929;
        Thu, 10 Oct 2019 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697351;
        bh=WmQ6xVhy6F1VzCuXT88er8kQuWfHDNle5G7/6tY/DhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3+I46dpodV2DA0Y5+Gy6Q06ymAjY9SMQOXvXLzkOBLEh4YXr63wAGmaMGNlnCzM7
         iePrbPAAD82hlOqXHjoOaRefMkEajOeMK3EdWAADLONAmugCMeEit96Gy0dd79cmei
         1tH+8ic3ruxisDts70xjWJFekJ3XhcMuv/2RXZTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4.19 110/114] staging: erofs: add two missing erofs_workgroup_put for corrupted images
Date:   Thu, 10 Oct 2019 10:36:57 +0200
Message-Id: <20191010083614.097681169@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

commit 138e1a0990e80db486ab9f6c06bd5c01f9a97999 upstream.

As reported by erofs-utils fuzzer, these error handling
path will be entered to handle corrupted images.

Lack of erofs_workgroup_puts will cause unmounting
unsuccessfully.

Fix these return values to EFSCORRUPTED as well.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Link: https://lore.kernel.org/r/20190819103426.87579-4-gaoxiang25@huawei.com
[ Gao Xiang: Older kernel versions don't have length validity check
             and EFSCORRUPTED, thus backport pageofs check for now. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/erofs/unzip_vle.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -311,7 +311,11 @@ z_erofs_vle_work_lookup(struct super_blo
 	/* if multiref is disabled, `primary' is always true */
 	primary = true;
 
-	DBG_BUGON(work->pageofs != pageofs);
+	if (work->pageofs != pageofs) {
+		DBG_BUGON(1);
+		erofs_workgroup_put(egrp);
+		return ERR_PTR(-EIO);
+	}
 
 	/*
 	 * lock must be taken first to avoid grp->next == NIL between


