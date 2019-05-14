Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B181BC04A6B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82942208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UB6b3zpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfENER2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 00:17:28 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42188 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENER1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:17:27 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x4E4HDFA005755;
        Tue, 14 May 2019 13:17:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x4E4HDFA005755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557807434;
        bh=uRp+cc23+8o4aJFfDFUvNr7qqKp95Z2gvy75q0uzix8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UB6b3zpELhUZXA0h4xPUsDO7uR1Yb0GLpjjrLO3W8En7OZnXwu89zqn7aUabdNGgB
         Vg4jzH1sC05Xxo/4+8ZqSYHKixq9rSyV2O7pA52j2oHE+0cAt2itxU3jJZktbCA57G
         Dqw97Tg14yjw8Dv1Q6icY5f+pynmDxZUwUfdjBqwWD4fwEer19z0V24PV/wiaeWrCw
         l5VI2R24Z9FF/HwsvfzSoRx9P7fAxIhC1t7+C0GzewpveEupcTHrYUxXCAjSNxs8kH
         US04ig+zG5qUUZKGcVET2umksU6wqZmw1PxBkW4BLb/NIAqOMUr0Q69ca9tAcfu8xL
         BLuQ2yYgVJEVQ==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id d4so5688251uaj.7;
        Mon, 13 May 2019 21:17:14 -0700 (PDT)
X-Gm-Message-State: APjAAAWKz0c9khAdXNIYIXHHQhM6DAOuY5sVLA5w97Xyj8Bq0Fz5d9R2
        JZbk+oUoZrZkiSfQ/nXiR7hcbX2EQEejSsNDQ4k=
X-Google-Smtp-Source: APXvYqwqpAai8X9ieuHPJXrpIn0TQTpjZm16VliqTUnUVfd+ar/fZ1I0cMmbkmphVXPVFdIqs8JEM6M5THbpk4ltr3I=
X-Received: by 2002:a9f:3381:: with SMTP id p1mr7970759uab.40.1557807433109;
 Mon, 13 May 2019 21:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190514100910.6996d2f5@canb.auug.org.au> <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
 <20190514110334.424cf0be@canb.auug.org.au>
In-Reply-To: <20190514110334.424cf0be@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 May 2019 13:16:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-KDO0Cuq34T5MZvJjxZ-A3HaG3qnJi3v4P9xS=4fRQA@mail.gmail.com>
Message-ID: <CAK7LNAS-KDO0Cuq34T5MZvJjxZ-A3HaG3qnJi3v4P9xS=4fRQA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the ecryptfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, May 14, 2019 at 10:04 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Masahiro,
>
> Also, this:
>
> On Tue, 14 May 2019 09:40:53 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >
> > > Mind you, I have no itdea why this file was begin rebuilt, the merge
> > > only touched these files:
> > >
> > > fs/ecryptfs/crypto.c
> > > fs/ecryptfs/keystore.c
>
> Its a bit annoying that the module was even being looked at given
> nothing it files depend upon had been modified.


If you are talking about the rebuild of
.tmp_versions/*.mod files,
yes, they are cleaned up every time.

# Create temporary dir for module support files
# clean it up only when building all modules
cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
                  $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)


I think the reason is that
we want to make sure stale modules are not remaining
when CONFIG_MY_DRIVER=m is turned into CONFIG_MY_DRIVER=n


Rebuilding .mod files is not expensive.

I think this behavior can be improved, but
that is how it has been working for a long time.


--
Best Regards
Masahiro Yamada
