Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEEEC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78512133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfELHki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 03:40:38 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45226 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbfELHkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 03:40:37 -0400
Received: from mr2.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x4C7eanD022301
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 03:40:36 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x4C7eV1J019325
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 03:40:36 -0400
Received: by mail-qt1-f197.google.com with SMTP id l20so11104606qtq.21
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 00:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=4niML5CBEC30siYgDwkdqvWzedR5M8WeQePCBwOwTk0=;
        b=M4mimFbKVyvTFcgUnz2SexFsNJqFewDUCdyuePrW8woSekGOfg4Zl0tGjwflyYXGLT
         NYVGbPFnecC/d6mIa3sPxKzL7eNFt09fA8FUl8rbzGMD6yd0CDk4Go/yfUfbM8QOYS8U
         oArgv5ljkWPzkGTSXoAT/vdO1VjLSkhk9FRmgoFyGOSBzZ+4yqy6DRjAxeRPm40ZkgYl
         XzGzlG1vWiCtEH4Y22K5Ikap21Lbsmx9gmb0gFUj1cnpCyiC3Fsu4cAvI87i+SjQ7O2u
         D16UAZ8wlzlFN+WN7zTWi1ud7Tw+VT3SmQpZjGbSGUlxaIDmCLEwFgN23t0uCvplSCYl
         I8jw==
X-Gm-Message-State: APjAAAXsBEKEAYJGsiVeacFtmtZOYckS1Ja1Ir2tdaZO+PHTVNiZIyNR
        sIJyNpjoClIKENQ+AEhRsGjjYH8lm/vMjxCOcFES/XRu91ZVOf+3GzQfKV610rfBYXv16/4ITYj
        JY9DZqnELFvEfPXuN9lfUu7EZhTh5lD+Qb1Q=
X-Received: by 2002:ac8:298d:: with SMTP id 13mr17969933qts.174.1557646831376;
        Sun, 12 May 2019 00:40:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAe13v194yDiRZP16Zt0YhlISnTOc1dpB98yMzdZWCHtKpcG/mjwaobALtaHZHMtv44Qfdxw==
X-Received: by 2002:ac8:298d:: with SMTP id 13mr17969915qts.174.1557646831127;
        Sun, 12 May 2019 00:40:31 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::bf6])
        by smtp.gmail.com with ESMTPSA id n36sm7215149qtk.9.2019.05.12.00.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 00:40:29 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Andrew Morton <akpm@linux-foundation.org>,
        Deepak Mishra <linux.dkm@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeremy Cline <jcline@redhat.com>
cc:     linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: [PATCH] scripts/spdxcheck.py - fix list of directories to check
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 12 May 2019 03:40:28 -0400
Message-ID: <2008.1557646828@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After this commit:

commit 62be257e986dab439537b3e1c19ef746a13e1860
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 30 06:51:30 2019 -0400

    LICENSES: Rename other to deprecated

checkpatch throws an error:

[/usr/src/linux-next]2 scripts/checkpatch.pl -f drivers/staging/rtl8712/rtl871x_rf.h
FAIL: "Blob or Tree named 'other' not found"
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 240, in <module>
    spdx = read_spdxdata(repo)
  File "scripts/spdxcheck.py", line 41, in read_spdxdata
    for el in lictree[d].traverse():
  File "/usr/lib/python2.7/site-packages/git/objects/tree.py", line 298, in __getitem__
    return self.join(item)
  File "/usr/lib/python2.7/site-packages/git/objects/tree.py", line 244, in join
    raise KeyError(msg % file)
KeyError: "Blob or Tree named 'other' not found"

Fix directory search list. Pick up the new LICENSES/dual while we're there...

Reported-by: Deepak Mishra <linux.dkm@gmail.com>
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 4fe392e507fb..7abd5f5cb14d 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -32,7 +32,7 @@ import os
 def read_spdxdata(repo):
 
     # The subdirectories of LICENSES in the kernel source
-    license_dirs = [ "preferred", "other", "exceptions" ]
+    license_dirs = [ "preferred", "dual", "deprecated", "exceptions" ]
     lictree = repo.head.commit.tree['LICENSES']
 
     spdx = SPDXdata()


