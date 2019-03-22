Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF87C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06FA21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257099;
	bh=0ZDgibt9+HDt38zKOSEMdV9wgvgxAaphMXKQb4Y+IIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dYU7ezth+hRtW/9KvynLXv2xjOoZPhifhvkraCDDqv5vkvYUq7Sfh8xv3Coi2Edo5
	 acIYCzkLnfSRY4LDUUpfjn/ljN7k7tHQl6j25KNk8JDN0048aQoK1LriywRJI35SWm
	 PdqVyAMY5u/Y64zZr4+0m8wurcCGbY22KHtUDwls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbfCVMSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390028AbfCVMSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2502083D;
        Fri, 22 Mar 2019 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257089;
        bh=0ZDgibt9+HDt38zKOSEMdV9wgvgxAaphMXKQb4Y+IIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxqxmZngRgZiYc3DNAww3nQ3/M8l+hDJvpUIYVgFDP8VV5Qla8SnVz5kP3GxzSeaX
         zJKqqyqjRya63ugovgZC77XweErWJbjEeyV6wWnF2IhA0Hdd3t+DOThal8rGo26u8S
         iV11pZs78QC4lBaRoUc/j97bM32c5ep9O50zwito=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 097/238] Btrfs: fix corruption reading shared and compressed extents after hole punching
Date:   Fri, 22 Mar 2019 12:15:16 +0100
Message-Id: <20190322111304.289411292@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 8e928218780e2f1cf2f5891c7575e8f0b284fcce upstream.

In the past we had data corruption when reading compressed extents that
are shared within the same file and they are consecutive, this got fixed
by commit 005efedf2c7d0 ("Btrfs: fix read corruption of compressed and
shared extents") and by commit 808f80b46790f ("Btrfs: update fix for read
corruption of compressed and shared extents"). However there was a case
that was missing in those fixes, which is when the shared and compressed
extents are referenced with a non-zero offset. The following shell script
creates a reproducer for this issue:

  #!/bin/bash

  mkfs.btrfs -f /dev/sdc &> /dev/null
  mount -o compress /dev/sdc /mnt/sdc

  # Create a file with 3 consecutive compressed extents, each has an
  # uncompressed size of 128Kb and a compressed size of 4Kb.
  for ((i = 1; i <= 3; i++)); do
      head -c 4096 /dev/zero
      for ((j = 1; j <= 31; j++)); do
          head -c 4096 /dev/zero | tr '\0' "\377"
      done
  done > /mnt/sdc/foobar
  sync

  echo "Digest after file creation:   $(md5sum /mnt/sdc/foobar)"

  # Clone the first extent into offsets 128K and 256K.
  xfs_io -c "reflink /mnt/sdc/foobar 0 128K 128K" /mnt/sdc/foobar
  xfs_io -c "reflink /mnt/sdc/foobar 0 256K 128K" /mnt/sdc/foobar
  sync

  echo "Digest after cloning:         $(md5sum /mnt/sdc/foobar)"

  # Punch holes into the regions that are already full of zeroes.
  xfs_io -c "fpunch 0 4K" /mnt/sdc/foobar
  xfs_io -c "fpunch 128K 4K" /mnt/sdc/foobar
  xfs_io -c "fpunch 256K 4K" /mnt/sdc/foobar
  sync

  echo "Digest after hole punching:   $(md5sum /mnt/sdc/foobar)"

  echo "Dropping page cache..."
  sysctl -q vm.drop_caches=1
  echo "Digest after hole punching:   $(md5sum /mnt/sdc/foobar)"

  umount /dev/sdc

When running the script we get the following output:

  Digest after file creation:   5a0888d80d7ab1fd31c229f83a3bbcc8  /mnt/sdc/foobar
  linked 131072/131072 bytes at offset 131072
  128 KiB, 1 ops; 0.0033 sec (36.960 MiB/sec and 295.6830 ops/sec)
  linked 131072/131072 bytes at offset 262144
  128 KiB, 1 ops; 0.0015 sec (78.567 MiB/sec and 628.5355 ops/sec)
  Digest after cloning:         5a0888d80d7ab1fd31c229f83a3bbcc8  /mnt/sdc/foobar
  Digest after hole punching:   5a0888d80d7ab1fd31c229f83a3bbcc8  /mnt/sdc/foobar
  Dropping page cache...
  Digest after hole punching:   fba694ae8664ed0c2e9ff8937e7f1484  /mnt/sdc/foobar

This happens because after reading all the pages of the extent in the
range from 128K to 256K for example, we read the hole at offset 256K
and then when reading the page at offset 260K we don't submit the
existing bio, which is responsible for filling all the page in the
range 128K to 256K only, therefore adding the pages from range 260K
to 384K to the existing bio and submitting it after iterating over the
entire range. Once the bio completes, the uncompressed data fills only
the pages in the range 128K to 256K because there's no more data read
from disk, leaving the pages in the range 260K to 384K unfilled. It is
just a slightly different variant of what was solved by commit
005efedf2c7d0 ("Btrfs: fix read corruption of compressed and shared
extents").

Fix this by forcing a bio submit, during readpages(), whenever we find a
compressed extent map for a page that is different from the extent map
for the previous page or has a different starting offset (in case it's
the same compressed extent), instead of the extent map's original start
offset.

A test case for fstests follows soon.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Fixes: 808f80b46790f ("Btrfs: update fix for read corruption of compressed and shared extents")
Fixes: 005efedf2c7d0 ("Btrfs: fix read corruption of compressed and shared extents")
Cc: stable@vger.kernel.org # 4.3+
Tested-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent_io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2985,11 +2985,11 @@ static int __do_readpage(struct extent_i
 		 */
 		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags) &&
 		    prev_em_start && *prev_em_start != (u64)-1 &&
-		    *prev_em_start != em->orig_start)
+		    *prev_em_start != em->start)
 			force_bio_submit = true;
 
 		if (prev_em_start)
-			*prev_em_start = em->orig_start;
+			*prev_em_start = em->start;
 
 		free_extent_map(em);
 		em = NULL;


