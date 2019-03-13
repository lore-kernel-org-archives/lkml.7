Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FF32054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xc9klXTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfCMRpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:45:44 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:37516 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:45:43 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2DHjWsT018607;
        Thu, 14 Mar 2019 02:45:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2DHjWsT018607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552499132;
        bh=AbMSZAUcqIEOIgIxxaDhD7RBuUY6Me8iIIfws+TqVuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xc9klXTwj/e0ByIWTwoIChOPPlSyvYORjPgCu98PQHZ0kC4PvnganWqnrl5BpGP1A
         Jro/IiAxw/6yANi961f1nM1QgmATaguY7UUPJJplbum9+A9YRnrk2VMQLW0pE8OW6M
         pnISVEbD75bYoG11hG/6EUjjTD3quZn5wFzMg0H6YtP+nimWNihZxlErijv0wTgxcK
         Qc0PLe8SQkrPQNIie351hbyeCzmkxFgGcBYVFH1Hi7A8f9hq7naqWsYsKgGsB318ff
         xGSXyh1KjDbcy/TKJxCXYHWT6fnyERwCeZmvUo8MU63N+FPpk4mdAu3GeuTPQgG6L8
         MXQCjiwRaaRJQ==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id y19so1549981vsc.4;
        Wed, 13 Mar 2019 10:45:32 -0700 (PDT)
X-Gm-Message-State: APjAAAU6NdQY2sX9+ib03llCZk1vYYTAaOb6c9uubc5FDvNluhG7VujA
        WkB7SZFp4fL62zMFx3Eh5a/ccFq+bJBmDLf+zGo=
X-Google-Smtp-Source: APXvYqzj94j6z3svlzm+MmfkVJ8thjJz/vz3tKKdiy07zBcLzSvMS3GWmuNNCJ2spPBJAdziClXWC0Pjmn9CoZUIRKM=
X-Received: by 2002:a67:f90e:: with SMTP id t14mr23702454vsq.181.1552499131604;
 Wed, 13 Mar 2019 10:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <1552036419-924-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1552036419-924-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 02:44:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATeqmC3daAxTk9J0r0YHB425gTFYLave2aMth6rmejREQ@mail.gmail.com>
Message-ID: <CAK7LNATeqmC3daAxTk9J0r0YHB425gTFYLave2aMth6rmejREQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add workaround for Debian make-kpkg
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Manoj Srivastava <srivasta@debian.org>,
        Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Manoj Srivastava <manoj.srivastava.1962@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 6:15 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since commit 3812b8c5c5d5 ("kbuild: make -r/-R effective in top
> Makefile for old Make versions"), make-kpkg is not working.
>
> make-kpkg directly includes the top Makefile of Linux kernel, and
> appends some debian_* targets.
>
>   /usr/share/kernel-package/ruleset/kernel_version.mk:
>
>     # Include the kernel makefile
>     override dot-config := 1
>     include Makefile
>     dot-config := 1
>
> I did not know the kernel Makefile was used in that way, and it is
> hard to guarantee the behavior when the kernel Makefile is included
> by another Makefile from a different project.
>
> It looks like Debian Stretch stopped providing make-kpkg. Maybe it is
> obsolete and being replaced with 'make deb-pkg' etc. but still widely
> used.
>
> This commit adds a workaround; if the top Makefile is included by
> another Makefile, skip sub-make in order to make the main part visible.
> 'MAKEFLAGS += -rR' does not become effective for GNU Make < 4.0, but
> Debian/Ubuntu is already using newer versions.
>
> The effect of this commit:
>
>   Debian 8 (Jessie)  : Fixed
>   Debian 9 (Stretch) : make-kpkg (kernel-package) is not provided
>   Ubuntu 14.04 LTS   : NOT Fixed
>   Ubuntu 16.04 LTS   : Fixed
>   Ubuntu 18.04 LTS   : Fixed
>
> This commit cannot fix Ubuntu 14.04 because it installs GNU Make 3.81,
> but its support will end in Apr 2019, which is before the Linux v5.1
> release.
>
> I added warning so that nobody would try to include the top Makefile.
>
> Fixes: 3812b8c5c5d5 ("kbuild: make -r/-R effective in top Makefile for old Make versions")
> Reported-by: Liz Zhang <lizzha@microsoft.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Lili Deng <v-lide@microsoft.com>
> Cc: Manoj Srivastava <srivasta@debian.org>
> ---

Applied to linux-kbuild.


> Changes in v2:
>   - Drop the unimportant comment about PowerPC
>
>  Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 4fb8896..6039685 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -31,6 +31,16 @@ _all:
>  # descending is started. They are now explicitly listed as the
>  # prepare rule.
>
> +# Ugly workaround for Debian make-kpkg:
> +# make-kpkg directly includes the top Makefile of Linux kernel. In such a case,
> +# skip sub-make to support debian_* targets in ruleset/kernel_version.mk, but
> +# displays warning to discourage such abusage.
> +ifneq ($(word 2, $(MAKEFILE_LIST)),)
> +$(warning Do not include top Makefile of Linux Kernel)
> +sub-make-done := 1
> +MAKEFLAGS += -rR
> +endif
> +
>  ifneq ($(sub-make-done),1)
>
>  # Do not use make's built-in rules and variables
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
