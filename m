Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576A1FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358742067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392894AbfJPMKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfJPMKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:10:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D93910F2E83;
        Wed, 16 Oct 2019 12:10:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3826960852;
        Wed, 16 Oct 2019 12:10:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 16 Oct 2019 14:10:33 +0200 (CEST)
Date:   Wed, 16 Oct 2019 14:10:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] uprobe: only do FOLL_SPLIT_PMD for uprobe register
Message-ID: <20191016121031.GA31585@redhat.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
 <20191016073731.4076725-5-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016073731.4076725-5-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Wed, 16 Oct 2019 12:10:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16, Song Liu wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -474,14 +474,17 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	int ret, is_register, ref_ctr_updated = 0;
>  	bool orig_page_huge = false;
> +	unsigned int gup_flags = FOLL_FORCE;
>  
>  	is_register = is_swbp_insn(&opcode);
>  	uprobe = container_of(auprobe, struct uprobe, arch);
>  
>  retry:
> +	if (is_register)
> +		gup_flags |= FOLL_SPLIT_PMD;
>  	/* Read the page with vaddr into memory */
> -	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
> -			FOLL_FORCE | FOLL_SPLIT_PMD, &old_page, &vma, NULL);
> +	ret = get_user_pages_remote(NULL, mm, vaddr, 1, gup_flags,
> +				    &old_page, &vma, NULL);
>  	if (ret <= 0)
>  		return ret;
>  
> @@ -489,6 +492,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	if (ret <= 0)
>  		goto put_old;
>  
> +	WARN(!is_register && PageCompound(old_page),
> +	     "uprobe unregister should never work on compound page\n");

But this can happen with the change above. You can't know if *vaddr was
previously changed by install_breakpoint() or not.

If not, verify_opcode() should likely save us, but we can't rely on it.
Say, someone can write "int3" into vm_file at uprobe->offset.

And I am not sure it is safe to continue in this case, I'd suggest to
return -EWHATEVER to avoid the possible crash.

Oleg.

