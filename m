Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5F5C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BF22073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZL8dY8gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfLBR1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:27:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42029 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfLBR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:27:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so203800plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VefP/+cQ+dQ/UUR9SD7jeQ4+peUOMt+EfPp6hOKIcqA=;
        b=ZL8dY8guV22Uz06jo26bIIK1QZdQXlb4Tr9ScOe/VmZzsQs3GyGUfryAVSquNR5LWc
         xB0CotyQd3oBvrxauwgl9dJHeZUzrbCNYnPHS5lJ8BXvWdvUMn4hVGkyedG4AGdhmxYh
         xkurDdkUv61x8mkgp9/R0YiWxaamkKstqgkncC9sBElXJWlsAbX1dJTTZU11rs1FSk9X
         sCPbrg8hmikaRJ9r8IX+SGBxFGuEcfTPW41P3qAZxPnbSD+ANqK0jwwHNRwuWppfVFo8
         /QNthVMcvdtDr13co0H+UXGAno6rSHwrPBZZeEdeZRM4q4OF7+tf7MXokB+6B851h+D0
         uMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VefP/+cQ+dQ/UUR9SD7jeQ4+peUOMt+EfPp6hOKIcqA=;
        b=tAivPPTjaFC10Grey+71nyjbbMtd/4rv3q08/+NcFmRRUh7Px57wIPfkDjqCF64Wth
         o/oal+KC/gXs0dZAH2n+Ltm6dj4SsMzCu7C+VY4eD6KGmmObvpR3MUbvQI1gR8YcBDvN
         3MUg2fF9iwVpzt7kwVQb0bAN4KwDp0t8uXbQYnBhp4jq0/2qvj3l2orzfHVRRmjAvBxF
         M1RXKFtXM1LS4JLIJjAIXbEFSe3HIHAKHjo/22d3Yn8IM1KzzIQND5sZwH6F8CTXuscJ
         ptwl5k9kTUTLxTwbdeInyGPoYSmgQPoutPOyelA/Ni5zgNHSZ0EzwzXkxlaQGLJe+Qn5
         OnYg==
X-Gm-Message-State: APjAAAXTXEE8oPQdvWbZK/8juL/0lWV1zKRsBX8Fs+/jYGJMFqZbOSzB
        zOnJSW4vbJyIi8JpEurOlnicI4YQTugnMIsBYBJh7Q==
X-Google-Smtp-Source: APXvYqyo+U7FbkqdkHj8sWUhLZOOwg9M06lpZyP42lIWa4c2IcoppkM4L2SY7TH8Cos5EDfOIIj8q52YDOAY0opCjzo=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr312605plm.232.1575307637383;
 Mon, 02 Dec 2019 09:27:17 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-4-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-4-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 09:27:08 -0800
Message-ID: <CAFd5g45ofMTq7LA8vticE5bEySD+K0MudE0v2eiTTKzodJ0TDQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] kunit: Remove duplicated defconfig creation
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> '--defconfig' option is handled by the 'main() of the 'kunit.py' but
> again handled in following 'run_tests()'.  This commit removes this
> duplicated handling of the option in the 'run_tests()'.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
