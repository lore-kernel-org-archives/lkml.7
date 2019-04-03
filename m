Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49C8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC4C20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHYVuxiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfDCEyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:54:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45733 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfDCEyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:54:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so7499900pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6UMUo87AynMzgOQp8qq0fzNqfRb8NbbaePfc4zroNvk=;
        b=rHYVuxiCwQoKOq1jFIn3v2Sg3D5wh5rGWYqvy7c4Iw/2TKyIVa1dNlUWzQtX7G0iIc
         6f9x912Whkt6rBTPxRtMhxCeKt9TE4u/HXNvghlLf0ouTLjpbc3ERfglFbdYyA60VSaT
         08Yqv/LLT+Wuuq1iqb6JyBlNXXjHDA+WiDk4k1q5yaplNL0wt3+RBpzPK83AEw5jlgHO
         WuyqRKXSH08t7H549uNcgrGckODPnd8Im0uQl7p0Sgegq1U6OsQ0G9C/dcWMIdyi70Od
         cZdecNBj+cj4XFwcIB8kIKX6bMmmq3A+Yn0Pg+kQJ2AofSIOXOjC+IQFCLWuJvflnqfU
         50eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UMUo87AynMzgOQp8qq0fzNqfRb8NbbaePfc4zroNvk=;
        b=Y8FRSGNVooWilE2LUWKKA+eyi3hV6O7ewvqGh9CKvw/9zXWF3G1z5EEVDWS0NhhrhI
         SIvJX1bwRe8YpnAI/tHPH3RiQyU/xzbThoX39rY2n2DL/ulkMRbKQ9D56K+E+noyqpmF
         wIUrcvrC1tsYaOJ9+DWqS9nK58petgyTftd6CRlcPCpkobRQtfhoMkQgjkZ0Ab0QZ9OE
         P6RoiDijIp6A8t76+kzj5W9HS/KqY/lAMSp+FTiS9kH1VKr8bKQM6ELoAK85KtR1PTBw
         cpUBcbx+buOYEBz43ACjxBqlcWjjp2h2fP6PF0tD2EW/d/cdaP8l/AG1vC2qsAQCEy/G
         Ph7g==
X-Gm-Message-State: APjAAAXeGm/x8lBpeV6wuCRQvqDVO3lFPGtX/sH/SADw085+q97GzvBA
        FgD9TKZjVBBST8JladAj8pA=
X-Google-Smtp-Source: APXvYqzfPwbt9S6VxlWHLWDuJzi5tAVCSm7Ok18yzDBqPmnYb21SHn7LwAmVJ9MeKX+e3iZlxjw9hQ==
X-Received: by 2002:a63:4e57:: with SMTP id o23mr67222725pgl.368.1554267284972;
        Tue, 02 Apr 2019 21:54:44 -0700 (PDT)
Received: from localhost (c-71-202-79-220.hsd1.ca.comcast.net. [71.202.79.220])
        by smtp.gmail.com with ESMTPSA id 66sm26261594pfr.44.2019.04.02.21.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:54:44 -0700 (PDT)
Date:   Wed, 3 Apr 2019 07:54:27 +0300
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] lib: rework bitmap_parselist and tests
Message-ID: <20190403045427.GA16444@yury-thinkpad>
References: <20190403044540.16322-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403044540.16322-1-ynorov@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:45:35AM +0300, Yury Norov wrote:
> bitmap_parselist has been evolved from a pretty simple idea for long and
> now lacks for refactoring. It is not structured, has nested loops and a
> set of opaque-named variables.
> 
> Things are more complicated because bitmap_parselist() is a part of user
> interface, and its behavior should not change.
> 
> In this patchset
>  - bitmap_parselist_user() made a wrapper on bitmap_parselist();
>  - bitmap_parselist() reworked (patch 2);
>  - time measurement in test_bitmap_parselist switched to ktime_get
>    (patch 3);
>  - new tests introduced (patch 4), and
>  - bitmap_parselist_user() testing enabled with the same testset as
>    bitmap_parselist() (patch 5).
> 
> v1: https://lkml.org/lkml/2018/12/23/50
> v2: https://www.spinics.net/lists/kernel/msg3048976.html
> v3: Implementation of an approach with copying the data to
>     kernel space in bitmap_parselist_user() instead of parsing
>     user data byte by byte. For me, it looks better than v2.

Hi all,

I'm sorry for noise. My mail server works unstable, and it would be
better to submit patches 4 and 5 a bit later. They are actually the
same as in v2.

Yury
