Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E94BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115EF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="DY5JKdpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDOIZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:25:18 -0400
Received: from chill.innovation.ch ([216.218.245.220]:38698 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDOIZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:25:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 202ED64013E;
        Mon, 15 Apr 2019 01:25:14 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Authentication-Results: chill.innovation.ch (amavisd-new);
        dkim=pass (2048-bit key) header.d=innovation.ch
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dsSpGWYhOX5Q; Mon, 15 Apr 2019 01:25:12 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 86EE2640132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555316711;
        bh=TBJU3Pb9NNNb10NH8UGsAsbPBXiFDazzRpGDTIYfx/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DY5JKdpYGyL9aP9tsaWNQJuXy+DIkSHg2RgiEiYgqfYxcct3qsyXI4VQVRQEZJ0nN
         aFMzj9EpnK8u3DdaGihgPCLmfbiFn8utQd7X2XggeDTjd4ZoUQH9OyyvTuWNnks/Xv
         iMiwIObDW25LPLywGlkivm1/MhqztzL8zu1nh+wNAMt+yY18QWGQPKnssDpaqEcalV
         iSt2uNJnY88xgigDjDNl7lsCG4aAm5o7sPW70Qc2BNfvvdJjLs6A3DEgUaxm2yYEsQ
         DB6SC9sAt4HsGe8+xrOQlSOp8M5egPyYAnF5+++7IsLcGhb0g/C+hnS/y31BCSlVfQ
         cCUphVWqPSGmg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] debugfs: make return value of all debugfs helpers consistent
Date:   Mon, 15 Apr 2019 01:25:06 -0700
Message-Id: <20190415082506.25610-3-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415082506.25610-1-ronald@innovation.ch>
References: <20190415082506.25610-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ff9fb72bc077 ("debugfs: return error values, not NULL")
almost all the debugfs helpers have stopped returning NULL. The lone
holdeout was debugfs_create_u32_array(). So fix that.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 fs/debugfs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index ddd708b09fa1..bb706d073782 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -999,8 +999,8 @@ static const struct file_operations u32_array_fops = {
  * Once array is created its size can not be changed.
  *
  * The function returns a pointer to dentry on success. If an error occurs,
- * %ERR_PTR(-ERROR) or NULL will be returned. If debugfs is not enabled in
- * the kernel, the value %ERR_PTR(-ENODEV) will be returned.
+ * %ERR_PTR(-ERROR) will be returned. If debugfs is not enabled in the kernel,
+ * the value %ERR_PTR(-ENODEV) will be returned.
  */
 struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
 					    struct dentry *parent,
@@ -1009,7 +1009,7 @@ struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
 	struct array_data *data = kmalloc(sizeof(*data), GFP_KERNEL);
 
 	if (data == NULL)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	data->array = array;
 	data->elements = elements;
-- 
2.20.1

