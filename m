Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49279C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1774020679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="s2sbP698"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfHLPmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:42:07 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:55794 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLPmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:42:06 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x7CFfuYK031604;
        Tue, 13 Aug 2019 00:41:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x7CFfuYK031604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565624517;
        bh=xqHdXxdJ6PpxUGE19Z5I8gZYC03sN81+SNVOX9WunLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s2sbP698KVZjpkMdu+7kK70Sn1Rqv8epPpoFREIaRVFyqUe0c2NyKI70vDYQwO2us
         bxjrjb9DLuljQgrP5YcLGnDmXkhHtixAARtyUiIWjMdflAPqKHMOUoa33lhnlw64Vo
         ZBhFSH8/c+HANrbyu7xlabkn/mKYcV/7udrVGVllBXnTXYEr02JVlGUKWYwdHYkXFC
         4XExguFbbjFT4uG4aJu0WqU/k4bH1Tf4XJj5GDtVXTg9tqWxSRhx8f+OajVBF8gwtd
         yMcLO9UjDOPFeGe9D0O73gDi5VdsfH/AodMFiK7Xvyl/vaPmIpN5fG9CDgRJ2wLVIH
         I43hO72t1RaJg==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id c7so2426496vse.11;
        Mon, 12 Aug 2019 08:41:57 -0700 (PDT)
X-Gm-Message-State: APjAAAUZelj76bPNthSi9BCgIToV5mOXuC8lknn+w8QQ8OSJovGB6pLZ
        HAN7793gde0XmhhR3XvTEIwDPvIU6aNkHq52FXY=
X-Google-Smtp-Source: APXvYqytSUiGQcS2gin7TbDYNo9UYz+qDVE/MiFNs/W15KPy8rSuXUdEXsLePT/n974yfEL4sAdwjb2qsj8wwf9nRUI=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr21454837vsd.215.1565624516047;
 Mon, 12 Aug 2019 08:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190810075226.GA24085@lst.de>
In-Reply-To: <20190810075226.GA24085@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 13 Aug 2019 00:41:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfQWNMMLS1-3mE41Ffy3MV9i3VpbWtmKQdUqZjyk8Yqg@mail.gmail.com>
Message-ID: <CAK7LNAQfQWNMMLS1-3mE41Ffy3MV9i3VpbWtmKQdUqZjyk8Yqg@mail.gmail.com>
Subject: Re: can we use mandatory-y for non-uapi headers?
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,


On Sat, Aug 10, 2019 at 4:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Masahiro,
>
> what is the reason that the documentation says mandatory-y should only
> be used for uapi headers?

Where is it documented?

Documentation/kbuild/makefiles.rst section 7.4 describes
mandatory-y is essentially used by include/(uapi/)asm-generic/Kbuild

include/(uapi/)asm-generic/Kbuild means:

include/uapi/asm-generic/Kbuild
include/asm-generic/Kbuild




-- 
Best Regards
Masahiro Yamada
