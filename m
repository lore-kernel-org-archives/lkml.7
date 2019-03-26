Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDD92084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPaErm2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfCZRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:41:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45557 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZRlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:41:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id e5so12252225otk.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13g8DOyZDfMxmWogI9dENc8mQIBbIGzhWqp70P2HsrU=;
        b=KPaErm2MV8OaGrMvyRRYAtuGBQja+veykRvl75T77WgEbywAgnsLzgUSYX8YBncc/L
         nvFvLPwurHACBJPiYZGCpvqxXLcNscN5HrXxrH0IIi6EbeI/wkU7En5pNLH11dzJqbTA
         eqit7SAFazqQVNPC2B5Hes2fYnIiaqrcgjtXAJ86IjNPNdztcxZwzC4T45cR2VkdyKlT
         o2EDaKftDBxtd6QOAcpsR1LBdOM2Lb4/jxMZM8yxgut8Gko8S9eZlnm8Smtb6rGarpuu
         oo9V3MKAaUxGACT/25uXS6rUYUDsesT2loKDO+pnns3NokykBZJGQJuedA2NYNBY7EsO
         Gd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13g8DOyZDfMxmWogI9dENc8mQIBbIGzhWqp70P2HsrU=;
        b=fGKLIuj44ajYSvStiLHgHMHrwcvQizz1J/9+3QtvXQbUmCC81gKJn3IvYc0SChHtTA
         4OmNlLBnvgLNJRNxBCgzVz1MpDLl3Nj6afbQMbkv3SAzFrURd4/ZO0ZenLgreuQZlpX8
         593DjIx1hyrpESJMbfwxMFfMszrhfoNYdVtJ5uh3Kg+QWKPemWpeT2LPZRKSxuVS50nu
         ya17Lv8AR5/VXE0r1fgTZwNWb6wfEO6b0LPT4Mu4ofZxAqIdBv0RQqKPFGJO3i8uv0DK
         hsraFnjAbPLAp0DelgfUoodnSS3aRGWJvkcoD4lEt/pTVr4jBegyA/Bpm3G03yrx2FeK
         rLoA==
X-Gm-Message-State: APjAAAXwBfdVRnDiydTxZMiUyv66JxSVK6rZaUxxfMyg/FLAG4PfJ72y
        MiS9vRPCr2mVHB127AfuQD4SukIF5oupdJwNpnZe3Q==
X-Google-Smtp-Source: APXvYqxxAlv2H+DzRqn070vzVwlaxgPJ4k/57vrfDwq3XWpnWqopr0qXXQ8rJ0mG3fcA8w5+OwCGgliBaBo7voRTqh8=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr22065819oth.83.1553622114149;
 Tue, 26 Mar 2019 10:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212446.25795-1-joe@perches.com> <CAP6Zq1g62wiDTd9zn5dhwsfK6Rr52+ishU_=cO+G0Rm3Cs7kbQ@mail.gmail.com>
In-Reply-To: <CAP6Zq1g62wiDTd9zn5dhwsfK6Rr52+ishU_=cO+G0Rm3Cs7kbQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 26 Mar 2019 10:41:42 -0700
Message-ID: <CAFd5g47LVZ6xtfcAx4GDO-bg1QsovMauiBqUHOk6JPT4fNPTqg@mail.gmail.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'ARM/NUVOTON NPCM ARCHITECTURE'
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 5:11 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Joe,
>
> Thanks for sending the notice.
>
> We will send a fix this week.
>
> Tomer
>
> On Mon, 25 Mar 2019 at 23:24, Joe Perches <joe@perches.com> wrote:
>>
>> A file pattern line in this section of the MAINTAINERS file in linux-next
>> does not have a match in the linux source files.

Hi Tomer,

Just thought I mentioned that I posted a fix here[1] sometime ago. The
patch should still apply cleanly.

On a side note, it would probably good to send a follow up patch that
removes me as a reviewer, and adds Benjamin Fair (CC'ed) as a
reviewer.

Cheers

[1] https://www.spinics.net/lists/kernel/msg2925741.html
