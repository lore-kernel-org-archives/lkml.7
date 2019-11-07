Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46175C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1694821D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573112245;
	bh=6uK+/VbIqFMwagWK76w0NKxiRn3WBCr2GqLJv4FoG6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nS6cHt1KQwHFvGIyrfOkq9w/yPnLA1dN1bOfk+DgtoMDwd45yxAdys/1Tr5ej8+ci
	 WKEzh95pKQECnCkrX0JMRoCt7B3tjtzXpd/hTNIEZ7TmQpCBfJObHlV6DGOOJcDxTu
	 8XSCOoVfQoGPFZE4tzfnf8jiUVRKb47pk7H6v96I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKGHhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:37:24 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40511 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfKGHhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:37:23 -0500
Received: by mail-wr1-f48.google.com with SMTP id i10so1792539wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ib8Q2GU5PS/0gXUXAfkY/zu4kC9GCe7NHTO7scyBhJ0=;
        b=O7d7WVuTZca4vJtGFzC4Qs2bNyl+ch261Zm640CyeDmiT/sCeRGMvnWx82dxVvUAnO
         2mmcOvz4juCECx9gZ06trUKNwOYalMiRWxQFbCIXFvBZD3qJ5qjCt8HmTMPgDjWBR8y1
         SnNTZmd5kRwV4/nUdZ8FgqixAGt0+XMzv0cG5zNHICxab89Eudl0f4n+y5EkktDShHX5
         WftA9BPKa5Wj7fPdfeNYnT2PcDDoLyyrNlwWw5wcAC9rlsr9nmtEZlEkj6UgTtd9c8ZC
         Yh253XgAxYtcg9N1b92CbUYb/rgGAcdz3qHxt8uWUUxWy9pSC8a7iyBxAd5k+mFDV793
         RX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ib8Q2GU5PS/0gXUXAfkY/zu4kC9GCe7NHTO7scyBhJ0=;
        b=hE5dizQ9tdCuYWbjLD1/iRCNExEJvA5zH/R9TldZFjj2VuRKW50GAzJ3ikUc2SPawG
         M8ojrbpzYEInCSM58BuyPGVYXd7sRXR0qWdb7+eXq1oiG/X4SNFR5zjpVhEmRZM8yN5K
         Yx5+VACTY5rw3zANuG4zLR8VH9KQNhiXMTz86PaaF5SKBvzpb/MGQr0PohtBwEtYrq46
         vsW4ogmzsDkT70sDD8zb0J9QAqUkr1dBVFl9irhbZ4tvzZ4ikVQr3hkPr31Gl4BQO/jd
         OhepginS+C8K6bV5nf1LzPN0UFQG/fO3c4H5Ls8xaa1XWjkG+joWF4e3ftgXzjZhxVAZ
         hlLg==
X-Gm-Message-State: APjAAAX6RlrZrsEo3/weyNDTLqErgKLv+ZmsSRlZrl2rhE2mG4tG8NIq
        KGSEAaTVFjum2dbRqo6D8p8=
X-Google-Smtp-Source: APXvYqzamC0ZKnOCrythJmZr1H/nFODR73nzw2pBfb4FwYXuSBS+q6SqtDjIH88XFSRsYgRN4/akrg==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr1390908wrt.195.1573112242536;
        Wed, 06 Nov 2019 23:37:22 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i3sm1385216wrw.69.2019.11.06.23.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 23:37:22 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:37:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
Message-ID: <20191107073719.GD30739@gmail.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106202806.241007755@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> @@ -365,19 +365,19 @@ struct tss_struct {
>  	struct x86_hw_tss	x86_tss;
>  
>  	/*
> -	 * Store the dirty size of the last io bitmap offender. The next
> -	 * one will have to do the cleanup as the switch out to a non
> -	 * io bitmap user will just set x86_tss.io_bitmap_base to a value
> -	 * outside of the TSS limit. So for sane tasks there is no need
> -	 * to actually touch the io_bitmap at all.
> +	 * Store the dirty byte range of the last io bitmap offender. The
> +	 * next one will have to do the cleanup because the switch out to a
> +	 * non I/O bitmap user will just set x86_tss.io_bitmap_base to a
> +	 * value outside of the TSS limit to not penalize tasks which do
> +	 * not use the I/O bitmap at all.
>  	 */
> -	unsigned int		io_bitmap_prev_max;
> +	unsigned int		io_zerobits_start;
> +	unsigned int		io_zerobits_end;
>  
>  	/*
> -	 * The extra 1 is there because the CPU will access an
> -	 * additional byte beyond the end of the IO permission
> -	 * bitmap. The extra byte must be all 1 bits, and must
> -	 * be within the limit.
> +	 * The extra 1 is there because the CPU will access an additional
> +	 * byte beyond the end of the I/O permission bitmap. The extra byte
> +	 * must have all bits set and must be within the TSS limit.
>  	 */
>  	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
>  } __aligned(PAGE_SIZE);

Note that on 32-bit kernels this blows up our CPU area calculations:

./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_181’ declared with attribute error: BUILD_BUG_ON failed: CPU_ENTRY_AREA_PAGES * PAGE_SIZE < CPU_ENTRY_AREA_MAP_SIZE
./include/linux/compiler.h:331:4: note: in definition of macro ‘__compiletime_assert’
./include/linux/compiler.h:350:2: note: in expansion of macro ‘_compiletime_assert’
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
arch/x86/mm/cpu_entry_area.c:181:2: note: in expansion of macro ‘BUILD_BUG_ON’
make[2]: *** [scripts/Makefile.build:265: arch/x86/mm/cpu_entry_area.o] Error 1

Thanks,

	Ingo
