Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D69DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A8120840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="h504ubAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCGGVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:21:21 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:36155 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfCGGVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:21:20 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x276L6VP006382;
        Thu, 7 Mar 2019 15:21:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x276L6VP006382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551939667;
        bh=SaUbJPh35qMvtSO6x2YO2POLAGTOEJasBh6a7GbBbFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h504ubAIdv5q+bexaAro8Zasphs312uZGsYEK5QH5Y9sTXDqlbBnVCdJWXek4Z52V
         boanLJ8+m2JqP1MTXfwFJ4WodrjMOV7yGXvX85FFlbw8oWLq8pzR0FTIRlKqTaOqXE
         MMkWeELS8VFlNVZMVilTrd7h7XK8YFfxIrOTv4hRU2+g2KsHe6Q1hTYlRBDFHmvOPN
         TbpOgRyDoFBlwB8IfxxcklrNZbxEu9YdhNwlEQcbMlqK8+W+MKFv07bfIOFI8k6CHT
         1YS9e656SG7047Qeu5yOwRxudn5gxKdxKwi/Xyb4rZ+EOx4cUTyU/hDj4l+IOIZ6Qm
         XO2i6uUGzF9RA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id y19so3801451vsc.4;
        Wed, 06 Mar 2019 22:21:06 -0800 (PST)
X-Gm-Message-State: APjAAAWoV2hWQrRb+QeSzVqzEGneQN9dOK7f0PCHZuQJbj5hlec7AFD9
        7CtvNy8l+9XQp+/aabIgHWhMIVe0iN+g8crklGU=
X-Google-Smtp-Source: APXvYqz1e98KiFgs0RZBo0YrVdYoTZLWlcYxXKnEQe4XzfTRKiImYg9Y3RPXmuf1p7KK1jEyWieI08FhkDfCtATg4EY=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr6078880vsc.155.1551939665685;
 Wed, 06 Mar 2019 22:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20190207123022.7961-1-2pi@mok.nu> <CAK7LNAQZ7PDZ4+uZu-FT4V8yw9oUGz6e++9xSshWJvALj3gN0Q@mail.gmail.com>
 <20190219200837.d34cxg2d7gqxlvhs@mok.nu> <CAK7LNASU=Jf7aYnnn_7DWgxLz4sf4=x1HZaoGQW2rSXVbFO9Bg@mail.gmail.com>
 <20190223195749.7yswuedfv4qbiyik@mok.nu> <20190307060926.GE44339@wrath> <20190307061700.GF44339@wrath>
In-Reply-To: <20190307061700.GF44339@wrath>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 7 Mar 2019 15:20:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWzKNPFDa8GEWHkGVc6zT+iJo2RCdzg5OysnqwwWJzog@mail.gmail.com>
Message-ID: <CAK7LNAQWzKNPFDa8GEWHkGVc6zT+iJo2RCdzg5OysnqwwWJzog@mail.gmail.com>
Subject: Re: [PATCH] modpost: file2alias: define size of alias
To:     Darren Hart <dvhart@infradead.org>
Cc:     Mattias Jacobsson <2pi@mok.nu>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren,


On Thu, Mar 7, 2019 at 3:17 PM Darren Hart <dvhart@infradead.org> wrote:
>
> On Wed, Mar 06, 2019 at 10:09:26PM -0800, Darren Hart wrote:
> > On Sat, Feb 23, 2019 at 08:57:50PM +0100, Mattias Jacobsson wrote:
> > > On 2019-02-20, Masahiro Yamada wrote:
> >
> > > > > > If you want all the patches to go through x86 platform-driver tree,
> > > > > > I am fine with that too.
> > > > >
> > > > > I don't mind either way, however I've asked the x86 platform-driver
> > > > > maintainers if they have a preference in this matter. You should have
> > > > > received that mail otherwise see [1].
> > > > >
> > > > > [1]: https://lkml.kernel.org/r/082d3d38b7dde6050b6b3e518ada439eade65b2c.1550603967.git.2pi@mok.nu
> > > >
> > > >
> > > > I saw it.  The 2/8 uses ALIAS_SIZE.
> > > >
> > > > So, I think it will be better to include this one in your series.
> > > > If necessary, please feel free to add
> > > >
> > > > Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > >
> > >
> > > Okey, will do. Thanks!
> >
> >
> > Agree, I'll pull it in.
>
> Masahiro, may I include your Acked-by on the 2/8 patch as well?


Sure.  Please go ahead.




> platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
>
> --
> Darren Hart
> VMware Open Source Technology Center



-- 
Best Regards
Masahiro Yamada
