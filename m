Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1829EC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C895A206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGC47y/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404582AbfFKMK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:10:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37739 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404538AbfFKMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:10:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so11378101ljf.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=OlBroJpOtG2fAiQi2+KvoYZ55h7JvLYHXpfPaSHKbcw=;
        b=NGC47y/oScIiAjPRt0FCCk38Bgw95mw4KUW9EBh+l0cDo/jcY4/aqjZdbpumuqAXVw
         gqwVpXd7znq5UxpiS9IgeD2t70qUnXLCFNIPgKpPrvTozG+39nZSGiKNMhnuHgiB9Tu2
         Jy7+naSIMp6b800fjfpJg8GMoZW+QP9LaMObqb3RRtO9jo6Zi+D7oWsBd0FpzLC49m0h
         IOOBtRPhPXqbEP/f5rHiip8onkaBqPQaXp8PrdPkCokOI0wc3hGgt/i9ZJDfDTaS8U+8
         usPkV53xrOQ2iYA87gqC7TbPuA1W/ZZ3NU91lQbpL5Cz9OEyX4M4kv1Bx7vBQADLVUPb
         i8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=OlBroJpOtG2fAiQi2+KvoYZ55h7JvLYHXpfPaSHKbcw=;
        b=SmshtHtzvedivUZoAJkF1CWst+PAcGd5zTC931IuZsXWUKXi2CTZ15p5a2WooOM+y3
         IR/aZ3NDL3qELmt6q2fDpRBaGrVaU0gx0UlZ/+VDhpF7wMmrl5Iq6t3RZaj2yYO7qtxA
         lSYV9SfeJTokHgRTNK5lHS+Rw+aXIVt9eRWNMnet52QYpLgQ8evfy+dKN2SZRGWq6bRK
         MVHtNvDIwLRFPkfNr5TRRKmzLFcOQME5cECBu3Zj8e+7f81FpRNtwHlKW4M7XicmlO8L
         CHilbwKv91hDU/TCEdG0aEuvtBzzT2tUmC50TLAIXAMIhfYsTIn1c4PlGjC8/Zh8wxiF
         Gxbg==
X-Gm-Message-State: APjAAAXHQ9a2oaVLkmKtPBQKVnrtijVewtvSHgFs3ctjpqW95Urnm+ms
        PGUcC4oufvaFaZdwhkjTpPc=
X-Google-Smtp-Source: APXvYqyFghm0fy9FrPQ/kDtAwxFSMj8fVEcuO2vbTPQcSN+wWSi9YnRAQEt0OmBJhXzXMjwp+M3Ygg==
X-Received: by 2002:a2e:534a:: with SMTP id t10mr13296112ljd.109.1560255022792;
        Tue, 11 Jun 2019 05:10:22 -0700 (PDT)
Received: from [192.168.100.183] ([178.127.187.52])
        by smtp.gmail.com with ESMTPSA id i70sm1348211lfe.12.2019.06.11.05.10.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 05:10:22 -0700 (PDT)
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
        kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-5-baolu.lu@linux.intel.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v4 4/9] iommu: Add bounce page APIs
Message-ID: <e404133f-dade-6fdf-08e9-6e4f15d23b66@gmail.com>
Date:   Tue, 11 Jun 2019 15:10:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603011620.31999-5-baolu.lu@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8HY8r2VbpWY3BsX5cwXgyfjmdvO62B6De"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8HY8r2VbpWY3BsX5cwXgyfjmdvO62B6De
Content-Type: multipart/mixed; boundary="LDB37ozgWO436JYRUL38NawZGD5NAczTt";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse
 <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
 kevin.tian@intel.com, mika.westerberg@linux.intel.com,
 Ingo Molnar <mingo@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pengfei.xu@intel.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@intel.com>
