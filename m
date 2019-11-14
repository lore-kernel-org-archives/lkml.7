Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECFFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F875206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573750658;
	bh=76cxCuwjutrp+bNmj1ygtud3m2RfPkOG7V0j/f7WrsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZtpR8R7nk4yHEJZRl52sBw+KC4NEBewxYuoo20JgLVIxB88PI/Z7WEGiSfy0Ldxmf
	 75HWZyaiSPWAxvay3pc1Jft7ej0k8t0xDRNY9EPVxKBgfiC3rG+TgPEwySH48csdQY
	 HaeubIO5mC0FArnWjgNZZgVCstf5n9JuPs+Gr4fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNQ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:57:37 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829C9206D3;
        Thu, 14 Nov 2019 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573750656;
        bh=76cxCuwjutrp+bNmj1ygtud3m2RfPkOG7V0j/f7WrsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZy7g62HQrf2bSQZZNbHSyI8f+w6sE6vWcHX+PzozDU6IOMAY+DZEtSMaeqKrwRqS
         kR1WtOxcHFKF7SN1sAQU5na3yuF6X8dOhgg9cn0UMYNCxJsGRm8rBVqiehVUVmn18l
         X8PmwZSPQG3qqCEk+QNp+WwehrfdvDa+tD8AC2SM=
Date:   Thu, 14 Nov 2019 16:57:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [RESEND PATCH v2] arm64: lse: fix LSE atomics with LLVM's
 integrated assembler
Message-ID: <20191114165730.GC5158@willie-the-truck>
References: <20191031195705.36916-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031195705.36916-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 12:57:05PM -0700, Sami Tolvanen wrote:
> Unlike gcc, clang considers each inline assembly block to be independent
> and therefore, when using the integrated assembler for inline assembly,
> any preambles that enable features must be repeated in each block.
> 
> This change defines __LSE_PREAMBLE and adds it to each inline assembly
> block that has LSE instructions, which allows them to be compiled also
> with clang's assembler.

Any chance LLVM can be fixed to avoid this bodge in the kernel?

Will
