Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41248C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC21220872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FqdjvIkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfDPRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:32:18 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:54094 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPRcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:32:18 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 2BC9D10C0AF2;
        Tue, 16 Apr 2019 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555435938; bh=rE9xZ6ycPngSr1UCSjdw09qpxsDbA1pLJTJucvOcJ/4=;
        h=From:To:CC:Subject:Date:References:From;
        b=FqdjvIkHMIZjLmVij9xE4XgY0EdZwJxdi5QrlnCnS4LGhwqWvQHJh14N/JpPfgqLa
         +Rtc7wVATkAiY1k9LbiQkyCZ68Ybibh0Sgc0Zl6l24yMy9bjkFngio/UfKDmkwtYRu
         tCy3dwKviB/eSCyuaoPeQEYhCEikzSX5kIkYGeM2vwEqQaAb3fKlLzAztacTJHltME
         +NLHq9eFO/8W7zCGBlbaiLAWSOwRn/kzz5cImrucOS5kfZTGx3E6qv3Py5GqbMofcZ
         cqTRfQ+JB1OSEv6tWeS5qhmjT5HiXx5MOzfTvx6Vc6Y+MP6K0aDPWXLiOmTLaNs1aW
         TbH2tMUojN1Dw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F2357A006A;
        Tue, 16 Apr 2019 17:32:17 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 16 Apr 2019 10:32:15 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 2/3] ARC: cache: check cache configuration on each CPU
