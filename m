Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB03C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D6B21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DSd3O0zQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfGVDXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 23:23:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48060 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfGVDXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:23:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6M3J2WK091282;
        Mon, 22 Jul 2019 03:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=bKQhUIwcPyqKlsiS6x+9R5sqKFbs4BHgdjnU5G7EHlc=;
 b=DSd3O0zQ4FRuEjIau9hjPInOC22IFeXHKkPNWBaycJAbDHtCgMnpC0R1qzzazWNn2RUp
 EJzbnMEVutxkhqtjKo1/+F7bc7ijlOUIzsjGpFuoKM8xPSBE+8KBvKfL6COUGBASbIlR
 NdLk9dXDx8Uen+1SYPrcWtbJqaHAVmhKu/mftrglskgSnxq5VwlqTejE4ywdch5Z1ze0
 oArggfQEIHPkpkIJv/Fc/TQAjoa9W4LqjYoP3FIT/KA2VJsi50HmO/BadAEYf2tYhq6J
 A7dQ1qX9Mtp9egiAdbo7amW9Ap4/oWGzGcus5DRjghh4qJZRMF+MX0wvshHrZMwhEg9C gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tuukqbw6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 03:22:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6M3I18c139244;
        Mon, 22 Jul 2019 03:20:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tuts2g8uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 03:20:46 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6M3KdXA015002;
        Mon, 22 Jul 2019 03:20:39 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Jul 2019 20:20:38 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3566.0.1\))
Subject: Re: [PATCH 2/3] sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <1563724685-6540-3-git-send-email-linux.bhar@gmail.com>
Date:   Sun, 21 Jul 2019 21:20:38 -0600
Cc:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org,
        ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BA84A99-4EB5-4520-BFBD-CD60D5B7AED9@oracle.com>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
 <1563724685-6540-3-git-send-email-linux.bhar@gmail.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>
X-Mailer: Apple Mail (2.3566.0.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9325 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9325 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect I'm being massively pedantic here, but the comments for =
atomic_pte_lookup() note:

 * Only supports Intel large pages (2MB only) on x86_64.
 *	ZZZ - hugepage support is incomplete

That makes me wonder how many systems using this hardware are actually =
configured with CONFIG_HUGETLB_PAGE.

I ask as in the most common case, this is likely introducing a few extra =
instructions and possibly an additional branch to a routine that is =
called per-fault.

So the nit-picky questions are:

1) Does the code really need to be cleaned up in this way?

2) If it does, does it make more sense (given the way pmd_large() is =
handled now in atomic_pte_lookup()) for this to be coded as:

if (unlikely(is_vm_hugetlb_page(vma)))
	*pageshift =3D HPAGE_SHIFT;
else
	*pageshift =3D PAGE_SHIFT;

In all likelihood, these questions are no-ops, and the optimizer may =
even make my questions completely moot, but I thought I might as well =
ask anyway.


> On Jul 21, 2019, at 9:58 AM, Bharath Vedartham <linux.bhar@gmail.com> =
wrote:
>=20
> is_vm_hugetlb_page has checks for whether CONFIG_HUGETLB_PAGE is =
defined
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
> drivers/misc/sgi-gru/grufault.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/sgi-gru/grufault.c =
b/drivers/misc/sgi-gru/grufault.c
> index 61b3447..75108d2 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -180,11 +180,8 @@ static int non_atomic_pte_lookup(struct =
vm_area_struct *vma,
> {
> 	struct page *page;
>=20
> -#ifdef CONFIG_HUGETLB_PAGE
> 	*pageshift =3D is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : =
PAGE_SHIFT;
> -#else
> -	*pageshift =3D PAGE_SHIFT;
> -#endif
> +
> 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, =
NULL) <=3D 0)
> 		return -EFAULT;
> 	*paddr =3D page_to_phys(page);
> @@ -238,11 +235,9 @@ static int atomic_pte_lookup(struct =
vm_area_struct *vma, unsigned long vaddr,
> 		return 1;
>=20
> 	*paddr =3D pte_pfn(pte) << PAGE_SHIFT;
> -#ifdef CONFIG_HUGETLB_PAGE
> +
> 	*pageshift =3D is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : =
PAGE_SHIFT;
> -#else
> -	*pageshift =3D PAGE_SHIFT;
> -#endif
> +
> 	return 0;
>=20
> err:
> --=20
> 2.7.4
>=20

