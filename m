Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5FD2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lJ88QZFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDCT3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:29:24 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:43424 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCT3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:29:24 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 4672210C21CA;
        Wed,  3 Apr 2019 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554319764; bh=VwOw8NKGjDhuWj/ytpnB+wbo+Pg/Hr9sYniIX46bAAE=;
        h=From:To:CC:Subject:Date:References:From;
        b=lJ88QZFsPvzhZnEom6BdxRIx91rJVGr7y+WMAJF5AN75ZOgx6u8NnVokfMrGNszRT
         ols0uPuvcSMznzWv27J5HkCYU7Q9rK2tGimfL8NDuf50VFIxaYbp1qsQgHLWP0v74J
         1pP6mdW3Vd7o103K1V49JW66TIUgtXkvHxwAFvGvREvEOIyNyP27VKBdg+N8eA64vJ
         aVAB6pUeQ87FtI0TNToTDdgfyD21oWVMMnmV8w/QcwfToUQAQ8FK1+H41RtCflLruS
         8msEMueD3zvafekfsuPNjZABN3NHfrf9B//ngYiZe2yoGCTT2E2NyixA/bdu5ME+E9
         Q3z7aEe/QaZ8A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9C398A005A;
        Wed,  3 Apr 2019 19:29:23 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 3 Apr 2019 12:29:23 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] ARC: fix memory nodes topology in case of highmem
 enabled
Thread-Topic: [PATCH] ARC: fix memory nodes topology in case of highmem
 enabled
Thread-Index: AQHU6LrOWOMbCHYyAEyuYCAzMbnAdg==
Date:   Wed, 3 Apr 2019 19:29:22 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146440183@US01WEMBX2.internal.synopsys.com>
References: <20190401184242.7636-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 11:43 AM, Eugeniy Paltsev wrote:=0A=
> Tweak generic node topology in case of CONFIG_HIGHMEM enabled to=0A=
> prioritize allocations from ZONE_HIGHMEM to avoid ZONE_NORMAL=0A=
> pressure.=0A=
=0A=
Can you explain the "pressure" part a bit more concretely - as in when did =
you saw=0A=
crashes, oom, yadi yada ....=0A=
=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
> Tested on both NSIM and HSDK (require memory apertures remmaping and=0A=
> device tree patching)=0A=
=0A=
How can one test this patch w/o those - are they secret which rest of world=
 should=0A=
not know about :-)=0A=
Jokes apart, at the very least, please include them as part of changelog "a=
s=0A=
indicative code" which people can use in testing if needed.=0A=
Preferably they need to be part of platform code under the right config (HI=
GHMEM +=0A=
PAE etc)=0A=
=0A=
FWIW as mentioned on other thread, for my setup of PAE + 2GB  HIGHMEM (so 2=
 nodes)=0A=
1. I didn't need any AXI aperture remapping=0A=
2. Didn't see any extra mem pressure / failures when running glibc testsuit=
e=0A=
=0A=
>=0A=
>  arch/arc/include/asm/Kbuild     |  1 -=0A=
>  arch/arc/include/asm/topology.h | 30 ++++++++++++++++++++++++++++++=0A=
>  2 files changed, 30 insertions(+), 1 deletion(-)=0A=
>  create mode 100644 arch/arc/include/asm/topology.h=0A=
>=0A=
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild=0A=
> index caa270261521..e64e0439baff 100644=0A=
> --- a/arch/arc/include/asm/Kbuild=0A=
> +++ b/arch/arc/include/asm/Kbuild=0A=
> @@ -18,7 +18,6 @@ generic-y +=3D msi.h=0A=
>  generic-y +=3D parport.h=0A=
>  generic-y +=3D percpu.h=0A=
>  generic-y +=3D preempt.h=0A=
> -generic-y +=3D topology.h=0A=
>  generic-y +=3D trace_clock.h=0A=
>  generic-y +=3D user.h=0A=
>  generic-y +=3D vga.h=0A=
> diff --git a/arch/arc/include/asm/topology.h b/arch/arc/include/asm/topol=
ogy.h=0A=
> new file mode 100644=0A=
> index 000000000000..c273506931c9=0A=
> --- /dev/null=0A=
> +++ b/arch/arc/include/asm/topology.h=0A=
> @@ -0,0 +1,30 @@=0A=
> +#ifndef _ASM_ARC_TOPOLOGY_H=0A=
> +#define _ASM_ARC_TOPOLOGY_H=0A=
> +=0A=
> +/*=0A=
> + * On ARC (w/o PAE) HIGHMEM addresses are smaller (0x0 based) than addre=
sses in=0A=
> + * NORMAL aka low memory (0x8000_0000 based).=0A=
> + * Thus HIGHMEM on ARC is imlemented with DISCONTIGMEM which requires mu=
ltiple=0A=
=0A=
s/imlemented/implemented=0A=
> + * nodes. So here is memory node map depending on the CONFIG_HIGHMEM=0A=
> + * enabled/disabled:=0A=
> + *=0A=
> + * CONFIG_HIGHMEM disabled:=0A=
> + *  - node 0: ZONE_NORMAL memory only.=0A=
> + *=0A=
> + * CONFIG_HIGHMEM enabled:=0A=
> + *  - node 0: ZONE_NORMAL memory only.=0A=
> + *  - node 1: ZONE_HIGHMEM memory only.=0A=
=0A=
Perhaps we could reduce the text above by having 2 lines and adding a "()" =
comment=0A=
for node 1=0A=
=0A=
+ *  - node 0: ZONE_NORMAL memory  (always)=0A=
+ *  - node 1: ZONE_HIGHMEM memory (HIGHMEM only)=0A=
=0A=
=0A=
=0A=
> + *=0A=
> + * In case of CONFIG_HIGHMEM enabled we tweak generic node topology and =
mark=0A=
> + * node 1 as the closest to all CPUs to prioritize allocations from ZONE=
_HIGHMEM=0A=
> + * where it is possible to avoid ZONE_NORMAL pressure.=0A=
> + */=0A=
> +#ifdef CONFIG_HIGHMEM=0A=
> +#define cpu_to_node(cpu)	((void)(cpu), 1)=0A=
> +#define cpu_to_mem(cpu)		((void)(cpu), 1)=0A=
> +#define cpumask_of_node(node)	((node) =3D=3D 1 ? cpu_online_mask : cpu_n=
one_mask)=0A=
> +#endif /* CONFIG_HIGHMEM */=0A=
> +=0A=
> +#include <asm-generic/topology.h>=0A=
> +=0A=
> +#endif /* _ASM_ARC_TOPOLOGY_H */=0A=
=0A=
Otherwise LGTM. I would like to give this a spin myself, but first need to =
know=0A=
what tests cause the increased failures which this patch mitigates.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
