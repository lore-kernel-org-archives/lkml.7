Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECEEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685E6207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Xxpj7Di3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfCJVyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:54:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35600 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfCJVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:54:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id g19so2420204edp.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3n3zLsxeTrvdNVHWG+lNbUiLZmUjtMGJ41LijBUri6Y=;
        b=Xxpj7Di375QxQ2ys4+Zi2/3fzc0AGWgGY2icT3ohKpNqkSzAApi1l5/4JuFlfGDIzg
         SWvwJtf5v09I/RTTz836ShVL40FswuhU12gvEc6Emcz4n/SujWbCtsKyAGT9gePWz7cb
         UZOiif5cmQ0tAEyFRLALnIxhXDPCt3OafCxVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3n3zLsxeTrvdNVHWG+lNbUiLZmUjtMGJ41LijBUri6Y=;
        b=fTQJMWYZtJIkslbE603HomD8bFQX6jHKK8eawcAkQgLmaZKnOuZgR82zO2FyZxp/h5
         I0UJXyUMxlDODBKZjTWwsoY4YyUgpEPRbvgMtbQIjRa9WlidKN/RYwMjvKQIk0h+iPZx
         ODhC41iTazjkhmP+OWj9B2zmNIwdtc0UwCl+38Sm+2KYcBDBqaMlyohpR88IMEhIrmmA
         SU5a7NB4C8oXMwGLIvgJSQAq+NiQqa71ZJna/809BA85+HBL7+gSi7saXtI9GJsLCIHb
         yHgdKpNklByQJCV9HSImvQrka+9q53MouEBpZpj4fYbrOoSz6ks0SuhbZ6ErSLBGx345
         Z4jg==
X-Gm-Message-State: APjAAAVP6SHrqRwzhMju8e723u8gLBD6lJlr4uSeMUUt5zCKCN+BVaom
        rex3uWwZCsFhk5Ntp3LOR2A6Fg==
X-Google-Smtp-Source: APXvYqyfILDqUBmT5ctxuV3OupkmR7o802RZarayl3LyQ/SJpFe7XMO+NNJqi6uDZo/u02/UxEI4vw==
X-Received: by 2002:a17:906:7fcc:: with SMTP id r12mr19719808ejs.100.1552254883454;
        Sun, 10 Mar 2019 14:54:43 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-117-145.cgn.fibianet.dk. [5.186.117.145])
        by smtp.gmail.com with ESMTPSA id g11sm4230390edf.44.2019.03.10.14.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 14:54:42 -0700 (PDT)
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove
 MAX_LIST_LENGTH_BITS
To:     George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
 <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3194949c-6e04-da01-68df-60ae344db099@rasmusvillemoes.dk>
Date:   Sun, 10 Mar 2019 22:54:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 04.06, George Spelvin wrote:

>   * The comparison function @cmp must return a negative value if @a
>   * should sort before @b, and a positive value if @a should sort after
>   * @b. If @a and @b are equivalent, and their original relative
>   * ordering is to be preserved, @cmp must return 0.
> + *
> + * (Actually, it is always called with @a being the element which was
> + * originally first, so it is not necessary to to distinguish the @a < @b
> + * and @a == @b cases; the return value may be a simple boolean.  But if
> + * you ever *use* this freedom, be sure to update this comment to document
> + * that code now depends on preserving this property!)
>   */

This was and still is used at least by the block layer, and likely
others as well. While 3110fc79606fb introduced a bunch of if() return -1
else if () ... stuff, it still ends with a 0/1 result. Before
3110fc79606fb, it was even more obvious that this property was used. So
I agree that it is worth documenting this feature, both for users of
list_sort, but even more so for future refactorers of it - but you
probably want to change the wording somewhat.

Grepping around shows that this could probably be used in more places,
gaining a cycle or two per cmp callback, e.g. xfs_buf_cmp. But that's of
course outside the scope of this series.

Rasmus
