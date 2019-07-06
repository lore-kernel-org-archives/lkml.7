Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF6DC5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 23:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F0820830
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 23:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="actA2lL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfGFXWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 19:22:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42127 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGFXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 19:22:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so5810496pgb.9;
        Sat, 06 Jul 2019 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RTOGUsYK/1YwgJdb8s4i6p4JdybmFRu4cjbcwuO4ysU=;
        b=actA2lL5SxzvOGPac8eYvqD7Zhxq9pGgQPpNitg5D/MC4U6ZjHbshh1ICgAnK3+PhQ
         NyVFXRcjrT51LHY7T6e9Fw32yHLlnni3eu09kpry0wc0zyu+oWdJEJyfEzUab62N2GsL
         UB9nz2rlvn6H60/Rtvy+e64sTVbgwNwtXAlp49rSokjiImXprGWZPkTA+9V8x6NS032C
         Jfc8O7tO7Hli390P6ofVNkvjTHyUowSjowjEN/TWhZV4QsFvj1jZ83H4hoVqIpseMqCP
         Rn3Qj2CAAIYI5iGUCaNBHnkZOpJIDsggJSqoJTu8WHkvMGGKIgGEomIBmyR9xByjGQbF
         sYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RTOGUsYK/1YwgJdb8s4i6p4JdybmFRu4cjbcwuO4ysU=;
        b=S3Q4MBFrSgjmZCsc6GtHbxXZ0aNy7R62uDPfKtsUMZQnsYE8f7XcT6/uiAXH7ZjE53
         1+DujFcnvROE+7kH2iyjdL8/fMq97U7/1dHBuYzjBUuv3g4sJON0U56LOBmnoGSAx6RA
         IZYxxxfW9meIJEDwrBRwCSYCYqiNCZCEPbzmI46ckDTudojGd2AJ3gXKJvCQw7vjVdV/
         Gc1UGVHVtodcrTtAwFHRiKAPYhfgZ7bQX49AhgPM6uI8pyL6sRHI3YQ4w11kUSwy9sFF
         7fR9/2/H+CPMPIrc8qTjB6I980jcN7teqEFfoALm1xAOLjMNqz1e724duw+khDSAi9rQ
         fNoA==
X-Gm-Message-State: APjAAAXk0pH86JH+rtlSERiX98w3zqihnBbb7IEHmAICnQni43TATyLJ
        4yo2NCby3lW5CG9cdlPNyrE=
X-Google-Smtp-Source: APXvYqwtZcCuv0nuK4tHMFVURpG/icf6qlS2NWpt7vCSnvHNqx9mpA3BzRQ+AiXIsevA2tIQvPmgCQ==
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr14414916pjg.116.1562455362586;
        Sat, 06 Jul 2019 16:22:42 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id v14sm5282828pfm.164.2019.07.06.16.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 16:22:41 -0700 (PDT)
Date:   Sat, 6 Jul 2019 16:22:39 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shobhitkukreti@gmail.com
Subject: [Linux-kernel-mentees] [PATCH] Documentation: filesystems: Convert
 jfs.txt to reStructedText format.
Message-ID: <20190706232236.GA24717@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation of jfs.txt to reStructuredText format.
Added to documentation build process and verified with make htmldocs

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 Documentation/filesystems/index.rst |  1 +
 Documentation/filesystems/jfs.rst   | 74 +++++++++++++++++++++++++++++++++++++
 Documentation/filesystems/jfs.txt   | 52 --------------------------
 3 files changed, 75 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/filesystems/jfs.rst
 delete mode 100644 Documentation/filesystems/jfs.txt

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1131c34..d700330 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -41,3 +41,4 @@ Documentation for individual filesystem types can be found here.
    :maxdepth: 2
 
    binderfs.rst
