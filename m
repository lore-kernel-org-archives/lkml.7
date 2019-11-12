Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1BCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F3D21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573561894;
	bh=QIoTmgLL9+NCoBLX5vL2fszGQhlynKU10LrCcwbpAA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ju17WUEWccTw0zl7K7/wOxduMFCDeeF0/DegYQCvYuikoJ29YjRfGelAUifnH/fQi
	 pQaZH1lEUZsL1Qor3vnjhPZmvEALN1hxLgur26ME3NEJ0sitmuHN0vQ/tRFObaqn2G
	 alWbBuUeN/krbTXjhFqize+hPGDReFxqBRnDUItc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKLMbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:31:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfKLMbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:31:31 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88D0206BB;
        Tue, 12 Nov 2019 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573561891;
        bh=QIoTmgLL9+NCoBLX5vL2fszGQhlynKU10LrCcwbpAA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiN+xEcE3ECioNc8n+0M9MDADf1n7To5zWKpKQJPLMrrDZs+mJhSRmfShNKMARppI
         Ap+dEtI7EdftM6yjiCTYCJOmI10rfxCuhunpTZkrN6Id1mVQsfUQLqtj73QmSGZqAY
         QwXR++d1yu2BnKbrFg1mB9w9V1eI5pifRU2X5k6Y=
Date:   Tue, 12 Nov 2019 12:31:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yamada.masahiro@socionext.com, ast@kernel.org, daniel@iogearbox.net
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
Message-ID: <20191112123125.GD17835@willie-the-truck>
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+lkml, Masahiro, Alexei and Daniel]

On Tue, Nov 12, 2019 at 04:56:39PM +0800, Xiao Yang wrote:
> With your patch[1], I alway get the following error when building
> tools/bpf:

In case people want to reproduce this, my branch is here:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto

> ----------------------------------------------------------------------------------
> 
> make -C tools/bpf/
> make: Entering directory
> '/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'
> 
> Auto-detecting system features:
> ... libbfd: [ on ]
> ... disassembler-four-args: [ OFF ]
> 
> CC bpf_jit_disasm.o
> CC bpf_dbg.o
> In file included from
> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
> from
> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
> fatal error: asm/rwonce.h: No such file or directory
> #include <asm/rwonce.h>
> ^
> compilation terminated.
> Makefile:61: recipe for target 'bpf_dbg.o' failed
> make: *** [bpf_dbg.o] Error 1
> make: *** Waiting for unfinished jobs....
> make: Leaving directory
> 
> ----------------------------------------------------------------------------------
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3
> 
> It seems that include/linux/compiler.h cannot find the asm/rwonce.h because
> tools/bpf/Makefile doesn't include arch/*/include/generated/asm/rwonce.h.

The problem with referring to the generated files is that they don't exist
unless you've configured the main source directory. The real problem here
seems to be that tools/bpf/ refers directly to header files in the kernel
sources without any understanding of kbuild, and therefore mandatory-y
headers simply don't exist when it goes looking for them.

Perhaps it's possible to introduce a dependency on a top-level "make
asm-generic" so that we can reference the generated headers from the arch
directly. Thoughts?

Will
