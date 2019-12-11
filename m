Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5DC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4FC2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIH6QeIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfLKQdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:33:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43070 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfLKQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:33:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id h14so2047325pfe.10;
        Wed, 11 Dec 2019 08:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=6VbwndfOevA49gSWBsSDaKuPkqBrYArPZVbqePw3B68=;
        b=aIH6QeIYTHSIgaMkJborqPovnMlGEqzrJWSf1UeqOzyuQC9S77kDThEbnP5mH5X2ck
         WsRui1evCCxGnEXZJ5UWJclgH5plLgv3wDHJhQdmooFJ2vTa6L/ESDynkstSMe7qf4St
         +PYCrVA/ADHK3g6H+OzGSQXbg3sKju50KqYG9lhK0m52v68xk5zHHl+RGoibRkLS0qM8
         dMBb5zGn5WNPpJMFkmnG4kdD6APDipcOD+8L2jmDQ8nGw4m3FDaBg5ZAzjEc6OVm2hT5
         SJJFrxbP55gIwU8FDof2anBMuCGWcYurGj06KiZRAfarLWlaMNKHJxrU79obRraYi2md
         6h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=6VbwndfOevA49gSWBsSDaKuPkqBrYArPZVbqePw3B68=;
        b=DO3/scIvf0DoKSbkOufQs+kvr4I31TB7FwTspOGADJSUmaJ4MLAr4YTS3N8XFEBAwS
         BAG2J/TM9DnI33F0TXjlR2MHNSqBnbz7ni1+ZahT3s4H38QXOn5MIloxtTIGsfH8Chbk
         l0wGAr16QvSctnZWyrmXNvm622AzS8O3i8ojfVNjrk3PtmLYgHVDhNhEYUiCi8knbKfs
         lbY9oL5LRHpweW3PjcuhjxQfJE1cY7OYi+FjA4PmjpvtxQJGxfHMvP1qE2uTbEvPGavO
         CcuC1YV9tNF8PxvD8c/eWPIQa1bH+pexd6iCw4uHGm/waYA4Jy3Lk1wz74rol3x6oXr2
         NiHA==
X-Gm-Message-State: APjAAAUzvo+ndlrn8lmId7C470sIFgwb/rAhjQ8ZMCqeHHdzFuOY7HMt
        ZVAiEJV5cgyXahgJ0yDQqXIGltd7EM4=
X-Google-Smtp-Source: APXvYqxLdek+AiPE1K4jghswhynkPPvMhqWs9KQuLbPMiWNEvGflTnT4VIAKIYT16auKLCmejjnOag==
X-Received: by 2002:aa7:9145:: with SMTP id 5mr4734155pfi.74.1576082002776;
        Wed, 11 Dec 2019 08:33:22 -0800 (PST)
Received: from carbonx.ucdavis.edu (campus-094-212.ucdavis.edu. [168.150.94.212])
        by smtp.gmail.com with ESMTPSA id i3sm3815106pfg.94.2019.12.11.08.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 08:33:21 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     sj38.park@gmail.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, sjpark@amazon.de
Subject: Re: [PATCH v5 0/6] Fix nits in the kunit
Date:   Wed, 11 Dec 2019 17:33:10 +0100
Message-Id: <20191211163310.4788-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191205093440.21824-1-sjpark@amazon.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I ask some comments?


Thanks,
SeongJae Park

On Thu, 5 Dec 2019 10:34:34 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> 
> This patchset contains trivial fixes for the kunit documentations and
> the wrapper python scripts.
> 
> This patchset is based on 'kselftest/test' branch of linux-kselftest[1]
> and depends on Heidi's patch[2].  A complete tree is available at my repo:
> https://github.com/sjp38/linux/tree/kunit_fix/20191205_v5
> 
> Changes from v4
> (https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
>  - Rebased on Heidi Fahim's patch[2]
>  - Fix failing kunit_tool_test test
>  - Add 'build_dir' option test in 'kunit_tool_test.py'
> 
> Changes from v3
> (https://lore.kernel.org/linux-kselftest/20191204192141.GA247851@google.com):
>  - Fix the 4th patch, "kunit: Place 'test.log' under the 'build_dir'" to
>    set default value of 'build_dir' as '' instead of NULL so that kunit
>    can run even though '--build_dir' option is not given.
> 
> Changes from v2
> (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com):
>  - Make 'build_dir' if not exists (missed from v3 by mistake)
> 
> Changes from v1
> (https://lore.kernel.org/linux-doc/1575242724-4937-1-git-send-email-sj38.park@gmail.com):
>  - Remove "docs/kunit/start: Skip wrapper run command" (A similar
>    approach is ongoing)
>  - Make 'build_dir' if not exists
> 
> SeongJae Park (6):
>   docs/kunit/start: Use in-tree 'kunit_defconfig'
>   kunit: Remove duplicated defconfig creation
>   kunit: Create default config in '--build_dir'
>   kunit: Place 'test.log' under the 'build_dir'
>   kunit: Rename 'kunitconfig' to '.kunitconfig'
>   kunit/kunit_tool_test: Test '--build_dir' option run
> 
>  Documentation/dev-tools/kunit/start.rst | 13 +++++--------
>  tools/testing/kunit/kunit.py            | 18 +++++++++++-------
>  tools/testing/kunit/kunit_kernel.py     | 10 +++++-----
>  tools/testing/kunit/kunit_tool_test.py  | 10 +++++++++-
>  4 files changed, 30 insertions(+), 21 deletions(-)
> 
> -- 
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> [2] "kunit: testing kunit: Bug fix in test_run_timeout function",
> https://lore.kernel.org/linux-kselftest/CAFd5g47a7a8q7by+1ALBtepeegLvfkgwvC3nFd8n8V=hqkV+cg@mail.gmail.com/T/#t)
> 
> 2.17.1
> 