+   jfs
diff --git a/Documentation/filesystems/jfs.rst b/Documentation/filesystems/jfs.rst
new file mode 100644
index 0000000..bfb6110
--- /dev/null
+++ b/Documentation/filesystems/jfs.rst
@@ -0,0 +1,74 @@
+===========================================
+IBM's Journaled File System (JFS) for Linux
+===========================================
+
+JFS Homepage:  http://jfs.sourceforge.net/
+
+Following Mount Options are Supported
+
+(*) == default
+ .. tabularcolumns:: |p{1.3cm}|p{1.3cm}|p{8.0cm}|
+
+.. cssclass:: longtable
+
+.. flat-table::   
+  :header-rows:  0
+  :stub-columns: 0
+  
+  * - iocharset
+    - =name
+    - Character set to use for converting from Unicode to ASCII. The default is to do no conversion. Use iocharset=utf8 for UTF-8 translations. 
+      This requires CONFIG_NLS_UTF8 to be set in the kernel .config file. iocharset=none specifies the default behavior explicitly.
+
+  * - resize
+    - =value
+    - Resize the volume to <value> blocks. JFS only supports growing a volume, not shrinking it. This option is only valid during a remount, 
+      when the volume is mounted read-write. The resize keyword with no value will grow the volume to the full size of the partition.
+	
+  * - nointegrity
+    -            
+    - Do not write to the journal. The primary use of this option is to allow for higher performance when restoring a volume from backup media. 
+      The integrity of the volume is not guaranteed if the system abnormally abends.
+
+  * - integrity
+    - (*)  
+    - Commit metadata changes to the journal. Use this option to remount a volume where the nointegrity option was previously specified in order 
+      to restore normal behavior.
+
+  * - errors
+    - =continue		
+    - Keep going on a filesystem error.
+
+  * - errors
+    - =remount-ro(*)
+    - Remount the filesystem read-only on an error.
+	
+  * - errors
+    - =panic
+    - Panic and halt the machine if an error occurs.
+
+  * - uid 
+    - =value
+    - Override on-disk uid with specified value
+
+  * - gid 
+    - =value
+    - Override on-disk gid with specified value
+
+  * - umask
+    - =value
+    - Override on-disk umask with specified octal value. For directories, the execute bit will be set if the corresponding read bit is set.
+
+  * - discard 
+    - =minlen
+    - :rspan:`1` :cspan:`1` This enables/disables the use of discard/TRIM commands.The discard/TRIM commands are sent to the underlying block device when blocks 
+      are freed. This is useful for SSD devices and sparse/thinly-provisioned LUNs. The FITRIM ioctl command is also available together with the nodiscard option.
+      The value of minlen specifies the minimum blockcount, when a TRIM command to the block device is considered useful. When no value is given to the 
+      discard option, it defaults to 64 blocks, which means 256KiB in JFS. The minlen value of discard overrides the minlen value given on an FITRIM ioctl()
+   
+  * - nodiscard(*)
+    -
+      
+
+The JFS mailing list can be subscribed to by using the link labeled
+"Mail list Subscribe" at our web page http://jfs.sourceforge.net/
diff --git a/Documentation/filesystems/jfs.txt b/Documentation/filesystems/jfs.txt
deleted file mode 100644
index 41fd757..0000000
--- a/Documentation/filesystems/jfs.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-IBM's Journaled File System (JFS) for Linux
-
-JFS Homepage:  http://jfs.sourceforge.net/
-
-The following mount options are supported:
-(*) == default
-
-iocharset=name	Character set to use for converting from Unicode to
-		ASCII.  The default is to do no conversion.  Use
-		iocharset=utf8 for UTF-8 translations.  This requires
-		CONFIG_NLS_UTF8 to be set in the kernel .config file.
-		iocharset=none specifies the default behavior explicitly.
-
-resize=value	Resize the volume to <value> blocks.  JFS only supports
-		growing a volume, not shrinking it.  This option is only
-		valid during a remount, when the volume is mounted
-		read-write.  The resize keyword with no value will grow
-		the volume to the full size of the partition.
-
-nointegrity	Do not write to the journal.  The primary use of this option
-		is to allow for higher performance when restoring a volume
-		from backup media.  The integrity of the volume is not
-		guaranteed if the system abnormally abends.
-
-integrity(*)	Commit metadata changes to the journal.  Use this option to
-		remount a volume where the nointegrity option was
-		previously specified in order to restore normal behavior.
-
-errors=continue		Keep going on a filesystem error.
-errors=remount-ro(*)	Remount the filesystem read-only on an error.
-errors=panic		Panic and halt the machine if an error occurs.
-
-uid=value	Override on-disk uid with specified value
-gid=value	Override on-disk gid with specified value
-umask=value	Override on-disk umask with specified octal value.  For
-		directories, the execute bit will be set if the corresponding
-		read bit is set.
-
-discard=minlen	This enables/disables the use of discard/TRIM commands.
-discard		The discard/TRIM commands are sent to the underlying
-nodiscard(*)	block device when blocks are freed. This is useful for SSD
-		devices and sparse/thinly-provisioned LUNs.  The FITRIM ioctl
-		command is also available together with the nodiscard option.
-		The value of minlen specifies the minimum blockcount, when
-		a TRIM command to the block device is considered useful.
-		When no value is given to the discard option, it defaults to
-		64 blocks, which means 256KiB in JFS.
-		The minlen value of discard overrides the minlen value given
-		on an FITRIM ioctl().
-
-The JFS mailing list can be subscribed to by using the link labeled
-"Mail list Subscribe" at our web page http://jfs.sourceforge.net/
-- 
2.7.4

