Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A387C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021F42081C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558803967;
	bh=JCyz2AHEnuFqjY1vov/YDirUQKDfQDhkKPswnqOMK3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gi21CHtUByzth3t09K+LUGONb/5tMH3XjGz6M2DOgBowuaj4MAYZH0nNRjv7R6jup
	 nrBZIZddcg2SVuK5+J0qyd/zf7A/fiqdnpSAbxMf1/12Rge29QEH5zEBeMHH2ehK1j
	 eQGUla9CrNs3rwLO9xnV7Fq3P/CzNBvmXVd1u7qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfEYRGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:06:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33865 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfEYRGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:06:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so11293023ljg.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUnPUEw25xH84DOq6zJ0v6Aw5NodbUsM/I1jFeyU0KM=;
        b=ZvNWnuQZMG/SkUan4dFz03SkF+F6NtqRC/Cgx2fb5lXthFpCjyzEbczW/SDraYncIR
         zQgHz3FqW2dkuJzWrU9AHwiQ6MhmEIkM0Uwmoc25goSdoXSqyrERxHA6nnEdyvmvjOcJ
         rQ898QL/9J9sDjvhm9K66P/TQWm9eicsR7EOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUnPUEw25xH84DOq6zJ0v6Aw5NodbUsM/I1jFeyU0KM=;
        b=fH+n1EFUY/da6ce1y9wY5VEc9/xVl/1l5wg/2yU4B9azk7Cr06Eat3EPitCIB/jza2
         3MNr+DqDqr/uEVXYxIAE1fBtVBTANUzPL0HnJDMIkmZD5VUlIpNQgoF5eUfUC8MyaSgV
         mYs6XUyhegqy+vDtso894wJr8wHefbzY3zOoPxQxZvsE8ti+yWIAkS3z8kfIOQ0WwEOJ
         JRFcOuO/ezeE9lqifyberz1we7qHVZzYOXo6RIp5QHwQ86+pso3cHARFxehThVovRbIJ
         A8wgK2vxb+LLxqcByjovYstIzHZ6duPyU4m8ZsfjQCEvfddVshadK2f7840TnhnrqfJ5
         0RmA==
X-Gm-Message-State: APjAAAWAuFnniQKon7DoAZ9K5rUutVBbGMwOebCZLGHuNwoxrwtaloTv
        7lgEjsK6BShIV1ZXGlVMzIDQWYCkN6U=
X-Google-Smtp-Source: APXvYqyfzysI69SI4LuUEiFOj3SfKlxFw/58Rijm/70+VvKZw4o7RHbZQaJxKaohIGsCZTiyl02JAg==
X-Received: by 2002:a2e:5b52:: with SMTP id p79mr2137135ljb.208.1558803962572;
        Sat, 25 May 2019 10:06:02 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y25sm1248214lfy.59.2019.05.25.10.06.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:06:01 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n22so1546405lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:06:01 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr629669lfn.52.1558803961013;
 Sat, 25 May 2019 10:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190525133203.25853-1-hch@lst.de> <20190525133203.25853-5-hch@lst.de>
In-Reply-To: <20190525133203.25853-5-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 May 2019 10:05:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com>
Message-ID: <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm: add a gup_fixup_start_addr hook
To:     Christoph Hellwig <hch@lst.de>,
        Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding Khalid, who added the sparc64 code ]

On Sat, May 25, 2019 at 6:32 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This will allow sparc64 to override its ADI tags for
> get_user_pages and get_user_pages_fast.  I have no idea why this
> is not required for plain old get_user_pages, but it keeps the
> existing sparc64 behavior.

This is actually generic. ARM64 has tagged pointers too. Right now the
system call interfaces are all supposed to mask off the tags, but
there's been noise about having the kernel understand them.

That said:

> +#ifndef gup_fixup_start_addr
> +#define gup_fixup_start_addr(start)    (start)
> +#endif

I'd rather name this much more specifically (ie make it very much
about "clean up pointer tags") and I'm also not clear on why sparc64
actually wants this. I thought the sparc64 rules were the same as the
(current) arm64 rules: any addresses passed to the kernel have to be
the non-tagged ones.

As you say, nothing *else* in the kernel does that address cleanup,
why should get_user_pages_fast() do it?

David? Khalid? Why does sparc64 actually need this? It looks like the
generic get_user_pages() doesn't do it.

                Linus
