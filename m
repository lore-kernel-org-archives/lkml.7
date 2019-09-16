Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49265C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1740021670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oRZloT25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbfIPWTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:19:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38251 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbfIPWTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:19:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id w10so524503plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5s0xpZGS83FwiMvCo1TIQP0cn/VBzbnyICFgBZ0OB8Y=;
        b=oRZloT25WgrG1A2E2/rG1KEJTsek/VSatAe1mECK70Mcns8rFB4oQSbaFfzWOC5w+M
         Xag6HGDZ5qz6fjMSOpYUmXJmJou5XfUcqmOTGP6pBjRziIzzNqZaUy3miVy+F4viGeqf
         GvJ+WpgDdjCraSnaMKdWGwKfJf5MQwf0ojIHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5s0xpZGS83FwiMvCo1TIQP0cn/VBzbnyICFgBZ0OB8Y=;
        b=CcgiDo9k1J3BBuD/4NpMikvbePTHRJLYgzerB2huV5l8dCYyZbmUBIcqcIvH8VP3n1
         3U5jTmqA8MianFqZB+DCCZgsd2GngIZ5DWZkDwJqhS1ff7DfJ8iMROAP3IC/zBiBhbjJ
         i2zrAT1bxLbNpgsf1cdr0GEuUeM/FctrFKHUBj3xjjUqTYCk3gNcZYLCfds80A+LU1Ic
         N5c5cDaNDk9L1DwL0NrjUrlG3vMjTTG+DVWm0orcPBuVeONUIpG0bUq2vfoI/cME/MWw
         +vckk0vbs8Z+BZ215Q0UpTi3w8RO9Cd2ZJ0cL2qSoIJViehHzv89XtkLJX0cWnEeHwla
         6u+w==
X-Gm-Message-State: APjAAAU/aBj2qEwLBEHcblHjTcaTahgbgoJpCN6ZTIXa9yD6iA52J8jR
        1UcbcTJZynGdI7EqPCBY/eLSyg==
X-Google-Smtp-Source: APXvYqw7sxEBBotFfIGOpBAi2210wDBdfmyL+aBEJsT7xHpKccGKNe0o4n5mxz3F+CpkAM0d6b8t+w==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr397883plo.3.1568672374134;
        Mon, 16 Sep 2019 15:19:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm113363pfp.109.2019.09.16.15.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 15:19:33 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:19:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: treewide replacement of fallthrough comments with "fallthrough"
 macro (was Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use)
Message-ID: <201909161516.A68C8239A@keescook>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd>
 <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
 <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <201907311301.EC1D84F@keescook>
 <201908151049.809B9AFBA9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908151049.809B9AFBA9@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:15:53AM -0700, Kees Cook wrote:
> With that out of the way, yes, let's do a mass conversion. As mentioned
> before, I think "fallthrough;" should be used here (to match "break;").
> Let's fork the C language. :)

FWIW, last week I asked Linus at the maintainer's summit which he
preferred ("__fallthrough" or "fallthrough") and he said "fallthrough".

Joe, if you've still got the series ready, do you want to send it for
this merge window before -rc1 gets cut?

-- 
Kees Cook
