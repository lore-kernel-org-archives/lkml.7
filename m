Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6927EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388852175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="nId/+JzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfDXTbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:31:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45461 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfDXTbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:31:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so5451290pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8JlwrEln20s9/aOucPUHK+u3UqPbgF8b6t88h882nM4=;
        b=nId/+JzE4bt4YU2hNBj8kFhmTRHl3qvAr81qDvsdscuXJ28cdOi7jSM8qp8FeEGl7M
         lu16fmXyjh2CbngAfP4d3Q7z8F9ygsVqGqpjG7+zppTJUWILFNwsjakzo1If+Rdw+bIA
         ts1JjQqaroNuam7nwtWJRT5ocQJGbe+8baiysmZSLh46avcQgcnlFVOgYu9jqbs7o/7n
         O9Rcv7AqJvZTX48mr9U/sZ2L+vL2E99bAq82zZeHcMJwaXwNFERnrG3adLVU18v4Hn4h
         W5au4JQb3J0vEiarKg5UnJVkiOnRm/QVhBXPyPMwXaRLHQOgYLK3PGL4/baDf+gtwlcC
         GsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8JlwrEln20s9/aOucPUHK+u3UqPbgF8b6t88h882nM4=;
        b=hStTec7w6PD7AvkqIcsgKUd9PEniqGAecKkoDfCVEX0lVkAxMliXMVTAoZlrMNA4mi
         OShkZHFq0Eg/NWtOvr9eA0ZTyD3kzRqE3kJgTYXF0aObXREvCnaUpwkwe2WE2EzAFVXS
         4xncFJWGikVEoGgQitRCkNP4I1oMNeyBTkASI2RNN0Jz5xBgOOrrtu08isv97tK2CskJ
         P0xGGqoTRpBzQbeDEVg5IRWiEamQ2uMstk+EOyKam32VNHS5gOepPbZCj1zhWPS9DvXd
         2ys5YeKMdvatQiFkpk3YoXDGxiCuBbngKhpJs3iKV9jtLAXWbMSmqWCZvHwpgtiLVQ6F
         wmFA==
X-Gm-Message-State: APjAAAXH6FrQ7ZJozvYEVrKGmuO5hSVhXB3DxnY/gGb1BA0wKTu9PsSN
        sDN3nI6GFvwJlqg6kb5G4O6VRw==
X-Google-Smtp-Source: APXvYqyhMplWmiupzeKAhnd683ePbVnUq9bbVkfFpOcWopG8Hor86LspXRFTt8Ho9+6fNXPiC1zHHw==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr34476270pls.39.1556134297060;
        Wed, 24 Apr 2019 12:31:37 -0700 (PDT)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id g2sm33331313pfd.134.2019.04.24.12.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:31:36 -0700 (PDT)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH] binder: check for overflow when alloc for security context
Date:   Wed, 24 Apr 2019 12:31:18 -0700
Message-Id: <20190424193118.207428-1-tkjos@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating space in the target buffer for the security context,
make sure the extra_buffers_size doesn't overflow. This can only
happen if the given size is invalid, but an overflow can turn it
into a valid size. Fail the transaction if an overflow is detected.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4b9c7ca492e6d..6f0712f0767c5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3121,6 +3121,7 @@ static void binder_transaction(struct binder_proc *proc,
 
 	if (target_node && target_node->txn_security_ctx) {
 		u32 secid;
+		size_t added_size;
 
 		security_task_getsecid(proc->tsk, &secid);
 		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
@@ -3130,7 +3131,15 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error_line = __LINE__;
 			goto err_get_secctx_failed;
 		}
-		extra_buffers_size += ALIGN(secctx_sz, sizeof(u64));
+		added_size = ALIGN(secctx_sz, sizeof(u64));
+		extra_buffers_size += added_size;
+		if (extra_buffers_size < added_size) {
+			/* integer overflow of extra_buffers_size */
+			return_error = BR_FAILED_REPLY;
+			return_error_param = EINVAL;
+			return_error_line = __LINE__;
+			goto err_bad_extra_size;
+		}
 	}
 
 	trace_binder_transaction(reply, t, target_node);
@@ -3480,6 +3489,7 @@ static void binder_transaction(struct binder_proc *proc,
 	t->buffer->transaction = NULL;
 	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
 err_binder_alloc_buf_failed:
+err_bad_extra_size:
 	if (secctx)
 		security_release_secctx(secctx, secctx_sz);
 err_get_secctx_failed:
-- 
2.21.0.593.g511ec345e18-goog

