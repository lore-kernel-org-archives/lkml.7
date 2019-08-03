Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F6C0650F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49312086A
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 00:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q3ngW/Ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfHCANp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 20:13:45 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12690 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfHCANo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 20:13:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d44d1b70000>; Fri, 02 Aug 2019 17:13:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 02 Aug 2019 17:13:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 02 Aug 2019 17:13:42 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Aug
 2019 00:13:42 +0000
Subject: Re: [PATCH v4] staging: kpc2000: Convert put_page() to
 put_user_page*()
To:     Bharath Vedartham <linux.bhar@gmail.com>,
        <gregkh@linuxfoundation.org>, <Matt.Sickler@daktronics.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <1564058658-3551-1-git-send-email-linux.bhar@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4467d671-d011-0ebc-e2de-48a9745d4fe6@nvidia.com>
Date:   Fri, 2 Aug 2019 17:13:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564058658-3551-1-git-send-email-linux.bhar@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564791223; bh=xdJekrXrqSEkbcFhdjp7xR8+tNNoUXUqIgXLHmUnwRs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Q3ngW/HtFs5cKcLOFRiDyp/sjKGrf3S/BIpPhC3sg/XAHIkhAPuOkBNsWlaIfZQm+
         DyOw+GoC7Ln++nsmMD6ICDlKHFOoazO5hasrN5Se39NVf4JiW0c0sWVapHhkd1zqVJ
         dAgPBLhMLeWZhlQg/eS3kDbFwwREGPFjShjmIEQwOFYDWJumJqcHn31IVhlLzvXG/5
         xMnItcy5iCsWOKLGXgW1x7XFgwhARbt77SFgA4QKuuOuvOspra98z+moBTUmkoKBUh
         xnNIF9Rn832yv7EMfep7LRQtgtB1yRzPgmhHUnfCkhoTZZSN59Pqt5f96lTYp21RKS
         ClwVCbnz8Yi8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 5:44 AM, Bharath Vedartham wrote:
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page().
>=20
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
>=20

Hi Bharath,

If you like, I could re-post your patch here, modified slightly, as part of
the next version of the miscellaneous call site conversion series [1].

As part of that, we should change this to use put_user_pages_dirty_lock()=20
(see below).


> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Matt Sickler <Matt.Sickler@daktronics.com>
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
> Changes since v1
>         - Improved changelog by John's suggestion.
>         - Moved logic to dirty pages below sg_dma_unmap
>          and removed PageReserved check.
> Changes since v2
>         - Added back PageResevered check as
>         suggested by John Hubbard.
> Changes since v3
>         - Changed the changelog as suggested by John.
>         - Added John's Reviewed-By tag.
> Changes since v4
>         - Rebased the patch on the staging tree.
>         - Improved commit log by fixing a line wrap.
> ---
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/=
kpc2000/kpc_dma/fileops.c
> index 48ca88b..f15e292 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -190,9 +190,7 @@ static int kpc_dma_transfer(struct dev_private_data *=
priv,
>  	sg_free_table(&acd->sgt);
>   err_dma_map_sg:
>   err_alloc_sg_table:
> -	for (i =3D 0 ; i < acd->page_count ; i++) {
> -		put_page(acd->user_pages[i]);
> -	}
> +	put_user_pages(acd->user_pages, acd->page_count);
>   err_get_user_pages:
>  	kfree(acd->user_pages);
>   err_alloc_userpages:
> @@ -211,16 +209,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd,=
 size_t xfr_count, u32 flags)
>  	BUG_ON(acd->ldev =3D=3D NULL);
>  	BUG_ON(acd->ldev->pldev =3D=3D NULL);
> =20
> -	for (i =3D 0 ; i < acd->page_count ; i++) {
> -		if (!PageReserved(acd->user_pages[i])) {
> -			set_page_dirty(acd->user_pages[i]);
> -		}
> -	}
> -
>  	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd-=
>ldev->dir);
> =20
> -	for (i =3D 0 ; i < acd->page_count ; i++) {
> -		put_page(acd->user_pages[i]);
> +	for (i =3D 0; i < acd->page_count; i++) {
> +		if (!PageReserved(acd->user_pages[i]))
> +			put_user_pages_dirty(&acd->user_pages[i], 1);


This would change to:
			put_user_pages_dirty_lock(&acd->user_pages[i], 1, true);


...and we'd add this blurb (this time with CH's name spelled properly) to=20
the commit description:

Note that this effectively changes the code's behavior in
qp_release_pages(): it now ultimately calls set_page_dirty_lock(),
instead of set_page_dirty(). This is probably more accurate.

As Christoph Hellwig put it, "set_page_dirty() is only safe if we are
dealing with a file backed page where we have reference on the inode it
hangs off." [1]

[1] https://lore.kernel.org/r/20190723153640.GB720@lst.de

Also, future: I don't know the driver well enough to say, but maybe "true"=
=20
could be replaced by "acd->ldev->dir =3D=3D DMA_FROM_DEVICE", there, but th=
at
would be a separate patch.


thanks,
--=20
John Hubbard
NVIDIA


> +		else
> +			put_user_page(acd->user_pages[i]);
>  	}
> =20
>  	sg_free_table(&acd->sgt);
>=20
