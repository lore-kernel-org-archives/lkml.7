Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CEEECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A77A2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Gk/m5lFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389728AbfJAPsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:48:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40256 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfJAPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mAjemN3zoy4NN/OBz00OSEPUQdbEoX+3LDmfYoCmeRg=; b=Gk/m5lFU3nP7Hb76nAnEXfpG/
        dxdlqhJPiM95K+QzKvDxeTGznCqoXLGQOgaRflUKryN7ErAQNMNa3j0Vax41fBSawXUHGkAXr+OQE
        hcQ8mgwp4+zl2JxMgNmsyAiEyHyzEjZyTT4KLL/sFmEr01psCAYCXX0QfTg5r33URgFedNK3QqvL4
        xTTSLlw2Adqb7JYYIinG34bhO6BFMBiaUyxG4zAY6k8fVsJGMgytobhwpxvl5X5ZuXaAAfy1DK/jf
        DSiCtENdKYVFx9qm98QjpskmMu5LWhofGMWzGiVw/7y8BRpl6ftbIrWMggt7QnheeZpl+WmzNxhay
        O8MZt9plQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46324)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFKNs-0003Iy-Ob; Tue, 01 Oct 2019 16:48:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFKNq-0008KL-A1; Tue, 01 Oct 2019 16:48:14 +0100
Date:   Tue, 1 Oct 2019 16:48:14 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] Partially revert "compiler: enable
 CONFIG_OPTIMIZE_INLINING forcibly"
Message-ID: <20191001154814.GJ25745@shell.armlinux.org.uk>
References: <20190930114540.27498-1-will@kernel.org>
 <CAK7LNARWkQ-z02RYv3XQ69KkWdmEVaZge07qiYC8_kyMrFzCTg@mail.gmail.com>
 <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
 <20191001114129.GL42880@e119886-lin.cambridge.arm.com>
 <20191001143626.GI25745@shell.armlinux.org.uk>
 <20191001152826.GM42880@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001152826.GM42880@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:28:27PM +0100, Andrew Murray wrote:
> I hadn't noticed the use of __OPTIMIZE__ - indeed if __compiletime_assert
> is no-op'd and you reach it then you won't have a build error - but you
> may get uninitialised values instead.
> 
> Presumably the purpose of __OPTIMIZE__ in this case is to prevent getting
> an undefined function error for the __compiletime_assert line, even though
> it doesn't get called (when using a compiler that doesn't optimize out the
> call to the unused function).
> 
> Why is the call to __get_user_bad not guarded in this way for when
> __OPTIMIZE__ isn't set, i.e. why doesn't it suffer from the issue
> that the following fixes?

Officially, the kernel does not support building with -O0.  To start
with, the top level makefile has:

ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
KBUILD_CFLAGS   += -Os
else
KBUILD_CFLAGS   += -O2
endif

and we've said for years that the kernel relies upon the compiler
optimiser to build correctly.  You may be lucky if you pass it via
some method to 'make' but that's going to rely on the argument order
to the compiler, and the order in which the compiler processes its
arguments, and whether it (for example) correctly disables all
optimisations if it encounters -O0 somewhere.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
