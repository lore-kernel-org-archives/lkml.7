Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D5C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2722621848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsniQefV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfIEILI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:11:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43762 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:11:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so968422pgb.10;
        Thu, 05 Sep 2019 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNUhBxF1OnG3d3ID43Jl2Sra4Jf1K5JNUVXSe0J/Mmo=;
        b=FsniQefV8YjuNc/PRrZO7rOT/9G0ax8+aLc2Sz/tUwIKjH+DrNsgTNPIdCNssllbf1
         yTsw2jCCl+nhi3JG+3OiKUJbn9m3OqZzU/MwtpGG7EvVTeby+PTM1a4kWl+pAl/W8p2f
         QW3A2gnfv/hpd5csElAMUYftBSWWIMgYAbyA8tas18mDueWBGlE+8y8yMlS7K97UJz1e
         FdGd63Y59wGv26usW5cD/I64bNqERDONTXMRb/TQ1dMOR3neAW0ou+hw7gmHuZ/jLN3R
         Yq6qr2hqq64hFguW6qK+LgttRPvNo0jBVjB5hpdOXr7pVzj2BUERpVvhbtWwaa3rb9Bu
         0X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNUhBxF1OnG3d3ID43Jl2Sra4Jf1K5JNUVXSe0J/Mmo=;
        b=TH+4o0+FR28jprocDOAgxdStGWwYI4ivFWyD9jEbgXJSqK/26fbtj+x1cpC51KPqf5
         4BygmquP+5crbeqBq7wbVSV9zOCCP2mnPKGGHDcuBMzHSn0/ZJJg5mwOcUsFPPA+qIJg
         znozsFSRIbshEMeF9QTY9Tu8Hqy++Cw2il0jSdnqqp3O/msHAWRaJ0kNMcT9Tmn7/q8G
         /4TvZzJtdjul/KxSkoVIOiXvoyqmWMsfZwcHqKJURhidViw9Mf2d7gGP0SLRY4oP7+tJ
         /ow4wSMJ18pA9mc1diAxCajMA1D/610joibQO7e4Sb9QRdavgXeflmzTqc7Nd4QNmUvl
         fEsg==
X-Gm-Message-State: APjAAAWty45o2FqkvW5k+m1tq+JCuS0f7XFROzp36srUBkbO3sgbupsg
        UqQ5Ym7uCHPazLoTmCKX47sQ2HNVCHwK/vdg8WA=
X-Google-Smtp-Source: APXvYqxtpDJ3+oWsCUzA9PrngplgA8XurQG2hkrTxbU64Fwo0RP5J+VAvVKFqCivcEjjcIw5AUIW1TNKX62bq9nBXEs=
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr2570783pjb.132.1567671067543;
 Thu, 05 Sep 2019 01:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190904061245.30770-1-rashmica.g@gmail.com> <20190904061245.30770-3-rashmica.g@gmail.com>
 <CAHp75Ve0zEkuD-75aZ6FU+A=DvX8NvVvY3n9p_pYDyfa76sxoQ@mail.gmail.com> <1ca6ffddd2452e218ef19ea84ac6c6277e1a9725.camel@gmail.com>
In-Reply-To: <1ca6ffddd2452e218ef19ea84ac6c6277e1a9725.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Sep 2019 11:10:55 +0300
Message-ID: <CAHp75VcCUuCNx35DReO4YzSgDv0YJPKXdpL+xNyjwOZX8jvVtA@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: Add in ast2600 details to Aspeed driver
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 2:34 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:>
> On Wed, 2019-09-04 at 19:30 +0300, Andy Shevchenko wrote:

> Perhaps this and your other comments below would be best addressed in
> an additional cleanup patch? This patch follows the formatting of the
> existing code and it's not very clean to differ from that or to change
> the formatting of the current code in this patch.

OK.

-- 
With Best Regards,
Andy Shevchenko
