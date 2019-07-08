Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE38C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C38C21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z//APFq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfGHOyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:54:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39365 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGHOyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:54:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so14835783edv.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bNT0DI8zf1x4sOIXDdDUd5MH9U1axxqV6OsNl9utl10=;
        b=Z//APFq9fnEjnMyxU9HNc8g1OiZb21AI6ZmjgovqJ5+uZtTMnYMyutuFPLhBWaJB5c
         mOeMNm+rcTQ+5cm23LHsgoMpWsnGYhMnb/uNMM+H7gcHOP7yMgVPDlqUj1A09wx2BelV
         oewOV9s3X7PCO1KbLjOCLD2UPNYELpUsPHhYiwEu2Y2OL0UBmEPg4Ecc3DAdobItOW6Q
         7lnKrPJjcYlWijiTcN6f3uQwkosnbBVmLWXKS7H8xO+HVhPbwW/INO/XNXwgmVJvhDLv
         3uxC5jij6XOKXibhG1c27GyszD8R8VxFtGo9nCAZp1R2FeGTPziWnK456LLZZQB1tKXa
         eGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bNT0DI8zf1x4sOIXDdDUd5MH9U1axxqV6OsNl9utl10=;
        b=mujZyJAGo9QaueDQep6Ub59Jz/IW7N0GRN0TPXqeQRZ4H+kxAn5dIg802hiuCxs7RT
         PZRbz5nXs8IqvexaSD8fFgy+rxNDVV4UBmXVle+dHzewiC4UxUiTtBQy1HKP1vyupZm/
         VrA3RiYfBRDKfApSmRkzzehncKciTXLXIpzoGKuEwGj6TsT8a+rP4XW0RQXmo7A6DdU+
         fYOr0DV/T4mfq+JjUYbKFFO/9IgvQkZSKbzGRrNGxB5EAv5UJBjFua91tuotlHii+hx3
         qn6gmKkWri0BmrnMzMjLmNjMX+SWzVjx58x1M7Elks/L1BUucv97tW8/AlSFLsc2li08
         iVyA==
X-Gm-Message-State: APjAAAU4MNiHr/ywr75G2zNdGFHQkBqLVcLpcptERSQtEdv5wtazgDYL
        uHh1N64KVtUMvH2epoo7WUg=
X-Google-Smtp-Source: APXvYqzYKo3loYnOhaKC1u/yZVXsZuc8T6BmR0pGvHksFxi/lteDxK85p+MMjEhT1cqCjiOqlQBBKw==
X-Received: by 2002:a50:f49a:: with SMTP id s26mr20855838edm.191.1562597673550;
        Mon, 08 Jul 2019 07:54:33 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id o21sm3779989edt.26.2019.07.08.07.54.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 07:54:32 -0700 (PDT)
Date:   Mon, 8 Jul 2019 07:54:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Likun Gao <Likun.Gao@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Gui Chengming <Jack.Gui@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/amd/powerplay: work around enum conversion warnings
Message-ID: <20190708145430.GC43693@archlinux-epyc>
References: <20190708135725.844960-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708135725.844960-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jul 08, 2019 at 03:57:06PM +0200, Arnd Bergmann wrote:
> A couple of calls to smu_get_current_clk_freq() and smu_force_clk_levels()
> pass constants of the wrong type, leading to warnings with clang-8:
> 
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: error: implicit conversion from enumeration type 'PPCLK_e' to different enumeration type 'enum smu_clk_type' [-Werror,-Wenum-conversion]
>                 ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
>                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:775:82: note: expanded from macro 'smu_get_current_clk_freq'
>         ((smu)->funcs->get_current_clk_freq? (smu)->funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)
> 
> I could not figure out what the purpose is of mixing the types
> like this and if it is written like this intentionally.
> Assuming this is all correct, adding an explict case is an
> easy way to shut up the warnings.
> 
> Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
> Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I sent a series last week for all of the clang warnings that were added
in this driver recently.

https://lore.kernel.org/lkml/20190704055217.45860-1-natechancellor@gmail.com/

I think it is safe to use the CLK enums from the expected type (from
what I could see from going down the code flow rabbit hole).

https://lore.kernel.org/lkml/20190704055217.45860-4-natechancellor@gmail.com/

https://lore.kernel.org/lkml/20190704055217.45860-7-natechancellor@gmail.com/

Cheers,
Nathan
