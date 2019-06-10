Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF6C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0D220820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="S+LGW0Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfFJTUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:20:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33234 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387674AbfFJTUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:20:34 -0400
Received: from zn.tnic (p200300EC2F052B000C22B0A0C73B2F50.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2b00:c22:b0a0:c73b:2f50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08E371EC028C;
        Mon, 10 Jun 2019 21:20:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560194432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xxCXT9OKK1v5ESsvG4S6KsVbQbx8GC4XzBvX1zTEGIU=;
        b=S+LGW0QoH1i2NOU0vWiLwIh6m2F/Mw8WrG7smVcaGK0ISYKStqFcHh7LO0uH1YDlxplicK
        sLNTvqPvFkZfdyaKXq5b1wIYShJOaLGbhquh7t+n0UySQrDjupDDILfkGkF05Ep9JhVkpJ
        lceruCEwrUJu+vp0SS+21ldzB0xGrT4=
Date:   Mon, 10 Jun 2019 21:20:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190610192026.GI5488@zn.tnic>
References: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:02:38AM -0700, Fenghua Yu wrote:
> AVX512 Vector Neural Network Instructions (VNNI) in Intel Deep Learning
> Boost support bfloat16 format (BF16). BF16 is a short version of FP32 and
> has several advantages over FP16. BF16 offers more than enough range for
> deep learning training tasks and doesn't need to handle hardware exception
> as this is a performance optimization. FP32 accumulation after the
> multiply is essential to achieve sufficient numerical behavior on an
> application level. 
> 
> AVX512 bfloat16 instructions can be enumerated by:
> 	CPUID.(EAX=7,ECX=1):EAX[bit 5] AVX512_BF16
>     
> Detailed information of the CPUID bit and AVX512 bfloat16 instructions
> can be found in the latest Intel Architecture Instruction Set Extensions
> and Future Features Programming Reference.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> 
> Since split lock feature (to-be-upstreamed) occupies the last bit 
> of word 7, need to create a new word 19 to host AVX512_BF16 and other
> future features.

Is CPUID.(EAX=7,ECX=1):EAX going to contain only feature bits? If so,
just make it a proper feature word instead of a linux-specific one.

Also, while on the subject, you can recycle word 11

/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:0 (EDX), word 11 */
#define X86_FEATURE_CQM_LLC             (11*32+ 1) /* LLC QoS if 1 */

and move it to scattered as it is a complete waste. Word 12 too, for
that matter. But do that in separate patches.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
