Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BTC_ID,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A089C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AFA21835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8+wwL2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLFNFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:05:03 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:34081 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfLFNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:05:03 -0500
Received: by mail-vs1-f74.google.com with SMTP id f24so797757vsk.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 05:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1KX2oVUMaou01lixSYTFwapcBrG5FrybP5vWFBurigw=;
        b=v8+wwL2q9iG843UGD4A0cogB3dxJSmi2LipG5QFco6E/i+nwbeY3esudqL8m5tu+Cm
         MppitP4cF9bwXbPW8OlNOTBoKY3jQove2CgxRlOHygymF38AwTamn9rpw8nHWMSiCBYs
         XrLyEnuJYGHFi9nHT50zrqMRwESibfcb5C4HD2x+HBqcW94pUj90Wtxc5xuliyCeZE/o
         OBOaQMZbU9J1Y/svvv22OAPzXH7evpztB1kfZ+omGab2ntS+a+NMtc4QkXDQaIH5mSsV
         9UpEl2NpIkQ0ZAUVS25f56Uyj/YQOe1ENmBywJyQk/0soUQNdnQZDIM/xrEXdwhDOzvG
         rM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1KX2oVUMaou01lixSYTFwapcBrG5FrybP5vWFBurigw=;
        b=H/y5mwxXXUCRU3gLmYFjWkQV5DjFMhbGaQDp7r3gO1434RM1EqmPsNj7y/UJx8nDlG
         iq9GvKNGSpKTxm5VLmUri4VswYSdJSnbvL946KtT4019//LoaN88L0WFuzm5jf4GKHwz
         MeKN8dO5egD1l9wbxsUetlVbbjzv+oX+rH0+GTiSySvjQYOAd8ERE88yyCv+E6m1GB+s
         gtpIkTyANCAwODBED5X6EWjqRMRY21oiZkpQeR6ZLwLYVOFMbrNCNPk3N6BXQiHc47or
         eiFkkUEBQ8u6SwAgdcsFfuCN4osU1/n76qZiCG4kIr/UKNLbRSsndgolguwNTyYvhnqr
         v7JA==
X-Gm-Message-State: APjAAAXd5BSngARYuQZGEaYJfC2XaWBRgk/7xCEf03m5HoBZIEmlZQ1e
        M7KVuSlPvOVukYWDDG8DZmgrEL69CVOo6DJ6
X-Google-Smtp-Source: APXvYqwTz5S212JljRgo8MkMqgT/kgtrmX3IVxk8KOyn3ROS+fMUaZUiAaz+e+zBtwgm/4O1yQ5CpD+lBe+TQ/9r
X-Received: by 2002:a1f:1e13:: with SMTP id e19mr11541636vke.88.1575637501944;
 Fri, 06 Dec 2019 05:05:01 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:04:55 +0100
Message-Id: <46cee2a09d53921057cd4b87d1ed3796a2ab15bb.1575637022.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] kcov: fix struct layout for kcov_remote_arg
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
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

Hi Andrew,

We've noticed failures on 32 bit syzbot instances when the kcov patches
got merged into mainline. The reason is that the layout of kcov_remote_arg
depends on the alignment rules, which are different for 32/64 bit code.
We can deal with this issue in syzkaller [1], but I think it would be
cleander to get this fixed in the kernel.

I hope this patch is acceptable, since the change has just been merged and
is not included into a release kernel version. The patch breaks the newly
introduced kcov API for 32 bit apps.

Sorry for not testing it with 32 bit code earlier.

Thanks!

[1] https://github.com/google/syzkaller/commit/ba97c611a36b7729d489ebca5f97183c2ba7a90a

 Documentation/dev-tools/kcov.rst |  7 ++++---
 include/uapi/linux/kcov.h        | 11 ++++++-----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 36890b026e77..744df2bae1ed 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -251,9 +251,10 @@ selectively from different subsystems.
 .. code-block:: c
 
     struct kcov_remote_arg {
-	unsigned	trace_mode;
-	unsigned	area_size;
-	unsigned	num_handles;
+	uint32_t	trace_mode;
+	uint32_t	area_size;
+	uint32_t	num_handles;
+	uint32_t	reserved;
 	uint64_t	common_handle;
 	uint64_t	handles[0];
     };
diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
index 409d3ad1e6e2..53267f9f1665 100644
--- a/include/uapi/linux/kcov.h
+++ b/include/uapi/linux/kcov.h
@@ -9,11 +9,12 @@
  * and the comment before kcov_remote_start() for usage details.
  */
 struct kcov_remote_arg {
-	unsigned int	trace_mode;	/* KCOV_TRACE_PC or KCOV_TRACE_CMP */
-	unsigned int	area_size;	/* Length of coverage buffer in words */
-	unsigned int	num_handles;	/* Size of handles array */
-	__u64		common_handle;
-	__u64		handles[0];
+	__u32	trace_mode;	/* KCOV_TRACE_PC or KCOV_TRACE_CMP */
+	__u32	area_size;	/* Length of coverage buffer in words */
+	__u32	num_handles;	/* Size of handles array */
+	__u32	reserved;
+	__u64	common_handle;
+	__u64	handles[0];
 };
 
 #define KCOV_REMOTE_MAX_HANDLES		0x100
-- 
2.24.0.393.g34dc348eaf-goog

