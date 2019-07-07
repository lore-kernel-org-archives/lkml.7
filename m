Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BBDC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 04:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B262083B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 04:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Wk3A769f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfGGEbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 00:31:25 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:23802 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfGGEbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 00:31:25 -0400
X-Greylist: delayed 6584 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jul 2019 00:31:24 EDT
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x674VEU7017936;
        Sun, 7 Jul 2019 13:31:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x674VEU7017936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562473875;
        bh=IU0sI9lPOAmBhk7WYcj3uitcIXFJtoxBE1UAngMjX+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wk3A769fxcaYr7FAEqIx5AV1FOC9WBk0yABfqa6o/GIn+keE7SkMR0w/p5R6oBPLf
         teh97OLt/FoxyUxFMYnqBgW5sCDNYv8mvc/qxKQJhv97nR9LLWfSDRPAl38AwG9+1H
         gcGQIpsvHlCBJi8NAsVx/9N+ijkstQNGMmEg/AYeGc0myr0gQUW56j/9BMIpTC1bpV
         9OP4PtjRSIJkwsWLBiyibDUj/WVmYUdVAISC5zsRAtWP4kY7pOR30NRl3IMKqQ7TUi
         R73NJCdri/Jr/J4rm+0f/Z4A7EunSS16TSqWwdJNQ0eqNgJ1ejS3wW/h2HpYqpHoFP
         XZgoV311I2oyw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id m8so6155741vsj.0;
        Sat, 06 Jul 2019 21:31:14 -0700 (PDT)
X-Gm-Message-State: APjAAAWIRwI6/4Y2Rl5NLUux2mD/q5eUuBPNRbtYfWwlRRH8HBoJ663E
        zcxhZPLlMIDnX8wvX2ALP2HV8tCgBGOFhBClXIE=
X-Google-Smtp-Source: APXvYqwKbCy6SG4VPCk6kF3FiYB0gXvisBArK09GBAC8M82YAt1D0LiOArAyE+Z9AKi3bhgH5xLCz3JCZWq/Xwtsbwk=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr6475026vsq.179.1562473873698;
 Sat, 06 Jul 2019 21:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190605053006.14332-1-yamada.masahiro@socionext.com> <20190706203745.af0bf9bd5dd46e94fa5e1ff9@linux-foundation.org>
In-Reply-To: <20190706203745.af0bf9bd5dd46e94fa5e1ff9@linux-foundation.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Jul 2019 13:30:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARCjucs=0BD=00SD8Ljh+a0GtCUNHF4En=eSM1+VG0-4g@mail.gmail.com>
Message-ID: <CAK7LNARCjucs=0BD=00SD8Ljh+a0GtCUNHF4En=eSM1+VG0-4g@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: do not use unexported cpu_to_le32()/le32_to_cpu()
 in uapi header
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Jul 7, 2019 at 12:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:

>
> Seems fairly serious.  I'm thinking this needs a cc:stable?


Ah, yes.


Cc: linux-stable <stable@vger.kernel.org> # 4.9
Fixes: e63e88bc53ba ("nilfs2: move ioctl interface and disk layout to
uapi separately")


Thanks.

-- 
Best Regards
Masahiro Yamada
