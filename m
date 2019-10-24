Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4616FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E98321928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sm0LVra1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfJXVqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:46:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46460 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfJXVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:46:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id b25so98058pfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylg2MBhMeUrtylr2iEwM0Lf6LZuEbMgXeAE0LFqAQ+Q=;
        b=sm0LVra1tGSu8lDc8RjcBwS4jsMsIQRLEy+UOc8Bg3ZjhPKVe9Pa7silK2byU4PHpX
         KV6mANQF5auk1EgP0DEb536+AdYmDRucmgc5cVhYxgGLCWMXA7rd0nhuzi++nvRNMQ5r
         knog15gmYqhWZ5lQ6WtsnpM/iR+6T5aMA0uE/AtRzquotRgqnq1bOOzkoS440sY3v8E8
         6DleXQwoDUfNzLXmdN5YVRM/8ISifQOB7sXGq+hYP3QwkwVDwCblA+01Pw1jKJTkI7Ny
         SzxFZNfraNN1fQbTcGiNgBQ65sA7syDlS5anm8XnlyF0lbG2W2S1BlPpMgzoStdTgrhN
         ONtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylg2MBhMeUrtylr2iEwM0Lf6LZuEbMgXeAE0LFqAQ+Q=;
        b=bwTu6ocGXB3OxfQYBs6vIIkNfkVQemvMcK5ApVa66XiAqx9fi1pD7GMoQXnoIG46tq
         xu+6xohrV4iFKEHjDkX+j1/Rp+w/VSx+yIAAZD+HS7sX2U/w2Lp7KARUi2vJH/F/FOHf
         C7r4bsznjMfO2xjiItcWht8LKAWlMxOFvRRS4jYmllue9VUBxD8YxUCyXaPLihXimCGW
         1jsB10UXgpKTRdivBgCqLy6XBS23Ox7rh4D6D2B7iAy9jUkVIdP3M5P54didJ2eYVGHf
         +EDnKomTwfB5T6qnaHj+/FVbEzt7GmPyiT44MRHXtpbcvH4vQhwYnVVwnJTmHYCxGFh6
         1BMg==
X-Gm-Message-State: APjAAAUZVq6G5qzlWBOLMQJ0aFsgXLcLm5SrjqWB+PtGOG9dpObeS2ec
        ftNqisEGw+6XtsTPCMY1tjfukJzuYohEbnZWvsOZ+g==
X-Google-Smtp-Source: APXvYqwm1PMIf+mWSjmzR6zcrl6IRhfA7LoN6krcH8c8m4x2dfkIHyl7OijiD3mbk1iUnqEWOrmv1xaVDzusce8/oJQ=
X-Received: by 2002:a17:90a:17e1:: with SMTP id q88mr9863054pja.134.1571953581844;
 Thu, 24 Oct 2019 14:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191024202803.47613-1-natechancellor@gmail.com>
In-Reply-To: <20191024202803.47613-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 24 Oct 2019 14:46:10 -0700
Message-ID: <CAKwvOdmw+fSNfksLtiAKF8upAuQB+rOzWP010cC-ivF5z=XuYA@mail.gmail.com>
Subject: Re: [PATCH] dm raid: Remove unnecessary negation of a shift in raid10_format_to_md_layout
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 1:28 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with Clang + -Wtautological-constant-compare:
>
>  drivers/md/dm-raid.c:619:8: warning: converting the result of '<<' to a
>  boolean always evaluates to true [-Wtautological-constant-compare]
>                  r = !RAID10_OFFSET;
>                       ^
>  drivers/md/dm-raid.c:517:28: note: expanded from macro 'RAID10_OFFSET'
>  #define RAID10_OFFSET                   (1 << 16) /* stripes with data
>  copies area adjacent on devices */
>                                            ^
>  1 warning generated.
>
> Negating a non-zero number will always make it zero, which is the
> default value of r in this function so this statement is unnecessary;

Yep, thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
(algorithm should be an enum, and there's some code duplication
between ALGORITHM_RAID10_OFFSET and ALGORITHM_RAID10_FAR cases, but
this patch is good enough).

> remove it so that clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/753
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/md/dm-raid.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index b0aa595e4375..13fabc6779e5 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -616,7 +616,6 @@ static int raid10_format_to_md_layout(struct raid_set *rs,
>
>         } else if (algorithm == ALGORITHM_RAID10_FAR) {
>                 f = copies;
> -               r = !RAID10_OFFSET;
>                 if (!test_bit(__CTR_FLAG_RAID10_USE_NEAR_SETS, &rs->ctr_flags))
>                         r |= RAID10_USE_FAR_SETS;
>


-- 
Thanks,
~Nick Desaulniers
