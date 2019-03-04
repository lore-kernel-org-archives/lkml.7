Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA2AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0C82070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCDThh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:37:37 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:41843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDThg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:37:36 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJVY8-1gh14P47YG-00JvBc; Mon, 04 Mar 2019 20:37:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: mark xfs_dir2_sf_entry_t as __packed again
Date:   Mon,  4 Mar 2019 20:36:47 +0100
Message-Id: <20190304193723.657089-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wXjoFVzi3CaIX/kd0PSUSW/UMteqMiuiM0hOYrJAchPiuY8ucN2
 szrEsz+19lnKPNjoEl9LQgTRfObe0rGn1aFFWfSRR8mbvdZitzBOrcL9+GVS2mRNAIKbHh0
 oOH3xgrcveCiwx/TKDOhhqdd2dJa5YhL5859Hs7UxyrkYQFMV8IXNE+vecaYUqEOKANZBcM
 Qe0WFJix/pAqM3o4ncuug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6x01TYg4aRM=:STmeLI/8ogrJQE2/kLUYp+
 1JeloQY3OSBYYrSeAKDpOwicDLnQO0PVirGa8XKz8oOFpj5VCNuVeOhoYkGWV01uYdHtJaIgL
 aJ3+DebPhMlQlinKQxs1qmc5AYjCjZFmMCM/KZIdKwSIc6JOyPjkkJWW3Ih5LFLPuea/WAkLt
 n5iofEPRkvwvi7f7WFcW3/UeB0sniRCook2AEDPpzzdWfx9sqXAmeQvpjSQ0T3wHVuy5WFdVN
 sPEw4rh6YVBuhnNyz/7Vjs8YZRt37IPG6yDLERxpNG6BjzUWJ2U0M58tTt1mgVA73VrScrfjZ
 jKxyHkkPd1eIJ9v4TvAyApyMEWwvHSIUg6ZSd4p9Enrc9ngvLI7PINw+9/xoIUsYibWI92RsY
 4n9Wd5Ncl4wMG9OAmIjB/3QDJZzr875CEygyIUzQ2wkyav9aaSr0+djLc72qQHoy5H4qf1bEw
 10TpsGRcrLwoNHeAMdWdAaHul6rxoam8KfOgXZ3GI9CWf9GgQE+1j0XSokkKPOUKgP/QDTLXq
 2kPTk1UkrSLMdzxKDKfOdAKFSasGJuxEfdUc6FCMkddDY8Xd2ArN+QgRZuF68dCTFNP/H7dlR
 8PF+afh0p+/S7ZQ2l0CPYO/jARMh17a1G2J2NPg+p2vVgfjgOoYQkaOQ+WPAk7su9iOuwq4PZ
 hR701LC4Mf17Ht8P63DMnDqFYrFZmN8Mfgt8ghn2RuJQzbTztEcfmkDDuPaG4D+KYpalu3EAn
 K9Fgtzm/PW4jfLZm844DyaCwjEIEA7U3K+DKLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ARM OABI builds, we run into a compile time assertion:

inlined from 'init_xfs_fs' at /git/arm-soc/fs/xfs/xfs_super.c:1991:2:
fs/xfs/xfs_ondisk.h:119:208: error: call to '__compiletime_assert_119' declared with attribute error: XFS: sizeof(xfs_dir2_sf_entry_t) is wrong, expected 3

While ARM OABI is pretty much dead and fails to build for typical
configurations on modern architectures (ARMv6 or higher), and has
been declared deprecated in user space since gcc-4.6, the kernel
still allows it to used for building the kernel.

In commit 8353a649f577 ("xfs: kill xfs_dir2_sf_off_t"), Christoph
removed the old __arch_pack annotation that made it possible to
build xfs with oddball ABIs. However, OABI not only requrires
padding around short structure but still adds padding after this
change. There is no harm to unconditionally mark the structure as
__packed now, and that will do the right thing here.

As of commit aa2dd0ad4d6d ("xfs: remove __arch_pack"), we need to
use __packed here as well, instead of the old __arch_pack.

Fixes: 8353a649f577 ("xfs: kill xfs_dir2_sf_off_t")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/xfs/libxfs/xfs_da_format.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index ae654e06b2fb..fa8f07451d39 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -230,7 +230,7 @@ typedef struct xfs_dir2_sf_entry {
 	 * A 64-bit or 32-bit inode number follows here, at a variable offset
 	 * after the name.
 	 */
-} xfs_dir2_sf_entry_t;
+} __packed xfs_dir2_sf_entry_t;
 
 static inline int xfs_dir2_sf_hdr_size(int i8count)
 {
-- 
2.20.0

