Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94323C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6CE2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="jToWQaO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408678AbfITKgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:36:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37001 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408666AbfITKgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:36:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id l21so6605378lje.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WxAeg0E408eZYRG3jaSU6/idFxhNoNTLxowg0akgOcw=;
        b=jToWQaO4D6xEhMK9/TNQMuFGKbY+7smm/ghe2egGrXdgjp9a7IGN72Xca35sidyhok
         kpaz5ralL1igV0259f/lzjwYwXol6ELi4hsyuVxNEYVOpGaHccZb94sqyxfKUys9yHdc
         D8Z0qlL7ecKdViFW2QPE7WhExVxQVCD6UVTCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WxAeg0E408eZYRG3jaSU6/idFxhNoNTLxowg0akgOcw=;
        b=mvAcrgjcfjAbmtcMG0LCUbPn0cqWThirUunk8y2m5UJLbbewt9XLLATcftiqyJGlw6
         HHVZYpZKRp2nzXNBqg4rp2pcmHvJrGWTZEN8cYxkGiFxj75yxiyFaPkOmaNMZULPTPC8
         XbvFNy7eKKNfw+zXP1hbWYIuwufO7Vxx16Mu17OpyZAslZiTJvh38QEm7PABz85xTtsH
         kORAPIDZ+tQQwH++yVER8dekUF3nWJK6RDjSBONxZZ62fmxph1Ot8F5v4IUqOSpv9RqM
         JKSHo9vh+AvosK1Fv0oljdlJn6JqxQszaAkhia58asQdUZJrhFrnLaisM+FERuDr665A
         lI9g==
X-Gm-Message-State: APjAAAW2kgBRdq65pQlMHAoVzC1+7JoHu7a7JRp67luYckR4TncjkHvC
        cJyY9hWICpIdmur9Bl+aF5sqj9j9ZTZg6rNH
X-Google-Smtp-Source: APXvYqxKkShwoINlCHvbgRna0mCpBj60DPtHn9mUmlUHjnbq1INmrrmDP4/wXchRCyQvKEe49i4U8Q==
X-Received: by 2002:a2e:934f:: with SMTP id m15mr8826326ljh.101.1568975811966;
        Fri, 20 Sep 2019 03:36:51 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y22sm400931lfb.75.2019.09.20.03.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 03:36:51 -0700 (PDT)
Subject: Re: [PATCH 1/5] backlight: pwm_bl: fix cie1913 comments and constant
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190920101405.yuu4bymublj45kd4@holly.lan>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <fe846ffb-857e-fda2-1277-3ca49ffc0d7a@rasmusvillemoes.dk>
Date:   Fri, 20 Sep 2019 12:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920101405.yuu4bymublj45kd4@holly.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2019 12.14, Daniel Thompson wrote:
> Hi Rasmus
> 
> Has something gone wrong with the mail out for this patch set. I didn't
> get a covering letter or patch 5/5?

Sorry about that. I should have included a cover letter so you'd know
that patch 5 wasn't directly related to the other patches.

https://lore.kernel.org/lkml/20190919140620.32407-5-linux@rasmusvillemoes.dk/

I was removing the now unused int_pow() function, but Andy has told me
there are new users in -next, so it's moot. Only the first four patches
are relevant.

Thanks,
Rasmus
