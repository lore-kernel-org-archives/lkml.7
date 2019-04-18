Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF99C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A351214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Dl98arVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbfDRJh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:37:56 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53822 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387971AbfDRJhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:37:55 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3I9bhke004493
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 18:37:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3I9bhke004493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555580264;
        bh=GvCnFzttfkpHV2W9ZV7OdJOO8DbXAej1AeNOSZh+MZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dl98arVcHxSD2O+sEzo2OyKTvoV5tr3mFl9Rsg0DBpsTUfSPLG1LboIgDz96QhSiO
         zy/cRgnkHIvMTbu3qX6MiRXjbpCYEFW8zVrEDInveE4fIJIEYtYrNXwI+k/x1HclH4
         zqGgpllY5e92BgaeeSktR9SyF/6bTF+57G+3svobKuUe09+Pl5jm5PJpscKG8EEnvG
         Mz1YbPhUt3uoWWloMoh2JAZVbNOELBs44bjj0EcQOVkVpolIMeq3U+uvsXL/B91nDt
         J8eDWQj3y98ARsVw/mD9lrcM+7b56wIeZI+g58XN+8SpyIzWCa6/sGNIOlBuWpQ2y+
         roZZeRz9E+Jhg==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id f15so803238vsk.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:37:44 -0700 (PDT)
X-Gm-Message-State: APjAAAXogbmXCknV2p5bINA/RXP6uWJdFnZrZ6OKuQ3nc7xuGNrm5Yto
        wPary52ZZoHnbpOcNl8OVJTxzrWjd/GzQb767p0=
X-Google-Smtp-Source: APXvYqzNRKPdOjCQFaktvHqD3Ra9xtRp42QikA9kmSrlbyB2+Rxwic+obZydn/sCDad5N4gKueO6Y5KqtiwQFoEPwL0=
X-Received: by 2002:a67:f105:: with SMTP id n5mr25677045vsk.181.1555580263133;
 Thu, 18 Apr 2019 02:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <1554280633-11457-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1554280633-11457-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Apr 2019 18:37:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUtor7Cxq35EUrNo0qhi8Kd9Tmfgg7mfiBg=NPtgb30g@mail.gmail.com>
Message-ID: <CAK7LNASUtor7Cxq35EUrNo0qhi8Kd9Tmfgg7mfiBg=NPtgb30g@mail.gmail.com>
Subject: Re: [PATCH] nds32: vdso: fix and clean-up Makefile
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,


On Wed, Apr 3, 2019 at 5:38 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> - $(call if_changed,...) must have FORCE as a prerequisite
>
> - vdso.lds is a generated file, so it should be prefixed with
>   $(obj)/ instead of $(src)/.
>
> - cmd_vdsosym is a one-liner rule, so the assignment with '='
>   is simpler.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Ping?


>  arch/nds32/kernel/vdso/Makefile | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/Makefile
> index e6c50a7..01a9610 100644
> --- a/arch/nds32/kernel/vdso/Makefile
> +++ b/arch/nds32/kernel/vdso/Makefile
> @@ -28,7 +28,7 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>  $(obj)/vdso.o : $(obj)/vdso.so
>
>  # Link rule for the .so file, .lds has to be first
> -$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
> +$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
>         $(call if_changed,vdsold)
>
>
> @@ -40,9 +40,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  # Generate VDSO offsets using helper script
>  gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
>  quiet_cmd_vdsosym = VDSOSYM $@
> -define cmd_vdsosym
> -       $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
> -endef
> +      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
>
>  include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>         $(call if_changed,vdsosym)
> @@ -65,7 +63,7 @@ gettimeofday.o : gettimeofday.c FORCE
>
>  # Actual build commands
>  quiet_cmd_vdsold = VDSOL   $@
> -      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
> +      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $(real-prereqs) -o $@
>  quiet_cmd_vdsoas = VDSOA   $@
>        cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
>  quiet_cmd_vdsocc = VDSOA   $@
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
