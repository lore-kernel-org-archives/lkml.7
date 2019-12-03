Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C3D2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxTExWP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfLCXLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:11:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42485 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfLCWli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so2260257plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 14:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvcQSeD9fUy4K6hmpGadBFCY8hD8Kt15D7Xjws7LrzY=;
        b=WxTExWP/19lbIo0fY+5OW62d08F7PomNap1+0TY5sUtrtzPOGpdsJbNrv4BmOK+wo3
         3KpKKvycvKGQnbwQUD2Al8L7apeOOVmQ5/fDbHdSyIJ0SrUYLivf7IxloVayeomLb9D6
         i1CeS+8S8UPrr6e7YawLim1GC2BsdJnla/UxSDKmk6dcYWW0X4LnN+qSgOem6/q0JH3m
         zeqQ1V0aE3sE3jdkBQHuLBrEXZBzEx8xNJm/0PfIzcR13BAG4CeFZ9QSgIkcL+VUsKYO
         BitSJLid6c3cE7TDqygbrOv2IZvQU1R+Rvt8Vme7VGWaPlZfQFX56g8xRsw51zgMS6jT
         noaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvcQSeD9fUy4K6hmpGadBFCY8hD8Kt15D7Xjws7LrzY=;
        b=U0m+PFDv5x33wkOTPso/O/HCHQZUlprDYyL57AYh/iy5p1aj0PbZCXdLRHXKe+jvu8
         Dmpy+rQCsVmoZDnfoWl7yu4r65a4RFfMFOk+MCq6q2znomcgtkDNWBhedMugtih0P22O
         pVMdXf2Cf+MyM9q+dMbCDGMHFUJY67Nh0uE3YU+Qme61u0zKa2QdS8T8lMnuZzaI5C3A
         XKls8AaO7uOd5yFapWIqTOvIgND5dw0fSmA3IKBxnuVSisrS4ySTkgiiHEthNH17w89H
         ndoGdjSWV4zT3ySADTXW7WQ3O4rriikSNc487aaNHsWHELB1kc2xMTqmlUXn4OURObcA
         veDA==
X-Gm-Message-State: APjAAAXWJT/HRN1kIKXmHKFItu2B6ct+PEaxOmb35dbOl9ez8stvKJsI
        i7zLleVWQi6ULbO56VcYrQYPEcZq8mneNg4zFkfAnw==
X-Google-Smtp-Source: APXvYqwNBKITRg7JLfQdIfZ7Hq2in6sPhBtMwgNhkjM1eOSXrNFrRKWgmizNbNOpj7SVMke2uCVL05noCM3vd+KB1eQ=
X-Received: by 2002:a17:90a:d155:: with SMTP id t21mr7870642pjw.84.1575412897403;
 Tue, 03 Dec 2019 14:41:37 -0800 (PST)
MIME-Version: 1.0
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:41:26 -0800
Message-ID: <CAFd5g46X9WK-xKJFF5AVYXXmM4a2dYD3fy=oi1CGJM1gc9RzuA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 10:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> This patchset contains trivial fixes for the kunit documentations and the
> wrapper python scripts.
>
> Changes from v2 (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com/T/#t):
>  - Make 'build_dir' if not exists (missed from v3 by mistake)
>
> SeongJae Park (5):
>   docs/kunit/start: Use in-tree 'kunit_defconfig'
>   kunit: Remove duplicated defconfig creation
>   kunit: Create default config in '--build_dir'
>   kunit: Place 'test.log' under the 'build_dir'
>   kunit: Rename 'kunitconfig' to '.kunitconfig'
>
>  Documentation/dev-tools/kunit/start.rst | 13 +++++--------
>  tools/testing/kunit/kunit.py            | 16 ++++++++++------
>  tools/testing/kunit/kunit_kernel.py     |  8 ++++----
>  3 files changed, 19 insertions(+), 18 deletions(-)

Tested-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
