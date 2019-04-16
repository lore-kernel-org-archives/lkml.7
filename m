Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C0DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057002075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FGhQoZ2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfDPRvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:51:45 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:49156 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfDPRvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:51:45 -0400
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9B20B24E10CA;
        Tue, 16 Apr 2019 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555437104; bh=ePteVM7cTAdhhuh99GW2efdephiUiCBfaVHqbdjGLaM=;
        h=From:To:CC:Subject:Date:References:From;
        b=FGhQoZ2s4t/Uu6E4W+wmPpeIgWwZo5vcCy1AM9wbPjgro5Z4/c0L4d14kbj62gRoq
         qP6XY9m9E1ru472QzzOvugt2krKYoO6ZvkRxbVgHG6y0WXdFoTpqea+1tZ3hEyKgna
         Pzqa/Uv6N7vXJwSklQ2x7U5rFAVUy49wd4uEavVLMb/Sgqk/aQI+3pcntNxnz0T23S
         hmp5Q36TImvqX1HGq7B8ZYpV8imvpbHdR+1RvuoEOqdtETqmVAjHyVBu+9OQ6/2CCv
         crQGTxhFPywCB6Al1wdHDO1MKQWu1Lx8mrmguCA0m2E/DgfHkgXPflf97xEaGwYNRE
         +tQ6hBNGnE2ow==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 86EF9A0070;
        Tue, 16 Apr 2019 17:51:44 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue, 16
 Apr 2019 10:51:43 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 3/3] ARC: cache: allow to autodetect L1 cache line size
Thread-Topic: [PATCH 3/3] ARC: cache: allow to autodetect L1 cache line size
Thread-Index: AQHU9HdPY22PWE0M8kWs6L4fooB6xA==
Date:   Tue, 16 Apr 2019 17:51:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A250164E@us01wembx1.internal.synopsys.com>
References: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
 <20190416171021.20049-4-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 10:10 AM, Eugeniy Paltsev wrote:=0A=
