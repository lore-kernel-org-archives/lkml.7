Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14775C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FDC20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565026449;
	bh=C/JzWhtSkBfA1oDrGl88GR52YoCBcNMvjy6dR5YkVys=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xFiK4G2eEBQybP1HUcApDCHrFFdGXxPDodUHVTtVtw56PrUBwYg16/ZnOp8mf5ELU
	 SnqrwYm+l1zUdw3OpC2yH2b/8n9f2/04eykG327YScEn6LDY7QTbdYVmAtIf/Pxin6
	 Zfhb8laC4/eSRnojY98PYoSL8nkmr8DtELKC43yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfHEReI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:34:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43428 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfHEReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:34:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so35019163qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EheSyu8QNL/rpe3eMlNLpt0BVd72EJYgiwTp6hSU4ws=;
        b=bDRa27/6RJbRPe1SQmKO3P2YZwWHelFSlZ+zaDI+xlSUO02yT3qjcBicx9vHb4i/qb
         3D1mLCjl3EvPWrmrhufTHhz6SfPsqC0XoTVxAOCYV/RGFQ4gntfDs1UabuVBWlq+Bx25
         CeVUi086xydOBleOGqnRSwXtpJcL6gmdZqMxUtqk419+elYv4b6J0snVVVMBpuzm+UhJ
         sSkU5jEsTmJMB+zB17nDiO2q4P2bOSyawgNMmJu1eS3OsZerhjGi/1W9z5ZYFyYVZM8C
         fTryKUMv2/GOlEAXSmhvE9XZ1nVoD8AMZkiLy5mi1GgBcDzjBwNsHMRKb0v9RKNgpqxI
         AArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=EheSyu8QNL/rpe3eMlNLpt0BVd72EJYgiwTp6hSU4ws=;
        b=C4zaE6+z79Cv2Thgycb7NnRs6S/7/1sSafanwNbqtGix3Medae8cFAGxVWhpT76SO0
         seACzZ6/YXab+BVaQXz6hHk1sBfu0Xj2JcpCSjACAs/1FoBF0CsZ5/+ZwxjPmTT2aTY0
         PZsOnaooCpm6qs/R6/zJBoGnmBX4lAINNY9WfI+DyRHy7TazKi8Su0lBPPoYyzpfYL0e
         QZ0uZN4+uVibvhQMZXVRNPlLzd7n/fOAT/V/bd44zZSZbsxOcwDb0+bN5aIBsPs3ceiG
         SnrqVfbcyJT5BRzejqEEcze3on5UCw7tKct0uRiN60aDBsFYfjI5QT5a7lYFXMFmfUvW
         yzQA==
X-Gm-Message-State: APjAAAWEqgdBTu/3MkJrvZUfVXCBuUnudlC7Dxw5fdJy8oAWVnzx9HrI
        0QkxBd0/yeZFOGIAhrUDhxk=
X-Google-Smtp-Source: APXvYqx13+J/0aL2q5gRFZRlcI93vYWiTA+xRH+ijAwVYJyfZOzxz12SOaX24q3+1O4O6Rt7jAW2Gg==
X-Received: by 2002:a37:660d:: with SMTP id a13mr75955734qkc.36.1565026447312;
        Mon, 05 Aug 2019 10:34:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::39f3])
        by smtp.gmail.com with ESMTPSA id h40sm47307388qth.4.2019.08.05.10.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:34:06 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:34:04 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ~@devbig004.ftw2.facebook.com
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] kernfs: fix memleak in kernel_ops_readdir()
Message-ID: <20190805173404.GF136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

If getdents64 is killed or hits on segfault, it'll leave cgroups
directories in sysfs pinned leaking memory because the kernfs node
won't be freed on rmdir and the parent neither.

Repro:

  # for i in `seq 1000`; do mkdir $i; done
  # rmdir *
  # for i in `seq 1000`; do mkdir $i; done
  # rmdir *

  # for i in `seq 1000`; do while :; do ls $i/ >/dev/null; done & done
  # while :; do killall ls; done

  kernfs_node_cache in /proc/slabinfo keeps going up as expected.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org # goes way back to original sysfs days
---
 fs/kernfs/dir.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1e7a74b8e064..82b6c699fa34 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1683,11 +1683,14 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		kernfs_get(pos);
 
 		mutex_unlock(&kernfs_mutex);
-		if (!dir_emit(ctx, name, len, ino, type))
-			return 0;
+		if (unlikely(!dir_emit(ctx, name, len, ino, type))) {
+			kernfs_put(pos);
+			goto out;
+		}
 		mutex_lock(&kernfs_mutex);
 	}
 	mutex_unlock(&kernfs_mutex);
+out:
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
