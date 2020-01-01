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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1200FC2D0DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1F4206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBTDe8pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgAAW0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:26:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34752 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgAAW0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 17:26:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so17124954pln.1;
        Wed, 01 Jan 2020 14:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snbkD8gIui2ODoVtFZ3ZclnMOMYPIMsUQlwjXFjRHYQ=;
        b=eBTDe8pp2rNywyNFGle2C7u8CBH4ftWl4VYuR554lcM2xZRdEXvVirnzI4GRE2nBCN
         V5bhKtGLx5QKBeNfrW1d6pGClUc3cpAyfj5UiyZmFZJhghgQH3YXFqei25w/X6B59AcP
         Bu/utuuwZOxS6zQtu6giD8dN48dd9+f9kl8bmj9+bwPmRk8wbcfMlF2x2Mp9B+PNnKx6
         /g0fHtFn6hz1Y86mNK+sGTkrkfFQRsjiNEAIslz8OizEDN9V4CiJCCx+wYTcfI8NYOSi
         lSCWna39oyjak1uw6Eo0cCc9eCJ7fDS6Fijj/IrQ5gNHSIgQwWJ0qapvV9XzsJuhuX/N
         27pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snbkD8gIui2ODoVtFZ3ZclnMOMYPIMsUQlwjXFjRHYQ=;
        b=VRGaGuznrHbqFeRyCUigKSoOxoEvSyNa9LI/nCE/tjvrbguJJM1sgmmsMr3tOxhuwB
         omkWwqfFp204UWFliaffo/A2SFKi1dkOKAY4GvENS1FmFwPIndiD2X72Kw36JvNNvEVU
         Hswo5qrZGzSnCp4sXxarChgAdO9zkOvjT93MO1vXPL6mN+M5ATghGt/O5ghRhFTOK5S+
         duqpLQhOUeUJxRKIY4cbxLcP1Nq9ksmTlau2VFPiJuUROunH2onz2EiIy0uK8M1/81p2
         b04KN1+1H3wHk7FiH2O88TSQB2y7eiL0Az9g15hlwHhHWSCCYKFgbcaZeyelXKnZ6TMB
         ne9A==
X-Gm-Message-State: APjAAAVe8tmn1NGMVrz559+0nEqT7BhIpysVfsBrujUre6G9jqmZs87N
        nXIfb1heqbJ4M61Cn6J7LuQ=
X-Google-Smtp-Source: APXvYqy8jwYypGRbQcwyGcw+xWP3k4SZYRrnlf45+ctDz2g5G6VcuouZ+F7L3ssZ6KdtWm9qtpgvpg==
X-Received: by 2002:a17:902:7b8c:: with SMTP id w12mr75669626pll.30.1577917591740;
        Wed, 01 Jan 2020 14:26:31 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id o2sm8601008pjo.26.2020.01.01.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:26:31 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 2/8] Documentation: nfsroot.rst: COSMETIC: refill a paragraph
Date:   Wed,  1 Jan 2020 19:26:09 -0300
Message-Id: <83802f7451f8ce78c989a0983e6876d8dd0576aa.1577917076.git.dwlsalmeida@gmail.com>
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

Refill a paragraph to eliminate long lines.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/nfsroot.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index cdbfa0c67186..657309759f6e 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -15,13 +15,14 @@ Mounting the root filesystem via NFS (nfsroot)
 
 
 
-In order to use a diskless system, such as an X-terminal or printer server
-for example, it is necessary for the root filesystem to be present on a
-non-disk device. This may be an initramfs (see Documentation/filesystems/ramfs-rootfs-initramfs.txt),
-a ramdisk (see Documentation/admin-guide/initrd.rst) or a
-filesystem mounted via NFS. The following text describes on how to use NFS
-for the root filesystem. For the rest of this text 'client' means the
-diskless system, and 'server' means the NFS server.
+In order to use a diskless system, such as an X-terminal or printer server for
+example, it is necessary for the root filesystem to be present on a non-disk
+device. This may be an initramfs (see
+Documentation/filesystems/ramfs-rootfs-initramfs.txt), a ramdisk (see
+Documentation/admin-guide/initrd.rst) or a filesystem mounted via NFS. The
+following text describes on how to use NFS for the root filesystem. For the rest
+of this text 'client' means the diskless system, and 'server' means the NFS
+server.
 
 
 
-- 
2.24.1

