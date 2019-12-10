Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D014FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A685920663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UOQeG+i7";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="QfT56czh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfLJBFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:05:30 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:59836
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbfLJBF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575939928;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=cDQOURu+lrltZUCUGf2b9a0iY5u9Z6E+9rCTbvJ0CNg=;
        b=UOQeG+i7C+ux64CjENBpigVzaz7FbZy9DWOSqIFTp4EZumdjODz+H3+yaZaZikIg
        YArdG3ZQ/1dk6ItvHUOubAlHRTJ+tkbd4mmNS4tPunbGqgvrnU6zFiSi56oSVftFefX
        cgMqIU8fQqwkJ6Ox7C5w3LAt5JZeW6FD82vMNsgY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575939928;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=cDQOURu+lrltZUCUGf2b9a0iY5u9Z6E+9rCTbvJ0CNg=;
        b=QfT56czhnKMNQ1F7j0vd7uqTIRvreK9vKR2gSwHNBNxpXDXEQHIt04KEsLtMsx+t
        mTMCMhl+WwBroUvgYqwaRddfEN57bpjWE0Ewfo+dIgnrqccTZ6ZiMsXFcEvpMT020xE
        utsI2UVXKItxFIhZSsy2hiaHiSuWzCq2Gi5bPr8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FD11C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nick Desaulniers'" <ndesaulniers@google.com>
Cc:     <lee.jones@linaro.org>, <andriy.shevchenko@linux.intel.com>,
        <ztuowen@gmail.com>, <mika.westerberg@linux.intel.com>,
        <mcgrof@kernel.org>, <gregkh@linuxfoundation.org>,
        <alexios.zavras@intel.com>, <allison@lohutok.net>,
        <will@kernel.org>, <rfontana@redhat.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <mingo@redhat.com>,
        <akpm@linux-foundation.org>, <geert@linux-m68k.org>,
        <linux-hexagon@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>,
        <linux-kernel@vger.kernel.org>,
        "'Nathan Chancellor'" <natechancellor@gmail.com>
References: <20191209222956.239798-1-ndesaulniers@google.com> <20191209222956.239798-2-ndesaulniers@google.com>
In-Reply-To: <20191209222956.239798-2-ndesaulniers@google.com>
Subject: RE: [PATCH 1/2] hexagon: define ioremap_uc
Date:   Tue, 10 Dec 2019 01:05:28 +0000
Message-ID: <0101016eed56f28a-58c118b8-face-49c8-af09-0a55a0500d99-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIttLPFE8ad6Ohy6/JIQvGwI+sJfQFJU664pvg3sOA=
Content-Language: en-us
X-SES-Outgoing: 2019.12.10-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of Nick Desaulniers
> Sent: Monday, December 9, 2019 4:30 PM
> To: bcain@codeaurora.org
> Cc: Nick Desaulniers <ndesaulniers@google.com>; lee.jones@linaro.org;
> andriy.shevchenko@linux.intel.com; ztuowen@gmail.com;
> mika.westerberg@linux.intel.com; mcgrof@kernel.org;
> gregkh@linuxfoundation.org; alexios.zavras@intel.com;
> allison@lohutok.net; will@kernel.org; rfontana@redhat.com;
> tglx@linutronix.de; peterz@infradead.org; boqun.feng@gmail.com;
> mingo@redhat.com; akpm@linux-foundation.org; geert@linux-m68k.org;
> linux-hexagon@vger.kernel.org; clang-built-linux@googlegroups.com; linux-
> kernel@vger.kernel.org; Nathan Chancellor <natechancellor@gmail.com>
> Subject: [PATCH 1/2] hexagon: define ioremap_uc
> 
> Similar to
> commit 38e45d81d14e ("sparc64: implement ioremap_uc") define
> ioremap_uc for hexagon to avoid errors from -Wimplicit-function-definition.
> 
> Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
> Link: https://github.com/ClangBuiltLinux/linux/issues/797
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/hexagon/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/hexagon/include/asm/io.h
> b/arch/hexagon/include/asm/io.h index 539e3efcf39c..b0dbc3473172
> 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -173,6 +173,7 @@ static inline void writel(u32 data, volatile void
> __iomem *addr)
> 
>  void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> #define ioremap_nocache ioremap
> +#define ioremap_uc(X, Y) ioremap((X), (Y))
> 
> 
>  #define __raw_writel writel
> --
> 2.24.0.393.g34dc348eaf-goog

Acked-by: Brian Cain <bcain@codeaurora.org>


