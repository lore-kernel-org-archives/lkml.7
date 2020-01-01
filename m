Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5277EC2D0DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A572073D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia/fc+sU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgAAW0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:26:52 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:35024 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgAAW0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 17:26:48 -0500
Received: by mail-pg1-f179.google.com with SMTP id l24so21042131pgk.2;
        Wed, 01 Jan 2020 14:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+dkYv5HLHzNOWTER7d+8BqEGnKLKwfpZv5Uz3xEK7E=;
        b=ia/fc+sUcStdQiY1tRyj3gBK8XL+cN/P7Afp7l/5pUEUexWwwzTPk0TtNNLa9RJ9Zl
         10fSpovx1pR8Gv3QwyEFQ9gri0PJ2TpQNqmlbFPpe4xTxpbqbCR8Yn0n19zY7s5UvtiT
         thrF/RYf9JvJM8lxEdW3m2KS+Kv6k4mCo5s2K0uaB/PuXmPbiRh/DaxPaPJWRJTVQDVX
         NGiWj9S9LsK/CWxXYnrxMBgpiMiNm7td5XN8VaKOo5J5pNwRLRxnFKWauJ1KzVBOiCyD
         WIV4htAlm2N4oAL1BGzyV6H7FIaErK9SFKG++xLYxoUU7UOAHcU8+dluvso0PNehgI+B
         Ew2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+dkYv5HLHzNOWTER7d+8BqEGnKLKwfpZv5Uz3xEK7E=;
        b=jaU0GwmkUyHeiBW+nY9jVp/fLu/C/rGVdULgb4HSFQevBP6BhQWAVBVotbLUcJ4jAt
         KIceaTMwAlzFUV6XaSW2TQwqJX2YBXOF3TPwpyqg08akODEKdjDgVfIEN0E9gM8Ijxiu
         EbZgwxejCURdPywqrQ27lPj6VsOUsRPVk0gOPqLsOfvxM146zZI6OVSQ0GlvFXQk0t8u
         pZFhi1gKJ/NgZo9IiRq7pPPyCm3lCkLEUAI3JDoMcUWiJ560atOEuwAyjQN2+ecBIAVN
         WBri5GSDZKghnizULpY0j7XBf5plLJJ4Z4giH1dBFPRFecA6KKxrsz6XTuqriv0tdv6M
         L4og==
X-Gm-Message-State: APjAAAVIJ7P61lD0NSpdZ91cUGWvGsziqyAUuPAv8mHHg222X57QTTe1
        NPacZhj28gdcg1z6Z6XrD4I=
X-Google-Smtp-Source: APXvYqzst1YW5MTfyOVJ9oyIhHWFUBIalWaKhBwd2RW0ubsenUzXdgCWymwZV1GrDQLlZmlb0/3lhg==
X-Received: by 2002:aa7:870d:: with SMTP id b13mr65507563pfo.212.1577917607944;
        Wed, 01 Jan 2020 14:26:47 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id o2sm8601008pjo.26.2020.01.01.14.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:26:47 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 7/8] Documentation: nfs: pnfs-scsi-server: convert to ReST
Date:   Wed,  1 Jan 2020 19:26:14 -0300
Message-Id: <adbb8abe0f8bd4f58c79fd503822604bdd2b9bd4.1577917076.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577917076.git.dwlsalmeida@gmail.com>
References: <cover.1577917076.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert pnfs-scsi-server to ReST and move it to admin-guide. Content
remains mostly unchanged.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst                          | 1 +
 .../nfs/pnfs-scsi-server.rst}                                    | 1 +
 2 files changed, 2 insertions(+)
 rename Documentation/{filesystems/nfs/pnfs-scsi-server.txt => admin-guide/nfs/pnfs-scsi-server.rst} (97%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index f3bfd0f5a362..c96e93b61744 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -11,4 +11,5 @@ NFS
     nfsd-admin-interfaces
     nfs-idmapper
     pnfs-block-server
+    pnfs-scsi-server
 
diff --git a/Documentation/filesystems/nfs/pnfs-scsi-server.txt b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
similarity index 97%
rename from Documentation/filesystems/nfs/pnfs-scsi-server.txt
rename to Documentation/admin-guide/nfs/pnfs-scsi-server.rst
index 5bef7268bd9f..d2f6ee558071 100644
--- a/Documentation/filesystems/nfs/pnfs-scsi-server.txt
+++ b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
@@ -1,4 +1,5 @@
 
+==================================
 pNFS SCSI layout server user guide
 ==================================
 
-- 
2.24.1

