Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8FBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10877217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567034560;
	bh=iWYTyEwuwlo7x52suhSa8ZImmNgaR9S9Sk9+oFI1S5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2lkDIctFSkEzdntvBAi3edPky8/kDqRHmLWV28S8N/6qN4/NlPva3m7uLg/OTn0bf
	 Gh76pb80e3FeRUhHcrONO37K6sd8sKsBSgYFmnenfAy0sIRapSPALEmp7jWhsIWlFj
	 yB6riPyRamyzBIVcrgUwjUpUNlPK2cV9zs+SC6b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfH1XWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:22:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38198 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1XWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:22:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so1475835wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AvN4fIezSJ+C/jhEzDi7EbKP3oKNxT5wmlM2R4Ta9yo=;
        b=Am2VYn52M2VkcRLpVXKUd3ONA//NUx9LsgmnzWoCqi6sSmj5902FUuI3+SKM/qrstf
         fHd7a384vhRic7tfTG865HqDs6Ks0EAAgUQdGjUOkkWI9fXbI01R1zaUF0rfYJFog9tf
         +iCMgrIkBdQ78dufoJxq3g3XEngGFFrYNQXXXJsJij+dBGnr8U4ZNbnsXH+ZNX3CQK1H
         CQ7lmZKhQVM8nxiTyzPDEzRUfUjFnSilEdfd21k+q+/hGCg5AzKjTGxj+aeOWAjnhNlz
         PcEDRzJ3i03iraqOYb5gYth2oSkwS8fg8FYl/Y41O4xReY62jepc8LV4V/MI1XjZXO3D
         f3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AvN4fIezSJ+C/jhEzDi7EbKP3oKNxT5wmlM2R4Ta9yo=;
        b=OJSfUnA6jyNLnsduqQSm39fiBuJqq+gt+pfJ1zqyJnpc9CzGFq8tBo5f/nyMwsIgxA
         Kc0shaB/+nMYtQeqeXYwI+UxbcVVS1bHKjtE4nyyd7FuqqN9WYkpR82ezkxPxy6nLfw0
         +jWzIQpcL99Qpw/fEWgh4nz/XNwZ6Iopi8tsK0LriDHuR6j6f6soVdrajqxRg4Wm2tXK
         eFOEITGwyUkzV0Q7oG4UJI60KILKwTEMjLbDeetd5hC3yD35TIWIIP3UnqK0WKsNxQr7
         +hLmmllsU3sgTfOpFInbAnL3DaKCmP/m4tftG7Hd2J25yBtgbDSEYkJ4fgdcQYKRqQxP
         joGg==
X-Gm-Message-State: APjAAAWo1ZXLKQDDXjCZkzGGq8s4kGZ6r2hK1OsLVSb17i3SRwwDoU2o
        ToNjfB+lt7kOHqKeK0TzVrU=
X-Google-Smtp-Source: APXvYqxbxGwJLyxoMYzcWlAZ1QRPVoq7YDeRC+NFucXMPRUs9Web9Rgb0BwPStWPfnSyHbI4bDJwbA==
X-Received: by 2002:a5d:5543:: with SMTP id g3mr7577230wrw.166.1567034556317;
        Wed, 28 Aug 2019 16:22:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r15sm476059wrj.68.2019.08.28.16.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 16:22:35 -0700 (PDT)
Date:   Thu, 29 Aug 2019 01:22:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch V3 1/2] x86/mm/pti: Handle unaligned address gracefully
 in pti_clone_pagetable()
Message-ID: <20190828232233.GA99597@gmail.com>
References: <20190828142445.454151604@linutronix.de>
 <20190828143123.971884723@linutronix.de>
 <alpine.DEB.2.21.1908282252170.1938@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908282352470.1938@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908282352470.1938@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Song Liu <songliubraving@fb.com>
> 
> pti_clone_pmds() assumes that the supplied address is either:
> 
>  - properly PUD/PMD aligned
> or
>  - the address is actually mapped which means that independently
>    of the mapping level (PUD/PMD/PTE) the next higher mapping
>    exists.
> 
> If that's not the case the unaligned address can be incremented by PUD or
> PMD size incorrectly. All callers supply mapped and/or aligned addresses,
> but for the sake of robustness it's better to handle that case properly and
> to emit a warning.
> 
> [ tglx: Rewrote changelog and added WARN_ON_ONCE() ]
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Negate P[UM]D_MASK for checking whether the offset part is 0
> V3: Fix changelog
> ---
>  arch/x86/mm/pti.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -330,13 +330,15 @@ pti_clone_pgtable(unsigned long start, u
>  
>  		pud = pud_offset(p4d, addr);
>  		if (pud_none(*pud)) {
> -			addr += PUD_SIZE;
> +			WARN_ON_ONCE(addr & ~PUD_MASK);
> +			addr = round_up(addr + 1, PUD_SIZE);
>  			continue;
>  		}
>  
>  		pmd = pmd_offset(pud, addr);
>  		if (pmd_none(*pmd)) {
> -			addr += PMD_SIZE;
> +			WARN_ON_ONCE(addr & ~PMD_MASK);
> +			addr = round_up(addr + 1, PMD_SIZE);
>  			continue;
>  		}

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
