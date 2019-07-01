Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D6C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691F3206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfGAPEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:04:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40245 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfGAPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:04:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so11228021qkg.7;
        Mon, 01 Jul 2019 08:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+VrEp0J9K+HfaNVqcJSqEqg3MQ2AUENDamu/jtKp1Q=;
        b=buTr7AAdHBk+m/FmUzWWNQEVps/jscWgdX75phHj/YPqWAUTI4JKBZlT/unEZocFZR
         I9p8rd2aiTbDoFmYiOecvRalN8hTBu5lKZVBWZeZ4FU8tuPI/sInMjKIHrCkvliNye7R
         wwQPm6AbId0OrOk/djfbV3Fo2vYkciTxsDTlfJhg6W3B7Ozhc126JzCbpQ2kyigA4nUQ
         2sq+6d31okhHr8djsAGwQTK9P2sjVtj/FqQUzdN4Paru21x0gTuhuSB2v+I743x2/S+X
         c6UcnKPbRgu6lnYvqfJHpRcZVdXCrNR30u4A6wLAhNoqfHqXmyFz5EBwwna44zCB0FrO
         ehxA==
X-Gm-Message-State: APjAAAUevNI19yr3Xh0zwNzS5F0cwgtDzCGJ1RoftL5dm2janIVut1j6
        bKlS9+ax3oZcPRYXia60Gv1DDmyf1UnVNpTbvtU=
X-Google-Smtp-Source: APXvYqwqcSPBj+y3Ek3wEnw9sJPkLJyXKkIOZdqZJPHOppZrs17NHOoh+6neHpAZWB/TTwdU8S2a6KLC0v5EWPbWwVA=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr20270454qka.138.1561993446857;
 Mon, 01 Jul 2019 08:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190628103158.2446356-1-arnd@arndb.de> <20190628.093215.173840298920978641.davem@davemloft.net>
In-Reply-To: <20190628.093215.173840298920978641.davem@davemloft.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jul 2019 17:03:50 +0200
Message-ID: <CAK8P3a1gunW+R16=GDG+NJ_eaYyiVCDisOa+w5F7tzSGkE2qHQ@mail.gmail.com>
Subject: Re: [PATCH] hinic: reduce rss_init stack usage
To:     David Miller <davem@davemloft.net>
Cc:     Aviad Krawczyk <aviad.krawczyk@huawei.com>, xuechaojing@huawei.com,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        zhaochen6@huawei.com, Eric Dumazet <edumazet@google.com>,
        Dann Frazier <dann.frazier@canonical.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 6:32 PM David Miller <davem@davemloft.net> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 28 Jun 2019 12:31:44 +0200
>
> > On 32-bit architectures, putting an array of 256 u32 values on the
> > stack uses more space than the warning limit:
> >
> > drivers/net/ethernet/huawei/hinic/hinic_main.c: In function 'hinic_rss_init':
> > drivers/net/ethernet/huawei/hinic/hinic_main.c:286:1: error: the frame size of 1068 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> >
> > I considered changing the code to use u8 values here, since that's
> > all the hardware supports, but dynamically allocating the array is
> > a more isolated fix here.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Applied to net-next.

Thanks

> Arnd, please make it clear what tree you are targetting in the
> future.

Sorry about missing this again. I usually remember but sometimes
one slips through when I send a lot of patches for different subsystems
at once.

      Arnd
