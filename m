Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53805C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CDB20842
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wlCXz96P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393720AbfIGCPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 22:15:35 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:19693 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732445AbfIGCPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 22:15:34 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x872FGVD027947
        for <linux-kernel@vger.kernel.org>; Sat, 7 Sep 2019 11:15:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x872FGVD027947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567822517;
        bh=nuq0HAmBDFXooLNLzl7SJHQtZrnXNqCd5Q1OJYGkr20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wlCXz96PqicMIU02gSTkxZoawNPQZ9fvlE38/ui6fsxmsqZ6pVTdSS6YPMCSa16h+
         k6a4TIjUsh3ws9Joa8dejUtbzlz7YBdX8Gm8s3oOeVWImnLss9QYN128CDBkEWKBJu
         qHiP4b+jBSZ1WninM857eLwZ7WFZC1mgYmJDXuYWNHvOEh7NsrSCKVc8krjEauvON6
         Ii12Mlc8dGGH695Izki8rQIC9B9jAWoK81X1Zzn9fxsqrOyXdOKOAoEn7X/aunFKfF
         C4WFuQaHMLcQRVNffki/m9779aOM+ibSTkNAaK9G15Y3H/Umbng/V857bUqQrx8fxX
         wBuYbpubW7BNA==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id 70so795829vkz.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 19:15:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWidldSeLJlF43EEzMrBVVsw0BlfoLtVn1rzvZ2X2/w4XedfSC/
        dyDWWpg9A2MwJqyO111xvX9g6GWN4fCA4ZK2ZL8=
X-Google-Smtp-Source: APXvYqySpYdYSA+j3WmaAn6MslI3DJw6uIC3I6H42O2iHd+GetphhuJwWJCV6zcrAc46Z/ahcutWBOO4MmosqL6aaTQ=
X-Received: by 2002:a1f:294a:: with SMTP id p71mr6166358vkp.74.1567822515710;
 Fri, 06 Sep 2019 19:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190906153700.2061625-1-arnd@arndb.de> <5ce4f4c7-f764-8937-75bf-83a4d4c57fa7@linux.com>
 <CAK8P3a1_m4R2Qz9A+B22vju_W3j8X1VbUrJT+Pnmfync8SoEQg@mail.gmail.com>
In-Reply-To: <CAK8P3a1_m4R2Qz9A+B22vju_W3j8X1VbUrJT+Pnmfync8SoEQg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 7 Sep 2019 11:14:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT7PZhW43LvJXotME3-QcKWEHDGvwU66agTdGCD+8H=bA@mail.gmail.com>
Message-ID: <CAK7LNAT7PZhW43LvJXotME3-QcKWEHDGvwU66agTdGCD+8H=bA@mail.gmail.com>
Subject: Re: [PATCH] lz4: make LZ4HC_setExternalDict as non-static
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Denis Efremov <efremov@linux.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 3:43 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 6, 2019 at 6:21 PM Denis Efremov <efremov@linux.com> wrote:
> >
> > Hi,
> >
> > > kbuild warns for exported static symbols. This one seems to
> > > be meant as an external API but does not have any in-kernel
> > > users:
> > >
> > > WARNING: "LZ4HC_setExternalDict" [vmlinux] is a static EXPORT_SYMBOL
> > >
> > > I suppose the function should not just get removed since it would
> > > be nice to stay close to the upstream version of lz4hc, so just
> > > make it global.

When you make the symbol global, you need to
provide a prototype declaration in a global header.
(include/linux/lz4.h in this case)

Otherwise, nobody cannot call this function anyway.

I prefer Denis's fix-up.




> > I'm not sure what is better here. But just in case, I sent a different
> > patch that removes EXPORT_SYMBOL from this function some time ago:
> > https://lkml.org/lkml/2019/7/8/842
> >
> > I checked first that this functions is indeed static in the original lib[1]
> > and this symbol is not used in kernel.
> >
> > [1] https://github.com/lz4/lz4/blob/dev/lib/lz4hc.c#L1054
>
> Ah, good. Your patch is the better fix then.
>
>       Arnd



-- 
Best Regards
Masahiro Yamada
