Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852BFC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EF920663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561545137;
	bh=4CKHa1A8vrfykHgGSNll1KY4BiJQ+KUGJASQX4F/EWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PYLfpWTyB768AVGjXi6dtqLRQPruePY68IR5uf/ft/JruANnk1Pg5NYBbMn+rJ7NM
	 X5twMB2+fTRyj7Q5Nssg/Xhb0AX243ZMX++RBJGGEJUKo2+9aDNMlvuWRyTo/YCT/a
	 VtZ/oRR49acybBact3Ktogz0/GpAwwriovqcz1vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfFZKcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZKcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:32:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C052133F;
        Wed, 26 Jun 2019 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561545134;
        bh=4CKHa1A8vrfykHgGSNll1KY4BiJQ+KUGJASQX4F/EWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0PEH7is8D1pTrioeduFf6lwQeETXQ2mQc3c4x7Mq/OqaWrCUuYjPsKLrDap/zZVF/
         3GghfjxVZg5/fg1F4VISO5tbJjV4uVeEY6+wc6+zuJoexqYensgcVDExl2PqPAsiB7
         HNyx+hw9BNHRNL7gPj3SxG0lY05Gambd1He339TA=
Date:   Wed, 26 Jun 2019 11:32:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@linaro.org>
Subject: Re: [PATCH] arm64/efi: Mark __efistub_stext_offset as an absolute
 symbol explicitly
Message-ID: <20190626103209.foq3bheaxzrqoeem@willie-the-truck>
References: <20190626042017.54773-1-natechancellor@gmail.com>
 <CAKv+Gu85xLD+-CqwgNQtC3Hr9z2R5bm5th8_zd_jMSzA3JE8og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu85xLD+-CqwgNQtC3Hr9z2R5bm5th8_zd_jMSzA3JE8og@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:07:00AM +0200, Ard Biesheuvel wrote:
> On Wed, 26 Jun 2019 at 06:20, Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > After r363059 and r363928 in LLVM, a build using ld.lld as the linker
> > with CONFIG_RANDOMIZE_BASE enabled fails like so:
> >
> > ld.lld: error: relocation R_AARCH64_ABS32 cannot be used against symbol
> > __efistub_stext_offset; recompile with -fPIC
> >
> > Fangrui and Peter figured out that ld.lld is incorrectly considering
> > __efistub_stext_offset as a relative symbol because of the order in
> > which symbols are evaluated. _text is treated as an absolute symbol
> > and stext is a relative symbol, making __efistub_stext_offset a
> > relative symbol.
> >
> > Adding ABSOLUTE will force ld.lld to evalute this expression in the
> > right context and does not change ld.bfd's behavior. ld.lld will
> > need to be fixed but the developers do not see a quick or simple fix
> > without some research (see the linked issue for further explanation).
> > Add this simple workaround so that ld.lld can continue to link kernels.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/561
> > Link: https://github.com/llvm/llvm-project/commit/025a815d75d2356f2944136269aa5874721ec236
> > Link: https://github.com/llvm/llvm-project/commit/249fde85832c33f8b06c6b4ac65d1c4b96d23b83
> > Debugged-by: Fangrui Song <maskray@google.com>
> > Debugged-by: Peter Smith <peter.smith@linaro.org>
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks. I'll pick this up and add the link to the Clang issue as a comment
in the header.

Will
