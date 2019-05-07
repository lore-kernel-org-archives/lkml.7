Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9A5C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA96205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyq9xD0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfEGVEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:04:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38966 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfEGVEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:04:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so9283820pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y2Y0CjWjtHP/Qy4+OparVDP87z9HGL2o3QgDn+d+krE=;
        b=kyq9xD0zvBmkC+9lbypm8x/BwDOZ+6JcizSxqy1gsQLtuXQq5Ph2euW/eL17RVJAS3
         ZOzTwAdPwQT7Y2mhlg9dTWMNMk+JG0zj2p7d97HiB32k7zpeMwCw3OIS09ITMB+lw9Bx
         RQKLIl0fbw+QjQLHbNI1219eTrgRhi3SwHmchiT1rP0Ut22kN7FxkyZoGeF7Y1lhFJh8
         Ezzigsip7I9iMp9cpkUAhNIa2kVtkLWVJMRfBRXNpoqdbmg0LCKR+DxyQpIAWEO1Ic24
         LNzFbckTeSOZBGGD0hv64u9pbOaYXYGtSTOehYDDRlUmVgcjpa8d+MXEyhiDmrHS8mKQ
         CkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y2Y0CjWjtHP/Qy4+OparVDP87z9HGL2o3QgDn+d+krE=;
        b=WLmn+giw0NbX2TpEIs7eH5dXSlndUPNkL4uY02dOfU/dprMQWyBjB6o1lJQelhqPwQ
         v5dzgnzVsvmvvtzC+2CoGeITe00/IfnTVU0J4NN2hLZNJOUeKHePW24mu6tmEcay6aLF
         APdulvPx0e8U7gwWmjQXrfLfRGVlZPYEnsVSZvEquuct+9HUysANNOAhdinS1d/LLzUq
         vdK2aWNhRIa+IgPdTHTpLPITo0x5H+MpWQ8aMi7x+4rb10T7GhOFk7K1cL2N2Bsn9g4B
         pVulPAOLi/7zEKOWVvWYJ2SDvNXg3jgE1BD6HZBM7aysrZq5xcdjIdYWbcg7AA/43fhd
         4jPg==
X-Gm-Message-State: APjAAAWkC2NwMMKo4it1HEe49PEwWl/4feqKH1vou9hdssbQ4lF5v88g
        jRzCll+d8U2o9HQLAwUEpkY=
X-Google-Smtp-Source: APXvYqzNSt+11j7miw3L1LKW2tCngdliT8Xm7f99QxM0C1+ZpwViDvlZFAVemZW3WfNN4Wh3cT50Mg==
X-Received: by 2002:a65:5886:: with SMTP id d6mr42277500pgu.295.1557263063352;
        Tue, 07 May 2019 14:04:23 -0700 (PDT)
Received: from localhost ([2601:640:2:82fb:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id 17sm27387961pfw.65.2019.05.07.14.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 14:04:22 -0700 (PDT)
Date:   Tue, 7 May 2019 14:04:21 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@marvell.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 0/7] lib: rework bitmap_parse
Message-ID: <20190507210421.GA8935@yury-thinkpad>
References: <20190501010636.30595-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501010636.30595-1-ynorov@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:06:29PM -0700, Yury Norov wrote:
> On top of next-20190418.
> 
> Similarly to recently revisited bitmap_parselist() [1],
> bitmap_parse() is ineffective and overcomplicated.  This
> series reworks it, aligns its interface with bitmap_parselist()
> and makes usage simpler.
> 
> The series also adds a test for the function and fixes usage of it
> in cpumask_parse() according to new design - drops the calculating
> of length of an input string.
> 
> The following users would also consider to drop the length argument,
> if possible:
> drivers/block/drbd/drbd_main.c:2608
> kernel/padata.c:924
> net/core/net-sysfs.c:726
> net/core/net-sysfs.c:1309
> net/core/net-sysfs.c:1391
> 
> bitmap_parse() takes the array of numbers to be put into the map in
> the BE order which is reversed to the natural LE order for bitmaps.
> For example, to construct bitmap containing a bit on the position 42,
> we have to put a line '400,0'. Current implementation reads chunk
> one by one from the beginning ('400' before '0') and makes bitmap
> shift after each successful parse. It makes the complexity of the
> whole process as O(n^2). We can do it in reverse direction ('0'
> before '400') and avoid shifting, but it requires reverse parsing
> helpers.
> 
> Tested on arm64 and BE mips.

Any comments?

> v1: https://lkml.org/lkml/2019/4/27/597
> v2:
>  - strnchrnul() signature and description changed, ifdeffery and
>    exporting removed;
>  - test split for better demonstration of before/after changes;
>  - minor naming and formatting issues fixed.
> 
> [1] https://lkml.org/lkml/2019/4/16/66
> 
> Yury Norov (7):
>   lib/string: add strnchrnul()
>   bitops: more BITS_TO_* macros
>   lib: add test for bitmap_parse()
>   lib: make bitmap_parse_user a wrapper on bitmap_parse
>   lib: rework bitmap_parse()
>   lib: new testcases for bitmap_parse{_user}
>   cpumask: don't calculate length of the input string
> 
>  include/linux/bitmap.h       |   8 +-
>  include/linux/bitops.h       |   5 +-
>  include/linux/cpumask.h      |   4 +-
>  include/linux/string.h       |   1 +
>  lib/bitmap.c                 | 197 +++++++++++++++++------------------
>  lib/string.c                 |  17 +++
>  lib/test_bitmap.c            | 102 +++++++++++++++++-
>  tools/include/linux/bitops.h |   9 +-
>  8 files changed, 226 insertions(+), 117 deletions(-)
> 
> -- 
> 2.17.1
