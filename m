Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88024C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5903B2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNowU+cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfCUQm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:42:28 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40760 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfCUQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:42:27 -0400
Received: by mail-vs1-f68.google.com with SMTP id z18so4054767vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TM4aBC6zm9hKq55xCoBiZg3RLkL8SEK/JZNqFbW40w4=;
        b=lNowU+clev/eTc9h4XzfcitVwN1lBZJf4AZJejcxn/VZovPC2pSTpO7UOd+0KIbmwm
         0UH0RUsTlTe++Lgd3QoQbKszmmPC8Q3uaMq1cnkib8V2zm1y7VF17Y+R7W7ExCWK98Nx
         to4kwMgb+Z83ULTaT2HC+yID6DQvQFY0NsXIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TM4aBC6zm9hKq55xCoBiZg3RLkL8SEK/JZNqFbW40w4=;
        b=GyMwbbo2cfySfxUz4PEQDwpfyfIQ2k4FS3jKvprsMASgYuU/l8kHstApSDqZwwXOZd
         pObcmttcpz4wH4jxIJRynB2vZuQ/mPVJHm6cDFXfwvrddIKYRzHC7RuWCXX5Q6AcRn4r
         GwU9KfkjMk3zOhaaR7NnqhdtB+TboJHCU5KiFMLFICIZR4xqtzR/VIi0NpOTYiAALC6e
         PWRGMVenQXgKxOzY7zQ9Hg7LIkwYumTMeOKEM+gWdFuADv9eM5MMvrD5jYgEC3PfXEDJ
         tVVN8X7V5BGeht+onU3W7g7ETjPPY5WP2OsS6jF/wZoH4/aeOXCfrkdXBARXbM/jzFif
         CQbA==
X-Gm-Message-State: APjAAAWYDA/F0h+oon80wWFkcEoeo62VONxk8JPZBbRP57FR2smhnAZa
        RnagT7NqJrv/tuKvdLqV9zREyH/WAcKfjA==
X-Google-Smtp-Source: APXvYqxqPUFzaKfCSW2QbPLFckPtNtLHwE0sov12Jp6Kq0o9AdiOXyLxIAMLyLhCQzdP6D2+RH4Sjg==
X-Received: by 2002:a67:c79a:: with SMTP id t26mr2691265vsk.72.1553186546113;
        Thu, 21 Mar 2019 09:42:26 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id o197sm4671999vkf.27.2019.03.21.09.42.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 09:42:25 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id h132so4050321vsd.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:42:24 -0700 (PDT)
X-Received: by 2002:a67:89c9:: with SMTP id l192mr2604280vsd.188.1553186544604;
 Thu, 21 Mar 2019 09:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222831.8243-1-mcgrof@kernel.org>
In-Reply-To: <20190320222831.8243-1-mcgrof@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Mar 2019 09:42:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK1oaEXYEKM45Ai3bPELTEF=aO0-OSSnpcnOdWtQf2+cw@mail.gmail.com>
Message-ID: <CAGXu5jK1oaEXYEKM45Ai3bPELTEF=aO0-OSSnpcnOdWtQf2+cw@mail.gmail.com>
Subject: Re: [PATCH 0/6] sysctl: add pending proc_do_large_bitmap fix
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Sandeen <sandeen@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 3:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Andrew, Kees,
>
> Eric sent a fix out for proc_do_large_bitmap() last month for when
> using a large input buffer. After patch review a test case for the issue
> was built and submitted. I noticed there were a few issues with the
> tests, but instead of just asking Eric to address them I've taken
> care of them and ammended the commit where necessary. There's a
> few issues he reported which I also address and fix in this series.
>
> Since we *do* expect users of these scripts to also use them on older
> kernels, I've also addressed not breaking calling the script for them,
> and gives us an easy way to easily extend our tests cases for future
> kernels as well.
>
> Before anyone considers these for stable as minor fixes, I'd recommend
> we also address the discrepancy on the read side of things: modify the
> test script to use diff against the target file instead of using the
> temp file.
>
> Eric Sandeen (2):
>   test_sysctl: add proc_do_large_bitmap() test case
>   sysctl: Fix proc_do_large_bitmap for large input buffers
>
> Luis Chamberlain (4):
>   test_sysctl: remove superfluous test_reqs()
>   test_sysctl: load module before testing for it
>   test_sysctl: ignore diff output on verify_diff_w()
>   test_sysctl: allow graceful use on older kernels

Thanks for collecting and updating these!

Acked-by: Kees Cook <keescook@chromium.org>

Andrew, can you carry these?

-Kees

>
>  kernel/sysctl.c                          |  30 ++++-
>  lib/test_sysctl.c                        |  18 ++-
>  tools/testing/selftests/sysctl/sysctl.sh | 161 +++++++++++++++++++----
>  3 files changed, 178 insertions(+), 31 deletions(-)
>
> --
> 2.18.0
>


-- 
Kees Cook