Message-ID: <e404133f-dade-6fdf-08e9-6e4f15d23b66@gmail.com>
Subject: Re: [PATCH v4 4/9] iommu: Add bounce page APIs
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-5-baolu.lu@linux.intel.com>
In-Reply-To: <20190603011620.31999-5-baolu.lu@linux.intel.com>

--LDB37ozgWO436JYRUL38NawZGD5NAczTt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 03/06/2019 04:16, Lu Baolu wrote:
> IOMMU hardware always use paging for DMA remapping.  The
> minimum mapped window is a page size. The device drivers
> may map buffers not filling whole IOMMU window. It allows
> device to access to possibly unrelated memory and various
> malicious devices can exploit this to perform DMA attack.
>=20
> This introduces the bouce buffer mechanism for DMA buffers
> which doesn't fill a minimal IOMMU page. It could be used
> by various vendor specific IOMMU drivers as long as the
> DMA domain is managed by the generic IOMMU layer. Below
> APIs are added:
>=20
> * iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
>   - Map a buffer start at DMA address @addr in bounce page
>     manner. For buffer parts that doesn't cross a whole
>     minimal IOMMU page, the bounce page policy is applied.
>     A bounce page mapped by swiotlb will be used as the DMA
>     target in the IOMMU page table. Otherwise, the physical
>     address @paddr is mapped instead.
>=20
> * iommu_bounce_unmap(dev, addr, size, dir, attrs)
>   - Unmap the buffer mapped with iommu_bounce_map(). The bounce
>     page will be torn down after the bounced data get synced.
>=20
> * iommu_bounce_sync(dev, addr, size, dir, target)
>   - Synce the bounced data in case the bounce mapped buffer is
>     reused.
>=20
> The whole APIs are included within a kernel option IOMMU_BOUNCE_PAGE.
> It's useful for cases where bounce page doesn't needed, for example,
> embedded cases.
>=20
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/Kconfig |  14 +++++
>  drivers/iommu/iommu.c | 119 ++++++++++++++++++++++++++++++++++++++++++=

