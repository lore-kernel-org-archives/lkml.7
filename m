Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D74C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993B2206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576126352;
	bh=wU7MOiAKcmA1brj18jg6XBrLjIBGxB5YTGkfdP4OipE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I014ZG52Dc6I9B+833fQcRj3o3TH91EKt4lWq4feE44t1BR9lvlYcdBJkYtzIhYNK
	 ojVm/y/txXcykH3VA7wshMkLMisofMskW/+bGopDzT9K2/qg+21IZ6flAN9JL6NY6B
	 tf4Ujjq4fCwOeWvq5g1lYSr3nH05lx8MGe3l2NwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfLLEwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:52:31 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:33731 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbfLLEwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:52:31 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id xBC4q23H013067
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:52:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xBC4q23H013067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576126323;
        bh=TyTFhnCKN2YT9bgwjekkQfef7OcPW8tA1OCfAFWZK7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A7yKkfSAcs9WjoquxzLh7cMFno8KGaAwFSH0NIn9ESuM6QSL/TUGtVFFbTa8/xu0r
         wQVmdp/Pe9koFAp6WKmBLh3ri+Kl32LgSe8/nZ/SMkRf44czRfl6X3ZcGUSrXDa+Mn
         oWW1ouviggHFzlGX53/yURcUMqqueqGKosTv0OZ45wjBVfTjwjF6Y4nRnEIS9p4yLd
         6LXBVMLZH3Yfr4SVlGxe6+4SxWgBxDzjlRKpTAp0QvK6vpue1IzqMBBfmO/qKsz6/J
         IHf8jAfgfV4pGvwPlGtVfoy2SCebW0f/u4ssKUQpcIk0cJC+miKFQW2VdBnFpvfn0q
         jGcgniX76NfKQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id i31so353672uae.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:52:03 -0800 (PST)
X-Gm-Message-State: APjAAAUonxWcDiWvL2H72wOZLifIAF/lrBuQy9tepU3IuzKeB9DlUOVj
        OZOcwUgynAcwekPXQCx9CioQnVbdOlp5Evw1ajE=
X-Google-Smtp-Source: APXvYqz/xKbHHZjwUWVynvq0LAVaNNjyZIbkX3XCyi5Zubq0qkD3LmQSy2gKjjpQPjA4me5ky2NjvvlFXvzrYZyE/Xw=
X-Received: by 2002:ab0:6509:: with SMTP id w9mr6474644uam.121.1576126321925;
 Wed, 11 Dec 2019 20:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20191211133951.401933-1-arnd@arndb.de>
In-Reply-To: <20191211133951.401933-1-arnd@arndb.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Dec 2019 13:51:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASeyPxgQczSvEN4S3Ae7fRtYyynhU9kJ=96VX34S4TECA@mail.gmail.com>
Message-ID: <CAK7LNASeyPxgQczSvEN4S3Ae7fRtYyynhU9kJ=96VX34S4TECA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: make it possible to disable
 CONFIG_GCC_PLUGINS again
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I noticed that randconfig builds with gcc no longer produce a lot of
> ccache hits, unlike with clang, and traced this back to plugins
> now being enabled unconditionally if they are supported.
>
> I am now working around this by adding
>
>    export CCACHE_COMPILERCHECK=/usr/bin/size -A %compiler%
>
> to my top-level Makefile. This changes the heuristic that ccache uses
> to determine whether the plugins are the same after a 'make clean'.
>
> However, it also seems that being able to just turn off the plugins is
> generally useful, at least for build testing it adds noticeable overhead
> but does not find a lot of bugs additional bugs, and may be easier for
> ccache users than my workaround.
>
> Fixes: 9f671e58159a ("security: Create "kernel hardening" config area")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


-- 
Best Regards
Masahiro Yamada
