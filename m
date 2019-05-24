Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B082C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3E421848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558735122;
	bh=XN1j3o7FRO+TU081w/o/048spPyT1yJbFxM2wnedB2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PQScPKzsWkxhheOfVKGYWvkmCtslu4W8ujp2mnhmgKarW5+BH4y/+NbZA2OSZyBhW
	 NIfOVF8YHx1gGShwnISdagBxLqMCb74DXS9j0gGZa7ogVB4Ff0u1SDHQwl0uNlMF1x
	 PHL4d1RLlIKyTNLbs94IJnLz07IkN+xfRhNoqdpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404464AbfEXV6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:58:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41988 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404259AbfEXV6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:58:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id w9so8097552oic.9;
        Fri, 24 May 2019 14:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FX0nAAQKdK8gCwAelke8YNA0bB3X71pjYoDs2aHxEiE=;
        b=LkKY2TLTIBDLMpOFtQjVSNEgz9+tvvxbpPSUvIPuNIFG/QSM1YLLoeWVh4/XyYRkeM
         o1kmkcGqKs21KdG8jNKs3mBUp4p8E90rumR2cc+zxOdKWmXBomsVnH26gJJDxAOFgCns
         XNh3fL3r9xErE5A4ZqQ7PVsWSKjeSkW9gp4/u9y5J/QImkVBCOUmMJdMHeLgcB1K8cgo
         u/5lDHBN4YSLRV6ANjTAxsdGkc2Gxu2AR0e7xdWuIk2aZJdqk18E5p8ehclN/ZgB+4Gz
         tOPQgo01IYdAV1UcR+LTgKV8T/RuOlxrLj5eWUjs/NTtGCZljMveDXH41E9fLgJDwrCU
         6u+A==
X-Gm-Message-State: APjAAAUBjlP6BwfqCDbha/CQVpGpDC4yY6LpdNU/2R38JGXoMzox8YPm
        6M3FXnYMEuQl8jPTuEZnqA==
X-Google-Smtp-Source: APXvYqytH+9RhKlZb9pctda4btXYaKYVWztG+4GxfJz4UGzSbQyRu3Kkka4gSAaGipt9f8+8R7wEFg==
X-Received: by 2002:aca:4bd2:: with SMTP id y201mr7159994oia.12.1558735119348;
        Fri, 24 May 2019 14:58:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x72sm1442794oif.50.2019.05.24.14.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 14:58:38 -0700 (PDT)
Date:   Fri, 24 May 2019 16:58:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 1/3] amr64: map FDT as RW for early_init_dt_scan()
Message-ID: <20190524215838.GA16271@bogus>
References: <20190519160446.320-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519160446.320-1-hsinyi@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:04:44AM +0800, Hsin-Yi Wang wrote:
> Currently in arm64, FDT is mapped to RO before it's passed to
> early_init_dt_scan(). However, there might be some code that needs
> to modify FDT during init. Map FDT to RW until unflatten DT.

typo in the subject.

Otherwise, this one seems fine to me.

> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change log v2->v4:
> * v3 abandoned
> * add an arg pgprot_t to fixmap_remap_fdt()
> ---
>  arch/arm64/include/asm/mmu.h | 2 +-
>  arch/arm64/kernel/setup.c    | 5 ++++-
>  arch/arm64/mm/mmu.c          | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
