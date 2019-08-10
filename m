Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019EBC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3462085A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fuf4h2He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfHJSnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 14:43:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36699 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfHJSnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 14:43:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so17751532lfp.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rja8RYLbYO7zdEZxlKWhvUwl1THkfzex1o6FWwU5HWU=;
        b=Fuf4h2HebdunXfRvEP80YJvHhIewGfgdnw0LmcDJGL9f/jrWf72Sq17b0GASMz/a79
         N38+yaX7pbq4Q7tLvaqtyRpSjcSXBXHCNSWjvSOyHp24qXve02WyIs4jVz3h6v0X6wfp
         kjJQlTFsg4LcACEBLvkSvgE0UzOKNLSRsl+u6aw6csyf9PFAeEgPA8dAAXtYdN0u18ud
         g1prOvDxbwsmwnPFzc99lpYs1LNd7RKLUAS7Okl960DHwwoSMa3S4ZUr7Zzjz/JJMsCb
         kBFiPOvbkd34VI7I4WMmP7PLYeToualVwOYZ+CNT4XGbifCn937po6t42nXnXAydwMLT
         kfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rja8RYLbYO7zdEZxlKWhvUwl1THkfzex1o6FWwU5HWU=;
        b=TUJ6+RZhExZqf57cEkPc+1OUa8FJxUH3h6oeEbfxggOFUFQ77XSSIdJjxfhQU1UYfV
         EhGvNYQFOxBNN3u+0Kxr+bp0YTqKlzDZ1zsrzwRX+oxExX7KmLxn9n0hqHWq7YF0gAbp
         kgh6LJiZKiLKrhOmwYCs3KNwPchclWRou8/0dc/bIcRjbG9SoMtjjORBoNPevcL0NVy1
         UJh0zzzl3qJyRJINdPfV6oIDm04trL1PI9ewIUCmyGG913hPsGxMYmLmOIydVtx1vDxe
         TDeZ2M47rGXbtPoBr7kH1eh31kuVd0eqiCQJQdR+VMc6bzDBNyjfOCYcjsGpECaDwZB1
         BBzg==
X-Gm-Message-State: APjAAAXhls3vGpNhP+lLnptQXeYfBmMtv7ELX28IWdBJ6T7+6ij1WXVo
        ZuJLXw4l925/wLAioFEUASI=
X-Google-Smtp-Source: APXvYqzaIZatV/01OI21+CvMkfrtBJnxCn9A6iH6H9F7KW8SrKPZ9io68sT/X9yWdVYzOlmcs2l/tg==
X-Received: by 2002:ac2:4ac4:: with SMTP id m4mr15625643lfp.172.1565462592193;
        Sat, 10 Aug 2019 11:43:12 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id s19sm19730754lji.38.2019.08.10.11.43.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 11:43:11 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Sat, 10 Aug 2019 20:43:07 +0200
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] linux/bits.h: Clarify macro argument names
Message-ID: <20190810184307.GA2353@rikard>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <CAK7LNASA1CszgXAvH78qnLOr11Po97s090rGujnNQ=zTHaSDDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASA1CszgXAvH78qnLOr11Po97s090rGujnNQ=zTHaSDDA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:46:45PM +0900, Masahiro Yamada wrote:
> On Fri, Aug 2, 2019 at 8:04 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > Be a little more verbose to improve readability.
> >
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> BTW, I do not understand what the improvement is.
> I tend to regard this as a noise commit.

Fair enough, I'll drop it and keep l and h as argument names.
