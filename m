Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24A7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D21F20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ZF9Xg2yO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfDOR6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:58:16 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:35882 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfDOR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:58:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 817A07A1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NgyflQKhCP59 for <linux-kernel@vger.kernel.org>;
        Mon, 15 Apr 2019 12:58:14 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 52726909
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:58:14 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id z125so16444821itf.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Kt3m9rcOnI6J+zVNa8o9f3p6anA0asulS92IkzcZMJ8=;
        b=ZF9Xg2yOU4mtnvmYyTIPdVITfDREnLt9YMSui3YaS+Mykb2Q6nRaVpWzJoLAkTi3VK
         gqWwOSzzw3wekTFFIyNNXEV2/c8rxmAy3gCJsyjkziXgpVniIqX/tO1sFBauNcKNuq9q
         woIPwFXJj0lqQyBnJoey1vmihHJU/J4wOE/0BvpIeYumfDyKlhUmH91J9n+NwIowxtvd
         DOq3tc8OHt+ObCv7+dyHEgdO7XJ5aT2vJgTBqQOKfK1vUYzmcag0yBey9amNd1pkQRVU
         dBIyvEHS/YdHy46RfLJGyLIM/GacX3PqNNNS0Lhxww3Q63y2j/tETD+cXvRALlqoDh8A
         NP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kt3m9rcOnI6J+zVNa8o9f3p6anA0asulS92IkzcZMJ8=;
        b=bOfGSWqxyK3e1XhyebWLXXoLvMR4b24/OT82w7p4HvcER8tiOnjVIr8NPQP8UDaMfG
         x3S0DWtIoOuw0DLDaMjttf8cpXt/SYXg0SL2955b0xjysW6hynknoSRtitJK0bip8kkB
         M+6FgCJb9ff4fvDxw4UCeqtof1HRtiYGSQ8P90cDwGHd8gDZvyrtw3DLndKfqctWfTM8
         RUxOJJq9vYJFGeN2ZggTLfjD0MSX+nUjVO/OSj5VoS1nQ8zIB6T12gOQfVtfsseuDhtv
         qHx7A5Mbkne6/pmK/35CiU/QPQPpfZMVS/rYyIamZzrrm7yv6LvHhT11f/AuO1YsyvkQ
         VT9w==
X-Gm-Message-State: APjAAAX6dbIg0hDufzrWe+Bcq/ce0GnkzsqIZa24SmIkfsRaGCpwAibd
        fZja8HRX7PVvUc5mlpx21xy9T7Ea+4kZe0uDAYDrosHJ8cMuyCWw18HPB3s9y5sSeOibglb4pk6
        DT/Xei/1nTru962AvrlDeqdYSiw5t
X-Received: by 2002:a24:7388:: with SMTP id y130mr27117488itb.85.1555351094019;
        Mon, 15 Apr 2019 10:58:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwok4QUX0awZLxdVHXSFz9c7tsFR2oG02mk94Qx5eE8d58DoA33oVOOOOM/2nBQ41pA4i38Vw==
X-Received: by 2002:a24:7388:: with SMTP id y130mr27117477itb.85.1555351093851;
        Mon, 15 Apr 2019 10:58:13 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id e11sm17761140iog.79.2019.04.15.10.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:58:13 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] udf: fix an uninitialized read bug and remove dead code
Date:   Mon, 15 Apr 2019 12:58:06 -0500
Message-Id: <1555351086-3935-1-git-send-email-wang6495@umn.edu>
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

To fix this issue, this patch drops the whole code in the ifdef
'UDF_RECOVERY' region, as it is dead code.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 fs/udf/namei.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 58cc241..77b6d89 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -304,21 +304,6 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > UDF_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-#ifdef UDF_RECOVERY
-	/* temporary shorthand for specifying files by inode number */
-	if (!strncmp(dentry->d_name.name, ".B=", 3)) {
-		struct kernel_lb_addr lb = {
-			.logicalBlockNum = 0,
-			.partitionReferenceNum =
-				simple_strtoul(dentry->d_name.name + 3,
-						NULL, 0),
-		};
-		inode = udf_iget(dir->i_sb, lb);
-		if (IS_ERR(inode))
-			return inode;
-	} else
-#endif /* UDF_RECOVERY */
-
 	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
 	if (IS_ERR(fi))
 		return ERR_CAST(fi);
-- 
2.7.4

