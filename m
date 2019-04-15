Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93158C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4745820818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ij1yIntI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfDOP0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:26:42 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:42394 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfDOP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:26:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id E4B61973
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A_iXBKS-RKsJ for <linux-kernel@vger.kernel.org>;
        Mon, 15 Apr 2019 10:26:39 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id AA3DDC64
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:26:39 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id t13so156094itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tSEywpfoCNlKFuZJuncBrF/Mbt6JnPGeLrWlA2hBd+E=;
        b=ij1yIntIVCSkDPqxekDCGgBoMJ+DLMF6R7KMyqpjZ75RHJoEfGwINHllNWoJFyzR4T
         +EG/a7mH1aAjk21pNVGM6t+d3LVm6PZWgFMQg/FxZpqNVU+H4pnT7aAf8VdDHrgg/h3G
         ki0lcqaqTy388HecyIQMPYAEEMKm9xoHwRYTCGimYW3kF0QIDvjCSUrYUOHZ4v6kIwf8
         HBe9y5Kar/YnPxU1fNO++RDlaQB3K90NpqLyND9j5bqcq6ekrQKVLgEAtpYtEwncEk1p
         cU//cy0o/hs2MILGToOiVi2KC7ioe6fRhvH4rdB6SipU9PT+fBfL0TtNkQj8O8oYU5tQ
         yn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tSEywpfoCNlKFuZJuncBrF/Mbt6JnPGeLrWlA2hBd+E=;
        b=G7kvCBxTLkp2ShRjO/uSGAw0EG9tm6DgnixlPvwIvgLw/zdy5AJ/XVCjfT6VRjoEVp
         nTC2BwQHCLOi85ERUeGTpPfP/ylRDysE2TWFaPHKwCvxtcaVpbn4UKff0jeO4DpbZX5Y
         bt9pzDFWITjDbbqPxYeynLJhyPwz727903E2oHFvB2YCsPKPs4KWjypwYScL99WolCIh
         DRKE7+NJ4s0Pv6eS+cgJb9BISzBFPiYy8I7ctNxvren8vG8b4SnJkBRb82fmb8W+CFmG
         uGf5MYxhOay14Kerurm9omx/jF9jlfTZadLRe1Uz+cMAkDI0mFHfw9juZoDmZA3H8Fvw
         vwoA==
X-Gm-Message-State: APjAAAVQMpwbYETQHCoEFE4my1qKZIAvSuyezbuR2HkeRE4lkxcbWcDP
        yYrC9etEXmPWxugTCoO1QKH5J2jRy95vbY7P8vJeRArDB0kgX/AC1aoNWjg9rDdKa9ZB/JuIfic
        l7fapzZvXffO3FAwhpn6lzQx4cb3F
X-Received: by 2002:a24:4210:: with SMTP id i16mr26180795itb.37.1555341999405;
        Mon, 15 Apr 2019 08:26:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyDkxjNdNt0RaQB4zDkVBNd/Z8g0JY9AJdjVCGd6bctmJYLmHcw/0kCRDy5ql2SPPa71HCI2A==
X-Received: by 2002:a24:4210:: with SMTP id i16mr26180778itb.37.1555341999241;
        Mon, 15 Apr 2019 08:26:39 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id m137sm8234209itb.27.2019.04.15.08.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 08:26:38 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] udf: fix an uninitialized read bug
Date:   Mon, 15 Apr 2019 10:26:24 -0500
Message-Id: <1555341984-3282-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In udf_lookup(), the pointer 'fi' is a local variable initialized by the
return value of the function call udf_find_entry(). However, if the macro
'UDF_RECOVERY' is defined, this variable will become uninitialized if the
else branch is not taken, which can potentially cause incorrect results in
the following execution.

This patch simply initializes this local pointer to NULL.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 fs/udf/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 58cc241..9d499e1 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -299,7 +299,7 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	struct fileIdentDesc cfi;
 	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi;
+	struct fileIdentDesc *fi = NULL;
 
 	if (dentry->d_name.len > UDF_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
-- 
2.7.4

