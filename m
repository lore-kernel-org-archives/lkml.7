Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0AC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 11:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D43D2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 11:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfERLM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 07:12:57 -0400
Received: from ozlabs.org ([203.11.71.1]:58149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERLM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 07:12:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 455jF22JyNz9s4V;
        Sat, 18 May 2019 21:12:53 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tobin@kernel.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.2-2 tag
Date:   Sat, 18 May 2019 21:12:54 +1000
Message-ID: <87bm00818p.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some powerpc fixes for 5.2:

The following changes since commit b970afcfcabd63cd3832e95db096439c177c3592:

  Merge tag 'powerpc-5.2-1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2019-05-10 05:29:27 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.2-2

for you to fetch changes up to 672eaf37db9f99fd794eed2c68a8b3b05d484081:

  powerpc/cacheinfo: Remove double free (2019-05-17 23:28:00 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.2 #2

One fix going back to stable, for a bug on 32-bit introduced when we added
support for THREAD_INFO_IN_TASK.

A fix for a typo in a recent rework of our hugetlb code that leads to crashes on
64-bit when using hugetlbfs with a 4K PAGE_SIZE.

Two fixes for our recent rework of the address layout on 64-bit hash CPUs, both
only triggered when userspace tries to access addresses outside the user or
kernel address ranges.

Finally a fix for a recently introduced double free in an error path in our
cacheinfo code.

Thanks to:
  Aneesh Kumar K.V, Christophe Leroy, Sachin Sant, Tobin C. Harding.

- ------------------------------------------------------------------
Aneesh Kumar K.V (2):
      powerpc/mm: Drop VM_BUG_ON in get_region_id()
      powerpc/mm/hash: Fix get_region_id() for invalid addresses

Christophe Leroy (1):
      powerpc/32s: fix flush_hash_pages() on SMP

Michael Ellerman (1):
      powerpc/mm: Fix crashes with hugepages & 4K pages

Tobin C. Harding (1):
      powerpc/cacheinfo: Remove double free


 arch/powerpc/include/asm/book3s/64/hash.h | 6 ++++--
 arch/powerpc/kernel/cacheinfo.c           | 1 -
 arch/powerpc/mm/book3s32/hash_low.S       | 3 ++-
 arch/powerpc/mm/hugetlbpage.c             | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJc3+h8AAoJEFHr6jzI4aWA8wQQAK6ChAWbSy5Xb8E9q/txwxhV
tCjg+CEbs4a5WpVPnL7oZm/axUEJVRDk++f1MydxnB2C6TDk0rBM20Umeh548ALP
RWe65asxMHHN+TihSSLf1kN5M+/6gnkRysg++u54KH0RU1fMj+KG+NudcFABJPZ/
5x7Pr1Ffy3FtEqlFAA3vjxioHOFA9aWB1nmjiW8osf01R7KQXNoZk7IX3dZ8YQce
aALvCx/OXqxJtiAj8ynb422nkBgDtwR5haEKZ8gxeVLE1hPnIXaSZfRHYvk3GvYY
t0q37adNeLR2a4UNB1dMaTiNn+6qANJO9tC4ITSsH5KzxIFJ6GI6fMfp+XDxI/pY
7CLAzO5WO466ar/XnJN1Z6cJXfC/WT8h9delzErFm8omEE2wHd+XsxffM7ToATh8
/ZMEip+gmKRU08qm46gU8o823Qpp0A85f5d5LJHjVWRomXTKovTNQvveBCIEB7H4
KKiWPOdo/vTUKh68l6ROR6g96qQbDjnzDZ5yUBOmHE1XXGjJqURtlm8hkhUO6/ws
+awGShDim6nfpOwqlDrpnu9wB0W7HxUDU32pvl0bi5VSJyZckPzaPB2MoVuIf5Aa
8i0x231708Kk8htB4n6tD7gJtrTWEZG3dyRwYZzU1FKKzrbItbDFcwN3H9O+QU5H
Xgk5Sd3CAiEQMbDE+t5x
=Iuyr
-----END PGP SIGNATURE-----
