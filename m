Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F759C48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7AA213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="l69nHg8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfFYMYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:24:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:52047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfFYMYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561465428;
        bh=lXm8L+HzKH4d1mexizCG9D/l2EEEHxMhxU58Jy+QVgI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l69nHg8uMeUijlLFX42gE3vl0S4pCco4bLsthCmG3Y8OxoxuJjE/inb7oJ2k8MCE+
         /x4kYXq4DeYX1OUDoJH5ahj+vNm6lW2k7qRXkIt9tgW7QZ4K9E9PuPyx9tnYjI1dfO
         1qsFRpm7zuqKV5q2KG/LsR5S3KmxCc+efsECkBEQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.144.45]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgvEY-1iK3O60j8I-00oFLO; Tue, 25
 Jun 2019 14:23:48 +0200
Subject: Re: [PATCH 5/7] dma-direct: handle DMA_ATTR_NON_CONSISTENT in common
 code
To:     Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@synopsys.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-6-hch@lst.de>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <3eb32e0b-5aa4-fe1e-e581-038750e11cef@gmx.de>
Date:   Tue, 25 Jun 2019 14:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614144431.21760-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nfaGv5spT8x7rf7B/nqBzz4jCb0tl88kVqyS0ePi/a46YeoZLiC
 pvu/LChtKCtOyQwnbu/2PGhxw+jWzpXSKWioxGckDeya97Lx3cwoH32FkVnTaavmTpoqgZ4
 IRrz56RXE0L7jZuB4moLknQ4guLpgGgbOucwaD02ongelV/zRy9lhHLhKYjt96pGZxBY0p0
 erPXQlmGcA/bkLH9TAUMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/MBv0FfBXkA=:BduY4+NJG7nwJq9PtPoBTJ
 fTTuR9z7MSN0d3rWITsrByvEPjWNvzKHp9lM9xFgiRC28d1KXg3oosND34Ftnav0+KnjxgQ+h
 hcalc7K7bep/1l4etpzwLXrp1UG8ndNHiDteWzAmJlCX5g4zZj+lp0jQiqKtnZKbIe8X//SZ1
 4yVspbAa9YUDUc3+QIW99a8FED92dc/PXAFKcsVGjb8fuBIGWU+X1B2tZVJx1dGdoYyhlatdA
 VvNdQhZ9Bb5QKTTo1iTzw7Hn7YN9bp7rkjmClcX1M9UtTj+PfDXaJLafZXzRzgn4rsyL2SELO
 MeLlIHcO02IeRckoLdwR/YIvbabZKFpfT4nI97tkvKBeyyIq4uxvK0XMFCwESULGopsEFjNQx
 HoxapufaLj+kxHlLcQP+5JeeONvE1Q4RlFkCFGkR9wQpAXBNI2On9rYvOnVW1rZWwH9k7+FwT
 90JghnpVEQLuFIh3qOb/tR4AC5NAkV3hlB2q2/vVEOKplXQukrEJUQo+1f5BHbcbb6hPmSZLE
 9+7ipBdGpX6MtC9uqMcBHn2sOBx1geO92dL+KouOAQRsvuKn+kho4/uuxAwJ6Y5mb2CvxWNDm
 7L4FMhKzyKEDimWpN1DVjVNrzOPQmShx7mXPUAlYlyvAZUBddO8anVXBaladLwVcuge/PGg/S
 iBDdVrrIW6hOS4UA2o5IR0G02YwHFr+TzPCZLCEc+bb+RX0sCMquyOr7fPOndF6YuyQiztAId
 c1x0LmT6l6kqGp6Kov1MzkqQGnm6NWLUJeZznwH16Q3blnlMa4P3mtktWiOzC9ZayMKouMOZP
 0xem64tk2R14YA3Pu7xQoR33qXzCATI8rNFUibKLxoD69gJpqTQ1NLak44QlVFlpfONBrLsk9
 Lr7fEerEo6ThYS1Yj1UkyMGCImkgueEPPDL7p6/Ix7t2SYoP0hyuA0J/kztpjlGNDuc8NLe6W
 1DZykvB+UWifUpEQYoEsW62d0NRueG8ajnettwCt3hLas6jPFQfsqJssn5WHG8Cc6KVxzsbXY
 xtFACec6J8brBbjsvHcB4UqB5JHjaUBvvrzs4plT0+jvz8PXpQklKxk0F9myO6pIqmuYqqDK1
 fi4AAjPLS9NDgI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.19 16:44, Christoph Hellwig wrote:
