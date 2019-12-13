Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C69C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FBC2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4QfLAbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbfLMBME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:12:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45828 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731578AbfLMBME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:12:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so502282pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 17:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OB/PpPf9DqYQf2Qw7tk2Kuy8kuD5wsJrhVi2dlqE7Sw=;
        b=B4QfLAbqAM/M4tT0D/uQ37jaQjF2YFpQR7QbFzgjVP1wMSrjvfxL+DT4sxickn293d
         pgaKxNvMbGrS9X2aVHL/W5rBxjeH7JPg/UAi0zUeUxSP7KPImmBYq+8Nf63RSlrZ8fN5
         ZqQvtgOVa1bBRAwhr1TSh/3FU85gmuZGU0tARN+s/bKlXCC8Mydbng0a1YJkd0wNy/ov
         9pcd6dLzTP7GXjagVVNyQla5nwJ74U9mOR8ii4Gi4R7LWQdGTIDjztuwrZ9w0PlU6W5I
         vOHEvyHmACYgub1FJK3zGtzCKug61Zwwnwz4iSUCsdeEsJlJLPQy2muUnw3Cg3PnMySd
         kBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OB/PpPf9DqYQf2Qw7tk2Kuy8kuD5wsJrhVi2dlqE7Sw=;
        b=T87uCWVAdnQk9b4UCd0PeeVrjAdQw0gqfWNB0LichaBSlOGwhYLs7cs5MkWDjIr/vi
         Kt7lRTKhyqIVjLaTubxcwjUAmsN34b6NVwdszlw6rf1gL/h0szewsLvmd1OMimrlaDHi
         WCZEPoIa2wMPdeZQhXT266ZwiHgrwzki6GPetQTEHeUuSrHHdQDTR9WsgLR/z6wYdtX5
         ipGU1UcIVgBRe4w5jtxPOOaLaS0qbSSe67YCsH2elnFn2IXAlT9jHfyPT3sWmSTUI9u9
         FVYWs+XMtC+cYrk5rwJNHsKdVmgyECyWk6cfzhFeFudfs0h51ZWkLXCz1RoGKBpvptOp
         UF9w==
X-Gm-Message-State: APjAAAW6d8S3SedMtRP8FOYRaehVgLzkgsCh6ylaP2kYlnNkbjCHN3+3
        9pjKDPkT7FmXSVtWcw4r9X7rdG5j7L2UT0ti3UQd8g==
X-Google-Smtp-Source: APXvYqxWvzd3ydWQnsw8GTi9x1x/1qLazZpUOpXIcE70GeNhhVCT1RDLbbb0t/qplulkQg7PwzhEf/OQh6tEoY3p+k8=
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr14061181pgi.159.1576199523237;
 Thu, 12 Dec 2019 17:12:03 -0800 (PST)
MIME-Version: 1.0
References: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 Dec 2019 17:11:52 -0800
Message-ID: <CAFd5g47KswC47H=0sDr+EFQUGJ3DSMSU2X=1dZc-5D_tZ3ZbOA@mail.gmail.com>
Subject: Re: [PATCH v6 linux-kselftest-test 0/6] kunit: support building
 core/tests as modules
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 7:27 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> The current kunit execution model is to provide base kunit functionality
> and tests built-in to the kernel.  The aim of this series is to allow
> building kunit itself and tests as modules.  This in turn allows a
> simple form of selective execution; load the module you wish to test.
> In doing so, kunit itself (if also built as a module) will be loaded as
> an implicit dependency.
>
> Because this requires a core API modification - if a module delivers
> multiple suites, they must be declared with the kunit_test_suites()
> macro - we're proposing this patch set as a candidate to be applied to the
> test tree before too many kunit consumers appear.  We attempt to deal
> with existing consumers in patch 3.

Hey Alan,

I just wanted to make sure you're not in the dark and wondering what
happened in regards to this patchset. To my knowledge, I believe you
have all necessary acks/reviewed-bys. As far as I am concerned,
everything looks good here and is ready to go. The only remaining bit
is Shuah picking it up, and sending it out in a pull request. Based on
the nature of this series, it will have to wait until 5.6; however, I
think we can accept it into kselftest/test (we are planning on
renaming it to kunit-next or something like that) as soon as we cut
that, which should be pretty soon.

Feel free to poke us if you have any questions!

Thanks again for all your hard work on this! I think this is going to
be a valuable addition to KUnit.

Cheers
