Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A4DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2199522CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567018718;
	bh=CBKtnFW9ZlO6IHgvOEUpDHqoVFzVyfWY/nzaZe5pyGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s6xKRmRNjQSK4NC2UcYOvXEtHqf4d+RmHzPH3gAOHnN+/E3NGsWds6xc0zNiVAdLy
	 0JJJHVS9w7K0bDk7zLXcXEgZHbfu3fDBpJ5wah2gKVVv+OABtCWQgswCiAOw7ldyzk
	 AWEd7LOo6FtYAcHwP/hOwyClKaUgJSC9mTRRt1wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfH1S6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:58:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35137 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfH1S6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:58:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id g7so896957wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rg266ysErRfz6Q6O8ZllDkT8j1Yu9RGIuCA6YHrmQ3E=;
        b=MUFabnk2H7YdNK5dqt8E6WFFJM/SNvgpRDY0fhZ7ln9Owbgr6VYnG30ClwbkprR8Ui
         wKeABdrdLQ21ZhDOX9wAW+uiNRqS/tiw4FPmeJ7DpIHl4bYKXvmuRyJhMn/3Nhug5Urd
         uDyDofZgEJEGvVexPuFc/c1Cnl669csAMi/k9OyhPzjG8cupcQ85nKx2Evxa1yigM8fU
         fF8WxyOGaO+zBYmLdGG+IZyu8qRLHcSqs4Yeu4/zS5eyzEiUJ3mD3rVs4W+s0lW/Jnz/
         Dip87USG4/VB9tzICrUsCbSJRSco9+UV0p/dg0e3EXT6flb/W91heLtI0oD7qiyyxRdN
         My7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rg266ysErRfz6Q6O8ZllDkT8j1Yu9RGIuCA6YHrmQ3E=;
        b=MHawzNkbPZz4HlOdgkq2jWguBKei+AlyuN8E4T+qCxYZqXJus7GkR3105GyuWwlxZ1
         C26if+8kfj+ACwxuMjGJQe5P+cNZzZE7bRTJo6lCaelo6FH1LehImXZkRlOTnepzVIyy
         jods1wwu5AUkweop2GNWyzoTRewri9ADGjoD5Whi6yh5kYy7lTsbaGux5Ij5VxvT5agh
         lCH23dgae1tl8Wk6a/vrkptCqR/fXArcxiYMqzSTNqJ+yDbrq3ywqJA7FgDYSVbWUIUc
         1KwMDBH2AbdcfaNvduCL5l69lfyvDTDIdG0qqdnBIyA8SMF6Zr2OzOskToHM30Qx5IYi
         aeLg==
X-Gm-Message-State: APjAAAWKFOEOpx/mXfsyPTGDEPVe3CD4TOd9WQ9MHZHJ8Sr8N59e30t5
        26ARQ0XblGb+dSSDRspLla4=
X-Google-Smtp-Source: APXvYqxd2oSRFERYqJrydmXOODNBPiWPvPWQ3BDeSyRdvtZQWbvckCCBAYbd/zBjdSVehTRzuQhdNQ==
X-Received: by 2002:adf:ab18:: with SMTP id q24mr6027144wrc.354.1567018714860;
        Wed, 28 Aug 2019 11:58:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h125sm147104wmf.31.2019.08.28.11.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 11:58:34 -0700 (PDT)
Date:   Wed, 28 Aug 2019 20:58:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
Message-ID: <20190828185832.GA77809@gmail.com>
References: <20190828142445.454151604@linutronix.de>
 <20190828143123.971884723@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828143123.971884723@linutronix.de>
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
>  - the address is actually mapped which means that independent
>    of the mapping level (PUD/PMD/PTE) the next higher mapping
>    exist.

s/independent
 /independently

s/exist
 /exists

> If that's not the case the unaligned address can be incremented by PUD or
> PMD size wrongly. All callers supply mapped and/or aligned addresses, but
> for robustness sake, it's better to handle that case proper and to emit a
> warning.

s/wrongly
 /incorrectly

s/robustness sake
 /robustness's sake

s/proper
 /properly

With that:

>  		pud = pud_offset(p4d, addr);
>  		if (pud_none(*pud)) {
> -			addr += PUD_SIZE;
> +			WARN_ON_ONCE(addr & PUD_MASK);
> +			addr = round_up(addr + 1, PUD_SIZE);
>  			continue;
>  		}
>  
>  		pmd = pmd_offset(pud, addr);
>  		if (pmd_none(*pmd)) {
> -			addr += PMD_SIZE;
> +			WARN_ON_ONCE(addr & PMD_MASK);
> +			addr = round_up(addr + 1, PMD_SIZE);

So given that PUD_MASK and PMD_MASK are masking out the *offset*:

 arch/x86/include/asm/pgtable_64_types.h:#define PMD_MASK	(~(PMD_SIZE - 1))

Didn't we want something like:

			WARN_ON_ONCE(addr & ~PUD_MASK);

			WARN_ON_ONCE(addr & ~PMD_MASK);

to warn about an unaligned 'addr', or am I misreading the intent here?

Thanks,

	Ingo
