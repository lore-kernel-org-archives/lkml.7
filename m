Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25689C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03D3227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576678260;
	bh=zsfuwCHRCrYDLaYlm+uHLDocq554cIuyQOBKXebZtn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vKaypHKFIRIeEAPL4q+x3//lVmArQ136hPOscTB5gEfBg7Ji49/c+p+VH8eRsTQ/0
	 JsvbvSmL2eqI7qIoJD+c6pB/jSGs8+buYA7Y9M4Yu/Rrg6KHLdkXyvZp00YiLxs51S
	 jkt6/y8XACtjQSSg2+W3ECoT5YQUPV4NF1TJaBTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLROK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:10:59 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:49692 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfLROK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:10:58 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xBIEAaqO031760;
        Wed, 18 Dec 2019 23:10:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xBIEAaqO031760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576678237;
        bh=ZtHoWzlWv4Nggpiz4JYJ0ktQQgL8zQr082eHKmhq0sA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y8IH6ikPKkZ91TfmMDmbLnCku2cKcFxE58DmglIwpn99HQzVP0ZgoP1YHXWG4K9tq
         Mt454eRcKY4Lo4HjJxr/lsGyAEMsFxOEZgakqmzincCPM7nmXAvOfJYHzciHJE8s2e
         6//kBXRQkxo/BuWPUiPDbkFb/5/l7rF8HHWJ0T6WtfnScNDNLfCGe4MXlpbYcNuDI0
         dTOvC3rlM1AGNbPHRWJO8KHLUzGxH+oOk4YN/Bn+nPwCWsMj1Ere+y+1uy5zDupZIm
         aBjpFvxpDPxs9QFY7/Ya4O8wJhWLEBgPbxqG/9/1Tgh8PRiSacy2R7I5qzMWgXxJkN
         9HWIChs8b86sQ==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id v18so668237uaq.7;
        Wed, 18 Dec 2019 06:10:36 -0800 (PST)
X-Gm-Message-State: APjAAAUH6tqw3rjpz5c1wjBiVbmiVdGACLsouF7QC5GsNcbNkvzk5+/v
        d3eTzE9a5HM1Q9c3tmroOS+5+gUtzyYNgUMAacs=
X-Google-Smtp-Source: APXvYqw9cT8Od3W7kctCPwiC5X53fct0hh2cQ9AwQ0K101fOwa4G9Y/YaVZbIWbz6ZgR4YnRDQddC6j+idk0VSoEamk=
X-Received: by 2002:ab0:63c7:: with SMTP id i7mr1393678uap.109.1576678235726;
 Wed, 18 Dec 2019 06:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20191217135539.17157-1-info@metux.net>
In-Reply-To: <20191217135539.17157-1-info@metux.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 18 Dec 2019 23:09:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVmO3i3BVSHHLAE3p10E5+POhBn9m9HpYqG5VeR1_NAw@mail.gmail.com>
Message-ID: <CAK7LNASVmO3i3BVSHHLAE3p10E5+POhBn9m9HpYqG5VeR1_NAw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: package: mkdebian: add missing rsync dependency
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:56 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> We've missed the dependency to rsync, so build fails on
> minimal containers.
>
> Fixes: 59b2bd05f5f4 ("kbuild: add 'headers' target to build up uapi headers in usr/include")
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---

Applied to linux-kbuild .Thanks.

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
