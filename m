Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F83EC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD75B20848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558039172;
	bh=tcgjrB3/19sDA33UxnnN4mT/qQLfumYlHg8RU4fVnaY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1yYKQW4+iODaeVU8wyBNo+HGZQNqzGMMgBd44fokwx1gESBOCMndz02Hq9OsCcEKN
	 LzegQAyoStZpxMoq7LUXvqL1cSJIGPg5P9tXTGqgT14AxVCz7P/MyN3uj8pfgjubeU
	 2ieiHWLWJ0Gf/Jgc9lBS2saKt0DQ609wGrEPRq04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfEPUjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 16:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfEPUjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 16:39:31 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8A320818;
        Thu, 16 May 2019 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558039170;
        bh=tcgjrB3/19sDA33UxnnN4mT/qQLfumYlHg8RU4fVnaY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WFE+ITa8xr4GmA613u92s7scZTpWyyw/1AKa5fYjuTeweu9RYwcgIEdNmgfKATXc2
         zE68nlxEWlO1AGpW8ooqqRn1cQvLQsu7KrvywzhsbHBSHGRP8si0JP6y1tVyrQss2O
         SSu9A15JrawNe9HQhmXnJFhv6bvqlJVrLZEZQDto=
Subject: Re: [PATCH for 5.2 07/12] rseq/selftests: s390: use trap4 for
 RSEQ_SIG
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
 <20190429152803.7719-8-mathieu.desnoyers@efficios.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ae4bdd65-d7ab-6bb8-f823-c22e320b4f64@kernel.org>
Date:   Thu, 16 May 2019 14:39:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429152803.7719-8-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 4/29/19 9:27 AM, Mathieu Desnoyers wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Use trap4 as the guard instruction for the restartable sequence abort
> handler.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>   tools/testing/selftests/rseq/rseq-s390.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
> index 7c4f3a70b6c7..1d05c5187ae6 100644
> --- a/tools/testing/selftests/rseq/rseq-s390.h
> +++ b/tools/testing/selftests/rseq/rseq-s390.h
> @@ -1,6 +1,13 @@
>   /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
>   
> -#define RSEQ_SIG	0x53053053
> +/*
> + * RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
> + * access-register mode nor the linkage stack this instruction will always
> + * cause a special-operation exception (the trap-enabled bit in the DUCT
> + * is and will stay 0). The instruction pattern is
> + *	b2 ff 0f ff	trap4   4095(%r0)
> + */
> +#define RSEQ_SIG	0xB2FF0FFF
>   
>   #define rseq_smp_mb()	__asm__ __volatile__ ("bcr 15,0" ::: "memory")
>   #define rseq_smp_rmb()	rseq_smp_mb()
> 

I generated my pull request for Linus and did a sanity check and ran
into merge conflict on this patch. Looks like this is already in
Linus's tree.

Can you confirm!

I have to drop this patch and regenerate my pull request. Can you
confirm!

thanks,
-- Shuah
