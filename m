Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75431C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C5E20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKTWnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:43:24 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:37287 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKTWnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 17:43:24 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iXYgs-0006FE-Oe; Wed, 20 Nov 2019 22:43:14 +0000
Message-ID: <4faa78cd0a86cf5d0aea9bb16d03145c5745450b.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 07/23] y2038: vdso: powerpc: avoid timespec
 references
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
Date:   Wed, 20 Nov 2019 22:43:13 +0000
In-Reply-To: <20191108210824.1534248-7-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
         <20191108210824.1534248-7-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
[...]
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -15,10 +15,8 @@
>  /* Offset for the low 32-bit part of a field of long type */
>  #if defined(CONFIG_PPC64) && defined(CONFIG_CPU_BIG_ENDIAN)
>  #define LOPART	4
> -#define TSPEC_TV_SEC	TSPC64_TV_SEC+LOPART
>  #else
>  #define LOPART	0
> -#define TSPEC_TV_SEC	TSPC32_TV_SEC
>  #endif
>  
>  	.text
> @@ -192,7 +190,7 @@ V_FUNCTION_BEGIN(__kernel_time)
>  	bl	__get_datapage@local
>  	mr	r9, r3			/* datapage ptr in r9 */
>  
> -	lwz	r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
> +	lwz	r3,STAMP_XTIME_SEC+LOWPART(r9)

"LOWPART" should be "LOPART".

>  
>  	cmplwi	r11,0			/* check if t is NULL */
>  	beq	2f
> @@ -268,7 +266,7 @@ __do_get_tspec:
>  	 * as a 32.32 fixed-point number in r3 and r4.
>  	 * Load & add the xtime stamp.
>  	 */
> -	lwz	r5,STAMP_XTIME+TSPEC_TV_SEC(r9)
> +	lwz	r5,STAMP_XTIME_SEC+LOWPART(r9)

Same here.

>  	lwz	r6,STAMP_SEC_FRAC(r9)
>  	addc	r4,r4,r6
>  	adde	r3,r3,r5
[...]

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

