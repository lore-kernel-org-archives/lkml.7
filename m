Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0C52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6X9hG/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfG2RRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:17:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40838 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfG2RRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:17:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so27712477pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDpc8dttTfICfu+NA2rP7d7EK6Xfd1t48iUvlABkY5c=;
        b=E6X9hG/qC+ZFNxAoh/s2Pax+XfWjHa0cGxosOaBllMvG1GoZ+bG7ht/P+SsHlvVM2i
         iAKE8UKAG1/U41GXIS9cayYInLH7IhdLfc9d2fM77LE/9ZjF5EAp0NTs1Umd/hYBB8aK
         ZPWUu/MSUNU+qmL7DyG4FegdgaQ4lSbnnfvmIHoynHJTgZfshP1otKFBvsI9Uw0nDVGF
         u2gAJ5e8o+Q2z+6XMKTj0WNKR210qYVB2RM8HcZNBnh8Aci3EM3fKgJDZtv7nH7yjLdc
         a5EsADvAaOmrrvElKx5wG0aHrb7xop8JK3ZevyugGcR3LOoQb7hb6N0oIP1G1cJjeoVZ
         cQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDpc8dttTfICfu+NA2rP7d7EK6Xfd1t48iUvlABkY5c=;
        b=OMGovCymPBtiTNUojnSbqfyzrUNMmSZj+O/QgqmTiBlmbp5rC4bdFdm9DiuDx04im2
         k3pJHF1VkaT3WMpirVFyobE4KguxhyyEzcF/wBsgOikI3gwayinLPQEmMEdqtmPialPa
         oibUHHLA86oNtY4P0i2Plir4izezzGo0FBM7aPPQDptHrBhTaEuW8nkPkwxvcCn/CHxp
         TXat9Ae637/rZi+hVzsG+ehRF7YbOsJFX2lxntqLy5l2AZulkBw1CW6RYzyeGd/lc7xF
         ZKIte2ffFJk8vTu8FOwBA3pLvIbOmFfW9EsX2sYDv02HMLpXaUzjI/6C/Js6PSSNkc6A
         ygcg==
X-Gm-Message-State: APjAAAUORT2BUK/X8Rf3slwG0+Z5CXUkxO5IyXMyhxg6WsrySKY6kTBv
        8oZGDdpnlenenGNVc/PBovj5JYEfeWsrU3S9mI4fpZJV0ZQ=
X-Google-Smtp-Source: APXvYqxkT4VhjJ6KR1/tOHA5hLJ9UZagJd/hPjuYBLQaKT1Zd31YQEsLjxmsmeguf6m3YBH0px2RpYUr7v78Frn4l0M=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr34783730pls.179.1564420668750;
 Mon, 29 Jul 2019 10:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190727030110.17208-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190727030110.17208-1-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jul 2019 10:17:36 -0700
Message-ID: <CAKwvOdmUUuFvdqD3X4SO7xPOpUevvc0iDpyUGC98KQH_AvvD=A@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_commands: lower the entry count threshold
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tom Roeder <tmroeder@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 8:01 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Running gen_compile_commands.py after building with allnoconfig
> gave this:
>
> $ ./scripts/gen_compile_commands.py
> WARNING: Found 449 entries. Have you compiled the kernel?
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This potentially may need to go lower for other arch's allnoconfig.
I'm guessing you tested x86_64?
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/gen_compile_commands.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> index 7915823b92a5..c458696ef3a7 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -21,9 +21,9 @@ _LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c)$'
>  _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
>
>  # A kernel build generally has over 2000 entries in its compile_commands.json
> -# database. If this code finds 500 or fewer, then warn the user that they might
> +# database. If this code finds 300 or fewer, then warn the user that they might
>  # not have all the .cmd files, and they might need to compile the kernel.
> -_LOW_COUNT_THRESHOLD = 500
> +_LOW_COUNT_THRESHOLD = 300
>
>
>  def parse_arguments():
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
