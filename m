Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446D1C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100FE21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624574;
	bh=LJfp+ky6fZ2RKX3G3TgV5iZgksgf6Ssb4NVfqEuOJJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H+Z+A4c7FoN8erY0Bb/ihtga6WWLzDiF3jp31t/4+h0KeiFwLn3R9PHnLgfEAeyre
	 MkvJDmtorbukADxGdpQ3Uji1RL+hazomsSR/kigWh7QuJoynMR73hEnDg6V6BjFfhr
	 5u4CoN0dmTD21+zGcle84/hjx8n5ECpEeL799Rzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfD3Lmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbfD3Lmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:42:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3264C21734;
        Tue, 30 Apr 2019 11:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624564;
        bh=LJfp+ky6fZ2RKX3G3TgV5iZgksgf6Ssb4NVfqEuOJJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7nSLiQOGtc9CedS4hsm9+hnWf81pA/EnRofFiSpeE5O0iTUrCt0TkMyVfjUL8Hb4
         J5ezORpse8OYVil0VoMw6tO2Wq/38ZR/NDYPNyjK2cE2lyyH51I/lHmQ/Ios8EL376
         ZVzA1nxE/5Mmyy5XBylc94Jn8AdjVegH5A7yLRL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 42/53] mm: Fix warning in insert_pfn()
Date:   Tue, 30 Apr 2019 13:38:49 +0200
Message-Id: <20190430113558.270650520@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113549.400132183@linuxfoundation.org>
References: <20190430113549.400132183@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit f2c57d91b0d96aa13ccff4e3b178038f17b00658 upstream.

In DAX mode a write pagefault can race with write(2) in the following
way:

CPU0                            CPU1
                                write fault for mapped zero page (hole)
dax_iomap_rw()
  iomap_apply()
    xfs_file_iomap_begin()
      - allocates blocks
    dax_iomap_actor()
      invalidate_inode_pages2_range()
        - invalidates radix tree entries in given range
                                dax_iomap_pte_fault()
                                  grab_mapping_entry()
                                    - no entry found, creates empty
                                  ...
                                  xfs_file_iomap_begin()
                                    - finds already allocated block
                                  ...
                                  vmf_insert_mixed_mkwrite()
                                    - WARNs and does nothing because there
                                      is still zero page mapped in PTE
        unmap_mapping_pages()

This race results in WARN_ON from insert_pfn() and is occasionally
triggered by fstest generic/344. Note that the race is otherwise
harmless as before write(2) on CPU0 is finished, we will invalidate page
tables properly and thus user of mmap will see modified data from
write(2) from that point on. So just restrict the warning only to the
case when the PFN in PTE is not zero page.

Link: http://lkml.kernel.org/r/20180824154542.26872-1-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1804,10 +1804,15 @@ static int insert_pfn(struct vm_area_str
 			 * in may not match the PFN we have mapped if the
 			 * mapped PFN is a writeable COW page.  In the mkwrite
 			 * case we are creating a writable PTE for a shared
-			 * mapping and we expect the PFNs to match.
+			 * mapping and we expect the PFNs to match. If they
+			 * don't match, we are likely racing with block
+			 * allocation and mapping invalidation so just skip the
+			 * update.
 			 */
-			if (WARN_ON_ONCE(pte_pfn(*pte) != pfn_t_to_pfn(pfn)))
+			if (pte_pfn(*pte) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(*pte)));
 				goto out_unlock;
+			}
 			entry = *pte;
 			goto out_mkwrite;
 		} else


