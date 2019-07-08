Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC356C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811B52064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtAdV/r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfGHL1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:27:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34080 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbfGHL1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:27:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so10705488lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hf3qpWa9o4L5jAB6/mRGuaap2/x9yf4r/vYifeii2fo=;
        b=wtAdV/r5ADnTNlCcb2H65bjv2Tsa00Kxo9Pak35xFfZqO4HQdn/Y83/YS7JLdXRSQL
         KK7cd+RjG3owZ9Hkw1yPnC58MOuzGpkMKESDqmM6zVUMLrIei4nJlD75/c1vr8HTryRM
         575lU4GslsVNElcIKu7WJ2+ZHLUg6qYpiL0IDok7DIBzLKPlz9GECIKcb5cJvTQhXaSU
         b4aKu3jTmOW60Hvcck7u+o2jVjQ82hniSEE5EftujuFjdWGl6dzvrvEPWMGgfHtXxqL+
         w4tCbLekz5jpXPA9bmsXrWRYKHi+lfrSkyNafswSxlz0JozmT2QkBp8Sr5dIx6TMcdN2
         8aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hf3qpWa9o4L5jAB6/mRGuaap2/x9yf4r/vYifeii2fo=;
        b=dkDFkI+kKnQvWRNgBL/oijkGO/BvAHODtT1UQ8Q2GSwSxw+dhCRkOHiDrx9tCwsg4S
         kkmxfa17aUrn7IYK19PMlAOIYZ8raaLc5tGGtOk/yK0jUZXQqqFw68j4SQtI3QOJbMJi
         VOfa/VVIwaKswhupDQDHCzFrT+h+7VHuxbQzzapK4SJF+MZLvPLhH/csq6zEhK7xOQo6
         XcomqCd8ijbtZFzFYIe4ccp0zj9hcNwcF3UQ7GM38zLbfMvvhYtNZrw7EbiNQ+ezf7vi
         D9MqTC3hoGUMVFe4RWicAYzKSMdhcqIpzokWfnU9jXLy4pO6BFx9jHBUnhKAy78nUkY2
         xflQ==
X-Gm-Message-State: APjAAAVsj6PgZnhIGKr5oitA+szs8N7Wa40+F2cLTrLXdLwUjwHD53bo
        Xnqg4LUtBC3NtNBKoQimrhPgTLNkZvYw41worqfTGw==
X-Google-Smtp-Source: APXvYqwC081d4fR8OLPtrXbCh+vYtmMk0Wru8dJUQmZZITm97zVIs/RPXdBvfUuHjytU0dkT/inqO7H2OXdKXuA7ADM=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr8605091lfp.61.1562585223749;
 Mon, 08 Jul 2019 04:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <5d215f83.1c69fb81.3739c.06f8SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5d215f83.1c69fb81.3739c.06f8SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 8 Jul 2019 16:56:52 +0530
Message-ID: <CAFA6WYPQWvVhjPjs9gueSvSn=EYcDBh7XGU+7te09-rmiWEvGw@mail.gmail.com>
Subject: Re: uuid define issue build on macos
To:     feng chen <puck.chen@foxmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2019 at 08:27, feng chen <puck.chen@foxmail.com> wrote:
>
> *** Default configuration is based on 'defconfig'
> #
> # No change to .config
> #
> arch/arm64/Makefile:40: LSE atomics not supported by binutils
> arch/arm64/Makefile:48: Detected assembler with broken .inst;
> disassembly will be unreliable
>    UPD     include/config/kernel.release
>    UPD     include/generated/utsrelease.h
>    HOSTCC  scripts/mod/file2alias.o
> scripts/mod/file2alias.c:42:3: error: typedef redefinition with
> different types ('struct uuid_t' vs '__darwin_uuid_t' (aka 'unsigned
> char [16]'))
> } uuid_t;
>    ^

It looks like somehow Darwin OS specific header is included here for
UUID definition. Please try to build with following change to include
only standardized headers:

--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -10,6 +10,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  */

+#define _XOPEN_SOURCE
 #include "modpost.h"
 #include "devicetable-offsets.h"

-Sumit

>
/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uuid_t.h:31:25:
> note: previous definition is here
> typedef __darwin_uuid_t uuid_t;
>                          ^
> scripts/mod/file2alias.c:1300:42: error: array initializer must be an
> initializer list or string literal
>          DEF_FIELD(symval, tee_client_device_id, uuid);
>                                                  ^
> 2 errors generated.
> make[2]: *** [scripts/mod/file2alias.o] Error 1
> make[1]: *** [prepare0] Error 2
> make: *** [sub-make] Error 2
>
> and:
>
> _types.h:77:typedef unsigned char   __darwin_uuid_t[16];
>
>   28 #ifndef _UUID_T
>   29 #define _UUID_T
>   30 #include <sys/_types.h> /* __darwin_uuid_t */
>   31 typedef __darwin_uuid_t uuid_t;
>
>
>   32 #endif /* _UUID_T */
>
>
>
