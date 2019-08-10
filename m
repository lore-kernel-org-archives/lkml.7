Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6A8C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02692085B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj+5pLDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHJTgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:36:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43406 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfHJTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:36:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so1203312otp.10;
        Sat, 10 Aug 2019 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3yb3LBkgCj2WvJ0+Uh/BuPywJFT4H1nD+b3TdWQhSU=;
        b=oj+5pLDdOrDIiAbaNDjQ1bkeAXV5AjT9TALASs8w5TWKZj3/dFkC2vv5yeQmG2uObR
         nhAVrWZmWM926inhvI08Pacm8FS4B3Sk5foq7dAYZ4S7oI7qkj41d2fGbke6Ad8ALZ4r
         UVQiWi+6+fw3QUqitteCJHBfvzaL/tCc/yTjT2LRHIP9AGgf72OnhYiQ+50XkoCWPIYF
         oS7Of0bG49hQB4RMbZNBZkWUqfIXQQlVj7dGZnpyMZEBJ1UAUAWDXDlbflfQamJwuAni
         saowKPupGI/V/yXVQmRSYuKfixhEyQwsJjr2eLoQgFetB5POTKwMs/cXzJYjnFmuRR7f
         LpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3yb3LBkgCj2WvJ0+Uh/BuPywJFT4H1nD+b3TdWQhSU=;
        b=BwQqznpMTdTdApjP3bTbJ0GzutQvmj/LZZaPlnJUtGdXqJ17qQxhh6sPTWFqngC0Ik
         +Ga81jwNzEw5YC0T1viyFerLUC0DRtUtZVCxKcwWj0E9B1z1d/b13bOo6PJF0K73l2G7
         ndX1uShTCnptqNhNUqvgbnyUYd2swKDlbRqN3q413nw9bqpr8+ebSDTQoSOmnld8iviR
         ZF3/9aiVgQtTRXf2fQHh7MGD+lrHr4bAKMjdnqZHhcEmHi9T+SUNgOxePem0ubwz5dUY
         xgEFsMiNjXVNBhcgICRTIuokbellf5KyeguHev1nWjRxbX4v8kbFcvBLGgh4IseQ7ooe
         8/PA==
X-Gm-Message-State: APjAAAWPnaTm8PKJIKhjJAjLaQ7kYVr/YQHcWJmHwB3GVutv+n6M1pqS
        dg2VFJbsSN+hqz+bJfpy3ScHYwqUGgjIAe98s9g=
X-Google-Smtp-Source: APXvYqwN+kQL85VSwh3lLWhx/55k2LTWeEHB2UFHSABa5sTDQl+sissp0jrGB1GwrOcENUeIvg/JCdsMYwsmdPxjRGc=
X-Received: by 2002:aca:c588:: with SMTP id v130mr5068345oif.165.1565465797825;
 Sat, 10 Aug 2019 12:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org> <CADxRZqy61-JOYSv3xtdeW_wTDqKovqDg2G+a-=LH3w=mrf2zUQ@mail.gmail.com>
 <20190810071701.GA23686@lst.de>
In-Reply-To: <20190810071701.GA23686@lst.de>
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Sat, 10 Aug 2019 21:36:26 +0200
Message-ID: <CAM43=SNbjVJRZs7r=GqFG0ajOs5wY4pZzr_QfVZinFRWV8ioBg@mail.gmail.com>
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the record the futex test case OOPSes a 5.3-rc3 kernel running on
a Sun Blade 2500 (2 x USIIIi).  This system runs a custom distro with
a custom toolchain (gcc-8.3 based), so I doubt it's a distro problem.

On Sat, Aug 10, 2019 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There isn't really a way to use an arch-specific get_user_pages_fast
> in mainline, you'd need to revert the whole series.  As a relatively
> quick workaround you can just remove the
>
>         select HAVE_FAST_GUP if SPARC64
>
> line from arch/sparc/Kconfig
