Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25D8C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B17D20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLd0Rm33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfFFSuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:50:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42832 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfFFSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:50:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so1841258pgd.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 11:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Bnwpy6cjzfBrajWkrs7wHMOESAxVWwnH8hnTtDte0U=;
        b=OLd0Rm33yAfl3TLExw0ekB2qn1paxAdhV4VDB8wnSqif91RFuDfuCA5tjaNvDRofFO
         lZ4YsmYWYWZSCjgsqULVqL/HPuCpsBud/F08K35cILFVIZp7N+ottB/wjxYA74au0Dj/
         auCI94TAm4MWNiHWmyOhgqAAnUWG3FzrAu/q4WoDk+z9mOl2QBaBQPqJSNdlz3NJsEea
         LeIOQOUx9pB3yELO9rSRom3kzFEQhSZXiPpS0hi/1Oju61CuIfaRgfyt1IRe2MyZfQjP
         6lEQaOaKi2VPpGQzW+ZW22x/6us4+BiyyG4Dy2qcLH+1GeMLdsqQNPPrI+o3YIeEHJL6
         xQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Bnwpy6cjzfBrajWkrs7wHMOESAxVWwnH8hnTtDte0U=;
        b=gI0APeFjoB90v2a4HpGp3rH9KnjzyrjowBHaf4lQ4DiOzIQ+/bvuhx3c1jb/aR/A3H
         l+SypV0cjPgq7SaIDAXTtNcoLKES3DNIHfMhh7pAYj+HJVz69x9S9XgMbciuiomwDORe
         bL3jB0LEB7X4usuhbsbAa1Jp+RNbu8LTR35dh/M5rIi16G4FjG+kSI8PcjjRv1ZXoBqR
         0ecA8wPyC304wMkj7teJodwy3bHL4BGalf2d9PVgOMp2kvfwh5T+tJ10hDEcd2+F8F33
         kEzzupJggK6g8Umge+hBbSKTDlB2Lh1TGZqeFuD3OAVWb76nnRO7GfEzgqmId1UVY/f3
         Slwg==
X-Gm-Message-State: APjAAAU5N5pgVpnf92q5y6G/Eu5cN+d+EYAYqyCcCV2MlxuotX+2thSt
        BWvbXu5Zsta6XibOrSExXIhMwdiS6Lv+50Y3XlqbgQ==
X-Google-Smtp-Source: APXvYqzdCLWgxj960/YUfQPhcpvzx0x+9Dh/oSxDWTDDNRlN23xXNdcpcn7jogMNWxlL1xvQwoCq4LGl2oezajjRk1g=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr1283296pjs.73.1559847021932;
 Thu, 06 Jun 2019 11:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190606051227.90944-1-natechancellor@gmail.com>
In-Reply-To: <20190606051227.90944-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 Jun 2019 11:50:10 -0700
Message-ID: <CAKwvOdnswiifrvSrBcAnc4Br8nhxJRUAL0yNM6T6=4xScHXf5g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt1011: Mark format integer literals as unsigned
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 10:13 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> sound/soc/codecs/rt1011.c:1291:12: warning: integer literal is too large
> to be represented in type 'long', interpreting as 'unsigned long' per
> C89; this literal will have type 'long long' in C99 onwards
> [-Wc99-compat]
>                 format = 2147483648; /* 2^24 * 128 */

This number's bitpattern is a leading one followed by 31 zeros.
`format` is declared as `unsigned int`, and literals in C are signed
unless suffixed, so this patch LGTM.  Maybe a macro declaring such a
bitpattern would improve readability over the existing magic constant
and comment?
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                          ^
> sound/soc/codecs/rt1011.c:2123:13: warning: integer literal is too large
> to be represented in type 'long', interpreting as 'unsigned long' per
> C89; this literal will have type 'long long' in C99 onwards
> [-Wc99-compat]
>                         format = 2147483648; /* 2^24 * 128 */
>                                  ^
> 2 warnings generated.
>
> Mark the integer literals as unsigned explicitly so that if the kernel
> does ever bump the C standard it uses, the behavior is consitent.

s/consitent/consistent/

:set spell

:P
-- 
Thanks,
~Nick Desaulniers
