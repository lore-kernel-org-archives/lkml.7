Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6022BC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FC22189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IyDLft22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfGDFJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:09:17 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:33921 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfGDFJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:09:17 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x64594Vx010210
        for <linux-kernel@vger.kernel.org>; Thu, 4 Jul 2019 14:09:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x64594Vx010210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562216945;
        bh=YxaedVyjGdbgEAATAZFbBNHjWvxWBniBk/2zBwHpP3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IyDLft22sCs8jqEd9JmK+VKe5QL5DQHxygGZDT8L0GL9K0L4Ki/C5vLA7nHFYRZkX
         fFxgco+fK7FK3XBi3JbWahmmAbJUf5XfwVdBfSFfymRZEY/1Raui5fAlQcstcx7rrC
         owlJ+p22Npuc1PSFvvHf9XSs+AwaeK+lDy7Hn93lqptipTxrWQpU1v5VMLgaKLyKUB
         YfVdQQbyJVOi5HHYyzfZIT6vhYYkgk4yTiP76b2PJ97be+0O6GDRCSgclOBfNqzQd5
         QDa1yqi4+KQPdN7E4rN+jXc8pNJNJFFG/+Sz1FB+sdKcfJEIjwGZFgSqCAx9eAJUOH
         6rbEX+T8oSTVg==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id f20so698710ual.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:09:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWlRScuBY/0Qrva9ahKAOoOpKzh7VaSRaXPNk3M/eH0dRSKF0IF
        /tQCS9tS6UFqbLKEYngHWmS6uhSyHhlp6H9ctkQ=
X-Google-Smtp-Source: APXvYqx/FQCdwGG+sooCQQznXCKEdYHte/WRea9a+VCR+acDGiWXLtMS8TX+3Xy4xc//M03ngFBemzQltfbHBRwooig=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr20664257uaf.95.1562216944080;
 Wed, 03 Jul 2019 22:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190624163111.171971-1-mka@chromium.org>
In-Reply-To: <20190624163111.171971-1-mka@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 4 Jul 2019 14:08:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5=MhXuaQMksBuuDxi2Xg1oMt1-CyOEvyQTw1FJFEEiA@mail.gmail.com>
Message-ID: <CAK7LNAT5=MhXuaQMksBuuDxi2Xg1oMt1-CyOEvyQTw1FJFEEiA@mail.gmail.com>
Subject: Re: [PATCH v2] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Tom Roeder <tmroeder@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Hughes <tomhughes@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Yu Liu <yudiliu@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 1:31 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> gen_compile_command.py currently assumes that the .cmd files and the
> source code live in the same directory, which is not the case when
> a separate KBUILD_OUTPUT directory is used.
>
> Add a new option to specify this the kbuild output directory. If the
> option is not set the kernel source directory is used.

I do not understand this patch.

In my understanding, this tool already provides
-d, --directory option, which is supposed to point to
the kbuild output directory, not a source directory.


This works except under tools/.



> -                        entry = process_line(directory, dirpath,
> +                        entry = process_line(source_directory, dirpath,
>                                               result.group(1), result.group(2))

This is wrong.

result.group(2) returns the relative path to the output tree
instead of the source tree.
(or absolute path).


[Example of breakage]

$ make -j8 O=foo defconfig all
$ scripts/gen_compile_commands.py  -d .  -k foo
WARNING: Found 0 entries. Have you compiled the kernel?






-- 
Best Regards
Masahiro Yamada
