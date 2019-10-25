Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2166A21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9ZQiH/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393338AbfJYFrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 01:47:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38602 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390519AbfJYFrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:47:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id c13so820978pfp.5;
        Thu, 24 Oct 2019 22:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qe1lmKsZUaERAxAUcKRdpJvWIJ7qs6SCkPADimNPizQ=;
        b=V9ZQiH/F2LGNkoGRvzMwckK4XfIKvmi/biZUn7MUFSxWn6EIJ1WgFOoPjeEEpIFLtm
         YmIYOqbm6iwTaLUfY6QE24ZnTDoeGrfSszgui8PG8Ab/rL4jrNFJjhwi9W6mTgNUAzNC
         5kuY+hvsJCo0ubikDl6QP/Ihj5mDF2hMZk+J0xDxeJJJ5sIotJiR/geqhXfuo4w3Yiy6
         /me5B/SxbKUJMFKuDkf3edEFky0czjP1iJw9/qDPF80BXDWBWHY5YZt138BSez0oc1a2
         +nRqTRA+Chshm2gMk+kEYE2/yJ9cCaXDqKPrBFpKGGPx1GXsgapUcElewI34XW4eMAbZ
         UwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qe1lmKsZUaERAxAUcKRdpJvWIJ7qs6SCkPADimNPizQ=;
        b=aCbO9+mh5pv9o15ZFSMDp7uTJLj9Q80NM0cxF+WQKiDGTnwWQRT8opW835b1srdmHJ
         zHuxDq05+dPGK1quuPFSzgKUXCtQgttdirIViqyIBtde8E9IDFD1apfJ8rlZlcqy0ke7
         PXv6vREce+SBatkgmA2NlYz81sMU9JyKsqoBsmf5ARYM45GlDA05mJltwFrBMQMpVWwJ
         XFmIeJIxS2bbzoHxJTzwZaXzv0bd9/vieKP68aqnLcN5zrssSxi3BKyD5eN5AwOvsaQc
         qf+guzV3vsG8v2ksNDQtVCuHXe1bLAZEu+0rELncpJUx6flquD0SOz8IRDLfdSc+/ME0
         eO1Q==
X-Gm-Message-State: APjAAAVdtvCKgNNlt61ThU1C4mkWcwtI0E/U9zv9O8bNQCgyhTM+lios
        tJiibGRpC5N7DSnOTpAV7VjdFq8tqVs=
X-Google-Smtp-Source: APXvYqyA+DNhdSU1Z1j1+Xkxl4d4aUfGsNWXmnvZawhhGVv1daVZYpVjMOjFIGwNc53770y2hurEgA==
X-Received: by 2002:a63:2f81:: with SMTP id v123mr2183121pgv.239.1571982440316;
        Thu, 24 Oct 2019 22:47:20 -0700 (PDT)
Received: from localhost.localdomain ([103.231.91.67])
        by smtp.gmail.com with ESMTPSA id o1sm918805pgm.1.2019.10.24.22.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 22:47:19 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     bfields@fieldses.org, rdunlap@infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] scripts:prune-kernel:prune old kernels and modules dir 
Date:   Fri, 25 Oct 2019 11:17:03 +0530
Message-Id: <20191025054703.16400-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will remmove old kernel and associated modules directory from
the system.

Few interaction with the script ,below 

1) ✔ ~/git-linux/linux-kbuild [master ↑·18|✔]
10:40 $ ./scripts/prune-kernel


2)10:41 $ ./scripts/prune-kernel -h
You need to use this script like this :

  ./scripts/prune-kernel -r kernel_version  modules_directory_name
 ./scripts/prune-kernel -i  option for interactive way to  use it.


3) 10:41 $ ./scripts/prune-kernel -r 5.2.2 5.2.2-gentoo
Removed  kernel version:5.2.2 and modules directory:5.2.2-gentoo from
the system.


4)10:41 $ ./scripts/prune-kernel -i


 Want to removing old kernels and modules dir [YN]: Y
 Please give another version to remove: 5.2.2
 /boot/vmlinuz-5.3.7-050307-generic
 /boot/vmlinuz-5.3.6-050306-generic
 find: ‘/boot/efi’: Permission denied
 Please give the full modules directory name to remove: 5.2.2-gentoo
 5.3.6-050306-generic
 5.3.7-050307-generic



  Removed kernel version:5.2.2 and associated modules:5.2.2-gentoo
  ..Done.




Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
To Bruce,
I have incorporated all the changes you asked for ,kindly review.

 scripts/prune-kernel | 75 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/scripts/prune-kernel b/scripts/prune-kernel
index e8aa940bc0a9..292ba70d7770 100755
--- a/scripts/prune-kernel
+++ b/scripts/prune-kernel
@@ -1,21 +1,58 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-
-# because I use CONFIG_LOCALVERSION_AUTO, not the same version again and
-# again, /boot and /lib/modules/ eventually fill up.
-# Dumb script to purge that stuff:
-
-for f in "$@"
-do
-        if rpm -qf "/lib/modules/$f" >/dev/null; then
-                echo "keeping $f (installed from rpm)"
-        elif [ $(uname -r) = "$f" ]; then
-                echo "keeping $f (running kernel) "
-        else
-                echo "removing $f"
-                rm -f "/boot/initramfs-$f.img" "/boot/System.map-$f"
-                rm -f "/boot/vmlinuz-$f"   "/boot/config-$f"
-                rm -rf "/lib/modules/$f"
-                new-kernel-pkg --remove $f
-        fi
-done
+#This script will delete old kernels and modules directory related to it interactively.
+#if you choose "-i" as interactive otherwise it will just go ahead and do the stuff once
+#you mentione the kernel_version and modules_directory_name as parameter.
+flag=$1
+kernel_ver=$2
+modules_dir_name=$3
+boot_dir=/boot
+modules_dir=/lib/modules
+remove_old_kernel() {
+	cd $boot_dir
+	find $boot_dir -name "vmlinuz-*" -type f -exec ls -1 {} \;
+	rm -If vmlinuz-$kernel_version System.map-$kernel_version config-$kernel_version
+	return 0
+}
+remove_old_modules_dir() {
+	cd $modules_dir
+	find $modules_dir -maxdepth 0 -type d -exec ls -1 {} \;
+	rm -rf $modules_version
+	return 0
+}
+while getopts :hir opt;
+do 
+		 case "$1" in
+			 -i | --interactive)
+		 printf "\n\n Want to removing old kernels and modules dir [YN]: %s"
+		 read response
+		 if [[ $response == "Y" ]];then
+			 printf "Please give another version to remove: %s"
+			 read kernel_version
+			 remove_old_kernel
+			 printf "Please give the full modules directory name to remove: %s"
+			 read modules_version
+			 remove_old_modules_dir
+			 printf "\n\n\n Removed kernel version:$kernel_version and associated modules:$modules_version ..Done. \n\n"
+		 elif [[ $response == "N" ]];then
+			 exit 1
+		 fi
+		 ;;
+	                  -h | --help)
+                    
+                     printf "You need to use this script like this :\n
+	             $0 -r kernel_version modules_directory_name\n
+                     $0 -i option for interactive way to use it.\n\n"
+	      
+	         exit 1
+		     ;;
+	                 -r | --remove)
+			 shift $(( OPTIND - 1 ))
+			 rm -f kernel_ver
+                         cd $modules_dir
+	                 rm -rf $modules_dir_name
+	                 printf "Removed  kernel version:$kernel_ver and modules directory:$modules_dir_name from the system.\n\n"
+			 exit 0
+                         ;;
+ esac
+     done
-- 
2.20.1

