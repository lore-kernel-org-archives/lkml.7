Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0975AC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4B72075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfFEKCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:02:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFEKCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:02:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50645307D90D;
        Wed,  5 Jun 2019 10:02:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6E49A5C225;
        Wed,  5 Jun 2019 10:02:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  5 Jun 2019 12:02:11 +0200 (CEST)
Date:   Wed, 5 Jun 2019 12:02:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com
Subject: Re: [PATCH uprobe, thp v2 2/5] uprobe: use original page when all
 uprobes are removed
Message-ID: <20190605100207.GD32406@redhat.com>
References: <20190604165138.1520916-1-songliubraving@fb.com>
 <20190604165138.1520916-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604165138.1520916-3-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 05 Jun 2019 10:02:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04, Song Liu wrote:
>
> Currently, uprobe swaps the target page with a anonymous page in both
> install_breakpoint() and remove_breakpoint(). When all uprobes on a page
> are removed, the given mm is still using an anonymous page (not the
> original page).

Agreed, it would be nice to avoid this,

> @@ -461,9 +471,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  			unsigned long vaddr, uprobe_opcode_t opcode)
>  {
>  	struct uprobe *uprobe;
> -	struct page *old_page, *new_page;
> +	struct page *old_page, *new_page, *orig_page = NULL;
>  	struct vm_area_struct *vma;
>  	int ret, is_register, ref_ctr_updated = 0;
> +	pgoff_t index;
>  
>  	is_register = is_swbp_insn(&opcode);
>  	uprobe = container_of(auprobe, struct uprobe, arch);
> @@ -501,6 +512,19 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	copy_highpage(new_page, old_page);
>  	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>  
> +	index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
> +	orig_page = find_get_page(vma->vm_file->f_inode->i_mapping, index);

I think you should take is_register into account, if it is true we are going
to install the breakpoint so we can avoid find_get_page/pages_identical.

> +	if (orig_page) {
> +		if (pages_identical(new_page, orig_page)) {
> +			/* if new_page matches orig_page, use orig_page */
> +			put_page(new_page);
> +			new_page = orig_page;

Hmm. can't we simply unmap the page in this case?

Oleg.

