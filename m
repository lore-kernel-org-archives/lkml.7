Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0771C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A1A2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFqM+LoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfHPW0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:26:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38290 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfHPW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:26:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id h28so5063988lfj.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrIWwCYqt6y1eeO+WlCbe2ljn3Qkrri3qYgYEjIcBUU=;
        b=qFqM+LoXVUtv+l/noiHl2Ppx+2RqdzE0dHyHVHdvhb0yYwPvRjkhXq1I0pkuU6DDu7
         GOFlW8G6LgZv5ELVCNJFvDR11volrbvDq7D0fG6irF48m2fXOvYyZKjzcd73zmLNg0uo
         6trEiVPvkWibXdxu1ZQi4UUbZ/4LiGMrMc9LHJrnSpWj6CeO50miqfe1xeI1CLWEjJw+
         DaA/VcO5bUfANdlShuG86jTwrsJRdXuP+noqLPaMJrnKUn1wd8+yKLINhV61RXCsf/Bj
         FgkVbizPtsrhdhZp/uUbKPaaZVDLsmiemphcadsCwzi7i9x/sGpbzdjnxxlXb6h8ClGx
         vpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrIWwCYqt6y1eeO+WlCbe2ljn3Qkrri3qYgYEjIcBUU=;
        b=TbkNZOT7Fu/w8EgkKIlk0KdNcbjHrIihyEbKls3elUwQUinstaaKEaAnoudJa62/7N
         dFW2oD1J5D8K7NlaYygHAzHKXY3vAqPROaVRmycu/8akHgfZrmm9zrxzgk3h8olocHMH
         SnDr+tknxEyuqJ9QQ505uhv16GBtWtCoomAoxrECJ26FTYK465A4ZNSLv6CP2jTyvhAA
         FIxO2OOkANY5XDw7MX4X2zKsS1LsicJA5et7P9H66p2qTYlXckT5L2LNxBcGUoRLqcwa
         cV3E9aZMIRpvrLoZILNUBYmhSfrzDIJnx5dZccZRwr3QwSpyOxlu/lZjG3hbS/C8AP1l
         GKrw==
X-Gm-Message-State: APjAAAVuf6E50W3uNvrHFem9uAvFgdUuleb34trm9trjn6Ht2hS/K0ym
        kOaEqXUqgHDrGG3Az/qBo1Zul2xYx93oCxeIiYuHHQ==
X-Google-Smtp-Source: APXvYqzRk4JU/UJJ4c76iwXHUBfgyYIL6EN9ZrEhlw6vzj6X19IKVB1C81FHKMDHsmKWCqHhTR5CtHwUKlzQLEAQxP8=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr5764558lfq.152.1565994368218;
 Fri, 16 Aug 2019 15:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190816213812.40a130db@canb.auug.org.au>
In-Reply-To: <20190816213812.40a130db@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Aug 2019 00:25:56 +0200
Message-ID: <CACRpkdbhdcmzqbr=4nQQ_upAyjrZsxGkMHhz=pZN2fvD7H9sOw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Brian Masney <masneyb@onstation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 1:38 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the gpio tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:

Oops!

> I have applied the following patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 16 Aug 2019 21:29:30 +1000
> Subject: [PATCH] gpio: stubs in headers should be inline
>
> Fixes: fdd61a013a24 ("gpio: Add support for hierarchical IRQ domains")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I just nicked that and applied to the GPIO tree to fix this.

Thanks Stephen!

Linus Walleij
