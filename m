Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5D7C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F8621926
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="axyva0Yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfGVCea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:34:30 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7820 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfGVCe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:34:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3520b50000>; Sun, 21 Jul 2019 19:34:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jul 2019 19:34:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jul 2019 19:34:28 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jul
 2019 02:34:28 +0000
Subject: Re: [PATCH 2/3] sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
To:     Bharath Vedartham <linux.bhar@gmail.com>, <arnd@arndb.de>,
        <sivanich@sgi.com>, <gregkh@linuxfoundation.org>
CC:     <ira.weiny@intel.com>, <jglisse@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
 <1563724685-6540-3-git-send-email-linux.bhar@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9b510a41-7ce1-b2b7-d3c6-f6f0305e10ea@nvidia.com>
Date:   Sun, 21 Jul 2019 19:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563724685-6540-3-git-send-email-linux.bhar@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563762869; bh=lO0pl2D/N0Wte9jFVwYyoxzkAS8kJOiDf/u2pevzBOk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=axyva0YhbvZrjjd+JQOH6Y0DYU+XPMlPGwyWbICHjIn8nCWjKrAIQ3Nsr0hDTUvze
         lpL0V66Z84aNd2j7r2POhsMZ2g1W48+3rACb7u5lKicDUcPiBANzVgq5NAtRPyyvQZ
         BUkmZyF21/eHaBhRt68KP6CCGVB1uS8F6y+BDQXas50Y73RFVq3LG1sx58q//56cNy
         Sc2nC9ndcjjoGO8WCMjjlXZg/qvs7+EtBUus/bAhoTTUC+tCeqTcrzFWd7g1xnM56+
         VjK+Xo1XkfdYYKTryKiB7/hKeqOf8OxmNB0YT2qWjZy/AptRLILXHHj1tibyEoXiC+
         5igf5moViBH9g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/19 8:58 AM, Bharath Vedartham wrote:
> is_vm_hugetlb_page has checks for whether CONFIG_HUGETLB_PAGE is defined
> or not. If CONFIG_HUGETLB_PAGE is not defined is_vm_hugetlb_page will
> always return false. There is no need to have an uneccessary
> CONFIG_HUGETLB_PAGE check in the code.
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
>  drivers/misc/sgi-gru/grufault.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufa=
ult.c
> index 61b3447..75108d2 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -180,11 +180,8 @@ static int non_atomic_pte_lookup(struct vm_area_stru=
ct *vma,
>  {
>  	struct page *page;
> =20
> -#ifdef CONFIG_HUGETLB_PAGE
>  	*pageshift =3D is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> -#else
> -	*pageshift =3D PAGE_SHIFT;
> -#endif
> +
>  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <=3D =
0)
>  		return -EFAULT;
>  	*paddr =3D page_to_phys(page);
> @@ -238,11 +235,9 @@ static int atomic_pte_lookup(struct vm_area_struct *=
vma, unsigned long vaddr,
>  		return 1;
> =20
>  	*paddr =3D pte_pfn(pte) << PAGE_SHIFT;
> -#ifdef CONFIG_HUGETLB_PAGE
> +
>  	*pageshift =3D is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> -#else
> -	*pageshift =3D PAGE_SHIFT;
> -#endif
> +
>  	return 0;
> =20
>  err:
>=20

Looks like an accurate cleanup to me.

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA
