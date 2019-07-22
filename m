Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF9C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A1121926
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TmwAzunX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfGVCck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:32:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8431 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfGVCcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:32:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d35204c0000>; Sun, 21 Jul 2019 19:32:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jul 2019 19:32:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jul 2019 19:32:37 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jul
 2019 02:32:37 +0000
Subject: Re: [PATCH 3/3] sgi-gru: Use __get_user_pages_fast in
 atomic_pte_lookup
To:     Bharath Vedartham <linux.bhar@gmail.com>, <arnd@arndb.de>,
        <sivanich@sgi.com>, <gregkh@linuxfoundation.org>
CC:     <ira.weiny@intel.com>, <jglisse@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
 <1563724685-6540-4-git-send-email-linux.bhar@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c508330d-a5d0-fba3-9dd0-eb820a96ee09@nvidia.com>
Date:   Sun, 21 Jul 2019 19:32:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563724685-6540-4-git-send-email-linux.bhar@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563762764; bh=vM8Jy937nRvxwkL1bwsxA2+vqomr30+OXJGmeXYwzBo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TmwAzunX+5qzu07CrqhvBJCCV0jq5HpocZtWwYm//UJko8hKWxee+N31cImnRhrin
         EyrgXUGITres3QieKC34H3xI8rXLDQPlsVzu/llAAo3hCd41vJy8AyIPDVAn/Y69Ou
         Zm4yF5W0MsP7IKNY6LukPPWyYWc8+eNoYpR9YZPqtI9ttKO0fsWkmuArrVBf2U+sgQ
         7wUrLDXfymWp/nPaElRVD6YtlVin5Q/u3+QC9rn7EBa+LLskeHBPMH65V+5SE2TLOB
         wXsYIPbTNp7Pk0SsrBayUEyKeHliV6b8W0pVWuTGY84yZ3zCXoYaspXINWJlNlZI5I
         t5GvpgJ3qo7fQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/19 8:58 AM, Bharath Vedartham wrote:
> *pte_lookup functions get the physical address for a given virtual
> address by getting a physical page using gup and use page_to_phys to get
> the physical address.
>=20
> Currently, atomic_pte_lookup manually walks the page tables. If this
> function fails to get a physical page, it will fall back too
> non_atomic_pte_lookup to get a physical page which uses the slow gup
> path to get the physical page.
>=20
> Instead of manually walking the page tables use __get_user_pages_fast
> which does the same thing and it does not fall back to the slow gup
> path.
>=20
> This is largely inspired from kvm code. kvm uses __get_user_pages_fast
> in hva_to_pfn_fast function which can run in an atomic context.
>=20
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/misc/sgi-gru/grufault.c | 39 +++++------------------------------=
----
>  1 file changed, 5 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufa=
ult.c
> index 75108d2..121c9a4 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -202,46 +202,17 @@ static int non_atomic_pte_lookup(struct vm_area_str=
uct *vma,
>  static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long v=
addr,
>  	int write, unsigned long *paddr, int *pageshift)
>  {
> -	pgd_t *pgdp;
> -	p4d_t *p4dp;
> -	pud_t *pudp;
> -	pmd_t *pmdp;
> -	pte_t pte;
> -
> -	pgdp =3D pgd_offset(vma->vm_mm, vaddr);
> -	if (unlikely(pgd_none(*pgdp)))
> -		goto err;
> -
> -	p4dp =3D p4d_offset(pgdp, vaddr);
> -	if (unlikely(p4d_none(*p4dp)))
> -		goto err;
> -
> -	pudp =3D pud_offset(p4dp, vaddr);
> -	if (unlikely(pud_none(*pudp)))
> -		goto err;
> +	struct page *page;
> =20
> -	pmdp =3D pmd_offset(pudp, vaddr);
> -	if (unlikely(pmd_none(*pmdp)))
> -		goto err;
> -#ifdef CONFIG_X86_64
> -	if (unlikely(pmd_large(*pmdp)))
> -		pte =3D *(pte_t *) pmdp;
> -	else
> -#endif
> -		pte =3D *pte_offset_kernel(pmdp, vaddr);
> +	*pageshift =3D is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> =20
> -	if (unlikely(!pte_present(pte) ||
> -		     (write && (!pte_write(pte) || !pte_dirty(pte)))))
> +	if (!__get_user_pages_fast(vaddr, 1, write, &page))
>  		return 1;

Let's please use numeric, not boolean comparison, for the return value of=20
gup.

Also, optional: as long as you're there, atomic_pte_lookup() ought to
either return a bool (true =3D=3D success) or an errno, rather than a
numeric zero or one.

Other than that, this looks like a good cleanup, I wonder how many
open-coded gup implementations are floating around like this.=20

thanks,
--=20
John Hubbard
NVIDIA

> =20
> -	*paddr =3D pte_pfn(pte) << PAGE_SHIFT;
> -
> -	*pageshift =3D is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> +	*paddr =3D page_to_phys(page);
> +	put_user_page(page);
> =20
>  	return 0;
> -
> -err:
> -	return 1;
>  }
> =20
>  static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
>=20
