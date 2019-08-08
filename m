Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FDC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B515821743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="KZrwUnP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfHHC3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:29:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45438 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfHHC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:29:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so3009234wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=911lJLOrOi7YW+Y8y2OrYwA8FJ9lIeonGQ2EsA8/ctM=;
        b=KZrwUnP8ndpdYJoxGXHvYDyIRBxN0j7v3Tc5YDqCdqauYvPvw86OG7o/le+VPI3UAz
         vbo0c36MSNpisepoRR7UlD0Rzh/1khg/DARvkiMppaVMsvD4DKb39c1I7XtjYuNwo15c
         UHkfSJSKfw0XezcK5Rj0vm0l/Zu16XqB51l6szL8tl5lCXyozb0QJF9n7jZcvAqFNrzk
         J5NJQ/CGBJbH37jAxr10rYY7n9MCa1zY/t7MsTR179evalypUAIPBNH8c4xCxSXZf/i7
         MhFojdt+h54C7/5f0ahEX7kyyP0jVop/EJ4lsMOwVawPXJZsbJY834dI2Mgke8nRrsDU
         ZCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=911lJLOrOi7YW+Y8y2OrYwA8FJ9lIeonGQ2EsA8/ctM=;
        b=AmiApxqYe364QJPfvDIYXuXWm7TwSTumgSTfvjLaQARm9aILcZ+nDaHipTnbJ9rH03
         eCNRJzJFKdI2HyAxCsn3xQpKw82ry5Mo5J/w+KznzP6PNOd9ci0BaFTqJ0eWROMWMWyj
         k0hplhOVgaVwlvFEiaoDTtQuPhDB38TBcN2gt7mTpuPYDEfigcMFfmtxcr+i7LbiOM1i
         vHo0Ob2mg5PjLAiDcTESfue7OybHAu2H7ABgHX/IcHwRJkYWKpzbHn1ZXALGbAw1HXYM
         cmCYoknlCtcyFPid2rMXI0Nhpbch2lfz12o4hkhwx/PNgh4wxE7SLAVTFQyajQxsCWil
         /y3g==
X-Gm-Message-State: APjAAAUpV0zYEHqoUMuJ3TiKRMvB/8A/XNYBb3jkxgbihJln0EWGtlBu
        pb6QhhN0y/oTShkGu4FUvauoXg==
X-Google-Smtp-Source: APXvYqz1Mc4QAhVqfkMi40hpRPqEHOgU+MZsaOcTsohcalcSO3XCCuc9myfLrOUFEZAp2Nuu1wUacA==
X-Received: by 2002:a05:6000:1148:: with SMTP id d8mr12498744wrx.354.1565231343427;
        Wed, 07 Aug 2019 19:29:03 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id j189sm953362wmb.48.2019.08.07.19.29.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 19:29:02 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, xiao jin <jin.xiao@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH 3.18.y 4.4.y 4.9.y] block: blk_init_allocated_queue() set q->fq as NULL in the fail case
Date:   Thu,  8 Aug 2019 03:28:19 +0100
Message-Id: <20190808022819.108337-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiao jin <jin.xiao@intel.com>

commit 54648cf1ec2d7f4b6a71767799c45676a138ca24 upstream.

We find the memory use-after-free issue in __blk_drain_queue()
on the kernel 4.14. After read the latest kernel 4.18-rc6 we
think it has the same problem.

Memory is allocated for q->fq in the blk_init_allocated_queue().
If the elevator init function called with error return, it will
run into the fail case to free the q->fq.

Then the __blk_drain_queue() uses the same memory after the free
of the q->fq, it will lead to the unpredictable event.

The patch is to set q->fq as NULL in the fail case of
blk_init_allocated_queue().

Fixes: commit 7c94e1c157a2 ("block: introduce blk_flush_queue to drive flush machinery")
Cc: <stable@vger.kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: xiao jin <jin.xiao@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alessio Balsini <balsini@android.com>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 50d77c90070d..7662f97dded6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -870,6 +870,7 @@ blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
 
 fail:
 	blk_free_flush_queue(q->fq);
+	q->fq = NULL;
 	return NULL;
 }
 EXPORT_SYMBOL(blk_init_allocated_queue);
-- 
2.22.0.770.g0f2c4a37fd-goog

