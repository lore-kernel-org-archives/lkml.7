Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2962054F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOm8wz2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLDARq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 19:17:46 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40203 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLDARp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:17:45 -0500
Received: by mail-qv1-f66.google.com with SMTP id i3so2377348qvv.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 16:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTyx2RZy7Y05cTkQC5l7sD6FLwz4Qd0lQ0nPf0EZIKQ=;
        b=hOm8wz2JV5irNU26ecry779uLa4TiPhyZ1ZbH5BMAy/dmu7zOGoJWBAfrrXnkZ4bAI
         i3S1GGj7B/bD+yuiGyVGBFPy0Scho66AEJzGF0Uz9gjhbCR20aK8/aD754sz5fHdycGk
         ElbXXiBdPnpI5fmy7qTAqyOnxSjMyNU8gh6CG/lsf7crB4HjGgbZ4aTmvdRq56HBEao6
         WiFWriZ/V4caGH9ZsSaK2SudOmSHCEnweMh/Rr4ecE0DCuWpEBcp59cbvpDBglqRURAu
         55Rp+JxFnBZW3Y6c9elMR3Ps13iJiRCX7Pcp+gToSKg/XaWp2AXLH4rYaqVePA8HVcGI
         Is1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTyx2RZy7Y05cTkQC5l7sD6FLwz4Qd0lQ0nPf0EZIKQ=;
        b=YlX/XjLUCnwEFWMLDRiDvJnQQsd7SsbDd78/92pxZuNiv5czY0QTvY5oW//bwF5M2r
         T6JYgRJI3/y62+HzpQZ+BviE+2a1t/XABgscMEpGD2Rz7WnfqCWTGLGx9rE3XdKx0i2/
         sz9rSkdUtI1GEIkNbhLrqAUT3gqa94dwUN0lt+lXhj6t3/3uG6fIEx/X4p5bonOOwQSt
         vocL29oDELlMTTp6bTDDLkWUqhRsOThIPYnVDbrwKrDvq1XAMCbbCyzRgWrDouu4/vQA
         G9DMXQ32b6nqzNvUThV8jzYf1mAMaAwK2wCKGTUU5J89IjsphwxoyLO5o2ekWMj91nFZ
         Bc0Q==
X-Gm-Message-State: APjAAAVqU2vXAFFklV0RNS+v042hVsZdfszYW5UKrn9DonST+GtbXoM5
        Y8n+TSPr31wP/hoGpRWTXzRLZluEh8AL9kcwWDpQ
X-Google-Smtp-Source: APXvYqyz1zLOAzlEW9SR6UXDydhWZrLGVzqeOyJQaU/XEZFykJigtOH++7UD8tHeCTXXoGftLWGr/Iw5KbggfuWAdmA=
X-Received: by 2002:a0c:8061:: with SMTP id 88mr411290qva.62.1575418664089;
 Tue, 03 Dec 2019 16:17:44 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Tue, 3 Dec 2019 16:17:07 -0800
Message-ID: <CAAXuY3rYZHac4o1bqqnbR_1g12dtqmJHVp8Taky00J4-+2hwZA@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        David Gow <davidgow@google.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +ifeq ($(CONFIG_EXT4_KUNIT_TESTS),y)
>  ext4-$(CONFIG_EXT4_KUNIT_TESTS)                += inode-test.o
> +else
> +obj-$(CONFIG_EXT4_KUNIT_TESTS)         += ext4-inode-test.o
> +ext4-inode-test-objs                   += inode-test.o
> +endif
Why not rename it unconditionally?
