Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DADC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C50520693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406087AbfIFSn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:43:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39147 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbfIFSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:43:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so8205807qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 11:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkS2XXCTwZb6YCGTw5O8BPXzmTufdtb9zrUqg8FXBEs=;
        b=XV2XZDQ8uEWM9GVBd8KC++b7cPC73XjFMgzAdTPqOTvuHH7LTkOGAn1mcRus0yZN1e
         5aefbbsOJkyD/HpZ7KY1s32jb9kapi5G8HcPrg4g8+SZMUwLiYKFwbGzyYF1TIL+POXc
         De8TL06hvoawHMyV9OENSr6bBDg7VS5gVocm/aOqG5wxWPEpfKX9QVUPViQQTnGKNu9g
         oZGXSNH7YcwsbxEjZAX4YAWygr4JHPTMSePbq1ZDBljpz+Ljl6hz4Ra7rGMayxV43NYV
         WDCfe3FwsBFYtw64Ketre9lYUr7WCNUbfziMUZaJwSiIFyWbIdG/C3Fy/j0PeFOlzR3G
         e4Tg==
X-Gm-Message-State: APjAAAUnhNRK9/hHlxm7H3aepHbTiTbjC3WFGAP95EeYmrMF5LuW5+nT
        GNzstkKUvUrIVjyiIWUQm8Q0mJMTlupzdbDtRzc=
X-Google-Smtp-Source: APXvYqzeM5sPyXVSJByhX9sewUEoecwMbHXmfzgZuNlYhYf52qE9yKwrupNhlJQ7WsFT6aNkw1+BHT4NIhTABRAe3XA=
X-Received: by 2002:aed:2842:: with SMTP id r60mr10515562qtd.142.1567795404696;
 Fri, 06 Sep 2019 11:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190906153700.2061625-1-arnd@arndb.de> <5ce4f4c7-f764-8937-75bf-83a4d4c57fa7@linux.com>
In-Reply-To: <5ce4f4c7-f764-8937-75bf-83a4d4c57fa7@linux.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 20:43:08 +0200
Message-ID: <CAK8P3a1_m4R2Qz9A+B22vju_W3j8X1VbUrJT+Pnmfync8SoEQg@mail.gmail.com>
Subject: Re: [PATCH] lz4: make LZ4HC_setExternalDict as non-static
To:     Denis Efremov <efremov@linux.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 6:21 PM Denis Efremov <efremov@linux.com> wrote:
>
> Hi,
>
> > kbuild warns for exported static symbols. This one seems to
> > be meant as an external API but does not have any in-kernel
> > users:
> >
> > WARNING: "LZ4HC_setExternalDict" [vmlinux] is a static EXPORT_SYMBOL
> >
> > I suppose the function should not just get removed since it would
> > be nice to stay close to the upstream version of lz4hc, so just
> > make it global.
>
> I'm not sure what is better here. But just in case, I sent a different
> patch that removes EXPORT_SYMBOL from this function some time ago:
> https://lkml.org/lkml/2019/7/8/842
>
> I checked first that this functions is indeed static in the original lib[1]
> and this symbol is not used in kernel.
>
> [1] https://github.com/lz4/lz4/blob/dev/lib/lz4hc.c#L1054

Ah, good. Your patch is the better fix then.

      Arnd