> One step to "build once run anywhere"=0A=
=0A=
This is what I'm afraid is going to happen. We will slowly sneak this into=
=0A=
defconfigs and this will become the default. Occasional need for verificati=
on=0A=
doesn't necessarily need this complexity to be maintained. Not all hacks ne=
ed to=0A=
be upstream.=0A=
=0A=
> Allow to autodetect L1 I/D caches line size in runtime instead of=0A=
> relying on value provided via Kconfig.=0A=
>=0A=
> This is controlled via CONFIG_ARC_CACHE_LINE_AUTODETECT Kconfig option=0A=
> which is disabled by default.=0A=
>  * In case of this option disabled there is no overhead in compare with=
=0A=
>    current implementation.=0A=
>  * In case of this option enabled there is some overhead in both speed=0A=
>    and code size:=0A=
>    - we use cache line size stored in the global variable instead of=0A=
>      compile time available define, so compiler can't do some=0A=
>      optimizations.=0A=
>    - we align all cache related buffers by maximum possible cache line=0A=
>      size. Nevertheless it isn't significant because we mostly use=0A=
>      SMP_CACHE_BYTES or ARCH_DMA_MINALIGN to align stuff (they are=0A=
>      equal to maximum possible cache line size)=0A=
>=0A=
> Main change is the split L1_CACHE_BYTES for two separate defines:=0A=
>  * L1_CACHE_BYTES      >=3D real L1 I$/D$ line size.=0A=
>    Available at compile time. Used for alligning stuff.=0A=
>  * CACHEOPS_L1_LINE_SZ =3D=3D real L1 I$/D$ line size.=0A=
>    Available at run time. Used in operations with cache lines/regions.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/Kconfig             | 10 +++++=0A=
>  arch/arc/include/asm/cache.h |  9 ++++-=0A=
>  arch/arc/lib/memset-archs.S  |  8 +++-=0A=
>  arch/arc/mm/cache.c          | 89 ++++++++++++++++++++++++++++++++++----=
------=0A=
>  4 files changed, 94 insertions(+), 22 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
> index c781e45d1d99..e7eb5ff1485d 100644=0A=
> --- a/arch/arc/Kconfig=0A=
> +++ b/arch/arc/Kconfig=0A=
> @@ -215,10 +215,20 @@ menuconfig ARC_CACHE=0A=
>  =0A=
>  if ARC_CACHE=0A=
>  =0A=
> +config ARC_CACHE_LINE_AUTODETECT=0A=
> +	bool "Detect cache lines length automatically in runtime"=0A=
> +	depends on ARC_HAS_ICACHE || ARC_HAS_DCACHE=0A=
> +	help=0A=
> +	  ARC has configurable cache line length. Enable this option to detect=
=0A=
> +	  all cache lines length automatically in runtime to make kernel image=
=0A=
> +	  runnable on HW with different cache lines configuration.=0A=
> +	  If you don't know what the above means, leave this setting alone.=0A=
> +=0A=
>  config ARC_CACHE_LINE_SHIFT=0A=
>  	int "Cache Line Length (as power of 2)"=0A=
>  	range 5 7=0A=
>  	default "6"=0A=
> +	depends on !ARC_CACHE_LINE_AUTODETECT=0A=
>  	help=0A=
>  	  Starting with ARC700 4.9, Cache line length is configurable,=0A=
>  	  This option specifies "N", with Line-len =3D 2 power N=0A=
> diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h=
=0A=
> index f1642634aab0..0ff8e19008e4 100644=0A=
> --- a/arch/arc/include/asm/cache.h=0A=
> +++ b/arch/arc/include/asm/cache.h=0A=
> @@ -15,15 +15,22 @@=0A=
>  #define SMP_CACHE_BYTES		ARC_MAX_CACHE_BYTES=0A=
>  #define ARCH_DMA_MINALIGN	ARC_MAX_CACHE_BYTES=0A=
>  =0A=
> +#if IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT)=0A=
> +/*=0A=
> + * This must be used for aligning only. In case of cache line autodetect=
 it is=0A=
> + * only safe to use maximum possible value here.=0A=
> + */=0A=
> +#define L1_CACHE_SHIFT		ARC_MAX_CACHE_SHIFT=0A=
> +#else=0A=
>  /* In case $$ not config, setup a dummy number for rest of kernel */=0A=
>  #ifndef CONFIG_ARC_CACHE_LINE_SHIFT=0A=
>  #define L1_CACHE_SHIFT		6=0A=
>  #else=0A=
>  #define L1_CACHE_SHIFT		CONFIG_ARC_CACHE_LINE_SHIFT=0A=
>  #endif=0A=
> +#endif /* IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT) */=0A=
>  =0A=
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)=0A=
> -#define CACHE_LINE_MASK		(~(L1_CACHE_BYTES - 1))=0A=
>  =0A=
>  /*=0A=
>   * ARC700 doesn't cache any access in top 1G (0xc000_0000 to 0xFFFF_FFFF=
)=0A=
> diff --git a/arch/arc/lib/memset-archs.S b/arch/arc/lib/memset-archs.S=0A=
> index b3373f5c88e0..4baeeea29482 100644=0A=
> --- a/arch/arc/lib/memset-archs.S=0A=
> +++ b/arch/arc/lib/memset-archs.S=0A=
> @@ -16,9 +16,15 @@=0A=
>   * line lengths (32B and 128B) you should rewrite code carefully checkin=
g=0A=
>   * we don't call any prefetchw/prealloc instruction for L1 cache lines w=
hich=0A=
>   * don't belongs to memset area.=0A=
> + *=0A=
> + * TODO: FIXME: as for today we chose not optimized memset implementatio=
n if we=0A=
> + * enable ARC_CACHE_LINE_AUTODETECT option (as we don't know L1 cache li=
ne=0A=
> + * size in compile time).=0A=
> + * One possible way to fix this is to declare memset as a function point=
er and=0A=
> + * update it when we discover actual cache line size.=0A=
>   */=0A=
>  =0A=
> -#if L1_CACHE_SHIFT =3D=3D 6=0A=
> +#if (!IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT)) && (L1_CACHE_SHIFT =
=3D=3D 6)=0A=
>  =0A=
>  .macro PREALLOC_INSTR	reg, off=0A=
>  	prealloc	[\reg, \off]=0A=
=0A=
You really want verification testing to hit these instructions....=0A=
=0A=
> diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c=0A=
> index 1036bd56f518..8d006c1d12a1 100644=0A=
> --- a/arch/arc/mm/cache.c=0A=
> +++ b/arch/arc/mm/cache.c=0A=
> @@ -25,6 +25,22 @@=0A=
>  #define USE_RGN_FLSH	1=0A=
>  #endif=0A=
>  =0A=
> +/*=0A=
> + * Cache line defines and real L1 I$/D$ line size relations:=0A=
> + *=0A=
> + * L1_CACHE_BYTES      >=3D real L1 I$/D$ line size. Available at compil=
e time.=0A=
=0A=
Call it "Max possible line size" compile time constant=0A=
=0A=
> + * CACHEOPS_L1_LINE_SZ =3D=3D real L1 I$/D$ line size. Available at run =
time.=0A=
> + */=0A=
> +#if IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT)=0A=
> +#define CACHEOPS_L1_LINE_SZ		l1_line_sz=0A=
> +#define CACHEOPS_L1_LINE_MASK		l1_line_mask=0A=
> +#else=0A=
> +#define CACHEOPS_L1_LINE_SZ		L1_CACHE_BYTES=0A=
> +#define CACHEOPS_L1_LINE_MASK		(~((CACHEOPS_L1_LINE_SZ) - 1))=0A=
> +#endif /* IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT) */=0A=
> +=0A=
> +static unsigned int l1_line_sz;=0A=
> +static unsigned long l1_line_mask;=0A=
>  static int l2_line_sz;=0A=
>  static int ioc_exists;=0A=
>  int slc_enable =3D 1, ioc_enable =3D 1;=0A=
> @@ -256,19 +272,19 @@ void __cache_line_loop_v2(phys_addr_t paddr, unsign=
ed long vaddr,=0A=
>  	 *  -@sz will be integral multiple of line size (being page sized).=0A=
>  	 */=0A=
>  	if (!full_page) {=0A=
> -		sz +=3D paddr & ~CACHE_LINE_MASK;=0A=
> -		paddr &=3D CACHE_LINE_MASK;=0A=
> -		vaddr &=3D CACHE_LINE_MASK;=0A=
> +		sz +=3D paddr & ~CACHEOPS_L1_LINE_MASK;=0A=
> +		paddr &=3D CACHEOPS_L1_LINE_MASK;=0A=
> +		vaddr &=3D CACHEOPS_L1_LINE_MASK;=0A=
>  	}=0A=
>  =0A=
> -	num_lines =3D DIV_ROUND_UP(sz, L1_CACHE_BYTES);=0A=
> +	num_lines =3D DIV_ROUND_UP(sz, CACHEOPS_L1_LINE_SZ);=0A=
>  =0A=
>  	/* MMUv2 and before: paddr contains stuffed vaddrs bits */=0A=
>  	paddr |=3D (vaddr >> PAGE_SHIFT) & 0x1F;=0A=
>  =0A=
>  	while (num_lines-- > 0) {=0A=
>  		write_aux_reg(aux_cmd, paddr);=0A=
> -		paddr +=3D L1_CACHE_BYTES;=0A=
> +		paddr +=3D CACHEOPS_L1_LINE_SZ;=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> @@ -302,11 +318,11 @@ void __cache_line_loop_v3(phys_addr_t paddr, unsign=
ed long vaddr,=0A=
>  	 *  -@sz will be integral multiple of line size (being page sized).=0A=
>  	 */=0A=
>  	if (!full_page) {=0A=
> -		sz +=3D paddr & ~CACHE_LINE_MASK;=0A=
> -		paddr &=3D CACHE_LINE_MASK;=0A=
> -		vaddr &=3D CACHE_LINE_MASK;=0A=
> +		sz +=3D paddr & ~CACHEOPS_L1_LINE_MASK;=0A=
> +		paddr &=3D CACHEOPS_L1_LINE_MASK;=0A=
> +		vaddr &=3D CACHEOPS_L1_LINE_MASK;=0A=
>  	}=0A=
> -	num_lines =3D DIV_ROUND_UP(sz, L1_CACHE_BYTES);=0A=
> +	num_lines =3D DIV_ROUND_UP(sz, CACHEOPS_L1_LINE_SZ);=0A=
>  =0A=
>  	/*=0A=
>  	 * MMUv3, cache ops require paddr in PTAG reg=0A=
> @@ -328,11 +344,11 @@ void __cache_line_loop_v3(phys_addr_t paddr, unsign=
ed long vaddr,=0A=
>  	while (num_lines-- > 0) {=0A=
>  		if (!full_page) {=0A=
>  			write_aux_reg(aux_tag, paddr);=0A=
> -			paddr +=3D L1_CACHE_BYTES;=0A=
> +			paddr +=3D CACHEOPS_L1_LINE_SZ;=0A=
>  		}=0A=
>  =0A=
>  		write_aux_reg(aux_cmd, vaddr);=0A=
> -		vaddr +=3D L1_CACHE_BYTES;=0A=
> +		vaddr +=3D CACHEOPS_L1_LINE_SZ;=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> @@ -372,11 +388,11 @@ void __cache_line_loop_v4(phys_addr_t paddr, unsign=
ed long vaddr,=0A=
>  	 *  -@sz will be integral multiple of line size (being page sized).=0A=
>  	 */=0A=
>  	if (!full_page) {=0A=
> -		sz +=3D paddr & ~CACHE_LINE_MASK;=0A=
> -		paddr &=3D CACHE_LINE_MASK;=0A=
> +		sz +=3D paddr & ~CACHEOPS_L1_LINE_MASK;=0A=
> +		paddr &=3D CACHEOPS_L1_LINE_MASK;=0A=
>  	}=0A=
>  =0A=
> -	num_lines =3D DIV_ROUND_UP(sz, L1_CACHE_BYTES);=0A=
> +	num_lines =3D DIV_ROUND_UP(sz, CACHEOPS_L1_LINE_SZ);=0A=
>  =0A=
>  	/*=0A=
>  	 * For HS38 PAE40 configuration=0A=
> @@ -396,7 +412,7 @@ void __cache_line_loop_v4(phys_addr_t paddr, unsigned=
 long vaddr,=0A=
>  =0A=
>  	while (num_lines-- > 0) {=0A=
>  		write_aux_reg(aux_cmd, paddr);=0A=
> -		paddr +=3D L1_CACHE_BYTES;=0A=
> +		paddr +=3D CACHEOPS_L1_LINE_SZ;=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> @@ -422,14 +438,14 @@ void __cache_line_loop_v4(phys_addr_t paddr, unsign=
ed long vaddr,=0A=
>  =0A=
>  	if (!full_page) {=0A=
>  		/* for any leading gap between @paddr and start of cache line */=0A=
> -		sz +=3D paddr & ~CACHE_LINE_MASK;=0A=
> -		paddr &=3D CACHE_LINE_MASK;=0A=
> +		sz +=3D paddr & ~CACHEOPS_L1_LINE_MASK;=0A=
> +		paddr &=3D CACHEOPS_L1_LINE_MASK;=0A=
>  =0A=
>  		/*=0A=
>  		 *  account for any trailing gap to end of cache line=0A=
>  		 *  this is equivalent to DIV_ROUND_UP() in line ops above=0A=
>  		 */=0A=
> -		sz +=3D L1_CACHE_BYTES - 1;=0A=
> +		sz +=3D CACHEOPS_L1_LINE_SZ - 1;=0A=
>  	}=0A=
>  =0A=
>  	if (is_pae40_enabled()) {=0A=
> @@ -1215,14 +1231,21 @@ static void arc_l1_line_check(unsigned int line_l=
en, const char *cache_name)=0A=
>  		panic("%s support enabled but non-existent cache\n",=0A=
>  		      cache_name);=0A=
>  =0A=
> -	if (line_len !=3D L1_CACHE_BYTES)=0A=
> +	/*=0A=
> +	 * In case of CONFIG_ARC_CACHE_LINE_AUTODETECT disabled we check=0A=
> +	 * that cache line size is equal to provided via Kconfig,=0A=
> +	 * in case of CONFIG_ARC_CACHE_LINE_AUTODETECT enabled we check=0A=
> +	 * that cache line size is equal for every L1 (I/D) cache on every cpu.=
=0A=
> +	 */=0A=
> +	if (line_len !=3D CACHEOPS_L1_LINE_SZ)=0A=
>  		panic("%s line size [%u] !=3D expected [%u]",=0A=
> -		      cache_name, line_len, L1_CACHE_BYTES);=0A=
> +		      cache_name, line_len, CACHEOPS_L1_LINE_SZ);=0A=
>  }=0A=
>  #endif /* IS_ENABLED(CONFIG_ARC_HAS_ICACHE) || IS_ENABLED(CONFIG_ARC_HAS=
_DCACHE) */=0A=
>  =0A=
>  /*=0A=
>   * Cache related boot time checks needed on every CPU.=0A=
> + * NOTE: This function expects 'l1_line_sz' to be set.=0A=
>   */=0A=
>  static void arc_l1_cache_check(unsigned int cpu)=0A=
>  {=0A=
> @@ -1239,12 +1262,28 @@ static void arc_l1_cache_check(unsigned int cpu)=
=0A=
>   * configuration (we validate this in arc_cache_check()):=0A=
>   *  - Geometry checks=0A=
>   *  - L1 cache line loop callbacks=0A=
> + *  - l1_line_sz / l1_line_mask setup=0A=
>   */=0A=
>  void __init arc_l1_cache_init_master(unsigned int cpu)=0A=
>  {=0A=
> +	/*=0A=
> +	 * 'l1_line_sz' programing model:=0A=
> +	 * We simplify programing of 'l1_line_sz' as we assume that we don't=0A=
> +	 * support case where CPU have different cache configuration.=0A=
> +	 * 1. Assign to 'l1_line_sz' length of any (I/D) L1 cache line of=0A=
> +	 *    master CPU.=0A=
> +	 * 2. Validate 'l1_line_sz' length itself.=0A=
> +	 * 3. Check that both L1 I$/D$ lines on each CPU are equal to=0A=
> +	 *    'l1_line_sz' (or to value provided via Kconfig in case of=0A=
> +	 *     CONFIG_ARC_CACHE_LINE_AUTODETECT is disabled). This is done in=
=0A=
> +	 *     arc_cache_check() which is called for each CPU.=0A=
> +	 */=0A=
> +=0A=
>  	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE)) {=0A=
>  		struct cpuinfo_arc_cache *ic =3D &cpuinfo_arc700[cpu].icache;=0A=
>  =0A=
> +		l1_line_sz =3D ic->line_len;=0A=
> +=0A=
>  		/*=0A=
>  		 * In MMU v4 (HS38x) the aliasing icache config uses IVIL/PTAG=0A=
>  		 * pair to provide vaddr/paddr respectively, just as in MMU v3=0A=
> @@ -1258,6 +1297,8 @@ void __init arc_l1_cache_init_master(unsigned int c=
pu)=0A=
>  	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {=0A=
>  		struct cpuinfo_arc_cache *dc =3D &cpuinfo_arc700[cpu].dcache;=0A=
>  =0A=
> +		l1_line_sz =3D dc->line_len;=0A=
> +=0A=
>  		/* check for D-Cache aliasing on ARCompact: ARCv2 has PIPT */=0A=
>  		if (is_isa_arcompact()) {=0A=
>  			int handled =3D IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);=0A=
> @@ -1274,6 +1315,14 @@ void __init arc_l1_cache_init_master(unsigned int =
cpu)=0A=
>  		}=0A=
>  	}=0A=
>  =0A=
> +	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE) ||=0A=
> +	    IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {=0A=
> +		if (l1_line_sz !=3D 32 && l1_line_sz !=3D 64 && l1_line_sz !=3D 128)=
=0A=
> +			panic("L1 cache line sz [%u] unsupported\n", l1_line_sz);=0A=
> +=0A=
> +		l1_line_mask =3D ~(l1_line_sz - 1);=0A=
> +	}=0A=
> +=0A=
>  	/*=0A=
>  	 * Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger=
=0A=
>  	 * or equal to any cache line length.=0A=
=0A=
