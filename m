Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55E6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62BC20717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576473157;
	bh=2kKwAdsBDSWZcgMl5S+Mj5/RItgzvVhvm4Gw1vNn228=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TL5TtQuMdv0OLvabnr6Yu3ZDlA8pJS7xlAddUYKAmLRswuJ8oJdT4Fagb1DF2APxy
	 d9HerV1lQmZlthTHcHuq1MzFiwG4/0Hk9H76DxnCxE/qBdqP9wd2FNtgxJgSUiiwJJ
	 WExCiskMw6gIJ7qwmAObL6yIzaCvU8FZTwueRl7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfLPFMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 00:12:36 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:24252 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfLPFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 00:12:36 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xBG5C6aW012876
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:12:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xBG5C6aW012876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576473127;
        bh=yl6Tz4iO7J/vuzlRNXbKAf8n5lJta1BrJoOL2Yhb/lc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WSelY+agzLCPGstUxCyswuQBlLJ5nWMDcqfZmmy8yP/C8t9s2dfcPcstGH7XrM2A5
         6yRs9ljk7i9RsDVdQWYjokTcV50nwq+g7egi3SMKhqwL2axwtGmt5Y6SuVa/EYne0S
         7e/vjHOSwiktwuzzjo0vUtm2FCcy3JTdM0i51GtkPOQiyCTwCzOmimGFfozG44FP1A
         khRGCH9JCOA2GNQi/qq1+cz68ytuXfKKgWB4bWoWx3z36PKMF0pVzu+8Ki7CGwtTc1
         kN8vlEr75Ol/+BN1AK+nmfm6NvokOtaw6gK5Jw9dswwTYXy49bAOyDge5DLbcjFqa4
         cDeyX9r6yShUA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id l6so1155886uap.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 21:12:07 -0800 (PST)
X-Gm-Message-State: APjAAAXav7YLD8ofqiVNeUC3KnAWsrMiDMsVSIZAoliMN3fSkVtLc3Xy
        HJFLnzwnCgCUZ60lq7otvXWyCAayGgpjaHrM5K8=
X-Google-Smtp-Source: APXvYqzmS8HvVVi2szRpojYPExgKEgQC4CYMj/OMvKX7/eqofqDgaetGfg1gTZeShMOfxEkMsuiLsmBLQF4Yg5Pp2kI=
X-Received: by 2002:ab0:2814:: with SMTP id w20mr21472074uap.95.1576473126199;
 Sun, 15 Dec 2019 21:12:06 -0800 (PST)
MIME-Version: 1.0
References: <392d86d2-76a4-03d2-5517-3c22bcf3e535@lwfinger.net>
In-Reply-To: <392d86d2-76a4-03d2-5517-3c22bcf3e535@lwfinger.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 16 Dec 2019 14:11:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUhrC92HM7DVBVUbPVpS9Q_svb-h6EZ496fpr5JFdPdg@mail.gmail.com>
Message-ID: <CAK7LNARUhrC92HM7DVBVUbPVpS9Q_svb-h6EZ496fpr5JFdPdg@mail.gmail.com>
Subject: Re: VirtualBox module build breakage since commit 39808e451fdf
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Dec 16, 2019 at 11:48 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> Hi,
>
> Since commit 39808e451fdf ("kbuild: do not read
> $(KBUILD_EXTMOD)/Module.symvers"), some of the modules for VirtualBox have
> failed to build. There are at least 3 such modules, namely vboxdrv, vboxnetflt,
> and vboxnetadp.

As the section 6.3 of Documentation/kbuild/modules.rst says,
the best practice is to put the related modules into the same source
tree, and then do like this:

  obj-m := vboxdrv/  vboxnetfit/  vboxnetadp/



If you want to maintain the three separately,
as 39808e451fdf mentions, you can useKBUILD_EXTRA_SYMBOLS.
KBUILD_EXTRA_SYMBOLS was added more than a decade.
So, you should be able to use it for your modules.

I think it is a cleaner solution than
copying around Module.symvers in your build tree.

Thanks.


> The latter 2 require linking to routines exported from the build
> of the first, thus file "Module.symvers" is copied from the build directory of
> vboxdrv into that of the other modules. Even though the documentation says that
> this method should work, and it has in the past, it fails after this commit. The
> necessary external symbols are not found.
>
> Am I missing some step needed to make the copy of "Module.symvers" method work?
> I understand that the method could lead to stale values; however, the build of
> vboxdrv immediately precedes the build of the others, thus the values are always
> current.
>
> Thanks,
>
> Larry
>


--
Best Regards
Masahiro Yamada
