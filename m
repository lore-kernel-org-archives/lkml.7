Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA4FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C4320644
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxzyLfa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfHEH06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:26:58 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:44157 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:26:57 -0400
Received: by mail-pg1-f178.google.com with SMTP id i18so39251082pgl.11;
        Mon, 05 Aug 2019 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EimvqE0jwyqP2WGVedMuh7qrn6YSjJuzP7Su4aO08UA=;
        b=PxzyLfa7re80m4D/ZGKf2uK1mGVnjoa23fNDxiw41OD6EYPoVxEksmkmpjZXTZJr3d
         f35V4qcpVFb1fWfZvDv+6oPRtrusv3q7rJtlen32b+gK3sn2PG3lwNUDPqGKyadLvvjV
         zTavhVtYpLjrovjEYS+rromXBFnHjMigjkUQYyv7AtaiVmGJD0d011li/a1Ldvoy5Bd0
         tLcxrBTk0RLH6q+Uro0RKlEQcY4L2Sg58j43ckvIRI45UW53CWldSZhbm4xo39YulDF4
         1hiIhZgj3sQfyUMFguThXe0LxeL28bXfxyS+DxT446cTVLRIjm+syT0sq7bCT752RAIB
         ZpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EimvqE0jwyqP2WGVedMuh7qrn6YSjJuzP7Su4aO08UA=;
        b=SC7f8faNYRSkTsFXtnLq3LkPGTeZmIxUfMLksWfpFSyL1pVnojLS0z99MVjNX+6JKs
         o4fJoZXTn32yvwJY3TzdSbbhlenjV501d7Kd0ePQhDDCpMbQVxuGAxHkRXmixe0X2w3q
         221iGNeUqzEuJ22DYmfDnOVMdciquiHTYOZi7KYSJ8MY+3mDORTKzojWTt7MZkgGLSsq
         IpzBYzqTkfLAkeHZLbfZH9xTJNjXYDPF7mOlBd84ppOGYrLVJb+ZDxNyq9aAQpHn7fIr
         jphpOkBXyDJ6d2NeJkP+jQ9WmK/wTqaue5u93O2qeMYXSdmzWjm/vKXnqbgXG5D9KvoE
         VBxw==
X-Gm-Message-State: APjAAAXoRjWkQCGOahRd+bU1p1f6cTz6fkmaYJX33sH9o6bGzJOLQRsJ
        RiE6cZYdHOBwnHXcS6LYepWKzUg9yt9scg==
X-Google-Smtp-Source: APXvYqyiGHjzQnzFsluj5XM90F8t6hyJvvi+Lq6zx2SX9OAWkCqaHYGp6mt9zRTsPtj1MgZ6nW2LUQ==
X-Received: by 2002:a63:c006:: with SMTP id h6mr4759884pgg.290.1564990016921;
        Mon, 05 Aug 2019 00:26:56 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id x25sm113662267pfa.90.2019.08.05.00.26.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 00:26:55 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] Documentation/checkpatch: Prefer str_has_prefix over strncmp
Date:   Mon,  5 Aug 2019 15:26:45 +0800
Message-Id: <20190805072645.32691-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "strncmp() on string prefix" to
Documentation/process/deprecated.rst since using strncmp()
to check whether a string starts with a prefix is error-prone.
The safe replacement is str_has_prefix().

Also add check to the newly introduced deprecated_string_apis
in checkpatch.pl.

This patch depends on patch:
"Documentation/checkpatch: Prefer stracpy/strscpy over
strcpy/strlcpy/strncpy."

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Use "strncmp() on string prefix" instead of
    "strncmp()" to make it more precise.
  - Remove "c:func" and use "strncmp" directly
    in description.

 Documentation/process/deprecated.rst | 8 ++++++++
 scripts/checkpatch.pl                | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 56280e108d5a..96fa32aba189 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -109,6 +109,14 @@ the given limit of bytes to copy. This is inefficient and can lead to
 linear read overflows if a source string is not NUL-terminated. The
 safe replacement is stracpy() or strscpy().
 
+strncmp() on string prefix
+--------------------------
+strncmp() is often used to test if a string starts with a prefix by
+strncmp(str, prefix, length of prefix). This is error-prone because length
+of prefix can have counting error if using a constant length, or use
+sizeof(prefix) without - 1. Also, if the prefix is a pointer, sizeof(prefix)
+leads to a wrong size. The safe replacement is str_has_prefix().
+
 Variable Length Arrays (VLAs)
 -----------------------------
 Using stack VLAs produces much worse machine code than statically
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0ae9ae01d855..38e82d2ac286 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -609,6 +609,7 @@ our %deprecated_string_apis = (
 	"strcpy"		=> "stracpy or strscpy",
 	"strlcpy"		=> "stracpy or strscpy",
 	"strncpy"		=> "stracpy or strscpy - for non-NUL-terminated uses, strncpy dest should be __nonstring",
+	"strncmp"		=> "str_has_prefix",
 );
 
 #Create a search pattern for all these strings apis to speed up a loop below
-- 
2.20.1

