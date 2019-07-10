Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D8C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62DC208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cSikSw0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfGJWBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 18:01:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36263 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJWBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:01:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so1875130pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BfPC1V8WPs+HHulvVzscZon29BNBv9nW1vMXkuMNcH8=;
        b=cSikSw0j7RwNrIAexEE5rx5741+GokKEPaAD5lEUxwAo2jxq0DHNfTvGWQHvqnKrLj
         5eHjrTbRivuBH4BCwdYxNUdrVKNrVVYGZTlAKf1cNdEOK3kXZO8hS98Sy2BeeVL84nfE
         gdE8DnSHxSGu05Yh2nTPoQwbq8x7V0F7pEeYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BfPC1V8WPs+HHulvVzscZon29BNBv9nW1vMXkuMNcH8=;
        b=T2w4F07kJZRWF6cGl11bmDcyvN0OtmaZ+Q6xgeKbYqR9ZV1D34FXWa7dGuwAYnXhOJ
         M5QhEuJXWRKAGeUc89prtVRfqXwnPpKD/o7BFRfmwkdxrxERlTyRyWcEiBZwSKw7s5uw
         9+jrYMJyDI0IC7HZ9wTqtI6zSWYNJVebGOTUrzkDXslfgEdwcRQFGZtxy+d+tnrxlfQ/
         2vuQ/vPveJglGqDXdDQUuhOJYwNJzcyJug/nWK4WlBrhMC64C+Sn/bat4KcUEQ8k+ixy
         mKvhAu61hXjoYwf1xnvL9xJzwjvHXVP9kiqN3JBe8jWJv0FOTxk99sIiAZkafhOXOp1G
         Wh+Q==
X-Gm-Message-State: APjAAAVJt153gtWTWgdZqvIVmhxxWZy4Du2/M4ljHxlQ/oHvk3CEVe8s
        jm+s7Lnpy4OcWb2WqsT30cPiMw==
X-Google-Smtp-Source: APXvYqzumLVmQ/e73Mwo7IK6MXfeulflBvINkKMzLElRwrRu0JEQiIr5nTkVilCGF87NCOt42jKo0w==
X-Received: by 2002:a65:4cc4:: with SMTP id n4mr515862pgt.307.1562796096616;
        Wed, 10 Jul 2019 15:01:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b11sm3483259pfd.18.2019.07.10.15.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 15:01:35 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:01:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Tom Roeder <tmroeder@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Hughes <tomhughes@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Yu Liu <yudiliu@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
Message-ID: <20190710220132.GP250418@google.com>
References: <20190624163111.171971-1-mka@chromium.org>
 <CAK7LNAT5=MhXuaQMksBuuDxi2Xg1oMt1-CyOEvyQTw1FJFEEiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAT5=MhXuaQMksBuuDxi2Xg1oMt1-CyOEvyQTw1FJFEEiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 02:08:27PM +0900, Masahiro Yamada wrote:
> On Tue, Jun 25, 2019 at 1:31 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > gen_compile_command.py currently assumes that the .cmd files and the
> > source code live in the same directory, which is not the case when
> > a separate KBUILD_OUTPUT directory is used.
> >
> > Add a new option to specify this the kbuild output directory. If the
> > option is not set the kernel source directory is used.
> 
> I do not understand this patch.
> 
> In my understanding, this tool already provides
> -d, --directory option, which is supposed to point to
> the kbuild output directory, not a source directory.

You are right specifying the output path with -d works.

The help string claims the directory passed to -d is the kernel
*source* directory though:

    -d DIRECTORY, --directory DIRECTORY
                        Path to the kernel source directory to search
                        (defaults to the working directory)

I recall getting plenty of errors of files not being found (possibly
after adding debug logs). Chrome OS builds the kernel inside a chroot,
I guess I ran the script from outside the chroot and got the errors
because the (chroot) file paths in the .cmd files don't exist outside
the chroot, but drew wrong conclusions.

Please disregard this patch.

Matthias
