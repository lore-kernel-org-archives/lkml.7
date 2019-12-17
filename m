Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3D4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140432072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576545037;
	bh=vidyZGtR2dINNJZ21JtddsN72Y4DKN9QSlgdOGTRvcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=peQqmAVtFDv+KtGd9PhixfhalacUTja5cNhRac21Nng8bXOTYov8EDVUln053BSfe
	 KhpPJ+UQJsH64v7SwncDkMlCea6aM5ftJZifYELNzNyZQqS99gKIDuXMRxLy65TTIP
	 U2HZjP386lIyIC/i3vGvvB2n6tr7xp5QuINhskuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLQBKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:10:36 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:57920 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQBKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:10:35 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xBH1AL41024113;
        Tue, 17 Dec 2019 10:10:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xBH1AL41024113
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576545022;
        bh=EfPkJ1K6br0RIoAN8GGT4R0vF2+h8CtL4curYlOC5SQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T5HUX7yccL+KyA+78j7r/t6p8sVwkVPF8EnE3pud8kBYKZx6+v3Fx7Kr37aQCw8rr
         jSwcemXZEXQUzvFyBYdnZErbK3TaFarfk6zMUNvAMclsAIGdvuyR9ilgRcDN6kYB4A
         rTDCiU2R399Y1wuQi5g/VvC4tC0iY/Kpufg0PR69AuRJnH3P9g0F0zbFPDgmhE0QO5
         HkSJ8EqzPFHu2UvQwDoRrJ2lvyQbB4Pu/ZCOFKRsJg3u0gXAethyKByAk56QR9YabP
         g2MwyUYHyLLmovd/elJAAa2ZL7RD9LOl55lrGpcgJ6k29QsP2L+KUuh909xXAlBefn
         v6hLWt4gUKjtQ==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id x18so5447514vsq.4;
        Mon, 16 Dec 2019 17:10:21 -0800 (PST)
X-Gm-Message-State: APjAAAUmpCFbrImAyjui1QH/ewKfuaS6dzlHgrHeMZjgReYEEuqW7DOV
        zdJIHZYF66ALAtc0zmtGgI0rxx0EfxyEDTEG22A=
X-Google-Smtp-Source: APXvYqwkIN9Lvwlmkp2stv+JiCv4A9+lBjvUCThtm2ZkD11UN3CKjhGlaOiDvW6XmlUNhWQtm79VZMv0NB9zgNtp9yE=
X-Received: by 2002:a67:30c3:: with SMTP id w186mr1240283vsw.179.1576545020751;
 Mon, 16 Dec 2019 17:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20191216200719.30479-1-info@metux.net>
In-Reply-To: <20191216200719.30479-1-info@metux.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Dec 2019 10:09:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASxcne9kryTsW2+7TQxuH+tp4Z4OT+1BjUHSE2Cfp_qxA@mail.gmail.com>
Message-ID: <CAK7LNASxcne9kryTsW2+7TQxuH+tp4Z4OT+1BjUHSE2Cfp_qxA@mail.gmail.com>
Subject: Re: [PATCH] scripts: package: mkdebian: add missing rsync dependency
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 5:08 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> We've missed the dependency to rsync, so build fails on
> minimal containers.

Ah, right.

Did it fail in headers_install?

If so, I will add this tag.

Fixes: 59b2bd05f5f4 ("kbuild: add 'headers' target to build up uapi
headers in usr/include")





> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  scripts/package/mkdebian | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index e0750b70453f..7c230016b08d 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -174,7 +174,7 @@ Source: $sourcename
>  Section: kernel
>  Priority: optional
>  Maintainer: $maintainer
> -Build-Depends: bc, kmod, cpio, bison, flex | flex:native $extra_build_depends
> +Build-Depends: bc, rsync, kmod, cpio, bison, flex | flex:native $extra_build_depends
>  Homepage: http://www.kernel.org/
>
>  Package: $packagename
> --
> 2.11.0
>


-- 
Best Regards
Masahiro Yamada