>  include/linux/iommu.h |  35 +++++++++++++
>  3 files changed, 168 insertions(+)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 83664db5221d..d837ec3f359b 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -86,6 +86,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
> =20
>  	  If unsure, say N here.
> =20
> +config IOMMU_BOUNCE_PAGE
> +	bool "Use bounce page for untrusted devices"
> +	depends on IOMMU_API
> +	select SWIOTLB
> +	help
> +	  IOMMU hardware always use paging for DMA remapping. The minimum
> +	  mapped window is a page size. The device drivers may map buffers
> +	  not filling whole IOMMU window. This allows device to access to
> +	  possibly unrelated memory and malicious device can exploit this
> +	  to perform a DMA attack. Select this to use a bounce page for the
> +	  buffer which doesn't fill a whole IOMU page.
> +
> +	  If unsure, say N here.
> +
>  config OF_IOMMU
>         def_bool y
>         depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2a906386bb8e..fa44f681a82b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2246,3 +2246,122 @@ int iommu_sva_get_pasid(struct iommu_sva *handl=
e)
>  	return ops->sva_get_pasid(handle);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> +
> +#ifdef CONFIG_IOMMU_BOUNCE_PAGE
> +
> +/*
> + * Bounce buffer support for external devices:
> + *
> + * IOMMU hardware always use paging for DMA remapping. The minimum map=
ped
> + * window is a page size. The device drivers may map buffers not filli=
ng
> + * whole IOMMU window. This allows device to access to possibly unrela=
ted
> + * memory and malicious device can exploit this to perform a DMA attac=
k.
> + * Use bounce pages for the buffer which doesn't fill whole IOMMU page=
s.
> + */
> +
> +static inline size_t
> +get_aligned_size(struct iommu_domain *domain, dma_addr_t addr, size_t =
size)
> +{
> +	unsigned long page_size =3D 1 << __ffs(domain->pgsize_bitmap);
> +	unsigned long offset =3D page_size - 1;
> +
> +	return ALIGN((addr & offset) + size, page_size);
> +}
> +
> +dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
> +			    phys_addr_t paddr, size_t size,
> +			    enum dma_data_direction dir,
> +			    unsigned long attrs)
> +{
> +	struct iommu_domain *domain;
> +	unsigned int min_pagesz;
> +	phys_addr_t tlb_addr;
> +	size_t aligned_size;
> +	int prot =3D 0;
> +	int ret;
> +
> +	domain =3D iommu_get_dma_domain(dev);
> +	if (!domain)
> +		return DMA_MAPPING_ERROR;
> +
> +	if (dir =3D=3D DMA_TO_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL)
> +		prot |=3D IOMMU_READ;
> +	if (dir =3D=3D DMA_FROM_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL)
> +		prot |=3D IOMMU_WRITE;
> +
> +	aligned_size =3D get_aligned_size(domain, paddr, size);
> +	min_pagesz =3D 1 << __ffs(domain->pgsize_bitmap);
> +
> +	/*
> +	 * If both the physical buffer start address and size are
> +	 * page aligned, we don't need to use a bounce page.
> +	 */
> +	if (!IS_ALIGNED(paddr | size, min_pagesz)) {
> +		tlb_addr =3D swiotlb_tbl_map_single(dev,
> +				__phys_to_dma(dev, io_tlb_start),
> +				paddr, size, aligned_size, dir, attrs);
> +		if (tlb_addr =3D=3D DMA_MAPPING_ERROR)
> +			return DMA_MAPPING_ERROR;
> +	} else {
> +		tlb_addr =3D paddr;
> +	}
> +
> +	ret =3D iommu_map(domain, iova, tlb_addr, aligned_size, prot);
> +	if (ret) {
> +		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
> +					 aligned_size, dir, attrs);
You would probably want to check, whether @tlb_addr came from
swiotlb_tbl_map_single. (is_swiotlb_buffer() or reuse predicate above).


> +		return DMA_MAPPING_ERROR;
> +	}
> +
> +	return iova;
> +}
> +EXPORT_SYMBOL_GPL(iommu_bounce_map);
> +
> +static inline phys_addr_t
> +iova_to_tlb_addr(struct iommu_domain *domain, dma_addr_t addr)
> +{
> +	if (unlikely(!domain->ops || !domain->ops->iova_to_phys))
> +		return 0;
> +
> +	return domain->ops->iova_to_phys(domain, addr);
> +}
> +
> +void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t si=
ze,
> +			enum dma_data_direction dir, unsigned long attrs)
> +{
> +	struct iommu_domain *domain;
> +	phys_addr_t tlb_addr;
> +	size_t aligned_size;
> +
> +	domain =3D iommu_get_dma_domain(dev);
> +	if (WARN_ON(!domain))
> +		return;
> +
> +	aligned_size =3D get_aligned_size(domain, iova, size);
> +	tlb_addr =3D iova_to_tlb_addr(domain, iova);
> +	if (WARN_ON(!tlb_addr))
> +		return;
> +
> +	iommu_unmap(domain, iova, aligned_size);
> +	if (is_swiotlb_buffer(tlb_addr))

Is there any chance, this @tlb_addr is a swiotlb buffer, but owned by an
API user? I mean something like
iommu_bounce_map(swiotlb_tbl_map_single()).

Then, to retain ownership semantic, we shouldn't unmap it. Maybe to
check and fail iommu_bounce_map() to be sure?


> +		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
> +					 aligned_size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bounce_unmap);
> +
> +void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t siz=
e,
> +		       enum dma_data_direction dir, enum dma_sync_target target)
> +{
> +	struct iommu_domain *domain;
> +	phys_addr_t tlb_addr;
> +
> +	domain =3D iommu_get_dma_domain(dev);
> +	if (WARN_ON(!domain))
> +		return;
> +
> +	tlb_addr =3D iova_to_tlb_addr(domain, addr);
> +	if (is_swiotlb_buffer(tlb_addr))
> +		swiotlb_tbl_sync_single(dev, tlb_addr, size, dir, target);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bounce_sync);
> +#endif /* CONFIG_IOMMU_BOUNCE_PAGE */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 91af22a344e2..814c0da64692 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -25,6 +25,8 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/swiotlb.h>
> +#include <linux/dma-direct.h>
> =20
>  #define IOMMU_READ	(1 << 0)
>  #define IOMMU_WRITE	(1 << 1)
> @@ -499,6 +501,39 @@ int iommu_sva_set_ops(struct iommu_sva *handle,
>  		      const struct iommu_sva_ops *ops);
>  int iommu_sva_get_pasid(struct iommu_sva *handle);
> =20
> +#ifdef CONFIG_IOMMU_BOUNCE_PAGE
> +dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
> +			    phys_addr_t paddr, size_t size,
> +			    enum dma_data_direction dir,
> +			    unsigned long attrs);
> +void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t si=
ze,
> +			enum dma_data_direction dir, unsigned long attrs);
> +void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t siz=
e,
> +		       enum dma_data_direction dir,
> +		       enum dma_sync_target target);
> +#else
> +static inline
> +dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
> +			    phys_addr_t paddr, size_t size,
> +			    enum dma_data_direction dir,
> +			    unsigned long attrs)
> +{
> +	return DMA_MAPPING_ERROR;
> +}
> +
> +static inline
> +void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t si=
ze,
> +			enum dma_data_direction dir, unsigned long attrs)
> +{
> +}
> +
> +static inline
> +void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t siz=
e,
> +		       enum dma_data_direction dir, enum dma_sync_target target)
> +{
> +}
> +#endif /* CONFIG_IOMMU_BOUNCE_PAGE */
> +
>  #else /* CONFIG_IOMMU_API */
> =20
>  struct iommu_ops {};
>=20

