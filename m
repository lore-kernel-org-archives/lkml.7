Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EA8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A962087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Jbr9GUCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfCKQUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:20:11 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:40533 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKQUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:20:11 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2BGK473001869;
        Tue, 12 Mar 2019 01:20:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2BGK473001869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552321205;
        bh=J2EdVSMmdVb73H7hclqhuXeBYWCnyXXRAAl39GsBCyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jbr9GUCrbDqCMDuTMdRmqH0KTMCkskLwi9Ya5m0mLdFbZo2Oub59T6hLLURA1oqK8
         6FbHfQGBHqScjvs7XBenKXupoH0427lazeYw51SfIgWrvJbrjHCi0FXCKn7KSPRNAl
         IQmmmkiqLR9zVE+rbT08sjcRRVKTn6pcrqQgxBc3zlBaHkTAzivb7dpYiH4liIDFum
         0dkOvqrtoN44sToT7hmb7lBlr2Ny2QKAaGPkbnEhFoO2wke2FIKVospdOS3SeM3rbF
         uG596JuI48+HixMgOCu+9mWLnbzWBPvRaG+JjRFjbG9FAAb7ZrUVc7rrJYyyKYcyOQ
         DS6aFdDvB4x6w==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id b17so3060619vsr.13;
        Mon, 11 Mar 2019 09:20:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWw+O5Z2AItegNRCWRIVpFxz1OCbaIc2GVBP8vi9mMJW+qaRYdn
        uEvMTimM75YQ1ukHg9Ebnq8CfGzneFlAUobjrVY=
X-Google-Smtp-Source: APXvYqy8Hp4yuoC9tjYEKoLSVSOg7YGAF2RZugJBbadOrjo58qsbNZdSq7uwdIITP/hALlq2dVQK6TEwY+Gy/AD3IAw=
X-Received: by 2002:a67:7bd3:: with SMTP id w202mr17253529vsc.179.1552321203680;
 Mon, 11 Mar 2019 09:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <1552049064-32044-1-git-send-email-info@metux.net>
In-Reply-To: <1552049064-32044-1-git-send-email-info@metux.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 01:19:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUc3CQXDKogH0MVWCbWatQK0-0PRrG5QbOaz+bb_rMsA@mail.gmail.com>
Message-ID: <CAK7LNARUc3CQXDKogH0MVWCbWatQK0-0PRrG5QbOaz+bb_rMsA@mail.gmail.com>
Subject: Re: Debian build polishing
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Robo Bot <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC more debian folks)


On Fri, Mar 8, 2019 at 9:45 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Hi folks,
>
>
> here're some patches for polishing up the Debian packaging stuff,
> so it can be directly used w/ usual Debian machinery like
> pbuilder, git-buildpackage, dck-buildpackage, etc.
>
> These expect debian/rules to exist in the unpacked/patched tree
> and drive the whole build. Currently 'make deb-pkg' does it in
> the opposite direction - it creates debian/rules and fills in
> some data, that's derived from .config etc.
>
> My goal is building the kernel package in exactly the same way as
> any other Debian package - so there must be a debian/rules as the
> primary entry point. To do that, w/ minimal change and w/o breaking
> the existing machinery, I'm going in several steps:
>
> #1: add Makefile rules for retrieving missing makefile-internal
>     variables kernel config system .config (eg. kernel arch).
>
>     this could be used for other build systems, too.
>     just call: `make kernelarch` or `make kernellocalversion`
>
> #2: add an env variable for changing the name of the rules file
>     generated by mkdebian. When coming from an existing rules
>     file, we can prevent this from being overwritten.
>
> #3: add a generic debian/rules file, that calls mkdebian to
>     create the remaining debian control files (w/ rules redirected
>     into nirvana)
>
> The existing `make deb-pkg` is bypassed and remains ontouched.
>
> One point still puzzling me: once the debian/rules is applied and
> somebody calls `make deb-pkg`, he'll end up w/ unclean tree, as
> now a git-tracked file is changed.


Then, setlocalversion will set -dirty flag.

Committing debian/rules looks questionable to me.


> Perhaps I just change deb-pkg to call debian/rules then, but I'd
> like to hear your oppinions about this, before.
>
>
> What do you think about that ?
>
>
> --mtx
>
>


-- 
Best Regards
Masahiro Yamada
