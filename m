Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101DAC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D747226F12
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZtEimIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfEaVCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:02:09 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45809 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfEaVCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:02:08 -0400
Received: by mail-vs1-f66.google.com with SMTP id n21so1832032vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuyCAOWAhmD+YZO0ugz0gJOz+hoKh/oSXrFPY7bljN8=;
        b=EZtEimIeHcrXqTbgifI3uHjto8/jboSrzUJb1iNZd+j4B/Ut+MLkTKkExtCcXvfkd0
         Nq9gV4hFY8zrUp10Plig/aEE/IafJCPXYNOqz2clS1TPU/8O9wItnP8shJZIRXK22qqV
         VDMlkjbIc1Nxx5kHdpFajj6qMS/G1I45Tfvl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuyCAOWAhmD+YZO0ugz0gJOz+hoKh/oSXrFPY7bljN8=;
        b=nTt9iokhboJBmPXiKbLJcHA8oxdsitp7xASKPA0d8ImaoGBNTO7r1n7k46qkhluDlA
         j4Q7ntBDLurkRxgWtPSAevBC7NCRD4IEV5DwA4hFLxn5qjQNsAqzggnsDaT3wCiS53gS
         1/o5IVONoiudb0XqUUeFCarjgdHTrmfBGAoh3kVzP7ZEv/2CjHWHBb2MLq7F1gmoWcDI
         C7S1TcBmP7YY0FLDpBY/Ssf19PF9mMkZWqZzFKv3TkpeCdrccR4cX3fz0wNEhINlt0um
         Hw3e+yl3c0+KMHWLzhkTqAh+osIcH6+v9QDhqJ/Tpyd5rnEm1oPkns5Ck/n+kdHT8cg5
         vIOA==
X-Gm-Message-State: APjAAAVpPyOsS8kkTb7ixCWUTGHN+xXNSz5GctaDU4C5IQAmkAsPIIVh
        vwzoHWqzCjcbbps9sVYNCgvd8RydX6o=
X-Google-Smtp-Source: APXvYqxACZENhXuWtm6BHFK9NYz1Pr/cEyLAjvTP9qGa8VZnvMfWk0YVXdPyhTMl2PaUWuDZFNlMFQ==
X-Received: by 2002:a67:f607:: with SMTP id k7mr7143278vso.169.1559336527508;
        Fri, 31 May 2019 14:02:07 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id l132sm3529394vkd.39.2019.05.31.14.02.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:02:05 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id q64so7602693vsd.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:02:05 -0700 (PDT)
X-Received: by 2002:a67:1cc2:: with SMTP id c185mr6238259vsc.20.1559336524877;
 Fri, 31 May 2019 14:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190531205926.42474-1-evgreen@chromium.org>
In-Reply-To: <20190531205926.42474-1-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 31 May 2019 14:01:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuPNwr-NhvDjH3stU7jCPy_+Cz2z3qTtr5EO2ozxsjkw@mail.gmail.com>
Message-ID: <CAD=FV=VuPNwr-NhvDjH3stU7jCPy_+Cz2z3qTtr5EO2ozxsjkw@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace: Accept dash/underscore in modules
To:     Evan Green <evgreen@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Manuel Traut <manut@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 31, 2019 at 1:59 PM Evan Green <evgreen@chromium.org> wrote:
>
> The manpage for modprobe mentions that dashes and underscores are
> treated interchangeably in module names. The stack trace dumps seem
> to print module names with underscores. Use bash to replace _ with
> the pattern [-_] so that file names with dashes or underscores can be
> found.
>
> For example, this line:
> [   27.919759]  hda_widget_sysfs_init+0x2b8/0x3a5 [snd_hda_core]
>
> should find a module named snd-hda-core.ko.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Note: This should apply atop linux-next.
>
> Thanks to Doug for showing me the bash string substitution magic.
>
> ---
>  scripts/decode_stacktrace.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index fa704f17275e..13e5fbafdf2f 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -28,7 +28,7 @@ parse_symbol() {
>                 local objfile=${modcache[$module]}
>         else
>                 [[ $modpath == "" ]] && return
> -               local objfile=$(find "$modpath" -name "$module.ko*" -print -quit)
> +               local objfile=$(find "$modpath" -name "${module//_/[-_]}.ko*" -print -quit)
>                 [[ $objfile == "" ]] && return
>                 modcache[$module]=$objfile
>         fi

Reviewed-by: Douglas Anderson <dianders@chromium.org>
