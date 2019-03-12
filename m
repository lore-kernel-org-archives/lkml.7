Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5379A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="T1v6BNEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfCLE5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:57:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40775 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCLE5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:57:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id k11so497552oic.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 21:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulVlBNx93AvCw2pPS7B18RQRsMD31269sXjowYwKgTc=;
        b=T1v6BNEhp7xH/eiyXzMJJm0Ez4TKygYl4el+Z22FwGdXaTpEgdKT1BbZXskQOck1x3
         9HrFZZuUHXO7VXtSiaDjSwxny5eN/FH9lGGqkAE7IelGNnqIymkiA+42smkgyXz+R1ou
         aT1nUpdhSOuWv9zDSp0aYe+20zSCKwGVY7CoZZfGIuVJ5e7G3WnDgcKf5ajH4Mp82ZR1
         YS+TBIZANzAQhZ1kpo+8PUZ+OKXq7zUYZdSZofBtcZ0nZ8b/GvCYO6lvvpB7P8Ztvnd4
         gG0AAfn/eMDURY5HE4X26dcbJJVpQLaYKLr3ATET0GhuQ4dEjzmlSmFvSmYs9nzYo1aO
         4ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulVlBNx93AvCw2pPS7B18RQRsMD31269sXjowYwKgTc=;
        b=CDgIiNWYnAyJbwi1QPnnbgAZN59pOXzxk9ZCalbhWkGsPJuVP6lKoEcKM9cDYzRoOg
         5pqH9qL1NPvxBtfevUwneyt5syeBkKBCIDFf7OeQH/sDz8QoavmVOx6IR8KRVivOQL9k
         0gSnakoEiEH51kYKBcyf157JLUejKhacb+aVL5IKpgHL+yXMMb1YzioRSYuDaMspuavl
         3ndNcgPCjS5bvSsJ+U746DN/E+Q0rL27kXzwK6AhcCzr4k7fb5PH0LeVy6hI63+jnAbm
         Ayb7FHUrjeK5E6sJsSle1XZtIhXcky2dWp2FYVhfOBU4Zwhe04Dg4dpO+rf9wh38tbDl
         LB/A==
X-Gm-Message-State: APjAAAUVYDRB9/u4+zWAeodu5jNEpiUYCbE4kfP4WxV5Ph+gAvptTubh
        GXBnySNYiKBUhS9fwvN9AlqT2ZpTCGE0BjRXftI7JA==
X-Google-Smtp-Source: APXvYqxkRJuAZE5TUS+TGw22+Ckc0J8d2Ab7lngek9d7uU6Sl1VRrMjAw6rn4j61UoI6Nf/tNiGZis/vZNqW2qSUEb0=
X-Received: by 2002:aca:c002:: with SMTP id q2mr493615oif.145.1552366673796;
 Mon, 11 Mar 2019 21:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190122233749.42220-1-trong@android.com> <7c7b4521-d747-d064-0506-4e3d6746877e@linux.ibm.com>
In-Reply-To: <7c7b4521-d747-d064-0506-4e3d6746877e@linux.ibm.com>
From:   Tri Vo <trong@android.com>
Date:   Mon, 11 Mar 2019 21:57:42 -0700
Message-ID: <CANA+-vCPOSWq5o6c3kT=jdLmyyJW9P9_-ZORPus6aFbFoBNUkA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] gcov: add Clang support
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Greg Hackmann <ghackmann@android.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 6:29 AM Peter Oberparleiter
<oberpar@linux.ibm.com> wrote:
>
> On 23.01.2019 00:37, Tri Vo wrote:
> > This patch series adds Clang supoprt for gcov.
> >
> > Patch 1 refactors existing code in preparation for Clang support.
> > Patch 2 implements necessary LLVM runtime hooks and gcov kernel interfaces.
> > Patch 3 updates documentation.
>
> Thanks for the updates! I've provided suggestions for some minor
> improvements in my other review e-mails.
>
> With those changes applied, the patch set is in my opinion ready for
> inclusion into the mainline kernel. My suggestion would be to re-post
> the resulting version while putting Andrew Morton on CC as gcov changes
> are typically integrated via his tree.
>
> Also I've successfully re-tested this patch set version on s390 using
> GCC 7.3.0 to ensure that the existing GCC support is still working.
> Unfortunately I wasn't able to test the Clang version due to some
> compile problems on s390 (unrelated to this patch set).
>
> If you haven't done so, I would like to suggest to run the following
> tests with the Clang gcov-kernel version that should catch problems in
> some corner cases:
>
> 1. Unload a module, then use llvm-cov on the associated coverage file.
>
>    Expectation: correct llvm-cov output including coverage of module
>    exit code.
>
> 2. Unload a module, modify its source, re-compile it and load it again,
>    then use llvm-cov on the associated coverage file.
>
>    Expectation: kernel message "discarding saved data", correct llvm-cov
>    output with no coverage of module exit code.
>
> 3. Unload a module, then reset all coverage data by writing to
>    /sys/kernel/debug/gcov/reset.
>
>    Expectation: all coverage files associated with the module are
>    removed from debugfs.

Thanks for the suggested test cases! The current patchset doesn't seem
to handle module loading/unloading correctly. I'll fix that in a
follow-up.
