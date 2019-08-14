Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A97C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80B02084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565799552;
	bh=Ns27KoVB7fWJmJ/83nGdUmBSCoi4rF+AeVKTdL7mpUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ul3iAI0DQ2VJguijB3zQv5ECAZuz554CPBod7vRT332BRh8ipOl6J5sbqNGOZaJJ6
	 BhRH7caPf2yuCTMzLT5Jki9icV68lHE4dUFggSFWJBlRmxX5mkVWuL7l/Io/6rzt+j
	 9TuqGpVSYrOtD2Tqb9D4RecMHdXcU4QP8nCsEWp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfHNQTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfHNQTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:19:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42C92083B;
        Wed, 14 Aug 2019 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565799549;
        bh=Ns27KoVB7fWJmJ/83nGdUmBSCoi4rF+AeVKTdL7mpUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dls/GSsn582m/y3/W8D9dNzWWp3De3XD/KqCpquTWLigKEGSt5kyPWQAhJ93UZjzO
         kQ3u/bO6h1iXGXV9t8J2iiFT82/FUJ6ofLSULcb/pEj/nhbTFOL6WfSZtKpFRUIDki
         QBBevpvGD2cL44x3yY0FDAIH9zrf9emJAGzIyagA=
Date:   Wed, 14 Aug 2019 17:19:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@linaro.org>
Subject: Re: [PATCH] arm64/efi: Move variable assignments after SECTIONS
Message-ID: <20190814161904.55jgaxnhd4ujyh2h@willie-the-truck>
References: <201908131602.6E858DEC@keescook>
 <CAKv+Gu9fEAG3CqmORyO2X_Uqse09nnXEQiB1kTL-xBqLWsy8Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9fEAG3CqmORyO2X_Uqse09nnXEQiB1kTL-xBqLWsy8Xg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 07:14:42PM +0300, Ard Biesheuvel wrote:
> On Wed, 14 Aug 2019 at 02:04, Kees Cook <keescook@chromium.org> wrote:
> >
> > It seems that LLVM's linker does not correctly handle variable assignments
> > involving section positions that are updated during the SECTIONS
> > parsing. Commit aa69fb62bea1 ("arm64/efi: Mark __efistub_stext_offset as
> > an absolute symbol explicitly") ran into this too, but found a different
> > workaround.
> >
> > However, this was not enough, as other variables were also miscalculated
> > which manifested as boot failures under UEFI where __efistub__end was
> > not taking the correct _end value (they should be the same):
> >
> > $ ld.lld -EL -maarch64elf --no-undefined -X -shared \
> >         -Bsymbolic -z notext -z norelro --no-apply-dynamic-relocs \
> >         -o vmlinux.lld -T poc.lds --whole-archive vmlinux.o && \
> >   readelf -Ws vmlinux.lld | egrep '\b(__efistub_|)_end\b'
> > 368272: ffff000002218000     0 NOTYPE  LOCAL  HIDDEN    38 __efistub__end
> > 368322: ffff000012318000     0 NOTYPE  GLOBAL DEFAULT   38 _end
> >
> > $ aarch64-linux-gnu-ld.bfd -EL -maarch64elf --no-undefined -X -shared \
> >         -Bsymbolic -z notext -z norelro --no-apply-dynamic-relocs \
> >         -o vmlinux.bfd -T poc.lds --whole-archive vmlinux.o && \
> >   readelf -Ws vmlinux.bfd | egrep '\b(__efistub_|)_end\b'
> > 338124: ffff000012318000     0 NOTYPE  LOCAL  DEFAULT  ABS __efistub__end
> > 383812: ffff000012318000     0 NOTYPE  GLOBAL DEFAULT 15325 _end
> >
> > To work around this, all of the __efistub_-prefixed variable assignments
> > need to be moved after the linker script's SECTIONS entry. As it turns
> > out, this also solves the problem fixed in commit aa69fb62bea1, so those
> > changes are reverted here.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/634
> > Link: https://bugs.llvm.org/show_bug.cgi?id=42990
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Although it is slightly disappointing that we need to work around this
> kind of bugs when adding support for a new toolchain, I don't see
> anything wrong with this patch, so
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Yup, it's gross, but I'll queue it with your ack.

Will
