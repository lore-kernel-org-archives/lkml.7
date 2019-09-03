Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09202C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFEE2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfICLmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbfICLmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:08 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31E52811BF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:08 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id v4so4215605wmh.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ydFLCcq0ciOZyr1APkM5OIxojvSPh3+JfyuTKS+43s=;
        b=qljSJbmQzrBkn4qYIb2xsV0ayD3Hib5cFr8y3kFzB8ujQAyDZ3zU9mbJ+G8EfS73+F
         czoFK8Ldze6q8K0bloZCXrrEybBy8bZUaH/Asr2gRAg411HUdtXRsUFqXfqFRy4Q9iBp
         SQsFPd0UIv99Rn1Mrw+R5dw3eK5/9LT1Qws7RHH6isCjIRPAfbaq73J3XEHzeglFivce
         k3a5WweD+ijWtf9GWQDMFDuV4Rqbv4Iie4jX77Zr/tTjEhDetm+mOoK1mI4fuiZ9HC7J
         it6Y8/oZ+hJbGSI90mwdOJ8LiaXeg8OX5epOPjNwEDOb4VkBtz9532FMMsIVpY02bYf3
         OFZQ==
X-Gm-Message-State: APjAAAW6hyev2hsfNSNtq5MX/j2CzA5ctaATb4mAyARUy79aLwf25SKm
        7EdXZMcGVbOXw+zoqwMTiC2M2FJanjyYuzPq3oR7scOPTP4DL9IrDLcdwHuxGYIPF7Cq84DNImZ
        pjNGyRaW61rGyJtyy9ZBHLTu0
X-Received: by 2002:a7b:c947:: with SMTP id i7mr43660043wml.77.1567510926813;
        Tue, 03 Sep 2019 04:42:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwVaQwtVBh/GvNyluxkYOtecnAIB1sEbYcsQqfpoYMUCYSVMPO87Fhv/znnSgCVILBxIAMhQ==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr43660009wml.77.1567510926604;
        Tue, 03 Sep 2019 04:42:06 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:06 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 07/16] fuse: export fuse_get_unique()
Date:   Tue,  3 Sep 2019 13:41:54 +0200
Message-Id: <20190903114203.8278-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio-fs will need unique IDs for FORGET requests from outside
fs/fuse/dev.c.  Make the symbol visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 3 ++-
 fs/fuse/fuse_i.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index bd2e5958d2f9..167f476fbe16 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -363,11 +363,12 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 }
 EXPORT_SYMBOL_GPL(fuse_len_args);
 
-static u64 fuse_get_unique(struct fuse_iqueue *fiq)
+u64 fuse_get_unique(struct fuse_iqueue *fiq)
 {
 	fiq->reqctr += FUSE_REQ_ID_STEP;
 	return fiq->reqctr;
 }
+EXPORT_SYMBOL_GPL(fuse_get_unique);
 
 static unsigned int fuse_req_hash(u64 unique)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8ced5e74e5a8..7e19c936ece8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1104,4 +1104,9 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
  */
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 
+/**
+ * Get the next unique ID for a request
+ */
+u64 fuse_get_unique(struct fuse_iqueue *fiq);
+
 #endif /* _FS_FUSE_I_H */
-- 
2.21.0

