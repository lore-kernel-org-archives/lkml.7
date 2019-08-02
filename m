Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E9C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0731A20665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XAkH79ZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391983AbfHBK06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:26:58 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:23838 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391850AbfHBK06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:26:58 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x72AQhkk008319
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 19:26:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x72AQhkk008319
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564741604;
        bh=NrHyJz9sbwjlQ1G/JXCwnU1HYur+bFR25j0mgCLdHEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XAkH79ZRsQcJMD/IfPs8cHF9TExY8tCZuhHtBxu1eNrQ7BhVljYE0qdtpr00qqkiE
         FKdR0eZ9myWvjiNJWJMnCNQl6m0tvfgess9l1k1Su5iN3XGan2b8SggTjb8aMkSX4V
         2aA7aeIUDJAAI9oTB3Jd+i8DIutptJRYTYgeBeFOPd1w1m1pSRqt0egFKlWmmSB0gq
         yhQssUI0DGjo7qbzr+pT1nbtFc+2NwLZNpdGF2biU458dXCrdtBAcGg7FVQSfZTlgr
         7Wn2slnpQl/24OWopxnt+8UywR1xqhxSfCmYa/gD2LSEnttLOyrR997d4niZ7c8P5o
         d12ACe4R2EVuw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id 2so50925380vso.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 03:26:43 -0700 (PDT)
X-Gm-Message-State: APjAAAVaKjzPellRhdrwvhv3+A9TAYbYrVWIT0bd2b+ptOo3iJ5TRmCk
        7Dk2rQ4GluLRA8B3cacMigaBR9OcwIaPvJMs10Y=
X-Google-Smtp-Source: APXvYqzy5VHpvFY28VxdfeeBWD9xONAsmstaCpei2TFS+8LAVJMGqLNTaeMZ0VBW3s/Z7F7b6oSNIg7wctgjmc4u2V4=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr62206301vsd.215.1564741602694;
 Fri, 02 Aug 2019 03:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <9c4425f0-3428-214b-a4f2-237bbae2f495@broadcom.com>
In-Reply-To: <9c4425f0-3428-214b-a4f2-237bbae2f495@broadcom.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 2 Aug 2019 19:26:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASiEGtqwAdiDkjnhZDMU3_byW1+hFAG-y0gU6twNaymRg@mail.gmail.com>
Message-ID: <CAK7LNASiEGtqwAdiDkjnhZDMU3_byW1+hFAG-y0gU6twNaymRg@mail.gmail.com>
Subject: Re: [BUILD REGRESSION] building single .ko not working in 5.3-rc1
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 6:26 PM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> In previous kernel versions I could do:
>
> make M=net/wireless cfg80211.ko
>
> However, in 5.3-rc1 I now get:
>
> $ make M=net/wireless cfg80211.ko
> make[1]: *** No rule to make target `cfg80211.ko'.  Stop.
> make: *** [sub-make] Error 2
>
> The 'modules' target is working, but sometimes there are multiple
> modules and I only want to build just one explicitly. Can this option be
> restored?

Please test this:
https://patchwork.kernel.org/patch/11073103/


BTW,
'make M=net/wireless cfg80211.ko' still works,
but if you  build a single module in the kernel tree,

make net/wireless/cfg80211.ko

is more correct.

M= is used for external modules.




> Regards,
> Arend



-- 
Best Regards
Masahiro Yamada
