Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0560FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04AD20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bV4WjPqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfCSEKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 00:10:44 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:29879 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCSEKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 00:10:44 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2J4AJOB030423;
        Tue, 19 Mar 2019 13:10:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2J4AJOB030423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552968620;
        bh=gNnwu/3W48uO8s1Quq1TU41bjR7ljkGf3JPs+BgQTN0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bV4WjPqskWle9aCbuKA6ZSh2HN6gnpU8bz+5rpiVe79RWJ1c1BPbxLMPyEkrQRqoU
         qwAGr/hxqVk/pzx6WpCh10ArJHfzJ4nIVjnBaRTA262aJQNtuQx0oVBkD4WMPunzIy
         3xdQklcbiPboKGeFwFcT4S/JTG2KXeV/PZJwmCn7fNReoc9+1svQ2BbXOKHGwH/AiH
         dggH4gtkwwxi5wZVQHMzJgLu+AgKoGeq17839svMOg+FCwsLwJVWWElNiAVjV+yE5U
         FTWgbOp8yMzPIho1fZ6E2I6VznL2KLTyOapcuTrtYb1AQod4EiRJMCkNUUWkEA0RLL
         1YlA/xjsd9PpQ==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id l17so4323401vke.7;
        Mon, 18 Mar 2019 21:10:20 -0700 (PDT)
X-Gm-Message-State: APjAAAWLNfgcoAh6W5aFRXxpZg2xYM9l/cDJB4+QFX3jwfZH0vhI2kYU
        ENSKgd+hqtn6fyPMFhR57fNeL4gfIJoPNB2+AZo=
X-Google-Smtp-Source: APXvYqyb1AMEueEtk0/j4E5A9lA2dHVv5+4a3tgSxiVbnVuYe+k1oLbHr7CX/wJ0GMC1WClCMPy4UihDM+SlZ5ppswM=
X-Received: by 2002:a1f:ae07:: with SMTP id x7mr213404vke.74.1552968619307;
 Mon, 18 Mar 2019 21:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <1552036419-924-1-git-send-email-yamada.masahiro@socionext.com> <mvm7ecwqz87.fsf@suse.de>
In-Reply-To: <mvm7ecwqz87.fsf@suse.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Mar 2019 13:09:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKGYm0fO1BR83RdCWtxNj4dWBAVAw-JHXxCrRON986kw@mail.gmail.com>
Message-ID: <CAK7LNARKGYm0fO1BR83RdCWtxNj4dWBAVAw-JHXxCrRON986kw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add workaround for Debian make-kpkg
To:     Andreas Schwab <schwab@suse.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Manoj Srivastava <srivasta@debian.org>,
        Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Manoj Srivastava <manoj.srivastava.1962@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, Mar 18, 2019 at 7:00 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 08 2019, Masahiro Yamada <yamada.masahiro@socionext.com> wrot=
e:
>
> > +$(warning Do not include top Makefile of Linux Kernel)
>
> So how do I add additional targets then?  Currently I create
> GNUmakefile, include Makefile, then add the targets I need.  It seems
> this is now broken.


---------(GNUmakefile BEGIN)-----------
your-own-target1:
        echo hello

your-own-target2:
        echo world

# For the rest, fall back to the kernel Makefile
%:
        $(MAKE) -f Makefile $@
---------(GNUmakefile END)-----------



Having said that, my previous cheesy workaround sucks.

How about this patch?
https://patchwork.kernel.org/patch/10858809/

I hope you will be able to wrap the top Makefile again.



--=20
Best Regards
Masahiro Yamada
