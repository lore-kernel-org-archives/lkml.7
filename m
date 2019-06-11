Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4753CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179312086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FWOlulk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbfFKBH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 21:07:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35375 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbfFKBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:07:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so6300737pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 18:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u5VUi+/+Lp3OAaH6aBcp/joKd4Ukhdrm/Xfhm3m+Zjo=;
        b=FWOlulk89Q6sNilNUb0D0F/t8a5PzzbWoKjDJ1eUN29xQHlsqL7ThkTnhvM43M+9U7
         QPEnykgcFvmVTTu97mH8oY3Ton+wi2vU/TtrN/FecWNSKtajohBgroG5J+hsj6N/4wOn
         i9h4b/3HSrn17VV1EQhx8iExlWfSV4D75cz58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5VUi+/+Lp3OAaH6aBcp/joKd4Ukhdrm/Xfhm3m+Zjo=;
        b=F7a10kryTnXoCrqVq3q7up7U0l/yB4+EFDJXc7QWzh/uOw7wW7xx6nRjfPYxMer+xn
         YMHKY5YLq4bBXly+2bNuep51KfMCPLYgj1c5rak+hFvj+Xo4ONepoiAnRV/ETLNMHwow
         VFQOfYbzGbUKaFhZsPL1lDngD8qrMRt8T1mhEBntz4h1t2DlOw1Ja0z6kQwImefujMYx
         FfDyy8ueK28BuRGm7xaeB7g0PA1Nox11hqwDCxUNvl5ZjDPHoY9VQR9xexcW+mjltWdz
         nap1/QBkSRwZw7r8TZpK9b74icTBSQ2Y7OIwAXdmKQGqOcgib8KCpezM5u8qJVP+zbRv
         zGdw==
X-Gm-Message-State: APjAAAXKJK/sfO7dW5IG+vyOwyZl7sfNSx9QR5tbQNuzTOwxkn7uLXWp
        WHj+1hMMr18WaxLbZ5NCE/b6Rw==
X-Google-Smtp-Source: APXvYqwSHZV6TZmKE2BnqBSehi/etgohpy35hx8V8ZDuK0Vu6Sjla4NdnWPhouU70Rolf5tbYqGXDg==
X-Received: by 2002:a17:90a:de0e:: with SMTP id m14mr24107021pjv.36.1560215275070;
        Mon, 10 Jun 2019 18:07:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm9861515pgs.78.2019.06.10.18.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 18:07:54 -0700 (PDT)
Date:   Mon, 10 Jun 2019 18:07:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <201906101807.090F1FE1FC@keescook>
References: <201905101341.A17DDD7@keescook>
 <ead5e4ad-d911-3680-04a4-ae98507ba48c@redhat.com>
 <201905111657.76FE0BDCEC@keescook>
 <20190512041142.GA24542@bombadil.infradead.org>
 <201905131430.541A76A6FE@keescook>
 <20190610223054.GT63833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610223054.GT63833@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:30:55PM -0700, Eric Biggers wrote:
> Any progress on this patch?

I have no had time yet; sorry. If anyone else would like to take a stab
at it, I'd appreciate it. :)

-- 
Kees Cook
