Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A56C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178202085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJ3Iztta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfFREJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:09:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45057 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFREJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:09:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id s21so6898936pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sxNxwbhlDFusqMdbSWcqqNQNWyvayYOF2m7mBoRJYf4=;
        b=PJ3IzttaXZ9ZP6m+bK5SbxOo0k0L5mVCRCs/HEeYWoAP0fd2T6fE9j4DdYSjPn2Igq
         RLpzTaKQhrkUsMJh5TuCLDkONT2MOhoIWpqkbpil9eGw1hDnCZubrZyH48l+5MMjOdqS
         yXpWOfaHaY7lZ9z3iBYrjt1cyFA4aZtBxzOko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxNxwbhlDFusqMdbSWcqqNQNWyvayYOF2m7mBoRJYf4=;
        b=DvuCRSp+n4XEcqvJp0WN2EJep5YrgXeEpRmR+jCg/tKWwmGbgd763SG/bUZrvSvhNk
         13337MantNH6e+3lCgh/lrDKDj37VaQI/q8c2g6Vb2aHsWH4vJGSokLIejqSVeYqtYer
         9QM37hGLWn6oUOm6zMPUl/TulCi9V3hLbmtySELBAzNa0XeMqfqAsT0idCeHwEUBaC9h
         BE2O9HZasFiI2srtO+RAczuj/6bIvowZhvPrSaaCMV9r8p27rOJGnVkwih/dc9BOMome
         tT8QOo94bumeZXJTHblHsbSXgNp20XS6FMSQmSSwkBRSqZhR2L9Hye/YiMvhMQhTkNgV
         xvzw==
X-Gm-Message-State: APjAAAVXIEodqljypNUwrbAnPsHbZInzm6D1PV+XGOJvL8LommwtsEEi
        k8qhkyaQnGTbGu6gyTjuHc5nAQ==
X-Google-Smtp-Source: APXvYqwF3JzZ+qH5xB0+Z14HJGeTdacZf7tH8hhFgeuBeekzs8qvdSqYK7/b6J/UDBy3h0/S5YR4UQ==
X-Received: by 2002:aa7:957c:: with SMTP id x28mr1396954pfq.42.1560830951687;
        Mon, 17 Jun 2019 21:09:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v138sm20195688pfc.15.2019.06.17.21.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 21:09:10 -0700 (PDT)
Date:   Mon, 17 Jun 2019 21:09:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/asm: Pin sensitive CR4 bits
Message-ID: <201906172050.AA52A49E9@keescook>
References: <20190604234422.29391-1-keescook@chromium.org>
 <20190604234422.29391-2-keescook@chromium.org>
 <alpine.DEB.2.21.1906141646320.1722@nanos.tec.linutronix.de>
 <201906142012.C18377C5@keescook>
 <alpine.DEB.2.21.1906170008580.1760@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906170008580.1760@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 12:26:01AM +0200, Thomas Gleixner wrote:
> Nah. The straight forward approach is to do right when the secondary CPU
> comes into life, before it does any cr4 write (except for the code in
> entry_64.S), something like the below.

Okay, will do; thanks! :) I'll respin things and get it tested.

-- 
Kees Cook
