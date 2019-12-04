Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3629C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7D620674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="vH/p6mFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfLDMwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:52:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54033 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLDMwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:52:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so6867715wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 04:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AjDTonAmsm7wZu8WklNi+HJ8agPWk8VysMXQZfsZKE=;
        b=vH/p6mFxMPhIPXLSKA2MmsiYqVZ9uUjOZNFid+6FXr9akO+zxh1gfBMrnADzfxZMEj
         00irJcP2S7BHBMSCrV4FbggDPiFgxPUjxk9tMJ9dFAFVLy2Rk+m1P2qAZsdSlcnpwmtE
         w+6mVklka0as3TGY4RHjYYRnEIZry7WvgtCPJUj9zPElrCTEJL0IQkkxTmHPWTHxz2oB
         RLIj0qmdz6uRti13RsNX3nl93zHNZVffQblqpHIv7CYt7PA192gobMI4zj0nl0P2b4SF
         OOrW5g3zKOqpp10tEtDbk3siQq9/V/vq2ZO04cQtnVmqzKtC+nWUNqbbGyTstLtkPgeo
         C1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AjDTonAmsm7wZu8WklNi+HJ8agPWk8VysMXQZfsZKE=;
        b=uJfhVFmDkolZSRj9OWGlUapaFZ7tmfYSQQP0Whgqap4iVIKCGQdm6JVQBroutXtXyd
         nKbG/nNPM+9yBM+IjqcYLe5B9cGbsTjGPQ6yd9v+EevTFttcLfo7Xny+zR9WJufhMKkM
         m6QsYRasjDOuXk1Ynfe+wIwFz9sqmGQ5pn1bd+cladQdH7h2cGl4KEc90V2ORNdO8PQH
         6hkmcDbLaTBF46bJDocxUfempQjPQ8uWDUvmgcl8zDCuZ04PovKl9HimlOskSzxtkN14
         JfQDCrPO4kDMvL9ochHKZOHZu2jKgtkQxW/aRR7lTwPeZs0t9gsuF/BBhYoDG2q8zJ5b
         7QwQ==
X-Gm-Message-State: APjAAAXTU9fS+LtLPJYa6tNnshDpflakpF1suhfsyw3EOf3Ofl5eg6TU
        6rJ+7058SZNzF+IIeeOnrPTCEIP/Qja3G13+TJYA7g==
X-Google-Smtp-Source: APXvYqzj2pSXDV+iU9KbyWjHve9YSIvZZFjycknEy9iuaV1MbCim9rQbbcEMFnhf94zkA+UiVRmDK/61S77Gpw4NJ/4=
X-Received: by 2002:a1c:30b:: with SMTP id 11mr37382528wmd.171.1575463936705;
 Wed, 04 Dec 2019 04:52:16 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 4 Dec 2019 18:22:06 +0530
Message-ID: <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 2:22 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Linus,
>
> The following changes since commit 5ba9aa56e6d3e8fddb954c2f818d1ce0525235bb:
>
>   Merge branch 'next/nommu' into for-next (2019-11-22 18:59:09 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc1-2
>
> for you to fetch changes up to 1646220a6d4b27153ddb5ffb117aa1f4c39e3d1f:
>
>   Merge branch 'next/defconfig-add-debug' into for-next (2019-11-22 18:59:23 -0800)
>
> ----------------------------------------------------------------
> Second set of RISC-V updates for v5.5-rc1
>
> A few minor RISC-V updates for v5.5-rc1 that arrived late.
>
> New features:
>
> - Dump some kernel virtual memory map details to the console if
>   CONFIG_DEBUG_VM is enabled
>
> Other improvements:
>
> - Enable more debugging options in the primary defconfigs
>
> Cleanups:
>
> - Clean up Kconfig indentation
>
> ----------------------------------------------------------------
> Krzysztof Kozlowski (1):
>       riscv: Fix Kconfig indentation
>
> Paul Walmsley (4):
>       riscv: defconfigs: enable debugfs
>       riscv: defconfigs: enable more debugging options

I had commented on your patch but my comments are still
not addressed.

Various debug options enabled by this patch have performance
impact. Instead of enabling these debug options in primary
defconfigs, I suggest to have separate debug defconfigs with
these options enabled.

Please address my comments and send this patch in
separate PR.

Regards,
Anup

>       Merge branch 'next/misc2' into for-next
>       Merge branch 'next/defconfig-add-debug' into for-next
>
> Yash Shah (1):
>       RISC-V: Add address map dumper
>
>  arch/riscv/Kconfig.socs           | 16 ++++++++--------
>  arch/riscv/configs/defconfig      | 24 ++++++++++++++++++++++++
>  arch/riscv/configs/rv32_defconfig | 24 ++++++++++++++++++++++++
>  arch/riscv/mm/init.c              | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 8 deletions(-)