Thread-Topic: [PATCH 2/3] ARC: cache: check cache configuration on each CPU
Thread-Index: AQHU9HdOIiOjMnmMG0iqFYy3fw1ZoA==
Date:   Tue, 16 Apr 2019 17:32:14 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A25015EE@us01wembx1.internal.synopsys.com>
References: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
 <20190416171021.20049-3-Eugeniy.Paltsev@synopsys.com>
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
> ARC kernel code assumes that all cores have same cache config=0A=
> but as of today we check cache configuration only on master CPU.=0A=
> Fix that and check cache configuration on each CPU.=0A=
=0A=
What is broken ? With current hardware it is impossible to have a SMP confi=
g with=0A=
different cache geometry, line size can definitely not be different.=0A=
This is adding needless cycles  for no apparent benefit.=0A=
=0A=
>=0A=
> Also while I'm at it, split cache_init_master() for two parts:=0A=
>  * checks/setups related to master L1 caches=0A=
>  * the rest of cache checks/setups which need to be done once=0A=
>    (like IOC / SLC / dma callbacks setup)=0A=
>=0A=
> Both of these changes are prerequisites for autodetecting cache=0A=
> line size in runtime.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/mm/cache.c | 66 +++++++++++++++++++++++++++++++++++------------=
------=0A=
>  1 file changed, 44 insertions(+), 22 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c=0A=
> index 4135abec3fb0..1036bd56f518 100644=0A=
> --- a/arch/arc/mm/cache.c=0A=
> +++ b/arch/arc/mm/cache.c=0A=
> @@ -1208,27 +1208,43 @@ noinline void __init arc_ioc_setup(void)=0A=
>  	__dc_enable();=0A=
>  }=0A=
>  =0A=
> +#if IS_ENABLED(CONFIG_ARC_HAS_ICACHE) || IS_ENABLED(CONFIG_ARC_HAS_DCACH=
E)=0A=
> +static void arc_l1_line_check(unsigned int line_len, const char *cache_n=
ame)=0A=
> +{=0A=
> +	if (!line_len)=0A=
> +		panic("%s support enabled but non-existent cache\n",=0A=
> +		      cache_name);=0A=
> +=0A=
> +	if (line_len !=3D L1_CACHE_BYTES)=0A=
> +		panic("%s line size [%u] !=3D expected [%u]",=0A=
> +		      cache_name, line_len, L1_CACHE_BYTES);=0A=
> +}=0A=
> +#endif /* IS_ENABLED(CONFIG_ARC_HAS_ICACHE) || IS_ENABLED(CONFIG_ARC_HAS=
_DCACHE) */=0A=
> +=0A=
>  /*=0A=
> - * Cache related boot time checks/setups only needed on master CPU:=0A=
> - *  - Geometry checks (kernel build and hardware agree: e.g. L1_CACHE_BY=
TES)=0A=
> - *    Assume SMP only, so all cores will have same cache config. A check=
 on=0A=
> - *    one core suffices for all=0A=
> - *  - IOC setup / dma callbacks only need to be done once=0A=
> + * Cache related boot time checks needed on every CPU.=0A=
>   */=0A=
> -void __init arc_cache_init_master(void)=0A=
> +static void arc_l1_cache_check(unsigned int cpu)=0A=
>  {=0A=
> -	unsigned int __maybe_unused cpu =3D smp_processor_id();=0A=
> +	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE))=0A=
> +		arc_l1_line_check(cpuinfo_arc700[cpu].icache.line_len, "ICache");=0A=
> +=0A=
> +	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE))=0A=
> +		arc_l1_line_check(cpuinfo_arc700[cpu].dcache.line_len, "DCache");=0A=
> +}=0A=
>  =0A=
> +/*=0A=
> + * L1 Cache related boot time checks/setups needed on master CPU:=0A=
> + * This checks/setups are done in assumption that all CPU have same cach=
e=0A=
> + * configuration (we validate this in arc_cache_check()):=0A=
> + *  - Geometry checks=0A=
> + *  - L1 cache line loop callbacks=0A=
> + */=0A=
> +void __init arc_l1_cache_init_master(unsigned int cpu)=0A=
> +{=0A=
>  	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE)) {=0A=
>  		struct cpuinfo_arc_cache *ic =3D &cpuinfo_arc700[cpu].icache;=0A=
>  =0A=
> -		if (!ic->line_len)=0A=
> -			panic("cache support enabled but non-existent cache\n");=0A=
> -=0A=
> -		if (ic->line_len !=3D L1_CACHE_BYTES)=0A=
> -			panic("ICache line [%d] !=3D kernel Config [%d]",=0A=
> -			      ic->line_len, L1_CACHE_BYTES);=0A=
> -=0A=
>  		/*=0A=
>  		 * In MMU v4 (HS38x) the aliasing icache config uses IVIL/PTAG=0A=
>  		 * pair to provide vaddr/paddr respectively, just as in MMU v3=0A=
> @@ -1242,13 +1258,6 @@ void __init arc_cache_init_master(void)=0A=
>  	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {=0A=
>  		struct cpuinfo_arc_cache *dc =3D &cpuinfo_arc700[cpu].dcache;=0A=
>  =0A=
> -		if (!dc->line_len)=0A=
> -			panic("cache support enabled but non-existent cache\n");=0A=
> -=0A=
> -		if (dc->line_len !=3D L1_CACHE_BYTES)=0A=
> -			panic("DCache line [%d] !=3D kernel Config [%d]",=0A=
> -			      dc->line_len, L1_CACHE_BYTES);=0A=
> -=0A=
>  		/* check for D-Cache aliasing on ARCompact: ARCv2 has PIPT */=0A=
>  		if (is_isa_arcompact()) {=0A=
>  			int handled =3D IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);=0A=
> @@ -1271,6 +1280,14 @@ void __init arc_cache_init_master(void)=0A=
>  	 */=0A=
>  	BUILD_BUG_ON_MSG(L1_CACHE_BYTES > SMP_CACHE_BYTES,=0A=
>  			 "SMP_CACHE_BYTES must be >=3D any cache line length");=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * Cache related boot time checks/setups needed on master CPU:=0A=
> + *  - IOC setup / SLC setup / dma callbacks only need to be done once=0A=
> + */=0A=
> +void __init arc_cache_init_master(void)=0A=
> +{=0A=
>  	if (is_isa_arcv2() && (l2_line_sz > SMP_CACHE_BYTES))=0A=
>  		panic("L2 Cache line [%d] > kernel Config [%d]\n",=0A=
>  		      l2_line_sz, SMP_CACHE_BYTES);=0A=
> @@ -1301,11 +1318,16 @@ void __init arc_cache_init_master(void)=0A=
>  =0A=
>  void __ref arc_cache_init(void)=0A=
>  {=0A=
> -	unsigned int __maybe_unused cpu =3D smp_processor_id();=0A=
> +	unsigned int cpu =3D smp_processor_id();=0A=
>  	char str[256];=0A=
>  =0A=
>  	pr_info("%s", arc_cache_mumbojumbo(0, str, sizeof(str)));=0A=
>  =0A=
> +	if (!cpu)=0A=
> +		arc_l1_cache_init_master(cpu);=0A=
> +=0A=
> +	arc_l1_cache_check(cpu);=0A=
> +=0A=
>  	if (!cpu)=0A=
>  		arc_cache_init_master();=0A=
>  =0A=
=0A=
