Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A95CC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB0A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="J4ZnqAXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfD2RS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:18:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39010 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfD2RS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:18:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id h16so7157432qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSTnY20qh+9b+fgMWdr7QdTtLxQEdNrvMsQhAEqFRPQ=;
        b=J4ZnqAXRg9j1GFxYtxKe6YVghngN71fz2kjh093Y+OOWzlrzrkDXWNLlfywFD3OlOB
         zuYHLS0Y/EWauPsTFyrxOeOSHPyquWEV3uuuEb8qmAS5S4M4e1Qaz8eI9InMlbS/Nl12
         hfrAZ4vd36BctyDjW8ajK5Hqeu4N/giB/+OYpeLW3d5qld8voDl8xZpIx0ydsFSGfN5H
         hN02DMonp4+3iz2woY0xyYExueonPxo4jxCRtKsy3VpocSAPVIhY5nw1Z5o6LYn2exYh
         fYO1nuRdtSNUlDSYXOIXr/b8cGIVm+riWuZLU9giLGVhso85uLRYedbJRNoXNdOWzyz7
         301w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSTnY20qh+9b+fgMWdr7QdTtLxQEdNrvMsQhAEqFRPQ=;
        b=YQj60ymLIFMy2a1JR8OHKKtpRkKq3NEq9s9uLKDUlaLMfdLUNsSKU6z9HEAhgDKfjz
         wnOS4DmkSX3IgT3G2w/fPKZSS5naLBtQKOAddrvuekXw6pXRBEGw1u8rr6NkPUAAjIAG
         OEKphfqJRN/J7qXBWV3H79oLVIH3XUPqr56Jt36J6/YI7FyK2s/m2v9ZRiG3h60ndhNT
         Sv29/pgt8tye2DGnNVSulyZ/Aw7fkitxVoWz96dxLgVFDkdewmPEspF4Finx3F6jGtpo
         MamNnf7rrfNVMYpeqdOR49AjY4rMC4d53PWJvOVOtRhUu2iluIayb4g71PtzBL4EyEZI
         9Lxg==
X-Gm-Message-State: APjAAAWvSnibidxH4H6H4t90a/FYG//9gsurzkK7qObkXJ7FNtQJHxaj
        nS58l/nFkKJTP2Mm4gb3rxeqCQ==
X-Google-Smtp-Source: APXvYqzDpiBsyJcAKjWLppvlEr8mrOVkh4RSHLNQbBP/5FkuX6AtXnf/sYzYfCOFZ5hGGWjHuCWC8w==
X-Received: by 2002:a0c:fba9:: with SMTP id m9mr749817qvp.32.1556558337608;
        Mon, 29 Apr 2019 10:18:57 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e4sm18216200qtb.61.2019.04.29.10.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 10:18:57 -0700 (PDT)
Message-ID: <1556558335.6132.9.camel@lca.pw>
Subject: Re: [PATCH] arm64: fix pte_unmap() -Wunused-but-set-variable
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Apr 2019 13:18:55 -0400
In-Reply-To: <20190429164923.GA26912@fuggles.cambridge.arm.com>
References: <20190427012842.93737-1-cai@lca.pw>
         <20190429164923.GA26912@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-29 at 17:49 +0100, Will Deacon wrote:
> >  arch/arm64/include/asm/pgtable.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable.h
> > b/arch/arm64/include/asm/pgtable.h
> > index de70c1eabf33..7543e345e078 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -478,6 +478,8 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
> >  	return __pmd_to_phys(pmd);
> >  }
> >  
> > +static inline void pte_unmap(pte_t *pte) { }
> 
> Hmm, is this guaranteed to stop the compiler from warning? Assuming the
> pte_unmap() call is inlined, I'd expect it to keep complaining. What
> compiler are you using?

Yes, it is guaranteed. Tested on both gcc and clang.

> 
> Also, there are a bunch of other architectures that I would expect to have
> this same issue because they defined pte_unmap() exactly the same way.

This has already fixed in powerpc that went in.

https://lore.kernel.org/lkml/20190307144031.52494-1-cai@lca.pw/

I am not sure if I care about any other arches nor I have real hardware to test
further.
