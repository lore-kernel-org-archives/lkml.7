Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C116C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EB0206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfDATMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:12:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728716AbfDATMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:12:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31JAs8m004622
        for <linux-kernel@vger.kernel.org>; Mon, 1 Apr 2019 15:12:17 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx031p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 15:12:16 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Apr 2019 20:12:16 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Apr 2019 20:12:12 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x31JCBYi22741130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 19:12:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D86C7B205F;
        Mon,  1 Apr 2019 19:12:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A15B2066;
        Mon,  1 Apr 2019 19:12:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Apr 2019 19:12:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 11AD416C34EA; Mon,  1 Apr 2019 12:12:16 -0700 (PDT)
Date:   Mon, 1 Apr 2019 12:12:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     hpa@zytor.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        dvyukov@google.com, jyknight@google.com, x86@kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] x86/asm: use memory clobber in bitops that touch
 arbitrary memory
Reply-To: paulmck@linux.ibm.com
References: <20190401162408.249668-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401162408.249668-1-glider@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040119-0060-0000-0000-000003270EEF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010856; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01182905; UDB=6.00619247; IPR=6.00963647;
 MB=3.00026248; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-01 19:12:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040119-0061-0000-0000-000048CD4EA6
Message-Id: <20190401191216.GP4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=896 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 06:24:08PM +0200, Alexander Potapenko wrote:
> Certain bit operations that read/write bits take a base pointer and an
> arbitrarily large offset to address the bit relative to that base.
> Inline assembly constraints aren't expressive enough to tell the
> compiler that the assembly directive is going to touch a specific memory
> location of unknown size, therefore we have to use the "memory" clobber
> to indicate that the assembly is going to access memory locations other
> than those listed in the inputs/outputs.
> 
> This particular patch leads to size increase of 124 kernel functions in
> a defconfig build. For some of them the diff is in NOP operations, other
> end up re-reading values from memory and may potentially slow down the
> execution. But without these clobbers the compiler is free to cache
> the contents of the bitmaps and use them as if they weren't changed by
> the inline assembly.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: James Y Knight <jyknight@google.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  arch/x86/include/asm/bitops.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index d153d570bb04..20e4950827d9 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -111,7 +111,7 @@ clear_bit(long nr, volatile unsigned long *addr)
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>  			: BITOP_ADDR(addr)
> -			: "Ir" (nr));
> +			: "Ir" (nr) : "memory");
>  	}
>  }
>  
> @@ -131,7 +131,7 @@ static __always_inline void clear_bit_unlock(long nr, volatile unsigned long *ad
>  
>  static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
>  {
> -	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr));
> +	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr) : "memory");
>  }
>  
>  static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
> @@ -176,7 +176,7 @@ static __always_inline void __clear_bit_unlock(long nr, volatile unsigned long *
>   */
>  static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
>  {
> -	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr));
> +	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr) : "memory");
>  }
>  
>  /**
> @@ -197,7 +197,7 @@ static __always_inline void change_bit(long nr, volatile unsigned long *addr)
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
>  			: BITOP_ADDR(addr)
> -			: "Ir" (nr));
> +			: "Ir" (nr) : "memory");
>  	}
>  }
>  
> @@ -243,7 +243,7 @@ static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *
>  	asm(__ASM_SIZE(bts) " %2,%1"
>  	    CC_SET(c)
>  	    : CC_OUT(c) (oldbit), ADDR
> -	    : "Ir" (nr));
> +	    : "Ir" (nr) : "memory");
>  	return oldbit;
>  }
>  
> @@ -283,7 +283,7 @@ static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long
>  	asm volatile(__ASM_SIZE(btr) " %2,%1"
>  		     CC_SET(c)
>  		     : CC_OUT(c) (oldbit), ADDR
> -		     : "Ir" (nr));
> +		     : "Ir" (nr) : "memory");
>  	return oldbit;
>  }
>  
> @@ -326,7 +326,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
>  	asm volatile(__ASM_SIZE(bt) " %2,%1"
>  		     CC_SET(c)
>  		     : CC_OUT(c) (oldbit)
> -		     : "m" (*(unsigned long *)addr), "Ir" (nr));
> +		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
>  
>  	return oldbit;
>  }
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 

