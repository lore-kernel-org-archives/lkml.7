Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B0C4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 23:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F38206CD
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 23:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fqe9X1ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfIHXkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 19:40:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37045 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbfIHXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:40:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id b10so5739970plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LohfG3rkkHl8bureWEJkUvhdbDGFWW8YgBUzOLjQodY=;
        b=Fqe9X1qllKs5enf5FC3P4j5w8zG3QiuUGfXHor2b6R811HjACIddysCpE5pQtTJsbu
         SoiWUs2RboFfg1mm0G8XfeWXwKybjnISHzhYZmH26MOBUbc/2FZeIZosjLwXl8uj8wZT
         kix6cH9yj/f87Et7cEIUZIRUB/Q+fxiq+IIl48S0t7ez7FdF9RzbXX5aSovS2mUEoC57
         hMUkz8DtSM5HPz4TZbuf+ohR/zzwKt/oqvUGDeyAov+PXg/eJLe20jY/eoyLwLrMEG9q
         +m2a42Z8XgGDrzxFTom6qWYM1rCw6tm7jRTZ6duum4yp5jRj0CdR0FrUO18fE/8ZHxXn
         +90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LohfG3rkkHl8bureWEJkUvhdbDGFWW8YgBUzOLjQodY=;
        b=Clc9LzYbKON//GnGnzjGNc8u0MRxnZ9JyP+wYPs5RQXT4sTuS5hYbhKhsghvxMIRTq
         1yD3VbDA4LYRVWPFQ0YdIiq/gVosm6KEED16llFX0pzNO8QUZZxs3o0i8QtjUClEXlSR
         H0OkVxqJzttYyFjviLruqCaSVM+Byivm9r5LmxgHI2MtDCeRxGtUQWvUuWtpgpWdl69o
         uEyK9g0KDpA5Rbv+/KaxbWj3R1iNPbp0ZA1387PU6Uc+SnGWNJ4QXOpGob0JHFk00CUQ
         mlEXwCGBaTh3+NuasL7oh5OwaQm82mGdO+rZGQYh43K1D5A46QH64tFKtuvPFe+JJHSu
         0wBA==
X-Gm-Message-State: APjAAAWslwqSvlw45P6wD8nZEEvT9TrREpFszenvEwQu6DrdLEohWkVt
        Du7OQuBvHw+O2iAnahf1tJ1zsWU2Y2XAJ7oa+n5sXw==
X-Google-Smtp-Source: APXvYqyrH785kn4aLZQoAcdk/b4CYqJIOXgDPzV+kfYglrL5OB9k2ceCWlG1luir/5qE+eNXHMdRoV6KPjOZAP4ArkY=
X-Received: by 2002:a17:902:169:: with SMTP id 96mr20334010plb.297.1567986021747;
 Sun, 08 Sep 2019 16:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <1567890091-9712-1-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1567890091-9712-1-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sun, 8 Sep 2019 16:40:10 -0700
Message-ID: <CAFd5g46MNYcY-o8Z-1tSi0Kva02CjhcWC-xwkeNc6kfiDzLpLQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Fix verification command
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 2:01 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> kunit wrapper script ('kunit.py') receives a sub-command (only 'run' for
> now) as its argument.  If no sub-command is given, it prints help
> message and just quit.  However, an example command in the kunit
> documentation for a verification of kunit is missing the sub-command.
> This commit fixes the example.
>
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  Documentation/dev-tools/kunit/start.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 6dc229e..aeeddfa 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -43,7 +43,7 @@ wrapper from your kernel repo:
>
>  .. code-block:: bash
>
> -       ./tools/testing/kunit/kunit.py
> +       ./tools/testing/kunit/kunit.py run

Ooops, that's embarrassing; I have the right command a couple lines above.

In anycase, thanks for finding and fixing this!

>  .. note::
>     You may want to run ``make mrproper`` first.
> --
> 2.7.4
>
