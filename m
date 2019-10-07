Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39500C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9452064A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpR2u7B9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfJGNeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:34:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37571 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:34:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so12540488qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nwlp1QPq4c1Fg6asQ7NB8TWNONjREWmPa9T7sJeo1Lk=;
        b=LpR2u7B9qLEOo21QyyEqXT18++T96JVqMjjDQyKd2ZljeCz4lOfAqE9jICCOUofOUh
         JVqDxIg1Co8ZFXn/zlC3TsCfiNvKGMhAnJLziq46rxbu4og/R+XW5nGWOgqMfz6pbbio
         DYlXgZzLO48AJQMOMhcVvAs3AI4aCK6b9O3UsPvpLyfmVZgxV62R4sbvBtT07sHpnj9p
         GKBLb19GpMl2Ppo9oiKiS+DUJEs6IMFL9vxBn6QRUcr9K8bqdEuG6fWgtOg4oqA3msfL
         F8mqxebT+PFm55/aoOV7zBRZ7ftd+J6BEiZbp+9jRyzhUTvQLBzB0PTqhbMLTk9e18EE
         78RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nwlp1QPq4c1Fg6asQ7NB8TWNONjREWmPa9T7sJeo1Lk=;
        b=TJ7XlwD1vkKx30cslCMzj5xEbD+FAkbCyMX53P/DgDt9Y4cp1X7mouJ8s/B73CP+Mi
         hCkLZ06yk3MFnKSR8O9KVS7pfgVGJWXWuM1zFsaMj1RJKQzLwg1bZcS5vubGU6qA28Bh
         qVYMuaHk5mNUFxaJOTRtUgTqTaslyRGTLzbbjD7fe/RfzAVI5juq9BdPYuP1X7SYhwLE
         4ZNanhbGI9XBxgEfvl3wb5tGzdpeAGHSC//ZVcBX0B2OfcQ8booZROq+VGnMVpjC92VJ
         ig6lVpqAo4zRtCN2Kkg4pSWh61KZR2j8aH6VOc8cPThv8m7VD2jKK+FoDeXGib7yNkMj
         NHow==
X-Gm-Message-State: APjAAAWvg0K8ILB+DNrP2wh3GD0W5+psjzG1hKs3v50XqANLg/Swf0Ot
        MEu2wA9aBJnzXH7aP8+eVqymEAnCvjcNpSASEN0cNw==
X-Google-Smtp-Source: APXvYqw2Ad19XCqX+cZlHA+koY+Sx+ZtM8Qex4TkHKoGbm8iZRab0lV148rExC6MroVc/4YnPTOIulyRMYK1XqNpOvw=
X-Received: by 2002:a37:e10f:: with SMTP id c15mr22691586qkm.256.1570455243666;
 Mon, 07 Oct 2019 06:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
 <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
 <1569594142.9045.24.camel@mtksdccf07> <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
 <1569818173.17361.19.camel@mtksdccf07> <1570018513.19702.36.camel@mtksdccf07>
 <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
 <1570069078.19702.57.camel@mtksdccf07> <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
 <1570095525.19702.59.camel@mtksdccf07> <1570110681.19702.64.camel@mtksdccf07>
 <CACT4Y+aKrC8mtcDTVhM-So-TTLjOyFCD7r6jryWFH6i2he1WJA@mail.gmail.com>
 <1570164140.19702.97.camel@mtksdccf07> <1570176131.19702.105.camel@mtksdccf07>
 <CACT4Y+ZvhomaeXFKr4za6MJi=fW2SpPaCFP=fk06CMRhNcmFvQ@mail.gmail.com>
 <1570182257.19702.109.camel@mtksdccf07> <CACT4Y+ZnWPEO-9DkE6C3MX-Wo+8pdS6Gr6-2a8LzqBS=2fe84w@mail.gmail.com>
 <1570190718.19702.125.camel@mtksdccf07> <CACT4Y+YbkjuW3_WQJ4BB8YHWvxgHJyZYxFbDJpnPzfTMxYs60g@mail.gmail.com>
 <1570418576.4686.30.camel@mtksdccf07> <CACT4Y+aho7BEvQstd2+a2be-jJ0dEsjGebH7bcUFhYp-PoRDxQ@mail.gmail.com>
 <1570436289.4686.40.camel@mtksdccf07> <CACT4Y+Z6QObZ2fvVxSmvv16YQAu4GswOqfOVQK_1_Ncz0eir_g@mail.gmail.com>
 <1570438317.4686.44.camel@mtksdccf07> <CACT4Y+Yc86bKxDp4ST8+49rzLOWkTXLkjs0eyFtohCi_uSjmLQ@mail.gmail.com>
 <1570439032.4686.50.camel@mtksdccf07> <CACT4Y+YL=8jFXrj2LOuQV7ZyDe-am4W8y1WHEDJJ0-mVNJ3_Cw@mail.gmail.com>
 <1570440492.4686.59.camel@mtksdccf07> <1570441833.4686.66.camel@mtksdccf07>
 <CACT4Y+Z0A=Zi4AxEjn4jpHk0xG9+Nh2Q-OYEnOmooW0wN-_vfQ@mail.gmail.com>
 <1570449804.4686.79.camel@mtksdccf07> <CACT4Y+b4VX5cW3WhP6o3zyKxHjNZRo1Lokxr0+MwDcB5hV5K+A@mail.gmail.com>
 <1570451575.4686.83.camel@mtksdccf07>
In-Reply-To: <1570451575.4686.83.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Oct 2019 15:33:51 +0200
Message-ID: <CACT4Y+bJFoQPJ4QbGNjAuqiZx-FFsuLansxkhX3kwLOc19NvcA@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 2:33 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> On Mon, 2019-10-07 at 14:19 +0200, Dmitry Vyukov wrote:
> > On Mon, Oct 7, 2019 at 2:03 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > My idea was just to always print "heap-out-of-bounds" and don't
> > differentiate if the size come from userspace or not.
>
> Got it.
> Would you have any other concern about this patch?


Last versions of the patch looked good to me except for the bug title.
The comment may also need some updating if you change the title.
