Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA8C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99995217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUQhdumz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfEJWiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:38:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34786 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfEJWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:37:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so3944198pfa.1;
        Fri, 10 May 2019 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYzIDdOTRwO65NdizYfpyEQ5dTtiEK69uQtVOuzEYqI=;
        b=UUQhdumzD9b5p2zhHSlGdfcKIBwD6/zTIi+Swjo4qnscsSfa7EHxRwWneSwXNWFNIS
         Xfq9mRFm6jf3OumMOcoGkYLqOCFexT42JZ6Nll4EnYURL2W0OiOYgSW1bxmwkEs41Gsy
         k5jLbVUUSY1HkA6ILWuFXhNcWtF+6kU8SA8d1E/NSEkoxG6yLomMi+PFUmJZU4hhuKGz
         rf198bOnrBJnITupC99aoANMsnRDaNxo8xV4o4TUMQrtK+tvybKPAzFK+6kR5dKgrIMw
         2dlQM6gGQR80LmGPyBBYoW76tVB2QXnKhRK7AUJk97dpzBS1WKjqefOj84n5POSQ0JN4
         tf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYzIDdOTRwO65NdizYfpyEQ5dTtiEK69uQtVOuzEYqI=;
        b=CZk/zA8NO5UM889h5LXeRs/GfHDErezLeJxdjUKd8lFrjfi2JmnjceadCjb2uT4QKw
         nJtAZ4zOqgT8RPQOp7smOjycCFTQjgEJ1GRB8wM08MdVN75mAi3TSRmW7sPQGmTQdsUR
         T9f7hGkVo2rqW+aLFFg7LenVeNFvNUoRLsKayhpOxYaPN4kZNqykqZmHrN8TdHF4hL+t
         PaXjJnN8A9NgVyxvraOv+gRbZefExrWKgTEIo+fOoRTu56d1tB+DEWp2/BooY5LjKWoc
         fkeF6utvuJAe1460YUg7j6UjAB4PO5drWYnQUOXY7EWqTIgvsuYPiglr4sdXQXC2bZu5
         7J6g==
X-Gm-Message-State: APjAAAUHn8HEeKUDhe5AZx+0uWwCMTeB8Zs9kenXYnqvdVfUHgkJQ5EB
        81SspVETPWbZJSVMBRxzmT/vyVCZokM=
X-Google-Smtp-Source: APXvYqxrdDf0YONK+/+mdOzYixpMoTJODFTIHOMdzCJ3pwx4Ds4toOexA6ae1KE1KfganUQbRnP5ow==
X-Received: by 2002:a65:4649:: with SMTP id k9mr16733096pgr.239.1557527878915;
        Fri, 10 May 2019 15:37:58 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:a:1d1b:db59:93e9:eab5])
        by smtp.gmail.com with ESMTPSA id r74sm12459430pfa.71.2019.05.10.15.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:37:58 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        prsriva@microsoft.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 3/3 v5] call ima_kexec_cmdline from kexec_file_load path
Date:   Fri, 10 May 2019 15:37:44 -0700
Message-Id: <20190510223744.10154-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510223744.10154-1-prsriva02@gmail.com>
References: <20190510223744.10154-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

To measure the cmldine args used in case of soft reboot. Call the 
ima hook defined in [PATCH 1/3 v5]:"add a new ima hook and policy to measure the cmdline"

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 kernel/kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1d0e00a3971..e779bcf674a0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -241,6 +241,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		ima_kexec_cmdline(image->cmdline_buf, image->cmdline_buf_len - 1);
 	}
 
 	/* Call arch image load handlers */
-- 
2.20.1

