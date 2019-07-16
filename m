Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AB8C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DE4206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2kG6iZqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfGPGDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 02:03:18 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:39844 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfGPGDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 02:03:17 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6G636R5005142;
        Tue, 16 Jul 2019 15:03:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6G636R5005142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563256987;
        bh=oQmOGyesxNYba6XgTksWhWesX7fjaeLuJ1z/AasyoXk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2kG6iZqG7bemHBHJP0RKuyNTwWRtrDD+VU01t0H5YwW4WCr1x3oNhJH3NfedvX54y
         WACnb5TFcrrwExgYHC4vHnB/YbQ/RO128IFnGPEBgwQTFCP6dhx1EZQRLBsbq/m6Ut
         Pl/zKZUf1Jtb3igDrlNAqcqHXoqXJ1dRDjF6qDb/ZbfXK9IxAktK6S8Ez7PGi3MFh1
         9loWoofF84q/As0QWDGbqp6ZpyqZVUqGi+cd9x1N8MGdB4XIWGNRQNRv113ykEbhwt
         PUJDHbOhKSGOL+Cb3v3AqBS9whAgyYbJuoSSCRDyO+5RoVFaElVehh5z5b7vGWS8vK
         AavaLWNEnfGWw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id u124so13104040vsu.2;
        Mon, 15 Jul 2019 23:03:07 -0700 (PDT)
X-Gm-Message-State: APjAAAWiJM3HY2PMP/2PNZll1Nvj/v900ZyC2VqwIxFgNPECUXJW/u/Q
        RnxXmYMMIDlCkB8XQwdcD7w+acH8I36fXbsnfNo=
X-Google-Smtp-Source: APXvYqyC0Gx+qDKhJr7TjWh6TCv7pdbWJzX2Ivsm3Pt2/zsttEqbj+jhWFBs5sTZ30/Yja3mXujfZ6mALdkdhWKhvMc=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr18511354vsl.155.1563256985984;
 Mon, 15 Jul 2019 23:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190716130341.03b02792@canb.auug.org.au>
In-Reply-To: <20190716130341.03b02792@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 16 Jul 2019 15:02:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNASTDPG6bDeXj9GfWQVB559D6GEsZiUaiqCfzcPpteZxZw@mail.gmail.com>
Message-ID: <CAK7LNASTDPG6bDeXj9GfWQVB559D6GEsZiUaiqCfzcPpteZxZw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the ntb tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jon Mason <jdmason@kudzu.us>,
        NTB Mailing List <linux-ntb@googlegroups.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 12:03 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the ntb tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
>
> WARNING: could not open /home/sfr/next/next/drivers/ntb/ntb.c: No such file or directory
>
> The only thing I could see that might be relevant is commit
>
>   56dce8121e97 ("kbuild: split out *.mod out of {single,multi}-used-m rules")
>
> and some others in the kbuild tree. Nothing has changed recently in the
> ntb tree ...
>
> drievrs/ntb builds a module called ntb but there is no ntb.c file.
>
> Any ideas?

commit 0539f970a8427138026d4738a7a32d869f1be300
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu Jul 11 14:44:31 2019 +0900

    kbuild: create *.mod with full directory path and remove MODVERDIR

is the first bad commit.


drivers/ntb/core.c defines MODULE_VERSION().

When CONFIG_DEBUG_SECTION_MISMATCH=y,
scripts/mod/sum.c tries to open the non-existing old
source based on the stale *.mod file
during the directory descending.


I will kill cmd_secanalysis for tomorrow's linux-next.


Thanks for catching various bugs!



-- 
Best Regards
Masahiro Yamada
