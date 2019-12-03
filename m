Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E293EC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78D42068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OA58cEfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfLCGQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:16:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40652 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfLCGQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:16:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1304206pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qE/70uhu0jaSAMS8KivJvAncflzBY+imZtLjsRtcA00=;
        b=OA58cEfLSG/ymRbZf1oZr5T5yf7CX4tQh61rxiUlE16G3++1SovYv+eUTEn0/EbvHg
         Ij0EXU9gjp/u8mFrSSw0zKkVX0mn47PspiuSy0IQ6g0ntqf9HUEfr3RGn9iUE4ghJFQg
         1oPZi001msqEKsLwqhes4b57LzVywuFgnNR+Lq8xOKLN7cBXbYfLUraQ9/+uYpQDM+Oq
         sg7gCYMk1YwY7mvf5l+gg/phX36djG2C5MrT4MeEEDny7/hQ6tXAjrdgo0dJJblgPInp
         XLfgdh50k1+pNfwARCdj74xn04YwLHNkdRnxJy+DapDIP2Fvtn3x1qlXRgrchcKhOJ7o
         1Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qE/70uhu0jaSAMS8KivJvAncflzBY+imZtLjsRtcA00=;
        b=TC8JRRAzpKl5bnGlb/Bcd5I4A3HpJChDZ9WVLhJp/XKQbRvbyAXqAz/k+OU7/47g0l
         cPblQu4A3XpCe/aflBTH1zYQAIzn64uFPayiWqI7KdHizVuR7I4tHKM2Zo0qPSP2Yhb2
         8ijpjwUSb5+kV282kH6khGdZkLa/P3sGA6t7XlwzOqy96wHKBqfDaen/JsYNFJmYlfWV
         N02Fk3k6RckYBmxqXfUn9e7zse/H/xS9wrgxnPuSkeg1xk9nIg/OqOsGaTSzW90CrMUZ
         OTtAKFZe6D8oO6Zp/4vmjJbftVI/4+TtXBXUUAThLF2vjNCiMoEoiHtBVqKgJ5iQD/zv
         rohg==
X-Gm-Message-State: APjAAAWfWTiYIJLdWKsxQI5Wd7bpOAFkg8/z7R0eaU0QfwHmuMcI0rS0
        1wLPeY4w2luukGF+fQKyyeLGIy7Lxsxy4l4dkWr9/g==
X-Google-Smtp-Source: APXvYqxIATMvEvC4LUmHaq0s9rzJuaHa84MyxysOr3z/cffTlAZjA1TXl44Q6sACqTVONzLZzMyh6y9VLKvOrRG52QQ=
X-Received: by 2002:a62:7b46:: with SMTP id w67mr3087699pfc.113.1575353788248;
 Mon, 02 Dec 2019 22:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20191202235329.241986-1-heidifahim@google.com>
In-Reply-To: <20191202235329.241986-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 22:16:17 -0800
Message-ID: <CAFd5g47a7a8q7by+1ALBtepeegLvfkgwvC3nFd8n8V=hqkV+cg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: testing kunit: Bug fix in test_run_timeout function
To:     Heidi Fahim <heidifahim@google.com>, shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 3:53 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Assert in test_run_timeout was not updated with the build_dir argument
> and caused the following error:
> AssertionError: Expected call: run_kernel(timeout=3453)
> Actual call: run_kernel(build_dir=None, timeout=3453)
>
> Needed to update kunit_tool_test to reflect this fix
> https://lkml.org/lkml/2019/9/6/351
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>
> Reviewed-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Heidi, thanks for taking care of this!

Shuah, can we make sure to get this in as a v5.5 fix?
