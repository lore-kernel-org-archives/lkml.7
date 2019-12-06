Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0450BC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF89D205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aq5hmJ8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLFNbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:31:15 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:44922 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLFNbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:31:14 -0500
Received: by mail-qk1-f201.google.com with SMTP id q13so4421906qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 05:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OuMl2Padgi2F86LngiXW/rNKGPqLqyPoo2tKLqo+OZ0=;
        b=aq5hmJ8/VLFT+W7QgPHzcpnRBd7dANE61topUxdtfQql1yj91FQAEXDVn9EicxiMhZ
         xurBhpeq7rANhxnf+7uxkxe5txTE/ynIHd+exOTEYUIi7PZ2I3qgF8qYRPL6XP8Heg9N
         hFmzWsK1AXYnb1Du/Xh4YAUS8f4bf2LzzSD4c1KzHAMkrZKBfpbb9hqXABIjgn3Hji6H
         bKL67YNg6+sGguM3Ar83PaxGR3x7Yhx4t/xJ07wStJOSZBDnPMNF/1JqB+P16ZjNbQaY
         c/EhzeWtQyPQkLzFS970HBgRD2k8IyVLkfQ6l7njD6M8COrqs+RZer7RDPvH+Tueyqli
         jQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OuMl2Padgi2F86LngiXW/rNKGPqLqyPoo2tKLqo+OZ0=;
        b=dPHrJ6pJvEOxkqwi93YwTj63mgGumnHZs9ZY4sgLGzECS3n2c/vELYGJOdoivGid2n
         N4SITQCNco6qkwsabs7DsvM10CDd2t34GrPiz0aAS4cE99X64rlibznGx1UjkatthHDO
         HQpqLFUV63xSaNKHkO/tyw0NswrD13I79g2ULTYTLdlEMxMxjyY10sKtGJdo2KKd20J0
         Cq1o9zFqp3wWBeH8hoDovqtia+Vo50Yqb87k7wSUr6gQzg9QkN0Ow7Co96jnmjSHG2VX
         1Sq2o6X9uLuRpkrGOJ42PquMwgHJyzDVIc5+c+9IoHZj+1xBn3L5VAEWBE9xZeuOZDsF
         b5Dg==
X-Gm-Message-State: APjAAAUxFi29iRn1oyjoM+/nTVmgVwhoLhxYjPIuqzI80hqFfByNtHF/
        aVidjAX3gQJJPyNsz3lyIKL1rkRyhcx6q6IT
X-Google-Smtp-Source: APXvYqzMp0oW8UTSsFXrzpQYp4Gyrxm04PWtL4iunaDNSy7yDWnj6tE5mH3i/jWKt7xBBt3heTmpptyZOljrCFJX
X-Received: by 2002:a0c:b455:: with SMTP id e21mr12584924qvf.72.1575639073416;
 Fri, 06 Dec 2019 05:31:13 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:31:09 +0100
Message-Id: <9e91020876029cfefc9211ff747685eba9536426.1575638983.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2] kcov: fix struct layout for kcov_remote_arg
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the layout of kcov_remote_arg the same for 32-bit and 64-bit code.
This makes it more convenient to write userspace apps that can be compiled
into 32-bit or 64-bit binaries and still work with the same 64-bit kernel.
Also use proper __u32 types in uapi headers instead of unsigned ints.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes v1->v2:
- Use __aligned_u64 instead of adding a __u32 reserved field.

 Documentation/dev-tools/kcov.rst | 10 +++++-----
 include/uapi/linux/kcov.h        | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 36890b026e77..1c4e1825d769 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -251,11 +251,11 @@ selectively from different subsystems.
 .. code-block:: c
 
     struct kcov_remote_arg {
-	unsigned	trace_mode;
-	unsigned	area_size;
-	unsigned	num_handles;
-	uint64_t	common_handle;
-	uint64_t	handles[0];
+	__u32		trace_mode;
+	__u32		area_size;
+	__u32		num_handles;
+	__aligned_u64	common_handle;
+	__aligned_u64	handles[0];
     };
 
     #define KCOV_INIT_TRACE			_IOR('c', 1, unsigned long)
diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
index 409d3ad1e6e2..1d0350e44ae3 100644
--- a/include/uapi/linux/kcov.h
+++ b/include/uapi/linux/kcov.h
@@ -9,11 +9,11 @@
  * and the comment before kcov_remote_start() for usage details.
  */
 struct kcov_remote_arg {
-	unsigned int	trace_mode;	/* KCOV_TRACE_PC or KCOV_TRACE_CMP */
-	unsigned int	area_size;	/* Length of coverage buffer in words */
-	unsigned int	num_handles;	/* Size of handles array */
-	__u64		common_handle;
-	__u64		handles[0];
+	__u32		trace_mode;	/* KCOV_TRACE_PC or KCOV_TRACE_CMP */
+	__u32		area_size;	/* Length of coverage buffer in words */
+	__u32		num_handles;	/* Size of handles array */
+	__aligned_u64	common_handle;
+	__aligned_u64	handles[0];
 };
 
 #define KCOV_REMOTE_MAX_HANDLES		0x100
-- 
2.24.0.393.g34dc348eaf-goog

