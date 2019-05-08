Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27214C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E717C20644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXO9tnt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfEHPcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:32:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40091 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHPcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:32:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id d15so17872701ljc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efFqE71myC6MPTZmHm78nEVSWRAaBgXdAc12s1W2kpY=;
        b=LXO9tnt2EM8URsuamNbGdiqdKaqqaX/EpEG+nAamEYMCftm2Ko15oGNlcXP2FvQfIz
         xc+/kenQh49yDjNpKW59niPBWwoFBTMji4QvNiAsG4V+f9HOLvVaDHn2SjK8QO4EhZng
         ePQJjVBXqsSwbIBAyH97xSqAqSnN+qXGTsGgi+F8d3ZMz405ZgorNJNn2t+/ROsOcbcd
         rtthFj9moXY4naveRVbIms2SlyaHdA/MW0kKU+TRbdARhJyyHDSk5RcuoNWGnin5OdIG
         +mJkt3kr++vcUDaMvmWmddg2JQZk+xfeXRIjf2hPISJ5YcIc0w4k6KmjxtYrt/9YRGNU
         gIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efFqE71myC6MPTZmHm78nEVSWRAaBgXdAc12s1W2kpY=;
        b=kaZWEV7k4hh6rUHO7R+z/Fjwo7933NDLzFSIN9dngahF8jAc9dy9XMasreUsNU8H+x
         Qlvy1dnfEiidcX7JGvduGzLhELxB9dGVz1hNcIVS0lkJ8Tu4rw8P4Bxw4rd46t4kS0je
         rbvdS9nWGTbVItXI+c7z4nKMxpLoPeg/qlB8lT6pNgFSvTTGKo7IXFFCKNggIFTQMgVC
         X+MQ0rSV34VrqIdyY0pzbU9sGsApsnrYBnLxxFuzjbqB/9qltOCdfywF2WU6qpvdhpMr
         Z4YlnQa393Ctg+zrAJQ6uCqA3751StxHIXAzrp/KvKyP5cTwd5R4Xcxzhe9TyY5qlhEX
         xwag==
X-Gm-Message-State: APjAAAWtoPiBpW6UTLEZ7qy/wz7NbYFWMs00MgqLwIWPvNDjGcOFk7pm
        yeLJarMnYNk/FzxbeltyzBoVevrZY/agq/mEplY=
X-Google-Smtp-Source: APXvYqxjMfOCsup4df3nANSM7MP6sd4VeE+ydPPvmQ9S/sCtRdgwZDSaWO0vlP5DDJMv6B8E6BuF2KMaxRU38Fo7veI=
X-Received: by 2002:a2e:1445:: with SMTP id 5mr1824359lju.37.1557329568904;
 Wed, 08 May 2019 08:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
 <20190508122721.7513-4-borneo.antonio@gmail.com> <73a79b49d0183468a63876b170d1318d38c78d73.camel@perches.com>
In-Reply-To: <73a79b49d0183468a63876b170d1318d38c78d73.camel@perches.com>
From:   Antonio Borneo <borneo.antonio@gmail.com>
Date:   Wed, 8 May 2019 17:32:28 +0200
Message-ID: <CAAj6DX3LahQK_t0paVzcTfTsavANXnatgc_vX_1VLPJ9RhsdHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] checkpatch: replace magic value for TAB size
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 4:52 PM Joe Perches <joe@perches.com> wrote:
...
> > In these cases the script will be probably modified and adapted,
> > so there is no need (at least for the moment) to expose this
> > setting on the script's command line.
>
> Disagree.  Probably getter to add a --tabsize=<foo> option now.

Ok, will send a V2 including the command line option.
Exposing TAB size, makes the option name relevant; should I keep
"--tabsize" or is "--tab-stop" more appropriate?

Antonio
