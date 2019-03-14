Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AFE2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCNHJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:09:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37716 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCNHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:09:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id c1so2723309qkk.4;
        Thu, 14 Mar 2019 00:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylbZhfh01+ptaJ2NnOqi52uz/oBhzGF4rEBIY/Lwhso=;
        b=uoXb6kpYMdNEbsm8HWl/IVB3uNtTr8dgCnw/t29Wqw/aNtoUgpq0k0qZSNsMiJRAg1
         MTII5Tf54YLWjTTvUnZJ7UpmN+PtKr+Wu9lddIVQhuLNhDEDvN+xvg7uhT3KhEu14ca7
         /A68ksy1mWBIoT2M2l9gfVwDmhx0Y4DKtSUFEHLUIE9ZvlEMsj4ek86I8ty7V5gvBJJI
         YxwiONYKLr0+pmh6gJ/ztm7BeuZq8QeTCTfk0LL+WaKoABSCamRyoKCZOx3hfDFyu8v/
         szZ1sMzitohXu3h5amMEUJqEVGGBNC9y3mDaAVut64iQp/vCot3ygP7MQBQQ6jUS/6fB
         P7qQ==
X-Gm-Message-State: APjAAAWrJlhhEiTHwhNm4qeT0ZTpVD9fN60MOYLBQY8/tQ7Cgj3jIbKU
        QoHCRZktMU8Arp7bZScEMSTD9PvzZq0oOI0HtXhu4g==
X-Google-Smtp-Source: APXvYqzo0jx2j2eE2eF64jL7YCNMclh3Jf42s8Y3aSnFT8yeBcpU+Q29+SJTeQ7UmiXrPHCrwSAsvJrK1vE0h1Vinus=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr34367191qkf.107.1552547363565;
 Thu, 14 Mar 2019 00:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190305132147.3739133-1-arnd@arndb.de> <20190305143453.GC8256@zn.tnic>
 <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com>
 <20190306175808.GA30016@agluck-desk> <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
 <20190313230137.GA12529@agluck-desk>
In-Reply-To: <20190313230137.GA12529@agluck-desk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Mar 2019 08:09:06 +0100
Message-ID: <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 12:01 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Wed, Mar 06, 2019 at 09:15:13PM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 6, 2019 at 6:58 PM Luck, Tony <tony.luck@intel.com> wrote:
> > > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > >
> > > This seems cleaner than adding all the EXPORTs to skx_common.c
> > > I also tried a build with the 0x8A152468-config.gz that Arnd
> > > supplied.
> >
> > It's still a bit fragile since you do something that kbuild doesn't
> > expect with having a file in both a module and built-in code
> > in some configurations. I'm fairly sure this version works today,
> > but it would break the next time that file gets changed to include
> > a reference to THIS_MODULE, or anything else that is different
> > between built-in and modular code.
> >
> > Another alternative would be to mark all symbols in this file
> > 'static' and then include skx_common.c from the other two files.
> > Of course that is also ugly and it increases the overall code size,
> > so I don't see a way to win this.
>
> Boris,
>
> So where should we go. Proposed solutions are piling up:
>
> 1) Make skx_common a module
>         [downside: have to EXPORT everything in it]
> 2) Move module-ish bits out of skx_common
>         [downside: perhaps fragile]
> 3) #include skx_common.c into {skx,i10nm}_edac.c
>         [downside: no patch yet, bigger code size]

Sorry to add on to the already long list, but one more idea after
looking at the two files:

4) Have a single driver module, with the skx_common.c containing
    the top-level module_init/module_exit functions that call into the
    hardware specific versions.

This is the opposite of the usual recommendation (the driver
is already structured nicely otherwise), but it would be cheap
way out here.

      Arnd