--=20
Yours sincerely,
Pavel Begunkov


--LDB37ozgWO436JYRUL38NawZGD5NAczTt--

--8HY8r2VbpWY3BsX5cwXgyfjmdvO62B6De
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAlz/mikACgkQWt5b1Glr
+6X51xAAhWwjLfuEToubdPY86r3aLoIhRNNK39LP0eQLq+Dj2NvivJ4vEUfSd5wD
/FosMQpqmqo3kiZh2pm10VNdSmG5R3a1QEwRFKavPx8ppMlOlxK8X25CF/cKYXdc
0zzUq4r4Bc1tFjedVHF5OCuYp2ZlghovXogyJKP7pUuDJZBy56gpUHyzlVDvOK9H
ElfN71MXKkNTlOfgTpiEg/S3V2DPSvnWxdxYguhC8dCLVmLKUE2MMGKMuB3Yzkds
w5k5IHwVq5aJGlytxVO+sGtSHnIvXI01xkS+xoYyThQvnBVY0ZDemWnJ8I6aSzY9
MRMSHp7ruWxmwuZi3qt4UaaR6fX3elChGynDBX48DBvFxpeBpn6tBwDp9yyr42gP
FeH5+HdQsWm/tv1lUBVo9Q4w9WlCMAFW+8G2Vq3gDCriLHNswQpZ5ybELXAMUdx2
cMn+zFW2+7q/3sB3Q4JqKWIo4ML2ugW7YcQOH8JKFlkXhTje7qMDxxPRgPuHMsup
WmvkOKzlpFK7BEZTRh1GbzByM2H6gqcFTPoUZuBKU5WO7OowFd0UTUxl11IzepQQ
1e3eDK9e30T4qWncLOoHHtNJvytgHOUci4+YXaMVwBdg8RbilO3+MptZo2ox5XU/
kGAWZROiO5cC4kroRacmC5SYLaW6lGdQnbZLxcCR2owI1shC26U=
=F2bi
-----END PGP SIGNATURE-----

--8HY8r2VbpWY3BsX5cwXgyfjmdvO62B6De--
