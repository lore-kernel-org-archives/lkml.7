Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC4BC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08F82147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hk0wWDkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfFSRbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:31:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfFSRbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:31:50 -0400
Received: from zn.tnic (p200300EC2F109900C181231BF4D53555.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:9900:c181:231b:f4d5:3555])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 862011EC066F;
        Wed, 19 Jun 2019 19:31:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560965508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wm6LlMFx4LPsbw3x7ZJ1QJ9Kv8m+cwMMvl4Y9Skn8fo=;
        b=Hk0wWDkGu8v73FVKv9YuWMwaZttwXeqwCRap0W+Rk0w3rqq104msfhtdjJvgPereHfoYCv
        rrC6TgwujQd7HUBT7b2me1ZaoaB/v69OPNrNAX5X+zuoFXhmbspogUsKkvviUhoaIxekT/
        VJtu98SigligZCeJECAThiQ39wrmkpw=
Date:   Wed, 19 Jun 2019 19:31:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/2] x86/cpufeatures: Enumerate new AVX512 BFLOAT16
 instructions
Message-ID: <20190619173140.GH9574@zn.tnic>
References: <1560794416-217638-1-git-send-email-fenghua.yu@intel.com>
 <1560794416-217638-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560794416-217638-3-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:00:16AM -0700, Fenghua Yu wrote:
> AVX512 Vector Neural Network Instructions (VNNI) in Intel Deep Learning
> Boost support BFLOAT16 format (BF16).

That sentence is a mouthful and I have no clue what it means. Marketing
junk? If so, either rewrite it for mere mortals or kill it.

> BF16 is a short version of FP32

FP32?

Please write out.

> and has several advantages over FP16.

Ditto.

> BF16 offers more than enough range for
> deep learning training tasks and doesn't need to handle hardware exception
> as this is a performance optimization. FP32 accumulation after the
> multiply is essential to achieve sufficient numerical behavior on an
> application level.
> 
> AVX512 BFLOAT16 instructions can be enumerated by:
> 	CPUID.7.1:EAX[bit 5] AVX512_BF16
> 
> Use word 12, which is empty now, to hold features in CPUID.7.1:EAX
> including AVX512_BF16.

... because that leaf is features only, right?

> Leaf CPUID_DUMMY is renamed as CPUID_7_1_EAX.

That's obvious from the patch, ain't it?

> Detailed information of the CPUID bit and AVX512 BFLOAT16 instructions
> can be found in the latest Intel Architecture Instruction Set Extensions
> and Future Features Programming Reference.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
