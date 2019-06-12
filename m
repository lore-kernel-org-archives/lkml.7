Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E172EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6054720896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MsLZJG3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfFLLSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:18:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:38138 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFLLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:18:35 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x5CBIF6L022141
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 20:18:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x5CBIF6L022141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560338296;
        bh=9qf4J6QRljcfXo5cUe4iXkNhy9Rz2w4BYyV8ixl/hPM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MsLZJG3O0m4XnY+kDeA6aNO0la9hMNG+YOcdfh9A+CbiK+sVJXGiOFWVgU4vEppmm
         pH68SIue+8bShOzLSDQ2suMAkHW5W4oo4HVSumabLgvs5JkjfPG88ZlmAt4OWAt6mC
         O4SCxENac1lwcqJzaFbezMiyxWawHnM0NGT5psLCnHfFUPBupJjaySWWZQ5YQmdTQm
         5AqvO2SFUJoaiaRlMjFjowrlj1+g0BDN2M4Pp4dk9Ax4I4UpxPxf9R8TVbBCoTnPHa
         FtgPeJmmaQLrQukh8LjiLleE/6Ix1T0FA3w09RDY+efL+DE0QRAKhwH5eNkAofSuC1
         LX9FidaSAi55g==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id v6so9989788vsq.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:18:15 -0700 (PDT)
X-Gm-Message-State: APjAAAXKLTWapkxcXRl20YJN3diOhx1dt1XpVpQZkEPRKr77QRsTMt8h
        OSED+TnlDJ1i92ylIEUqiaFcRLtZQLEc8Ys8ohk=
X-Google-Smtp-Source: APXvYqyiAJLzuWlm9OGNKzll2um7PpgCRjNhqR9NhMbeh8rj+9jrh3+P+45l89HNf3AKA3kzYmgmctCHy5tkeOKPtts=
X-Received: by 2002:a67:f495:: with SMTP id o21mr28123827vsn.54.1560338294432;
 Wed, 12 Jun 2019 04:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190603063119.36544-1-abrodkin@synopsys.com> <C2D7FE5348E1B147BCA15975FBA2307501A2522AB4@us01wembx1.internal.synopsys.com>
 <CY4PR1201MB012022B3EBC7F7C2788E7B06A1140@CY4PR1201MB0120.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB012022B3EBC7F7C2788E7B06A1140@CY4PR1201MB0120.namprd12.prod.outlook.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Jun 2019 20:17:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-NBUuB6duaQP138Jx7y0UpgqaD=wYtRC2G_c5_H=EJg@mail.gmail.com>
Message-ID: <CAK7LNAQ-NBUuB6duaQP138Jx7y0UpgqaD=wYtRC2G_c5_H=EJg@mail.gmail.com>
Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, Jun 4, 2019 at 2:49 AM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
>
> Hi Vineet,
>
> > -----Original Message-----
> > From: Vineet Gupta <vgupta@synopsys.com>
> > Sent: Monday, June 3, 2019 7:25 PM
> > To: Alexey Brodkin <abrodkin@synopsys.com>; linux-snps-arc@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org; Masahiro Yamada <yamada.masahiro@socionext.com>
> > Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix
> >
> > On 6/2/19 11:31 PM, Alexey Brodkin wrote:
> > > For a long time we used to hard-code CROSS_COMPILE prefix
> > > for ARC until it started to cause problems, so we decided to
> > > solely rely on CROSS_COMPILE externally set by a user:
> > > commit 40660f1fcee8 ("ARC: build: Don't set CROSS_COMPILE in arch's Makefile").
> > >
> > > While it works perfectly fine for build-systems where the prefix
> > > gets defined anyways for us human beings it's quite an annoying
> > > requirement especially given most of time the same one prefix
> > > "arc-linux-" is all what we need.
> > >
> > > It looks like finally we're getting the best of both worlds:
> > >  1. W/o cross-toolchain we still may install headers, build .dtb etc
> > >  2. W/ cross-toolchain get the kerne built with only ARCH=arc
> > >
> > > Inspired by [1] & [2].
> > >
> > > [1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-May/005788.html
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc2b47b55f17
> > >
> > > A side note: even though "cc-cross-prefix" does its job it pollutes
> > > console with output of "which" for all the prefixes it didn't manage to find
> > > a matching cross-compiler for like that:
> > > | # ARCH=arc make defconfig
> > > | which: no arceb-linux-gcc in (~/.local/bin:~/bin:/usr/bin:/usr/sbin)
> > > | *** Default configuration is based on 'nsim_hs_defconfig'


I just noticed this patch is queued on top of v5.2-rc4.
(2bc42bfba9b247abd)

This 'side note' is no longer needed or reproducible
because -rc4 contains my fix-up (913ab9780fc0212).

I do not know if the ARC maitainer is happy to rebase.

Just for your information.


-- 
Best Regards
Masahiro Yamada
