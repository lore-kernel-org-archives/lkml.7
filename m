Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6739AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF52206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDHO3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:29:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDHO3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:29:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1063F30894ED;
        Mon,  8 Apr 2019 14:29:31 +0000 (UTC)
Received: from [10.43.17.46] (unknown [10.43.17.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E21163F83;
        Mon,  8 Apr 2019 14:29:30 +0000 (UTC)
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
To:     sedat.dilek@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
 <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com>
 <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
 <CA+icZUUw3SgyCdk9fyv+mVUGDepDNGj8Bm7t0WWOE3Q0sHJs4Q@mail.gmail.com>
From:   Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <863a33cf-0a1a-17af-0ea8-42e288f8a1fd@redhat.com>
Date:   Mon, 8 Apr 2019 16:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUUw3SgyCdk9fyv+mVUGDepDNGj8Bm7t0WWOE3Q0sHJs4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 08 Apr 2019 14:29:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 4:23 PM, Sedat Dilek wrote:
> For the .rodata.cst16 part you mean sth. like this?

yes, see below

> --- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
> +++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
> @@ -573,8 +573,12 @@
> ENDPROC(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
>          vmovdqu y7, 15 * 16(rio);
> 
> 
> -/* NB: section is mergeable, all elements must be aligned 16-byte blocks */
> -.section       .rodata.cst16, "aM", @progbits, 16
> +/*
> + * NB: section is mergeable, all elements must be aligned 16-byte blocks
> + * There is more than one object in this section, let's use module name
> + * instead of object name as unique suffix
> + */
> +.section        .rodata.cst16.camellia-aesni-avx-asm_64, "aM", @progbits, 16

dashes in the name may cause problems, replace with '_'.

>   .align 16
> 
>   #define SHUFB_BYTES(idx) \
> diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> index b66bbfa62f50..d6ce36e82a93 100644
> --- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> +++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> @@ -626,8 +626,12 @@
> ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
>          .long 0x00010203, 0x04050607, 0x80808080, 0x80808080
>          .long 0x00010203, 0x04050607, 0x80808080, 0x80808080
> 
> -/* NB: section is mergeable, all elements must be aligned 16-byte blocks */
> -.section       .rodata.cst16, "aM", @progbits, 16
> +/*
> + * NB: section is mergeable, all elements must be aligned 16-byte blocks
> + * There is more than one object in this section, let's use module name
> + * instead of object name as unique suffix
> +*/
> +.section        .rodata.cst16.ccamellia-aesni-avx2-asm_64, "aM", @progbits, 16

dashes in the name may cause problems, replace with '_'.
