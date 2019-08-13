Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7846C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD00420840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565686928;
	bh=lIZNtL4gojHH4sWQIqOF9yVEEqhU5Vt9LRIRR6QoW30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M4QGBSQzbwSHPk19PrTtReWbXZrP+FVNBIXnbXbFb0ueMvOac7v/mpmXWJY9Sm3tu
	 qfUieesr4psB7oWGb25t+kEi9pcFLF+L5f05/4wATQkoweABSZZsLYMyRLVcpjE2BC
	 bRZ/ealLomGTFB8cNS/ufWtKWGyM45ZZ+bh9LLpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfHMJCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbfHMJCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:02:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2143C20840;
        Tue, 13 Aug 2019 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565686925;
        bh=lIZNtL4gojHH4sWQIqOF9yVEEqhU5Vt9LRIRR6QoW30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVOzItnDYzw85kp2QrS+hvwSTcjym4DShBh8/HxiG9vSmIA2QCl4JkxiF8DU+WJ9C
         LdTc3VjyV5FgYQoLNEOJ2CYCX+PK387d5j+FX1YyfRmCE8MWU/OSIo8O/q4RzXngsS
         4xRq9r4M/VuD9hPc9kgdUtjhAaoRg6ueM4NT/dgY=
Date:   Tue, 13 Aug 2019 10:02:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: "arm64/for-next/core" causes boot panic
Message-ID: <20190813090200.h2rz4xphgnb5j5bc@willie-the-truck>
References: <1565646695.8572.6.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565646695.8572.6.camel@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

Thanks for the report.

On Mon, Aug 12, 2019 at 05:51:35PM -0400, Qian Cai wrote:
> Booting today's linux-next on an arm64 server triggers a panic with
> CONFIG_KASAN_SW_TAGS=y pointing to this line,

Is this the only change on top of defconfig? If not, please can you share
your full .config?

> kfree()->virt_to_head_page()->compound_head()
> 
> unsigned long head = READ_ONCE(page->compound_head);
> 
> The bisect so far indicates one of those could be bad,

I guess that means the issue is reproducible on the arm64 for-next/core
branch. Once I have your .config, I'll give it a go.

> [    0.000000][    T0] Unable to handle kernel paging request at virtual address
> 0030ffe001e01588
> [    0.000000][    T0] Mem abort info:
> [    0.000000][    T0]   ESR = 0x96000004
> [    0.000000][    T0]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.000000][    T0]   SET = 0, FnV = 0
> [    0.000000][    T0]   EA = 0, S1PTW = 0
> [    0.000000][    T0] Data abort info:
> [    0.000000][    T0]   ISV = 0, ISS = 0x00000004
> [    0.000000][    T0]   CM = 0, WnR = 0
> [    0.000000][    T0] [0030ffe001e01588] address between user and kernel
> address ranges

Hmm, nice address...

I suppose we're looking at the interaction of 52-bit VA, untagged pointers
and KASAN using sw tags. Lovely.

Thanks, and please keep us updated on the bisection.

Will
