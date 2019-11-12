Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD030C17447
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAE7206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKLCLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:11:08 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45782 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727202AbfKLCLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:11:07 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2B6Os028502
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:11:06 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2B1AE006874
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:11:06 -0500
Received: by mail-qt1-f198.google.com with SMTP id h39so19139285qth.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 18:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CcYLAh/UyTxqCQmL3RjWyYe/kNKV5YS8PJV7/eSFSes=;
        b=hxYL9qvbaER6n6PDIN1tI6AsMytzRYD5cMDPoGyOMMRTiUwMj3A9oN0oRKAN2J6ix3
         OgM1Aw2iqFJFHMASkpzK+v3615YkI5Ioxe8M4d1lfJdNv8hKcOB0/a28TUCK1jaVQEcw
         CjTkWBXguatWmaBdTNNhgnwvtrGOCDAlvoNoXPBtSl/O9OynAS4Ji68kIbYn4i3OEc8o
         SEIN5IdPeJum4FBgDyyu0W9ctn41kJ1Mrp/2Y74LJ4KkDHw5pXeyC53Xo45KyuNPy5CR
         RrTabj/5qxL0jBy9uFBYpKg5L789gHNZ6AFmGQUi2VEkOJztuIp8v2/roa/6nPIOwGvq
         AFJw==
X-Gm-Message-State: APjAAAXFiXFU3lLCcYecRkjQV5xcOVaY1Iy/+NqQeTgu9X6gfk4/btsr
        XNxQHKYCvkLRph4CVzhZ0ktzjkcEp1NKgB+0W8ukjjMMUrT+vkpafQECt5wT0PEAwYSlzpi8xYF
        zPti7CTdU9lF7dreRvrZusYVuffkL4HKWOmk=
X-Received: by 2002:a37:782:: with SMTP id 124mr13629140qkh.142.1573524660754;
        Mon, 11 Nov 2019 18:11:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZYuxGedyB7a+wA/llda6YOy1P21HsSw35yYTNEbYtMJL30UKBF+x5CPddS8qesmICNXkDXw==
X-Received: by 2002:a37:782:: with SMTP id 124mr13629129qkh.142.1573524660504;
        Mon, 11 Nov 2019 18:11:00 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:58 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] staging: exfat: Correct return code
Date:   Mon, 11 Nov 2019 21:09:57 -0500
Message-Id: <20191112021000.42091-10-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use -ENOTEMPTY rather than -EEXIST for attempting to remove
a directory that still has files in it.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index a97a61a60517..e2254d45ef6e 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2167,7 +2167,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	clu_to_free.flags = fid->flags;
 
 	if (!is_dir_empty(sb, &clu_to_free)) {
-		ret = -EEXIST;
+		ret = -ENOTEMPTY;
 		goto out;
 	}
 
-- 
2.24.0

