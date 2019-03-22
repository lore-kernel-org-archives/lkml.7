Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BA7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E120830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="L+kXcMt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfCVHR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:17:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42641 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfCVHR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:17:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so1126556lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I9XL32VaryU35aESoWJmJhriLITRXQ7M1EygfJ/Jbhw=;
        b=L+kXcMt45QFGL7OgTKwtOGuuB89yfK6ZmCzk9jLaw0qFIia2NIX1XthFjKzi7rLbo9
         XMD9pzYBt3UqxaXHcc1AObozUYjFxX6MtWQa25My5rja0WndmTYGPiB/FtvWgghRCEwi
         JKpmxCUiRUJDTj2lQqh/GAU+ISvx9XFsqR1PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I9XL32VaryU35aESoWJmJhriLITRXQ7M1EygfJ/Jbhw=;
        b=Ye58UU2ujydjWY+KBdLICXV3Jqf8WtO9wC7yj8URcnRcqzQGUSeC+IDbvcyBer41tq
         0xxPJQGtoytSvpI0Rn4XcEgDzpDgDcZ54gY9X1JxR0/lqs9p/o5ILghOsmjPEBmK5hiM
         DJKvaOF4+WyeE9UYXjFZ5UC9cHfCHelfMEjT2xtygPIpl4M7siSWtx/t+5EU4bURO2RB
         34MZaNrN4+RWEnDfut5rwdYJQ0rZNxnqZepB//CJWivRo9tPCVIXyTlncATsM+5Osl4C
         L1iYJpQG0++B+y8hApGDeIaWtX6KNopwPW9sXaDqsy6HbSQkcs40JwWNwW+D1ga+H0CI
         54Bg==
X-Gm-Message-State: APjAAAUhsMdnbxcHl/SgaF5l9J8kFgsGkCLr7ZHtcu0ZFNbUS7q+oz5X
        AGPIPJC99apo179xElI9WCfu0ywXw39KP9Xy
X-Google-Smtp-Source: APXvYqzqTnYBdGoMYaggsrvV9bV9eXZ9/gVZVG3+VhE45haMfmF3kAF+lj1ntOhgVRYgo6JlZyAzjw==
X-Received: by 2002:a2e:84cf:: with SMTP id q15mr4214997ljh.48.1553239074326;
        Fri, 22 Mar 2019 00:17:54 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u5sm819533lfu.1.2019.03.22.00.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 00:17:53 -0700 (PDT)
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
 <20190313211335.165605-1-ndesaulniers@google.com>
 <20190320191135.e49e976a8258c8ac0bb428c9@linux-foundation.org>
 <CAKwvOdn84HNEB3u4XO-V_+c=txmDd1061G_7K0zZVS4MfF--Lg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e0b18c66-677c-7418-875d-f3d8c2f01913@rasmusvillemoes.dk>
Date:   Fri, 22 Mar 2019 08:17:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdn84HNEB3u4XO-V_+c=txmDd1061G_7K0zZVS4MfF--Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2019 18.02, Nick Desaulniers wrote:
> On Wed, Mar 20, 2019 at 7:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
> 
> Further, I can drop some of the __GNUC__ < 4 code in
> arch/x86/include/asm/string_32.h. 

Already on its way to Linus:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=88ca66d8540ca26119b1428cddb96b37925bdf01

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=2e905c7abdcd5ff09b9df33d25eb7148c85bed2a


