Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CCC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79DA2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="o9Q41Qcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCAVve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:51:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAVve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:51:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so12054410pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 13:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Aj5WngXuPv1MUGPfr1Svb4twrAc+hcEOJ/1LSJ7sZ+s=;
        b=o9Q41QcrAmiy9uClSumYrhP0iIX1ivdxDjZJXBgtpU1Wa/IhUIBZ9Wsy2IXYtbjtAu
         QLNb5xTEx1bVx/d9Ks70I5wArsnPwmzFhdyccxlH2Y1x39uGrK7TV5Fox3VBW5L/Fuwh
         MR0PUYQsP0blBMEG27GA5FAk/3CCBX9jBeLPY+2epUC/cO05WTuW/kukGAj1vaOGABGT
         N6ujdNuuiVeX4WC0qaWFarQKhh6VvcEfelWGu94ARSkaeeXKD01NeDuL3ScC66+ja2aT
         578nbXYLdDYnLnrTCgY7vu/bBcboS6uFf1Ux75ILzpvgHlfjLnYKF7s8ZyQw0xL+tAxu
         Soag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aj5WngXuPv1MUGPfr1Svb4twrAc+hcEOJ/1LSJ7sZ+s=;
        b=LiKJuC+FkOKCRcXpEg6BkkUi6kiAz61WO7ExFG/Hb9W0TbMfIr76qjjM2wIjYQU1wE
         Hfom2PvoSFooIKMYwl01oHM+rtQMI5XbVeyIRkCqJhoEeWHPgOuzTOE3K368m4JbX7yB
         uQDn/Iqjbj+i5SATlkirb9zlLOyarKOsZ1aulO8uX/ZfC446m+KgInc5OMlkDmrOn9RN
         XY1aegqKX4IHBv2PFkOm8XyXrgrgwxNJ/9cW8GP1H5zM/4y3JbMd1YXulaVaLkxFLy50
         sjuH1mwBqpijTkdreTEOBLE1bTGxhkoLSRFTVoZNUGxcbK9JGeTZ+nvMgzWjUb3ol0XH
         ZZ6g==
X-Gm-Message-State: APjAAAVAj8ic9+mR4gT1acv3hi7SriYnptltkTzicmZmcZIjJGW57gnP
        Wz9pmUZBFAeVlrEWB1EIHGA7aA==
X-Google-Smtp-Source: AHgI3IZDDJx8IBKR78ntuvauMt2JDwANXe4J3i+HfBUUs8GKofdYxp30dg8nhFCM1C0nuGGiV76tSw==
X-Received: by 2002:a62:449b:: with SMTP id m27mr7938829pfi.79.1551477093379;
        Fri, 01 Mar 2019 13:51:33 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id e21sm60252029pfh.45.2019.03.01.13.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 13:51:32 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 31A663007CA; Sat,  2 Mar 2019 00:51:29 +0300 (+03)
Date:   Sat, 2 Mar 2019 00:51:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 06/34] csky: mm: Add p?d_large() definitions
Message-ID: <20190301215128.qqzmyqyzxxatbqgh@kshutemo-mobl1>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-7-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227170608.27963-7-steven.price@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:05:40PM +0000, Steven Price wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For csky, we don't support large pages, so add a stub returning 0.
> 
> CC: Guo Ren <guoren@kernel.org>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/csky/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
> index edfcbb25fd9f..4ffdb6bfbede 100644
> --- a/arch/csky/include/asm/pgtable.h
> +++ b/arch/csky/include/asm/pgtable.h
> @@ -158,6 +158,8 @@ static inline int pmd_present(pmd_t pmd)
>  	return (pmd_val(pmd) != __pa(invalid_pte_table));
>  }
>  
> +#define pmd_large(pmd)	(0)

Nit: here and in other places, parentheses around 0 is not needed.

-- 
 Kirill A. Shutemov
