Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CCAC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE74B208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMy6goev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfELPyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:54:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45822 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:54:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so5785312pfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ctPGboDNDGmjFYiEazMcfzgkODikwa3AsFgd4Zyl/aM=;
        b=nMy6goevAU34IOb46/1Hf6xie10X97sMqObsq0qHXdYYxjUm3Z0ZMTba2TOHHACxm9
         Hyom9RmtArj/n2l4n4UL1YySbfieqUZmtjV3+pX4KoE7nm3HWNeA5khS6/uq7GRqt+LB
         X4Y8+d9mS7FwEx/H2+n3IJCH2iKsF2pKiOMD1rEz6CklPfOXvN3JjweWodbP/AGjFFUH
         EVAGqSJ8rRX9U8dRXa3CmLLT55YDj5EWH6FuVrMDNryPUhp7PTxhuErbcbvGVsVVPMEs
         Ou7TgZ/L0kY3pb/hYmcXkjoVmgBCKBiaQOJN5JjwOouWJ+0hzuz94AE5pp0Nz7T5+rxv
         HSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ctPGboDNDGmjFYiEazMcfzgkODikwa3AsFgd4Zyl/aM=;
        b=fzSxUn1EnRci//D+G3oIaj60HuD73DxCaM/4kWc6PvkJ9/zw76Yzlv/omiyfp598bL
         JVFsJGXOTjOm/+DGCqZ+XdtA3zpWJBftLochF5pRyPEtkrGJzTvCT7Vc8QRsRNSxbI+O
         DsJEzJGm2Yag9IgMk/59MBsFelrAdsfPpKuA7etgYlNJ9B+52icG790FRkKwUDcx1tGH
         uIW7NNDBs4125tZRAEZ5BwyHL8jAlwd0hzRwSsDlXHXaPTsK8oT43Os1HpswZhT2JIGU
         lK7X2OEo+8ES8WjsGvoCfH8QxqWHmhIUF0DdoZmyWXuljpgLdO/TkdXfpMJfVx/glA99
         8thA==
X-Gm-Message-State: APjAAAWOHiM26jU7R6kcfKzCbEQ951iY6zqgdjmhJf1i4HhR+bcZtDaC
        enkmdOT+Hz2b6GIYviC9M6c=
X-Google-Smtp-Source: APXvYqy5McS61tFBa5pCjUu5eW7VQ4z1D0OAZPgl5XGQeJ5qA+QLnzlKQVtjWnBHCnjVWMybMXjbzQ==
X-Received: by 2002:a62:65c1:: with SMTP id z184mr8671379pfb.130.1557676481624;
        Sun, 12 May 2019 08:54:41 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:918e:f7e4:1728:3f45])
        by smtp.gmail.com with ESMTPSA id v2sm4470058pgr.2.2019.05.12.08.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 08:54:40 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>
Subject: [PATCH v3 1/7] devcoredump: use memory_read_from_buffer
Date:   Mon, 13 May 2019 00:54:11 +0900
Message-Id: <1557676457-4195-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memory_read_from_buffer() to simplify devcd_readv().

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- No change since v2

 drivers/base/devcoredump.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f1a3353..3c960a6 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -164,16 +164,7 @@ static struct class devcd_class = {
 static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
 			   void *data, size_t datalen)
 {
-	if (offset > datalen)
-		return -EINVAL;
-
-	if (offset + count > datalen)
-		count = datalen - offset;
-
-	if (count)
-		memcpy(buffer, ((u8 *)data) + offset, count);
-
-	return count;
+	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
 }
 
 static void devcd_freev(void *data)
-- 
2.7.4

