Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70088C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CE6206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KW9uxdKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfLQUyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:54:01 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51840 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfLQUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:54:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47cr3D10tgz9vYwf
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PWSn7wD74zxG for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 14:54:00 -0600 (CST)
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com [209.85.161.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47cr3C6pHPz9vKkk
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:53:59 -0600 (CST)
Received: by mail-yw1-f71.google.com with SMTP id c68so9158550ywa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knhSf+eyCdoX1uYdgnl9DAzGqM/zDzsAxGOMt75GOeY=;
        b=KW9uxdKVEE1cGboEmFPtl1bF+X0FhEtizkUnApethUm/LhLaZszjO3xBtQCAIuI1Ar
         2SK9l6JiGdphs8PEFxbVTQKAQwDAMzijOfUw5x+JwRfDC0O2cl0a5F8oG6ejZ1SW6zSp
         wabutn9GBBX35Wf0/fzS8xQx0FrLU4eRhy+S6/sd4As/7jaNgpHp6v8+h0eXo0fjxpXK
         h3TNpQsiC5U2tXb6B6bNEe1uKsFyO+HSBQSNyaaHaU5ZfeItF9bnUV/KcT4LyRMoueDM
         TK41NghYcTzCTo3hT5T68vg3M/V55K02wE8nLdtdqfhBmNvgBcObaDY+P8lfgJ4ITY2D
         3FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knhSf+eyCdoX1uYdgnl9DAzGqM/zDzsAxGOMt75GOeY=;
        b=BnTfGwPXfGcV82MDxMgnfrk7xhE7oBRWZbgSJyKYujXNmrTrMKMtOqs92oeSh15qEj
         hqr79fXofdnocDpQsybDwmXrYQgNWYzGu9VJJ/WJz1vEsULB6ySg4H1BRBPMDHXL3bzq
         5UWMCp1tKa31gnHsQK0RLE0e8d/5eiKHXPfN7mQvEkRJp51zSh1+KEkkK4FLadMoCwED
         bz24K8kxZ+qvHW4GLYWbGhXIwUAH9lWZm+M42DJA1uGunfrY5+/xvOFOAMMx/w0BUTrO
         Ya8Q/13peJnF6jqF9kefUmvZdb+WdWDjtVLzLdwfRIOf4sVooLjnd06P2RYqZ3ED1UPH
         n5TQ==
X-Gm-Message-State: APjAAAXGcRhpJPjYKTaFPa2VHyuL3v8UiwobG5rVyAh0M+iDaphFoRMA
        64MZu3z5i+SlrWEyUgYsxVOv5zIFrYMm8J3bXreQ3w34edoR0uXrSTzbfgsSIucv65aE1g0XvAw
        RuGU4LE7yZumnY3V3Z93OAHVSuoQd
X-Received: by 2002:a25:dd04:: with SMTP id u4mr21885ybg.419.1576616039238;
        Tue, 17 Dec 2019 12:53:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgA5SI4ho9qhM2qkA9c0wLxK4/wVAABvXhm0AgOJCd5pQ/kuKS89YzxeQKtfbjs+EEsNCSGQ==
X-Received: by 2002:a25:dd04:: with SMTP id u4mr21862ybg.419.1576616039020;
        Tue, 17 Dec 2019 12:53:59 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id d143sm8500294ywb.51.2019.12.17.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 12:53:58 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] xen/grant-table: remove multiple BUG_ON on gnttab_interface
Date:   Tue, 17 Dec 2019 14:53:56 -0600
Message-Id: <20191217205356.29172-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gnttab_request_version() always sets the gnttab_interface variable
and the assertions to check for empty gnttab_interface is unnecessary.
The patch eliminates multiple such assertions.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Eliminate more BUG_ON calls, as suggested by Juergen Gross.
---
 drivers/xen/grant-table.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 49b381e104ef..7b36b51cdb9f 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -664,7 +664,6 @@ static int grow_gnttab_list(unsigned int more_frames)
 	unsigned int nr_glist_frames, new_nr_glist_frames;
 	unsigned int grefs_per_frame;
 
-	BUG_ON(gnttab_interface == NULL);
 	grefs_per_frame = gnttab_interface->grefs_per_grant_frame;
 
 	new_nr_grant_frames = nr_grant_frames + more_frames;
@@ -1160,7 +1159,6 @@ EXPORT_SYMBOL_GPL(gnttab_unmap_refs_sync);
 
 static unsigned int nr_status_frames(unsigned int nr_grant_frames)
 {
-	BUG_ON(gnttab_interface == NULL);
 	return gnttab_frames(nr_grant_frames, SPP);
 }
 
@@ -1388,7 +1386,6 @@ static int gnttab_expand(unsigned int req_entries)
 	int rc;
 	unsigned int cur, extra;
 
-	BUG_ON(gnttab_interface == NULL);
 	cur = nr_grant_frames;
 	extra = ((req_entries + gnttab_interface->grefs_per_grant_frame - 1) /
 		 gnttab_interface->grefs_per_grant_frame);
@@ -1423,7 +1420,6 @@ int gnttab_init(void)
 	/* Determine the maximum number of frames required for the
 	 * grant reference free list on the current hypervisor.
 	 */
-	BUG_ON(gnttab_interface == NULL);
 	max_nr_glist_frames = (max_nr_grant_frames *
 			       gnttab_interface->grefs_per_grant_frame / RPP);
 
-- 
2.20.1

