Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B8A21929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138621;
	bh=Nx+B3wKVjIcMtPeFQWPDPc1Nk2eSA5xxRB/GuN5TZkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ZTH16w3y2mZmAzYadWwnYBeYZvWuczbFt6YaFBCmzADMUS5fnOZypjacJCuZqhgQ
	 a8EYKttidNpxoTMjJvH+Ubwwxz/nqVnPMx04HrRJXfVtTP7CuH2CtnHnYq7NcItURA
	 Hrtr4YiDwW0d/FLUNFoR7a5Y7rynTvknAmTR0Coc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfDARKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfDARKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB70206B8;
        Mon,  1 Apr 2019 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138616;
        bh=Nx+B3wKVjIcMtPeFQWPDPc1Nk2eSA5xxRB/GuN5TZkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBiHRDV9CTZANlb/sFtjpJVmMCvwYRIFP3YtTv4iM8VG3xtPdhZgqRy1IIGnnMEKK
         Exf1E6kJJnQxLJp17U6L0sgMQLOjUgRSUVHKuHKEqMbk+fyeJ5XQxhjdHbwbJaj46i
         2CiTigjZRt50X7VZ9NgvwmfyqebuVYCw0DKNmCjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 117/146] mm/memory.c: fix modifying of page protection by insert_pfn()
Date:   Mon,  1 Apr 2019 19:02:09 +0200
Message-Id: <20190401170058.299390654@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit cae85cb8add35f678cf487139d05e083ce2f570a upstream.

Aneesh has reported that PPC triggers the following warning when
excercising DAX code:

  IP set_pte_at+0x3c/0x190
  LR insert_pfn+0x208/0x280
  Call Trace:
     insert_pfn+0x68/0x280
     dax_iomap_pte_fault.isra.7+0x734/0xa40
     __xfs_filemap_fault+0x280/0x2d0
     do_wp_page+0x48c/0xa40
     __handle_mm_fault+0x8d0/0x1fd0
     handle_mm_fault+0x140/0x250
     __do_page_fault+0x300/0xd60
     handle_page_fault+0x18

Now that is WARN_ON in set_pte_at which is

        VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));

The problem is that on some architectures set_pte_at() cannot cope with
a situation where there is already some (different) valid entry present.

Use ptep_set_access_flags() instead to modify the pfn which is built to
deal with modifying existing PTE.

Link: http://lkml.kernel.org/r/20190311084537.16029-1-jack@suse.cz
Fixes: b2770da64254 "mm: add vm_insert_mixed_mkwrite()"
Signed-off-by: Jan Kara <jack@suse.cz>
Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Chandan Rajendra <chandan@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1546,10 +1546,12 @@ static vm_fault_t insert_pfn(struct vm_a
 				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(*pte)));
 				goto out_unlock;
 			}
-			entry = *pte;
-			goto out_mkwrite;
-		} else
-			goto out_unlock;
+			entry = pte_mkyoung(*pte);
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
+				update_mmu_cache(vma, addr, pte);
+		}
+		goto out_unlock;
 	}
 
 	/* Ok, finally just insert the thing.. */
@@ -1558,7 +1560,6 @@ static vm_fault_t insert_pfn(struct vm_a
 	else
 		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
-out_mkwrite:
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);


