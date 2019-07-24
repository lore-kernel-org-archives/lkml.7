Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46986C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1718020665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDOr7PQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGXC3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:29:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46579 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbfGXC3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:29:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so45108799wru.13;
        Tue, 23 Jul 2019 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TLtx0N0iTDt+TcQGK6XUkJYJ0+fHixleXGl8p31XVfo=;
        b=eDOr7PQIbMwNaNWyIQeyHtYiT3PKoptD3mkASWB4ZLU3CFxrEdigBWsSZ0DDJkrsfn
         kSH+HmOYLdxHBx+MjSB4cyqGVjt8s5oaKjQKMxro/szqtGiwEM5YkEwirejbFsHZGhGW
         NiBGOOS3m8KKvMJYEIbBg6j8nHeWg86FR60Ecds00gikp9ANCQgbhxnWyGh1nT4MW+YO
         RyLe30sjKXyhLRvgrbYnKnRWbjI650SmFes+psMidJUMmCTAoYOFvK0v8/ovEJ4CThy/
         JrXGHCzFy8ZlqLcEmdsukJNJMxahDxImt8cl/YaUsxsVb2GyAcTDInd5xjU3y3D4qcbn
         cJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLtx0N0iTDt+TcQGK6XUkJYJ0+fHixleXGl8p31XVfo=;
        b=P3pO5AwfWQgdFou+tUo9vszZ5kiB/BxsF4s/293YaDr5wE380bZpTlvPiF1zB0xQlG
         Up6/dCciv57YAqVhgdtjUu5ViZrbDbJ/r2amNyzPZ5GlCSqJm87yzOwcEuJcy6jaOqe/
         EhEIPyg34DbDq0uO/kWbKJ3IUMsagCM2N94xtgI+YD2LfHZb73O75zHehmPPcnt75beJ
         4P2BwGOkdz5V+Y6OSZxwlitoDNOJu35+wh4uDw+6uQ51GY+F/6UoNCk8TipPI+yIHNAO
         BZr91JyVtUXm3vMDK62GpzkaM3PO8YZZa+MNm9V/4oVTXuleR8UuYd7qBqd+aexPm5Q7
         5hzg==
X-Gm-Message-State: APjAAAX4IciYyk77EKWxOakL1vX8rHtSGyd7z6P9SCerAPClu9EYGbGY
        SU5vICrvtRZ4v4dsDdsgtYI=
X-Google-Smtp-Source: APXvYqxP82OlR+xwzksHk3Bqw3NSV0ilSAxJ/JRHknHnb7OTFiah0RTA+6+ucX6uPJv/uDNiZAdhZg==
X-Received: by 2002:adf:f348:: with SMTP id e8mr87051410wrp.76.1563935379043;
        Tue, 23 Jul 2019 19:29:39 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id w14sm34548442wrk.44.2019.07.23.19.29.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 19:29:38 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:29:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de,
        dhowells@redhat.com, jakub@redhat.com, ndesaulniers@google.com,
        morbo@google.com, jyknight@google.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Message-ID: <20190724022936.GA73305@archlinux-threadripper>
References: <1563914986-26502-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563914986-26502-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:49:46PM -0400, Qian Cai wrote:
> The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
> compilation warning because "rx_frag_size" is an "ushort" while
> PAGE_SHIFT here is 16. The commit changed the get_order() to be a
> multi-line macro where compilers insist to check all statements in the
> macro even when __builtin_constant_p(rx_frag_size) will return false as
> "rx_frag_size" is a module parameter.
> 
> In file included from ./arch/powerpc/include/asm/page_64.h:107,
>                  from ./arch/powerpc/include/asm/page.h:242,
>                  from ./arch/powerpc/include/asm/mmu.h:132,
>                  from ./arch/powerpc/include/asm/lppaca.h:47,
>                  from ./arch/powerpc/include/asm/paca.h:17,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/thread_info.h:21,
>                  from ./arch/powerpc/include/asm/processor.h:39,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
> drivers/net/ethernet/emulex/benet/be_main.c: In function
> 'be_rx_cqs_create':
> ./include/asm-generic/getorder.h:54:9: warning: comparison is always
> true due to limited range of data type [-Wtype-limits]
>    (((n) < (1UL << PAGE_SHIFT)) ? 0 :  \
>          ^
> drivers/net/ethernet/emulex/benet/be_main.c:3138:33: note: in expansion
> of macro 'get_order'
>   adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
>                                  ^~~~~~~~~
> 
> Fix it by moving almost all of this multi-line macro into a proper
> function __get_order(), and leave get_order() as a single-line macro in
> order to avoid compilation errors.

Wouldn't it just be better to rename __get_order to get_order?

> Fixes: d66acc39c7ce ("bitops: Optimise get_order()")
> Signed-off-by: Qian Cai <cai@lca.pw>

Other than that, LGTM.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
