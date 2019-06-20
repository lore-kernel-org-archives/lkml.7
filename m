Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C37C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AEA2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QgR2ID4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfFTQVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:21:02 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:26484 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:21:02 -0400
X-Greylist: delayed 130677 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jun 2019 12:21:00 EDT
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x5KGKwJA010137;
        Fri, 21 Jun 2019 01:20:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x5KGKwJA010137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561047659;
        bh=vH/H/amVrIF6dYZOdR3bYRn8UJN8aLBCmB8vORY1UnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QgR2ID4VWc+MB7aRJ0NTLb11Mu1qwsQSTYkOSQzUnbgBvUUwHX/WjxuRzWNWUPKYp
         qqZL8Y5ydmrWBl1APS3s8tfTk3LC8KIWU82jRB/dzOPIpBVsyCWF6K8WdEeGJOgxWF
         2nEcbxKy0dfnPfzwSKB+3K1ThTBYvpZoYXQh89zsX93sM/8DhqrU47FZIurvDNDK5h
         2P1cYpk1tmZKwHTL5bUYPHTq6nYVDGKV2R3Hc8kbjfdhj39h7FmV8dNzXw5WXMHTVL
         kEXZ79zHMT4RjygyxCvjQ7gj7n0ySPE3N23LvJmZAY4jlADlA0fZOvDPdwZloUstx5
         0exXA0VV/yPzg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id u124so1903026vsu.2;
        Thu, 20 Jun 2019 09:20:58 -0700 (PDT)
X-Gm-Message-State: APjAAAV0FBUfr39ygBOa8VutEJc3JCOe5jSGtpFqExAA1gmzVNqeXT8+
        U7Xi9l0LfP4Pcqx7cD9kx9ilq3lyQJlvRlMqXNo=
X-Google-Smtp-Source: APXvYqxHO4/4z7w3TznBnMVgkBmgxFvlR0vphCbWHsju4uthPADyWcsnbIecx2JYf1blOnODMg+ueVEz8sQk+7tEpDM=
X-Received: by 2002:a67:ed04:: with SMTP id l4mr4891433vsp.179.1561047657639;
 Thu, 20 Jun 2019 09:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190619200608.69474286@canb.auug.org.au>
In-Reply-To: <20190619200608.69474286@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 21 Jun 2019 01:20:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQc14aYc_cHAYQNxKX_uY5Ssm1aWRRQE1ERaqV8qjUoXg@mail.gmail.com>
Message-ID: <CAK7LNAQc14aYc_cHAYQNxKX_uY5Ssm1aWRRQE1ERaqV8qjUoXg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 7:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from usr/include/linux/byteorder/big_endian.hdrtest.c:1:
> ./usr/include/linux/byteorder/big_endian.h:6:2: error: #error "Unsupported endianness, check your toolchain"
>  #error "Unsupported endianness, check your toolchain"
>   ^~~~~
>
> Caused by commit
>
>   1ac94caaee11 ("byteorder: sanity check toolchain vs kernel endianness")
>
> Presumably exposed by commit
>
>   b91976b7c0e3 ("kbuild: compile-test UAPI headers to ensure they are self-contained")
>
> from the kbuild tree.
>
> I have reverted 1ac94caaee11 (and its following fixup) for today.


I can exclude big_endian.h and little_endian.h
from the header test.


-- 
Best Regards
Masahiro Yamada
