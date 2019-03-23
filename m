Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D552148D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KN2ObHhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfCWWKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 18:10:25 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:53564 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfCWWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 18:10:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 1F845BA6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 22:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OnD5wULZoaee for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 17:10:23 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E62D89D2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 17:10:23 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id e126so4617737ioa.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4N/n9Cj2LolUHnf3+FkKh4bEuQdQ9jfWnJb1diucgu4=;
        b=KN2ObHhrt29Y0liChsaT3HzGeSW3TxGbIM79QEiVTHn4ouD3nfeFixfk6xVZJ7vfFQ
         MVEOqOS6x1JuH918+o49aTklcnHMe1QD49Q1MpJhQQwswJC4CkeeeoJJA54wQ5r2ETjN
         YVp809in6YRY6OrraaQIjwwhOIIfRpSKxY0QygcucjdN4HiM/tI5D5WlcFzQ8yF6oLCX
         RQc7PE+Vd07Ze/c17R0tHpuQ7AP8WtGiNMlpz0zx+VqSe1CBZ234sLVU0BsXf+SP6sdR
         nA0rdIKygnawfgEhsHIBWJKiKYXTC/1xbDhqlrsdtWJ8fxvKulw1dIzCRHO7UH+FKTAE
         /tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4N/n9Cj2LolUHnf3+FkKh4bEuQdQ9jfWnJb1diucgu4=;
        b=AIkh2lsqM1xJzpo2MFPKRJeEWmIGjNG5dnxfdi5M64LMlYV6fM2ilgqkfXs8LLeSDv
         TAU06q2k16WWPZ5MnyK6F1rdk2gjPJ/C+I+2LM41dFkJBO92EgI/kpijDx0ACKLPX6ZI
         /Wxv/61aKhNbiAoYCCvLqHETJeqm6qcVCh2HhSNX7KK9FIRwx/gx10BuUdz/L/0JVl2P
         6C2Kb6d0NocZUcO8u1ejlS0JIevrK6BxyuioXAXIWQS63lW0INBPQaIh5HKUmMvozmgg
         LPiE+yaqhJR+0CasaRTOWPdU7AcnkBlsJNFFgiFLCaPxVaiRNrIrRagCCXjNU2ZeEfEt
         7nQA==
X-Gm-Message-State: APjAAAVP0U4XEpmvAgP2l86LQCmqv0jlJe4Yb5LX+z+ATXtv303Hs+Ju
        odoHFvX9Lm+6xffvYHBw6ArDoNd5EHlj0B0uGC8m0H/xa+1OzplyvrEhnbTgoREhWkqhaFR3cEJ
        wUac0g5hXWulGjTtAxEY8QDthGdH+
X-Received: by 2002:a5d:8708:: with SMTP id u8mr11267913iom.299.1553379023584;
        Sat, 23 Mar 2019 15:10:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxX7sCQKSZNK3lFu+yDYki7jqUWay6wOjljnmwvaptv2em3E67lXjGeBDy1+5NNYWig3LPJg==
X-Received: by 2002:a5d:8708:: with SMTP id u8mr11267905iom.299.1553379023376;
        Sat, 23 Mar 2019 15:10:23 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id z13sm4730012ioj.21.2019.03.23.15.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 15:10:22 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jiri Kosina <jkosina@suse.cz>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: edd: fix a NULL pointer dereference
Date:   Sat, 23 Mar 2019 17:10:16 -0500
Message-Id: <20190323221018.13026-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As other functions in this module do, edev should be checked to
ensure that it is not NULL.
The fix inserts such as check to avoid potential NULL pointer
dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/firmware/edd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 1b82c89a49df..7ebfaca53721 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -279,6 +279,8 @@ static ssize_t
 edd_show_mbr_signature(struct edd_device *edev, char *buf)
 {
 	char *p = buf;
+	if (!edev)
+		return -EINVAL;
 	p += scnprintf(p, left, "0x%08x\n", edev->mbr_signature);
 	return (p - buf);
 }
-- 
2.17.1

