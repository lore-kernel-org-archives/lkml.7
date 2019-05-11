Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B53C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 11:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FB0216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 11:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfEKLdt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 07:33:49 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:45184 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbfEKLds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 07:33:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2Ak9ACh299ZAEaufAFehV+EIYMqh2modUQBhH0BhRoDAQEBAQECDwEBATKGFlEdEA0CizibYJARgicii0yBDoIfg1iCFYdkAQGDYIISIAWSVo5ugi6UUIV0g3ENhwqXJFaBDzIhMFMSAYcaigiCNQEBAQ
X-IronPort-SPAM: SPAM
Received: from unknown (HELO [100.69.127.174]) ([1.124.174.70])
  by ipmail06.adl6.internode.on.net with ESMTP; 11 May 2019 21:03:46 +0930
Date:   Sat, 11 May 2019 21:03:44 +0930
User-Agent: K-9 Mail for Android
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     linux-kernel@vger.kernel.org
From:   Arthur Marsh <arthur.marsh@internode.on.net>
Message-ID: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have yet to bisect, but have had trouble with recent, post 5.1.0 kernels built from Linus' git head on both i386 (Pentium 4 pc) and amd64 (Athlon II X4 640).

The easiest way to trigger the problem is:

git gc

on the kernel source tree, although the problem can occur without doing a git gc.

The filesystem with the kernel source tree is the root file system, ext3, mounted as:

/dev/sdb7 on / type ext3 (rw,relatime,errors=remount-ro)

After the "Compressing objects" stage, the following appears in dmesg:

[  848.968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode #8: block 30343695: comm jbd2/sdb7-8: invalid block
[  849.077426] Aborting journal on device sdb7-8.
[  849.100963] EXT4-fs (sdb7): Remounting filesystem read-only
[  849.100976] jbd2_journal_bmap: journal block not found at offset 989 on sdb7-8

fsck -yv 

then reports:

# fsck -yv
fsck from util-linux 2.33.1
e2fsck 1.45.0 (6-Mar-2019)
/dev/sdb7: recovering journal
/dev/sdb7 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong (4619656, counted=4619444).
Fix? yes

Free inodes count wrong (15884075, counted=15884058).
Fix? yes


/dev/sdb7: ***** FILE SYSTEM WAS MODIFIED *****

Other times, I have gotten:

"Inodes that were part of a corrupted orphan linked list found."
"Block bitmap differences:"
"Free blocks sound wrong for group"

No problems have been observed with the 5.1.0 release kernel.

Any suggestions for narrowing down the issue welcome.

Arthur.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
