Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B711F20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWt1VHPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKSXbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:31:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56096 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKSXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:31:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so5085998wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 15:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mP+0iqiXj77eONbT81jP0IEP9HdwZqjxx63AWCIxHNA=;
        b=eWt1VHPn8CeyEJkHh8wfdDoWw5EBwvsVv+ooqf2AO/Zbwx52j4WyMuZ5MnEbfn+4Gi
         KfL/jdy4ujXa0lrrB4mryex1DzfBRrRNcJJzcXW+RNbKutYVCpwkXIY0pylxxMgWm3Ht
         M8VIf2ub0+jN+0s3ZGOz+lYWhR8yH/TtZfTuSaO9asxRMqzuDXYlks/kEkTgE/S/P53S
         m5fYO4xeerkaV2wpfwkPh1m2WbLZs3cvqOti+OCNs09c0s4sHlZt4JrvGQ4JXuXf5oAH
         EiOeSSVac8ZaFvRrrRNj9ba26sS3QxpitGEk2F+ZU+USScUYVseseeZx10PO67zMRmXt
         SLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP+0iqiXj77eONbT81jP0IEP9HdwZqjxx63AWCIxHNA=;
        b=Am+HlLcTdr5tl4BHYMfin1vHWUroKwaxMciaxuGmL7OsY0FDwLGdBNJreBHkp5bR8u
         QN6Dpnat5e1/nemPTMLI0kuFt4yaSzy9/wRdYXKLmaEWGFQkEF7AMikTAHCJID8Mvb4G
         saKpyCYM0dm0gD4+urNxeUoqY+bPWNiS2thLQDbOQ8eLFBTVPAV3VXgyd6jh6pEBP+wG
         Qdnr4udMZgOub6tbCvGI8LyLxcY/QezNFg+z8OyCEnPJO0lkCs55uAOzrDuZuj1T/BQi
         wM0mn8EKc+/+mxCnyqcRuGC0CmSNqtAY6BYk787qs50Rt6qEMKyAtW7Qa6ZLXYI112CC
         +T6Q==
X-Gm-Message-State: APjAAAVyXhFg847arK3sg4aoRioIyOfpaSRW7xHpIOSI4Lm/NDFL8CE5
        cgKhvyhE61cX9uEtsml3bYnYQTJjpWcEqZymaHTqFw==
X-Google-Smtp-Source: APXvYqwRIvQ8PKVNdixUgQnuXSHFcZZKFRs7eXQkjHRIkNkDAd3sCFPQ/jj3utQ2CUNuE+/QqniO8zwM2uAD7sAvFhM=
X-Received: by 2002:a05:600c:295:: with SMTP id 21mr369402wmk.43.1574206263262;
 Tue, 19 Nov 2019 15:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20191119213834.175992-1-brendanhiggins@google.com>
In-Reply-To: <20191119213834.175992-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 19 Nov 2019 15:30:51 -0800
Message-ID: <CABVgOSn6bc=Rq50Y_Av+0gXTjyHuV+UaULNHicz16hp_uRmDsg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] Documentation: kunit: fix typos
 and gramatical errors
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-doc@vger.kernel.org,
        corbet@lwn.net, heidifahim@google.com,
        Patricia Alfonso <trishalfonso@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 1:39 PM 'Brendan Higgins' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> Fix typos and gramatical errors in the Getting Started and Usage guide
> for KUnit.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://patchwork.kernel.org/patch/11156481/
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/dev-tools/kunit/start.rst |  6 +++---
>  Documentation/dev-tools/kunit/usage.rst | 22 +++++++++++-----------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>

Reviewed-by: David Gow <davidgow@google.com>

These changes look good to me.


> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index f4d9a4fa914f8..db146c7d77490 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst

Could you also fix the kunit.py invocation on line 162, which should
have "run" passed as an argument?
See:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/Documentation/dev-tools/kunit/start.rst?h=test#n162

It should read "/tools/testing/kunit/kunit.py run".

Thanks,
-- David
