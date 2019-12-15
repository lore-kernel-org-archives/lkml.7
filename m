Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08479C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71B32467A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DAEclJHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfLOUNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:13:33 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:51646 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOUNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:13:33 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bbFS36mFz9vYkx
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 20:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rOvR07cqox1F for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 14:13:32 -0600 (CST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bbFS20Mxz9vYkV
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 14:13:32 -0600 (CST)
Received: by mail-yb1-f199.google.com with SMTP id d191so4957651ybc.17
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 12:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EV3d9IrHuviw6NuP0prZ+L56BjgZrxEmg7Osn+ldLeY=;
        b=DAEclJHhiwU1JiAx6Swl3XCgRzafLipHbCsIVaj5z9LYNzqOAZW9w5kdRSlZOPBnPH
         xnE2+TXUGknqfCVyu2aHgFsJjQug1n+ub63TfO56HYcLSpv7VIQFKLB3q4BvCFC3vIj1
         miQxJXXvjQof9NQmXTeaJ1k6zeRPguw0aYkMu6lEVdUWNt5JDIzMat8B46oT4XxrWtD6
         c759KpV05FW/3kQsaGejmQrlUNY3JAa+iUoIm7yumiJl8zor7MDuveDZQ2K8RKV/2ywD
         5IIMq61m0nCcXdoE9TFqZN/KWG65/jfwahOWr1Ev/+o/bl3phO5KCp19FQIvlBA5Z8Wc
         505w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EV3d9IrHuviw6NuP0prZ+L56BjgZrxEmg7Osn+ldLeY=;
        b=HWu1qKQZIIruuxA6cGp7UxLGfMuCpgq8ZC3b+5Gx3DNc6YauG3Nur2PuS5G4TIWW9F
         Ji+lUjup2sYaIyMSc6mqLsO9+7kRPanBKrrTfnzdOdobUVGdvFUiGH8eC2KSpepYjHQu
         xLpgt6u6BEJqnnFn7OjTNsj16Uep+KN5MQ2U9gKzFoJ+bFpLmLUxEo2QIyvJwcakUm+h
         Pudcoj/yjqbyNIvR4Hxzm3HcGgbCqfuEPM9hZPI/VUMdc6fNfEZoIFEVl1EYVfg2KPtp
         I05X+LvcU6SL7MstZ3bqECX0hqSWzuYLt9fKN1U1w88gvXrKiErDFtiBqatiHrZ+BE4e
         XhmA==
X-Gm-Message-State: APjAAAX9+xULrr+EVpyHa1sI0YN//EKuoiNAnu2FaH/EaE0x5IADT6Ew
        jO7fPuCikdEif2KGhd+jTsiFtCVhYTY8rClCyZKYDoDi9g95G6w+RnsUnyqZghDdacXjehAEAgL
        2c/3JApZhcxPtOOew3p/DEkZsp/rY
X-Received: by 2002:a25:d80d:: with SMTP id p13mr140457ybg.160.1576440811792;
        Sun, 15 Dec 2019 12:13:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2aXNgpQh2rdh1zAq/XXv8ZBWxNTw/1xzYwr/dwL99HLrUehUYmqdJX5ABNij4OyLLRVnmEw==
X-Received: by 2002:a25:d80d:: with SMTP id p13mr140448ybg.160.1576440811576;
        Sun, 15 Dec 2019 12:13:31 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id v38sm7251276ywh.63.2019.12.15.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 12:13:31 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/grant-table: remove unnecessary BUG_ON on gnttab_interface
Date:   Sun, 15 Dec 2019 14:13:21 -0600
Message-Id: <20191215201321.7439-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

grow_gnttab_list() checks for NULL on gnttab_interface immediately
after gnttab_expand() check. The patch removes the redundant assertion
and replaces the BUG_ON call with recovery code.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/xen/grant-table.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 49b381e104ef..f59694c352be 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -664,7 +664,6 @@ static int grow_gnttab_list(unsigned int more_frames)
 	unsigned int nr_glist_frames, new_nr_glist_frames;
 	unsigned int grefs_per_frame;
 
-	BUG_ON(gnttab_interface == NULL);
 	grefs_per_frame = gnttab_interface->grefs_per_grant_frame;
 
 	new_nr_grant_frames = nr_grant_frames + more_frames;
@@ -1388,7 +1387,9 @@ static int gnttab_expand(unsigned int req_entries)
 	int rc;
 	unsigned int cur, extra;
 
-	BUG_ON(gnttab_interface == NULL);
+	if (!gnttab_interface)
+		return -EINVAL;
+
 	cur = nr_grant_frames;
 	extra = ((req_entries + gnttab_interface->grefs_per_grant_frame - 1) /
 		 gnttab_interface->grefs_per_grant_frame);
@@ -1423,7 +1424,9 @@ int gnttab_init(void)
 	/* Determine the maximum number of frames required for the
 	 * grant reference free list on the current hypervisor.
 	 */
-	BUG_ON(gnttab_interface == NULL);
+	if (!gnttab_interface)
+		return -EINVAL;
+
 	max_nr_glist_frames = (max_nr_grant_frames *
 			       gnttab_interface->grefs_per_grant_frame / RPP);
 
-- 
2.20.1

