Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB2C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A362087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cmgtjYpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfD0G1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:27:53 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:61237 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfD0G1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:27:52 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x3R6Ra5l032097;
        Sat, 27 Apr 2019 15:27:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x3R6Ra5l032097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556346457;
        bh=4/qD2RXPXk3v7vWAC8i5p2bKn+1IigPlvHVhniwstD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cmgtjYpaDhoim7fJGpg5iik9VAdOpdefXtHviJEB1pOFnDX+Cc4NU1GcudDn/WFCm
         YRTUwMgv5Pg8uHfq4BmQr1o8FxwDTx5VmTxjtlPi3EsQlydGwPhHL5E5PImFoAX+on
         Tb70wM1JsA2p0AKTDtSXUvJK7mVPG/LzjOT1wf8d3cn4K0R1VY/MR+c94AWRnRqapg
         k/Cy2YqCt6LxtAhflKhlT2GAgRLxlfEybou/XAtijb3ScC0/RTbGegVxvLg0GnRyUO
         L3O4TYyOB7LwbGY1+HytCVEVSK+UtKTvwcaCSWt2OpQdJESqUroJiIUNUZPtxRLSbF
         Gli/okWqqC+IQ==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id g187so3188042vsc.8;
        Fri, 26 Apr 2019 23:27:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWqUj7bL4wJrJUeFwJwXYUginf7NenQDUz6+7SxsGJ7zm3+MQw5
        pNUNk3Jb3PpDVCfF6MeFbp8rXvk9uWhWZQkuTWA=
X-Google-Smtp-Source: APXvYqxtxQQtpzNPVeh2ZyfNWDQ5lXHP/1ZJdV5/KHEUanbEJkuM/G8uqUEq2yVGxUrtineOYlVALQCayzi+7JsOPZw=
X-Received: by 2002:a67:fc4:: with SMTP id 187mr506813vsp.215.1556346456270;
 Fri, 26 Apr 2019 23:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <1556346241-10451-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1556346241-10451-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 27 Apr 2019 15:27:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2vTGF0dYJ67Ct2xDL=7qxYhhK-VoVHfkqDu0d8ULd+g@mail.gmail.com>
Message-ID: <CAK7LNAS2vTGF0dYJ67Ct2xDL=7qxYhhK-VoVHfkqDu0d8ULd+g@mail.gmail.com>
Subject: Re: [PATCH] unicode: refactor the rule for regenerating utf8data.h
To:     Olaf Weber <olaf@sgi.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 3:24 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> scripts/mkutf8data is used only when regenerating utf8data.h,
> which never happens in the normal kernel build. However, it is
> irrespectively built if CONFIG_UNICODE is enabled.
>
> Moreover, there is no good reason for it to reside in the scripts/
> directory since it is only used in fs/unicode/.
>
> Hence, move it from scripts/ to fs/unicode/.
>
> In some cases, we bypass build artifacts in the normal build. The
> conventianl way to do so is to surround the code with ifdef REGENERATE_*.


This is a typo.

conventianl -> conventional



> For example,
>
>  - 7373f4f83c71 ("kbuild: add implicit rules for parser generation")
>  - 6aaf49b495b4 ("crypto: arm,arm64 - Fix random regeneration of S_shipped")
>
> I rewrote the rule in a more kbuild'ish style.
>
> It works like this:
>
> $ make REGENERATE_UTF8DATA=1 fs/unicode/
>   [ snip ]
>   HOSTCC  fs/unicode/mkutf8data
>   GEN     fs/unicode/utf8data.h
>   CC      fs/unicode/utf8-norm.o
>   CC      fs/unicode/utf8-core.o
>   AR      fs/unicode/built-in.a
>
> Also, I added utf8data.h to .gitignore and dontdiff.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---




-- 
Best Regards
Masahiro Yamada
