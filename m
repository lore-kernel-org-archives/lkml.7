Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A4AC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC03216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vP57rgZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfGHP4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:56:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55608 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733062AbfGHP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:56:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so18677wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7GFFUAxkwmd9bZW5ALeCVgIwc3/UM2OlBr8OH2HiFo=;
        b=vP57rgZvG1ta2wCxkTIBQnUFffTIerXQNC4aDKpFGhSu63chgpd4Xsme91y7VyfxFe
         fI8mnKFRZZAWuZbVN4ghaicILvv72fJ+R5rtcPg25zc9xbptMKFXreA7uhJ1m6Oi6deb
         XWqejMLtLB/d51TskK0+yiHOhda1NF410nhJ+8HJ6SJuzpQ5PLyr+WhGwW5k8vrtImry
         kQX6B6yUYBozQh/l6+IybWELaOmcGOfFhDayyLrPssfkKqToQhVgkv9E9NYu31uSpP45
         FnCDD2+v7PJMbq3oJEX2opxDK1vvEUg9K/qw8WWChA+gp9/PZ7HAzixdtPjEXz05yv+L
         I2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7GFFUAxkwmd9bZW5ALeCVgIwc3/UM2OlBr8OH2HiFo=;
        b=XmYP5WGUawlh9OYv61Ed0HCeBWaZ1Umw+WSNOlNHBra1oUipK94CZZach0Q/Hp4T+P
         3OwzX3O8KtyFEeKQI5h45RPOAw9CgzoD2Yp4QcFxuttd9kHlWhOi94u+EmoseoYE7VZK
         JtRthgEpcfL5U86s5Oj3EqGZrZG69u37mU9NplUfrPRuZruTu2TRBqLlti6YCpV8yoMo
         vUO7znyIAH8inFN4ZdYv1XZccYmHxPlBoTJg0htBzHofbew8B+VdBR4pDFv+dF9lHw8c
         QjUnuG1mIvusTyaWUKLcQ0Sdx7nzK5w5/lbj4hQgylxKCaVqyLdzrDlO/3IWyhTCTLyx
         /tFg==
X-Gm-Message-State: APjAAAXIm9C1JTEugcf6HJZMINZkzkCxaT1gCvUsyaorrylaSiFoYMSA
        pBp56mLexMGUs57Jis9X0qLdKgp1za2vtHHF/bk=
X-Google-Smtp-Source: APXvYqwvdG9n4dfYmbjZx6tcKpI5aNX/GwQXmiYbc9MMXPeVWi4xE5HFNth6IXVYz3I5PXLtA+BXJt1qVYH4jveeJp8=
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr18280832wme.67.1562601361884;
 Mon, 08 Jul 2019 08:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190704055217.45860-1-natechancellor@gmail.com>
In-Reply-To: <20190704055217.45860-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Jul 2019 11:55:50 -0400
Message-ID: <CADnq5_MGzLLMNPSQXpdxwrBpvsp7Fd1KdExS-K4yNeDBQYEGMg@mail.gmail.com>
Subject: Re: [PATCH 0/7] amdgpu clang warning fixes on next-20190703
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux@googlegroups.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  thanks!

Alex

On Thu, Jul 4, 2019 at 3:26 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> I don't do threaded patches very often so if I have messed something up,
> please forgive me :)
>
> This series fixes all of the clang warnings that I saw added in
> next-20190703. The full list is visible in the gist linked below and
> each full individual warning can be seen in the GitHub link in each
> patch.
>
> https://gist.github.com/5411af08b96c99b14e60c60800e99a47
>
> All of the warnings are fixed in what I believe is the optimal way but
> the enum conversion warnings were the trickiest; please review carefully
> as the code paths for some of them have changed (especially in patch 3
> and 6).
>
> Thank you!
> Nathan
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
