Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AB5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CC6217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l//G//2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbfCZS2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:18 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55782 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732642AbfCZS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:13 -0400
Received: by mail-pl1-f201.google.com with SMTP id m37so2642377plg.22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iaaF5/aYD/K1PTKwNLEWQdX8WLqLGYfc09hndKsTKvo=;
        b=l//G//2sHdyapUFBKmU1Oe0w93NOV++WkMVLG4McMk+SBsjMEM+vwC89tGHOeX4bX3
         iLq2kDF27llh4VMpGE2JN5mQSXFfsQXQ6lDhYGtVWKn+8k364eUUUUFwWmvoQAg6NLmf
         GHIbF9CfAVLYRRoFqCFAY1gOfCMug1s/siggmuBq1Znm3Cu8YRUYsq7EpMo/6j7VjBef
         lCBHnMX9WL8pjUdPRK6ORN67KC8xL61mOXGev20Lw8Mkp0N+UiHfZzP3hC5VMfvpsnuf
         ki1fbB3JpuJVLdbavBWsVnzqyTLpzCb7ODNS0Q+LbzEj0FoHeMceWgWYlYk7kiTux4VE
         KGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iaaF5/aYD/K1PTKwNLEWQdX8WLqLGYfc09hndKsTKvo=;
        b=TNrRKQYcrACZJ4nXsG+t1oXlvCkSfhsLcAjc4hXuznBb/jsccq09s3Xf/19SdpTWKN
         ziLi/VUgQP+un+sqHcphIyIXfpsIRm2r0WBneGxzyER3IMxqSannOQFRJHcx0eDr7eAe
         cMYDlZ2KeAmTDDf/fY1jPMlSwZO8np6ZFe3NdgUFAjTLBfPXGWkXMIsXG1sxh5HVOto4
         EOBI9kyhlJ5bIxr4GEmAGvLdJjivegqcDPrUONpshQOd3K2SYsMvdyegSi/45k7I5VWc
         D3B5k1AoViqXKwpFw3QHxBEW5hWhI/Lqob+F4c0k6bjorZOxgcqRuKIOgsF37O4FCMCu
         ZqBQ==
X-Gm-Message-State: APjAAAWtmwyzehMu52jIbECuZ2gxKc6w2P+NJvA/6buG+2JDHSGg29bX
        jF6soGiy4Y51zfvkOdq4uWpsGRuKmSYN2LrU2VUzFQ==
X-Google-Smtp-Source: APXvYqx/+tjzXSZCjrL8Cln0/kVVOU3RI7T0H+0YpsU3UDmguRWm19jB1kNMcF+CVt78WKXvE7FVTtk8kfMkEo40fzSgPQ==
X-Received: by 2002:a63:2747:: with SMTP id n68mr29116516pgn.317.1553624892782;
 Tue, 26 Mar 2019 11:28:12 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:23 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..a1cc37c8b43b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+
+		if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.21.0.392.gf8f6787159e-goog

