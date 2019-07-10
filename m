Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E46AC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5895420844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQEuRN+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfGJP3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:29:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35050 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfGJP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:29:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so1424179plp.2;
        Wed, 10 Jul 2019 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MdOxKwqbOJNN62BREvj5/5BRN5rSH+WxFWM7LgBxf6E=;
        b=bQEuRN+ZyjSDUzUB+nFWoUt9QElahPH/MEYYOWzr4TOVj68xl9uPnaRUcNXcrq1N27
         7ilKTo/wOWhrjN8PVGPknnpfkj911znf0uuz5F6UMKaaSfm44NTArbTWafqgxnn5XzsC
         RnU09XrPn4/wiFFUw5PQLvnFb7buUFGVAavz/ViHVW1FImTOXlrJjmXEWezBKO3xHPan
         f7GeqtBvxnhzSxaDPmB4qMEg0VgL90tQL3kjgNGUmCoSOP52ZYo5kIPBFAgl6Vgg+1Vy
         4lDQU4+ZGdfbdkkcNRnTI304L3xdHQuWyTrFYYHUJveFfjgNFbgonOPyuM46+sUplxkf
         JFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MdOxKwqbOJNN62BREvj5/5BRN5rSH+WxFWM7LgBxf6E=;
        b=bDTUP0Y2XqJ/X0dt70AudnErPsfkfGm1Uu958PinB8/RlxZE6gO8QZspbdLCdp9jSR
         QaDKky+Jz6NxiuDCYUXA33YR89LvLnF+yKEne5eWWOzEEkU5gOmsjxtJoyu0G57xJmNg
         NzCOOa9ueFq+73/7iyejSTYyK6q8ffP1wcCF9v9Uyv2JwCkKczJ8b2pjAbrAwtPfAz+3
         irY//LM9hcy1CFN/aM2uJunX1wh4clUy3HESjTxJuMNn+ITl0SpYHtRuUublF3b7qe9m
         a5zhNwyav9kpL5ie/9KjbhIz3dL0XOSLxEEwi4himQLd9bwK15a6dqWVY/73F3ZyUpWm
         r7mg==
X-Gm-Message-State: APjAAAXkEcYzy+JlDbolBPsBDCNr0hdEDKzTlwBxlDadarkpIcDcTw4P
        9GOj1BFqRICEZfpjYolEQjE=
X-Google-Smtp-Source: APXvYqxMYBu3Ooy60D80xvsIIEqvdDL05QgVyHd28yhyf5WOVmagnAZax9URtoaoiXbk9Oe+ZUEHJA==
X-Received: by 2002:a17:902:e202:: with SMTP id ce2mr35861996plb.272.1562772560744;
        Wed, 10 Jul 2019 08:29:20 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id s6sm5755827pfs.122.2019.07.10.08.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jul 2019 08:29:19 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v3] Documentation: filesystems: Convert jfs.txt to
Date:   Wed, 10 Jul 2019 08:29:01 -0700
Message-Id: <1562772541-32144-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190710093323.7e5d6790@coco.lan>
References: <20190710093323.7e5d6790@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation of jfs.txt to reStructuredText
format. Added to documentation build process and verified with 
make htmldocs

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
Changes in v3:
        1. Reverted to minimally changed jfs.rst
        2. Used -M1 in git format-patch to show files as renamed

Changes in v2:
        1. Removed flat-table.
        2. Moved jfs.rst from filesystem to admin-guide

 Documentation/admin-guide/index.rst                |  1 +
 .../{filesystems/jfs.txt => admin-guide/jfs.rst}   | 44 ++++++++++++++--------
 2 files changed, 30 insertions(+), 15 deletions(-)
 rename Documentation/{filesystems/jfs.txt => admin-guide/jfs.rst} (51%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 8001917..2871b79 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -70,6 +70,7 @@ configure specific aspects of kernel behavior to your liking.
    ras
    bcache
    ext4
+   jfs
    pm/index
    thunderbolt
    LSM/index
diff --git a/Documentation/filesystems/jfs.txt b/Documentation/admin-guide/jfs.rst
similarity index 51%
rename from Documentation/filesystems/jfs.txt
rename to Documentation/admin-guide/jfs.rst
index 41fd757..9e12d93 100644
--- a/Documentation/filesystems/jfs.txt
+++ b/Documentation/admin-guide/jfs.rst
@@ -1,45 +1,59 @@
+===========================================
 IBM's Journaled File System (JFS) for Linux
+===========================================
 
 JFS Homepage:  http://jfs.sourceforge.net/
 
 The following mount options are supported:
+
 (*) == default
 
-iocharset=name	Character set to use for converting from Unicode to
+iocharset=name
+                Character set to use for converting from Unicode to
 		ASCII.  The default is to do no conversion.  Use
 		iocharset=utf8 for UTF-8 translations.  This requires
 		CONFIG_NLS_UTF8 to be set in the kernel .config file.
 		iocharset=none specifies the default behavior explicitly.
 
-resize=value	Resize the volume to <value> blocks.  JFS only supports
+resize=value
+                Resize the volume to <value> blocks.  JFS only supports
 		growing a volume, not shrinking it.  This option is only
 		valid during a remount, when the volume is mounted
 		read-write.  The resize keyword with no value will grow
 		the volume to the full size of the partition.
 
-nointegrity	Do not write to the journal.  The primary use of this option
+nointegrity
+                Do not write to the journal.  The primary use of this option
 		is to allow for higher performance when restoring a volume
 		from backup media.  The integrity of the volume is not
 		guaranteed if the system abnormally abends.
 
-integrity(*)	Commit metadata changes to the journal.  Use this option to
+integrity(*)
+                Commit metadata changes to the journal.  Use this option to
 		remount a volume where the nointegrity option was
 		previously specified in order to restore normal behavior.
 
-errors=continue		Keep going on a filesystem error.
-errors=remount-ro(*)	Remount the filesystem read-only on an error.
-errors=panic		Panic and halt the machine if an error occurs.
+errors=continue
+                        Keep going on a filesystem error.
+errors=remount-ro(*)
+                        Remount the filesystem read-only on an error.
+errors=panic
+                        Panic and halt the machine if an error occurs.
 
-uid=value	Override on-disk uid with specified value
-gid=value	Override on-disk gid with specified value
-umask=value	Override on-disk umask with specified octal value.  For
-		directories, the execute bit will be set if the corresponding
+uid=value
+                Override on-disk uid with specified value
+gid=value
+                Override on-disk gid with specified value
+umask=value
+                Override on-disk umask with specified octal value. For
+                directories, the execute bit will be set if the corresponding
 		read bit is set.
 
-discard=minlen	This enables/disables the use of discard/TRIM commands.
-discard		The discard/TRIM commands are sent to the underlying
-nodiscard(*)	block device when blocks are freed. This is useful for SSD
-		devices and sparse/thinly-provisioned LUNs.  The FITRIM ioctl
+discard=minlen, discard/nodiscard(*)
+                This enables/disables the use of discard/TRIM commands.
+		The discard/TRIM commands are sent to the underlying
+                block device when blocks are freed. This is useful for SSD
+                devices and sparse/thinly-provisioned LUNs.  The FITRIM ioctl
 		command is also available together with the nodiscard option.
 		The value of minlen specifies the minimum blockcount, when
 		a TRIM command to the block device is considered useful.
-- 
2.7.4