> Only call into arch_dma_alloc if we require an uncached mapping,
> and remove the parisc code manually doing normal cached
> DMA_ATTR_NON_CONSISTENT allocations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Helge Deller <deller@gmx.de> # parisc

Boot-tested 32-bit kernel on PCX-L and PCX-W2 machines (although
the patches don't cleanly apply any longer against git head).

Helge

> ---
>  arch/parisc/kernel/pci-dma.c | 48 ++++++++++--------------------------
>  kernel/dma/direct.c          |  4 +--
>  2 files changed, 15 insertions(+), 37 deletions(-)
>
> diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
> index 239162355b58..ca35d9a76e50 100644
> --- a/arch/parisc/kernel/pci-dma.c
> +++ b/arch/parisc/kernel/pci-dma.c
> @@ -394,17 +394,20 @@ pcxl_dma_init(void)
>
>  __initcall(pcxl_dma_init);
>
> -static void *pcxl_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
> +void *arch_dma_alloc(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	unsigned long vaddr;
>  	unsigned long paddr;
>  	int order;
>
> +	if (boot_cpu_data.cpu_type !=3D pcxl2 && boot_cpu_data.cpu_type !=3D p=
cxl)
> +		return NULL;
> +
>  	order =3D get_order(size);
>  	size =3D 1 << (order + PAGE_SHIFT);
>  	vaddr =3D pcxl_alloc_range(size);
> -	paddr =3D __get_free_pages(flag | __GFP_ZERO, order);
> +	paddr =3D __get_free_pages(gfp | __GFP_ZERO, order);
>  	flush_kernel_dcache_range(paddr, size);
>  	paddr =3D __pa(paddr);
>  	map_uncached_pages(vaddr, size, paddr);
> @@ -421,44 +424,19 @@ static void *pcxl_dma_alloc(struct device *dev, si=
ze_t size,
>  	return (void *)vaddr;
>  }
>
> -static void *pcx_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
> -{
> -	void *addr;
> -
> -	if ((attrs & DMA_ATTR_NON_CONSISTENT) =3D=3D 0)
> -		return NULL;
> -
> -	addr =3D (void *)__get_free_pages(flag | __GFP_ZERO, get_order(size));
> -	if (addr)
> -		*dma_handle =3D (dma_addr_t)virt_to_phys(addr);
> -
> -	return addr;
> -}
> -
> -void *arch_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> -{
> -
> -	if (boot_cpu_data.cpu_type =3D=3D pcxl2 || boot_cpu_data.cpu_type =3D=
=3D pcxl)
> -		return pcxl_dma_alloc(dev, size, dma_handle, gfp, attrs);
> -	else
> -		return pcx_dma_alloc(dev, size, dma_handle, gfp, attrs);
> -}
> -
>  void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>  		dma_addr_t dma_handle, unsigned long attrs)
>  {
>  	int order =3D get_order(size);
>
> -	if (boot_cpu_data.cpu_type =3D=3D pcxl2 || boot_cpu_data.cpu_type =3D=
=3D pcxl) {
> -		size =3D 1 << (order + PAGE_SHIFT);
> -		unmap_uncached_pages((unsigned long)vaddr, size);
> -		pcxl_free_range((unsigned long)vaddr, size);
> +	WARN_ON_ONCE(boot_cpu_data.cpu_type !=3D pcxl2 &&
> +		     boot_cpu_data.cpu_type !=3D pcxl);
>
> -		vaddr =3D __va(dma_handle);
> -	}
> -	free_pages((unsigned long)vaddr, get_order(size));
> +	size =3D 1 << (order + PAGE_SHIFT);
> +	unmap_uncached_pages((unsigned long)vaddr, size);
> +	pcxl_free_range((unsigned long)vaddr, size);
> +
> +	free_pages((unsigned long)__va(dma_handle), order);
>  }
>
>  void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index c2893713bf80..fc354f4f490b 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -191,7 +191,7 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> -	    !dev_is_dma_coherent(dev))
> +	    dma_alloc_need_uncached(dev, attrs))
>  		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
>  	return dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
>  }
> @@ -200,7 +200,7 @@ void dma_direct_free(struct device *dev, size_t size=
,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
>  	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> -	    !dev_is_dma_coherent(dev))
> +	    dma_alloc_need_uncached(dev, attrs))
>  		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
>  	else
>  		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
>

