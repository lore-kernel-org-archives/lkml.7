Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E216CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025E421721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572382933;
	bh=DU276rBOmXNq/UGPWSsHr+vCt4tZPq33yvckroogy+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dItvL+BnQioaJxRvnEfhhzTqNi0GHOuqJixAabt5LdoNP/vESxCSvRAulwsh6xSyF
	 +W8LJYlXevrJ6zk5EDGi2u0CniF1vY23KtdKoPatN1FKFvThGywwFN2NDZyCpQb4P9
	 t6qUsNtP1GLFpeW39Lzo/XzsIg75PEpYLj8tNSeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfJ2VCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfJ2VCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:02:11 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199182087E;
        Tue, 29 Oct 2019 21:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572382930;
        bh=DU276rBOmXNq/UGPWSsHr+vCt4tZPq33yvckroogy+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NwwDI9pwnDo75NGmhbNfHM/Z52BOv/JUemoHekwTJypzHNtZFbJvRDk+E1Wc7jgUC
         On20wb4dVGoVudHP0YtkioHoHAmgGvETr9xPwj0hBuoBho6V+6x/fFUAFlnWfQN9Vw
         pFqgMOSZ0/b9dD4OKeTBUpNaSAK7B84JMq1Kn71U=
Date:   Tue, 29 Oct 2019 14:02:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
        =?ISO-8859-1?Q?J=E9?= =?ISO-8859-1?Q?r=F4me?= Glisse 
        <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: khugepaged might_sleep() warn due to CONFIG_HIGHPTE=y
Message-Id: <20191029140209.e70385637d3617ad43869f31@linux-foundation.org>
In-Reply-To: <20191029201513.GG1208@intel.com>
References: <20191029201513.GG1208@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 22:15:13 +0200 Ville Syrj=E4l=E4 <ville.syrjala@linux.i=
ntel.com> wrote:

> Hi,
>=20
> I got some khugepaged spew on a 32bit x86:
>=20
> [  217.490026] BUG: sleeping function called from invalid context at incl=
ude/linux/mmu_notifier.h:346
> [  217.492826] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 25,=
 name: khugepaged
> [  217.495589] INFO: lockdep is turned off.
> [  217.498371] CPU: 1 PID: 25 Comm: khugepaged Not tainted 5.4.0-rc5-elk+=
 #206
> [  217.501233] Hardware name: System manufacturer P5Q-EM/P5Q-EM, BIOS 220=
3    07/08/2009
> [  217.501697] Call Trace:
> [  217.501697]  dump_stack+0x66/0x8e
> [  217.501697]  ___might_sleep.cold.96+0x95/0xa6
> [  217.501697]  __might_sleep+0x2e/0x80
> [  217.501697]  collapse_huge_page.isra.51+0x5ac/0x1360
> [  217.501697]  ? __alloc_pages_nodemask+0xec/0xf80
> [  217.501697]  ? __alloc_pages_nodemask+0x191/0xf80
> [  217.501697]  ? trace_hardirqs_on+0x4a/0xf0
> [  217.501697]  khugepaged+0x9a9/0x20f0
> [  217.501697]  ? _raw_spin_unlock+0x21/0x30
> [  217.501697]  ? trace_hardirqs_on+0x4a/0xf0
> [  217.501697]  ? wait_woken+0xa0/0xa0
> [  217.501697]  kthread+0xf5/0x110
> [  217.501697]  ? collapse_pte_mapped_thp+0x3b0/0x3b0
> [  217.501697]  ? kthread_create_worker_on_cpu+0x20/0x20
> [  217.501697]  ret_from_fork+0x2e/0x38
>=20
> Looks like it's due to CONFIG_HIGHPTE=3Dy pte_offset_map()->kmap_atomic()=
 vs.
> mmu_notifier_invalidate_range_start().
>=20
> My naive idea would be to just reorder those things, but not sure
> if there's some magic ordering constraint here. At least the machine
> still boots when I do it :)
>=20
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0a1b4b484ac5..f05d27b7183d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1028,12 +1028,13 @@ static void collapse_huge_page(struct mm_struct *=
mm,
> =20
>  	anon_vma_lock_write(vma->anon_vma);
> =20
> -	pte =3D pte_offset_map(pmd, address);
> -	pte_ptl =3D pte_lockptr(mm, pmd);
> -
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
>  				address, address + HPAGE_PMD_SIZE);
>  	mmu_notifier_invalidate_range_start(&range);
> +
> +	pte =3D pte_offset_map(pmd, address);
> +	pte_ptl =3D pte_lockptr(mm, pmd);
> +
>  	pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
>  	/*
>  	 * After this gup_fast can't run anymore. This also removes
>=20

Looks good to me.  Can you resend it with a signoff please?
