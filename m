Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90F6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3072084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/QkwqXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDCP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:28:31 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45720 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:28:30 -0400
Received: by mail-ua1-f65.google.com with SMTP id c13so5761294uao.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2TrC490qrOBKkH9CGqbOZKSOXeq6rmELLPjCApNgQg=;
        b=n/QkwqXPMeHkv3KX4X3r+ZLmCHYGZ2Q1gFIftvinu64J63ng2V6Lw/shzcLHHzMJAE
         TNjXe8gdRYNsYBj5Trxh2ATe2UEMJ5NfVvsJxtJdaL3mfA9WbgGKbihC9wNqJW/y+oVV
         b2biPCG66Vdb2OOFJ8719oI5dR5fXt7G2ULmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2TrC490qrOBKkH9CGqbOZKSOXeq6rmELLPjCApNgQg=;
        b=P9Ko+HL9S5Plj7HL2XM10jYesdfRfSXGQnLiiwqR85ucN464GWviIbcWlMmyM+tk/G
         EvWpGRGHa+cQ6RWM5XEkr9p7ZyXteqsE4iqJhVkLfPjhOo1B1MrgnhLLL0TqewkAlioP
         MRrnTTKJH3jVNsvmWJytfe0Cq0vUd14yOnDmhfT049AOC1qcBdiX4ohNkA9zrl63bgNZ
         Pmb3LpYXNRXhEgtYejWu1t83FeycmbXFQalXKwm2trug//EmqOkaICprjl6F5/yOcpz1
         ZoSm4p6eYK/b2ivfxECUWFGMRA5Zm18kdUZYNSN0MflAfLIbMdwSK4Y4h4gaawKsYGvC
         8mKQ==
X-Gm-Message-State: APjAAAWmazFqVgLMqebIh/R/KVkQqE+jnnm6XAGhZSzDSpKoGY+/74Z7
        WvSuhxZEACHQK6PWYLrSOIGXmjY4hxI=
X-Google-Smtp-Source: APXvYqwC2vmutwe1wVrr+1YhOTxkfvrfCKJcXCbjMh6Vs8dkB3UyLH2BeX9AKWkksXJi+JM6nHiM/A==
X-Received: by 2002:ab0:4882:: with SMTP id x2mr491586uac.125.1554305309294;
        Wed, 03 Apr 2019 08:28:29 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id k65sm5269899vkk.40.2019.04.03.08.28.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:28:28 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id s80so3918245vke.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:28:27 -0700 (PDT)
X-Received: by 2002:a1f:2443:: with SMTP id k64mr512753vkk.47.1554305307492;
 Wed, 03 Apr 2019 08:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190402222610.GA15100@beast> <20190403002355.GA29296@eros.localdomain>
In-Reply-To: <20190403002355.GA29296@eros.localdomain>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 3 Apr 2019 08:28:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL16hn=_uY1tojAGqEi=a_nU=ScUZkTVO9_nbWnS+2wSw@mail.gmail.com>
Message-ID: <CAGXu5jL16hn=_uY1tojAGqEi=a_nU=ScUZkTVO9_nbWnS+2wSw@mail.gmail.com>
Subject: Re: [PATCH v3.1] selftests: Clean up module testing shell script
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 5:24 PM Tobin C. Harding <me@tobin.cc> wrote:
>
> On Tue, Apr 02, 2019 at 03:26:10PM -0700, Kees Cook wrote:
> > This adjusts kselftest_module.sh to take an option "args" argument for
> > modprobe arguments, removes bash-isms (since some system's /bin/sh may
> > not be bash), and refactors the lib/ scripts into a shorter calling
> > convention.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > This is my suggested clean-up for the module testing script for the
> > strscpy_pad() series...
>
> You are seriously at risk of being the most awesome code reviewer on
> LKML.  Beer is on me next time I see you.

And slowest! ;)

> I will roll this into a v4 for the strscpy_pad() set.  Would you like a
> Co-developed-by tag or just a mention in the commit log?

I'm happy either way. I really just tweaked it; maybe commit log?

-- 
Kees Cook
