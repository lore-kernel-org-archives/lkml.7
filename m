Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D021C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37282053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SjGlrLrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfLPOYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:24:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38152 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfLPOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:24:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so2977494qki.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xH7Rh+Sv8Avz1lueVqDT1Yxv5WY/6i233yYPIKANZoU=;
        b=SjGlrLrVRpqctVtUTbJuGKVyM+K278q3lPCoB2cw5P3GsxKMy4XD8MLY73pfnypDyT
         UMiohqi+UiQKsTnSJXJqZCnuZmpHYCRs54eY2/jHTlV11oiTn3i40lYYJjgg4Upv9wQo
         OJCU44hoUhgInVlWVqi/B2/FgPacypA/X8QJGjhMKLEfoQ6ZW6SrItdQ6ptGiNQt1y08
         aabNxHzHkmB+/2QRYh7zN95D4AhdK1rGPDj+UAUAysbRw1kY59fI3sfFwP5o0VH47qf0
         yqoSek4eOmZipqQyrqu69FmEufjw+k82bS1zPax1jRsY4vJcTvlqJZZMzLrb0EE51add
         1i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xH7Rh+Sv8Avz1lueVqDT1Yxv5WY/6i233yYPIKANZoU=;
        b=PZ3K8Ecs+25D8rE0vTu85smtt4TE8kpr1JTh15/KtwVRheoGG7OgVTtq5Jt8iGfAM8
         9A35ZXPoeimGwJyYLAoX10TaYIWEJRv/PScUsi6Jtqn8I5m+IIXpDN1hV3RG3Q0rzjB1
         KHQ+/11vw8Cbe8k2qnlrcW0hJDAFKSxFZJKuYtlImZMaK6HhWklfAgMkP26T4pqyYjLw
         vQp54cvdrcbmCKKwwOhMV031wKTHpahDYSvelQECZHGLaG59UPCPnXolokiQq5NoCCHd
         XZgeRvQatBA1RJbsjV9NVZy4E9vwpH4zWlJnFSynnHqAirEzwXejMkReE/eB4qGFU/SN
         k5Ug==
X-Gm-Message-State: APjAAAXYnt3KA5xizTzyBN/3vD+9pe7BmbPAlSUPJzSUUjgSUvNxissB
        HGGYlN06zZ/oWBTQ4EKto9gF7w==
X-Google-Smtp-Source: APXvYqyhRC8+rzu6pngzPj+vH8JcT9xSiO4b+vuls4qHAy8CsW5HgNQQyY5CoMVEWlfzrzmgIY5XUg==
X-Received: by 2002:a05:620a:218a:: with SMTP id g10mr27269472qka.351.1576506270435;
        Mon, 16 Dec 2019 06:24:30 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c8sm635244qtv.61.2019.12.16.06.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:24:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v3] iommu: fix KASAN use-after-free in
 iommu_insert_resv_region
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191126102743.3269-1-eric.auger@redhat.com>
Date:   Mon, 16 Dec 2019 09:24:28 -0500
Cc:     eric.auger.pro@gmail.com, Joerg Roedel <joro@8bytes.org>,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DE725CD-01CD-4E01-B817-9CC7F4768FBC@lca.pw>
References: <20191126102743.3269-1-eric.auger@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 26, 2019, at 5:27 AM, Eric Auger <eric.auger@redhat.com> wrote:
>=20
> In case the new region gets merged into another one, the nr
> list node is freed. Checking its type while completing the
> merge algorithm leads to a use-after-free. Use new->type
> instead.
>=20
> Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
> implementation")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Stable <stable@vger.kernel.org> #v5.3+


Looks like Joerg is away for a few weeks. Could Andrew or Linus pick up =
this=20
use-after-free?

>=20
> ---
>=20
> v2 -> v3:
> - directly use new->type
>=20
> v1 -> v2:
> - remove spurious new line
> ---
> drivers/iommu/iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d658c7c6a2ab..285ad4a4c7f2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -313,7 +313,7 @@ int iommu_insert_resv_region(struct =
iommu_resv_region *new,
> 		phys_addr_t top_end, iter_end =3D iter->start + =
iter->length - 1;
>=20
> 		/* no merge needed on elements of different types than =
@nr */
> -		if (iter->type !=3D nr->type) {
> +		if (iter->type !=3D new->type) {
> 			list_move_tail(&iter->list, &stack);
> 			continue;
> 		}
> --=20
> 2.20.1
>=20

