Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B079CC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F917216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfGHOYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:24:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725869AbfGHOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:24:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68ENmOK148314
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 10:24:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tm4eqyjk8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:23:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 8 Jul 2019 15:21:55 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 15:21:52 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68ELpKF57540610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 14:21:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABF5C52054;
        Mon,  8 Jul 2019 14:21:51 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.86.140])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BFB005204F;
        Mon,  8 Jul 2019 14:21:49 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] powerpc/64: reuse PPC32 static inline flush_dcache_range()
In-Reply-To: <d6f628ffdeb9c7863da722a8f6ef2949e57bb360.1557824379.git.christophe.leroy@c-s.fr>
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr> <d6f628ffdeb9c7863da722a8f6ef2949e57bb360.1557824379.git.christophe.leroy@c-s.fr>
Date:   Mon, 08 Jul 2019 19:51:46 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19070814-0028-0000-0000-00000381FCA9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070814-0029-0000-0000-000024420592
Message-Id: <87y318d2th.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch drops the assembly PPC64 version of flush_dcache_range()
> and re-uses the PPC32 static inline version.
>
> With GCC 8.1, the following code is generated:
>
> void flush_test(unsigned long start, unsigned long stop)
> {
> 	flush_dcache_range(start, stop);
> }
>
> 0000000000000130 <.flush_test>:
>  130:	3d 22 00 00 	addis   r9,r2,0
> 			132: R_PPC64_TOC16_HA	.data+0x8
>  134:	81 09 00 00 	lwz     r8,0(r9)
> 			136: R_PPC64_TOC16_LO	.data+0x8
>  138:	3d 22 00 00 	addis   r9,r2,0
> 			13a: R_PPC64_TOC16_HA	.data+0xc
>  13c:	80 e9 00 00 	lwz     r7,0(r9)
> 			13e: R_PPC64_TOC16_LO	.data+0xc
>  140:	7d 48 00 d0 	neg     r10,r8
>  144:	7d 43 18 38 	and     r3,r10,r3
>  148:	7c 00 04 ac 	hwsync
>  14c:	4c 00 01 2c 	isync
>  150:	39 28 ff ff 	addi    r9,r8,-1
>  154:	7c 89 22 14 	add     r4,r9,r4
>  158:	7c 83 20 50 	subf    r4,r3,r4
>  15c:	7c 89 3c 37 	srd.    r9,r4,r7
>  160:	41 82 00 1c 	beq     17c <.flush_test+0x4c>
>  164:	7d 29 03 a6 	mtctr   r9
>  168:	60 00 00 00 	nop
>  16c:	60 00 00 00 	nop
>  170:	7c 00 18 ac 	dcbf    0,r3
>  174:	7c 63 42 14 	add     r3,r3,r8
>  178:	42 00 ff f8 	bdnz    170 <.flush_test+0x40>
>  17c:	7c 00 04 ac 	hwsync
>  180:	4c 00 01 2c 	isync
>  184:	4e 80 00 20 	blr
>  188:	60 00 00 00 	nop
>  18c:	60 00 00 00 	nop
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/cache.h      | 10 ++++++++++
>  arch/powerpc/include/asm/cacheflush.h | 14 ++++++++------
>  arch/powerpc/kernel/misc_64.S         | 29 -----------------------------
>  3 files changed, 18 insertions(+), 35 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
> index 0009a0a82e86..45e3137ccd71 100644
> --- a/arch/powerpc/include/asm/cache.h
> +++ b/arch/powerpc/include/asm/cache.h
> @@ -54,6 +54,16 @@ struct ppc64_caches {
>  };
>  
>  extern struct ppc64_caches ppc64_caches;
> +
> +static inline u32 l1_cache_shift(void)
> +{
> +	return ppc64_caches.l1d.log_block_size;
> +}
> +
> +static inline u32 l1_cache_bytes(void)
> +{
> +	return ppc64_caches.l1d.block_size;
> +}
>  #else
>  static inline u32 l1_cache_shift(void)
>  {
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> index d405f18441cd..3cd7ce3dec8b 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -57,7 +57,6 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
>  }
>  #endif
>  
> -#ifdef CONFIG_PPC32
>  /*
>   * Write any modified data cache blocks out to memory and invalidate them.
>   * Does not invalidate the corresponding instruction cache blocks.
> @@ -70,9 +69,17 @@ static inline void flush_dcache_range(unsigned long start, unsigned long stop)
>  	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
>  	unsigned long i;
>  
> +	if (IS_ENABLED(CONFIG_PPC64)) {
> +		mb();	/* sync */
> +		isync();
> +	}
> +
>  	for (i = 0; i < size >> shift; i++, addr += bytes)
>  		dcbf(addr);
>  	mb();	/* sync */
> +
> +	if (IS_ENABLED(CONFIG_PPC64))
> +		isync();
>  }


Was checking with Michael about why we need that extra isync. Michael 
pointed this came via 

https://github.com/mpe/linux-fullhistory/commit/faa5ee3743ff9b6df9f9a03600e34fdae596cfb2#diff-67c7ffa8e420c7d4206cae4a9e888e14

for 970 which doesn't have coherent icache. So possibly isync there is
to flush the prefetch instructions? But even so we would need an icbi
there before that isync.

So overall wondering why we need that extra barriers there. 

>  
>  /*
> @@ -112,11 +119,6 @@ static inline void invalidate_dcache_range(unsigned long start,
>  	mb();	/* sync */
>  }
>  

-aneesh

