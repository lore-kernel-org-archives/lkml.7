Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F28C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB46206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKRNWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:22:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:64926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfKRNWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:22:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 05:22:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="236915582"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2019 05:22:45 -0800
Date:   Mon, 18 Nov 2019 21:22:35 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        sfr@canb.auug.org.au, rppt@linux.ibm.com, jannh@google.com,
        steve.capper@arm.com, catalin.marinas@arm.com, aarcange@redhat.com,
        walken@google.com, dave.hansen@linux.intel.com,
        tiny.windzz@gmail.com, jhubbard@nvidia.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Message-ID: <20191118132235.GA28027@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1574079844-17493-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574079844-17493-1-git-send-email-linmiaohe@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 08:24:04PM +0800, linmiaohe wrote:
>From: Miaohe Lin <linmiaohe@huawei.com>
>
>The jump labels try_prev and none are not really needed
>in find_mergeable_anon_vma(), eliminate them to improve
>readability.
>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
>-v2:
>	Fix commit descriptions and further simplify the code
>	as suggested by David Hildenbrand and John Hubbard.
>-v3:
>	Rewrite patch version info. Don't show this in commit log.
>-v4:
>	Get rid of var near completely as well.
>---
> mm/mmap.c | 36 ++++++++++++++++--------------------
> 1 file changed, 16 insertions(+), 20 deletions(-)
>
>diff --git a/mm/mmap.c b/mm/mmap.c
>index 91d5e097a4ed..4d93bda30eac 100644
>--- a/mm/mmap.c
>+++ b/mm/mmap.c
>@@ -1273,26 +1273,22 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
>  */
> struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
> {
>-	struct anon_vma *anon_vma;
>-	struct vm_area_struct *near;
>-
>-	near = vma->vm_next;
>-	if (!near)
>-		goto try_prev;
>-
>-	anon_vma = reusable_anon_vma(near, vma, near);
>-	if (anon_vma)
>-		return anon_vma;
>-try_prev:
>-	near = vma->vm_prev;
>-	if (!near)
>-		goto none;
>-
>-	anon_vma = reusable_anon_vma(near, near, vma);
>-	if (anon_vma)
>-		return anon_vma;
>-none:
>+	struct anon_vma *anon_vma = NULL;
>+
>+	/* Try next first. */
>+	if (vma->vm_next) {
>+		anon_vma = reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
>+		if (anon_vma)
>+			return anon_vma;
>+	}
>+
>+	/* Try prev next. */
>+	if (vma->vm_prev)
>+		anon_vma = reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
>+
> 	/*
>+	 * We might reach here with anon_vma == NULL if we can't find
>+	 * any reusable anon_vma.
> 	 * There's no absolute need to look only at touching neighbours:
> 	 * we could search further afield for "compatible" anon_vmas.
> 	 * But it would probably just be a waste of time searching,
>@@ -1300,7 +1296,7 @@ struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
> 	 * We're trying to allow mprotect remerging later on,
> 	 * not trying to minimize memory used for anon_vmas.
> 	 */
>-	return NULL;
>+	return anon_vma;
> }
> 
> /*
>-- 
>2.21.GIT

-- 
Wei Yang
Help you, Help me
