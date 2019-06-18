Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D624C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4365214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sP36Vf18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfFRPqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:46:17 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:16687 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfFRPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:46:17 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x5IFjwqD023285;
        Wed, 19 Jun 2019 00:45:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x5IFjwqD023285
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560872759;
        bh=V7giHAbZPfYoFBM3Xyv/F80mdpvKFs40bUrQhe8IQiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sP36Vf18fQIZb+CVM+0DxsStrkaqNzND7HtInHkU+Q2BA5OYh46dvuxHr63rCKMOH
         lVl8Kfss9AiCeqFavDOa2M051ApZu6T+NJl1+lHMr5inbBBrctzYW2mJOQSctC48fV
         51Iy54M9ID5y4/s7L1b79XqWkHRTvUTIKc61ama0rW0fDyVX/E6jWMU2h0UW/vFO+J
         +f2UqVa7loeI4LMpfftTkoJkA5xuUd91+JyMggTxJdG1dj8mTsVJ77tNWVK6PMkBbO
         hBcCJft3ICjy3UZzg3PISc+KqnkfWqesi5Sd8Pfh6K2e1qOGbelUFRNlursEEaOrtu
         8QFXqYUyMYVyA==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id z13so6471184uaa.4;
        Tue, 18 Jun 2019 08:45:59 -0700 (PDT)
X-Gm-Message-State: APjAAAWIOR2Nbw/NkMB+7Ajny2ENOBey28XY1sjt0gLQxqK3HWSEXRI1
        k8uqG6y1m2Ua1KWgnHyjSW4AgHPfHP/a3kDZADs=
X-Google-Smtp-Source: APXvYqw4h9EJR1bQClc9HUF3me4qk8yVmsh87N3K55z5XrgXNEmDqKStsUDcH08GwctN1lomxK3OyhN8wzXgoeuROS4=
X-Received: by 2002:a67:7fcc:: with SMTP id a195mr44481110vsd.181.1560872758279;
 Tue, 18 Jun 2019 08:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190604101409.2078-14-yamada.masahiro@socionext.com>
 <20190604124248.5564-1-jani.nikula@intel.com> <20190604172553.GA2383@ravnborg.org>
In-Reply-To: <20190604172553.GA2383@ravnborg.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Jun 2019 00:45:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_FxSK=TBvcmKsGEK2jB+rGE7uLqjaNYmKBsCPp8X0Gg@mail.gmail.com>
Message-ID: <CAK7LNAQ_FxSK=TBvcmKsGEK2jB+rGE7uLqjaNYmKBsCPp8X0Gg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add support for ensuring headers are self-contained
To:     Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Michal Marek <michal.lkml@markovi.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 2:26 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Tue, Jun 04, 2019 at 03:42:48PM +0300, Jani Nikula wrote:
> > Sometimes it's useful to be able to explicitly ensure certain headers
> > remain self-contained, i.e. that they are compilable as standalone
> > units, by including and/or forward declaring everything they depend on.
> >
> > Add special target header-test-y where individual Makefiles can add
> > headers to be tested if CONFIG_HEADER_TEST is enabled. This will
> > generate a dummy C file per header that gets built as part of extra-y.
> >
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Looks good, thanks.
>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>

Applied to linux-kbuild.
Thanks.


-- 
Best Regards
Masahiro Yamada
