Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07771C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA33E2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8CzuKxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCLKml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:42:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53061 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:42:40 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so3591623ita.2;
        Tue, 12 Mar 2019 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8vHoepjDxJI1lt/gbcimZl2bZHFCnc6mUWZPsIut26w=;
        b=N8CzuKxIksHQ5xPqbXGiE0OLTQi/epvu6nzrOJcRqAKwTsk0/slyqiksuFVuxVcODK
         Vru8zK0iRtFoFTDb3nhz8GkDAkYlKZp5n2CQAEqYoxZWS31odp7jkdJkGY5WKOk7x2qA
         ePa0tvQWUxMViM8H36egltoDSl3E2yYFxKxwDQiMbtP1t/9YmoDolz7fWtYod/Ep/1S4
         RykkS20H5xQLQtFmGddAqn8yEBicylUcil9EyXMLLHSFjReJC7Q4mkX8JeQI3Iv2185K
         SaULbg1fpPhlhy0CjD2bahKBVOHAtKHdzFgNeB5h+pC8CxeVVFAGLVKSlwL5gKNnV3rn
         sGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vHoepjDxJI1lt/gbcimZl2bZHFCnc6mUWZPsIut26w=;
        b=IxETXOBLFc47HpjehgDza9KLgvpi/CyEPL6nFb/bpB6gz3rX3qaxDDd0D//T5yk+Uo
         ayPLS0TkJzy8VElm2Y/THjac7Z8oUosY1R3SVxkZ3YjKSy3AH4MTdJzg1fB02X2FTnaO
         sBDtvqUUpVabUc7MlqdsXOMXccVMblY7qsrfWe9ITm7DtoN62lhHh0KF9kRnaozcLYmJ
         hdMgmx8L6aFi7RVHyHnBpi0GB9vc664KpX1qAZQFBFypWZ30y+nLRKGBizRnUil0+cTw
         /T03/TQGoB8gEJtp97AzO87Au3+p+mGvNxWKebgoqVTdB/gbh713G1yOKwlLH/0YFd7R
         ttUA==
X-Gm-Message-State: APjAAAXtg7I1mEBAEcINDfPoFvjJHXPwOfeQyUpYZrXddyy7TQ0mWc8O
        Bf77v6VChipyhtCjNH4SIrQ=
X-Google-Smtp-Source: APXvYqyXYvXTMs0+/diJ0UO+2pJyiBEFNN7tXJuBV4g6A/TMoN8jnSTJhaCmNAblPf3U82sZ7OxsTQ==
X-Received: by 2002:a24:7a4b:: with SMTP id a72mr1563584itc.178.1552387359123;
        Tue, 12 Mar 2019 03:42:39 -0700 (PDT)
Received: from icarus ([2001:268:c0a3:c255:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id k133sm54561itk.9.2019.03.12.03.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 03:42:38 -0700 (PDT)
Date:   Tue, 12 Mar 2019 19:43:22 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190312104322.GA3425@icarus>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
 <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
 <20190311180113.c283fdbcba3df10db2c815aa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311180113.c283fdbcba3df10db2c815aa@linux-foundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 06:01:13PM -0700, Andrew Morton wrote:
> On Fri, 8 Mar 2019 09:31:00 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> > 
> > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > within a bitmap memory region. For each iteration, "start" is set to the
> > > bit offset of the found clump, while the respective clump value is
> > > stored to the location pointed by "clump". Additionally, the
> > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > respectively get and set an 8-bit value in a bitmap memory region.
> > >
> > > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > 
> > Andrew: would you be OK with this being merged in v5.1?
> 
> Yup.  We have quite a few users there.  I assume this will go via the
> gpio tree?
> 
> Feel free to add Acked-by: Andrew Morton <akpm@linux-foundation.org>,
> although it probably isn't worth churning the git tree to do so at this
> late stage - your cvall.

Linus,

I discovered a bug in this version of the patchset. I'll release a
version 10 once I've resolved the issue.

William Breathitt Gray
