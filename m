Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0685BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C583720675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCGWED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:04:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36007 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfCGWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:04:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id p25so19074762qtb.3;
        Thu, 07 Mar 2019 14:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umZpGxIUGsQMJuR46UExM++Jzi2x8tjM5mlu9y31iZ4=;
        b=icrsJCUN6Te11VWe1duFjHq0x5tzlTQMelN075UnbCk8tx0Xx/s/3jK3aFxPTXTPEk
         pcjR8e7jNmRjDMwzw63piHho0ykPjP3vu+7vjQOW6v4sXH7DKd4Kz6+6MHiD7EMNRSTY
         r0M0Q3OXQ4KZcmnxnoyNzfLn36HJI0R+Fy7y9Tbi0EuEkWuE0yurcLjjhS8baS51vcQc
         +/XegLgsphQMHa5COPBlghVuqi6eH4Nj/zynbvHpP2zdHMOyIZ+hlfRC25QS/mIB3l6C
         8m+f/fvhEkuSdPQpkkwuc/rf5fO6qrn9ZaSXYviBLXpQka+tNNqWoBvYgtbdFxbtDNdR
         RajA==
X-Gm-Message-State: APjAAAWG9/Stzgs40NGeX+rRTX2SQCe0l4rpPwayV+CJuE9THHK7pOnV
        7bhUdnq1V/7JiQckwOS5+D1QzH+jrBu9KyFsG1X122cV
X-Google-Smtp-Source: APXvYqxznMXGXOyKQX526FH4yXcHPOzAonggDFdTpTvLVTOsQHkNImEgnwVi0Swc0KWKO/4leB6aaW58dRYXybSohPg=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr11997576qtb.319.1551996241725;
 Thu, 07 Mar 2019 14:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20190307160017.3120362-1-arnd@arndb.de> <20190307.094600.334828809875646248.davem@davemloft.net>
In-Reply-To: <20190307.094600.334828809875646248.davem@davemloft.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 23:03:44 +0100
Message-ID: <CAK8P3a3_aqxrpwwZLjoqsaXaE9RaeaF+VA1uEEHzVYSW1HoQ-A@mail.gmail.com>
Subject: Re: [PATCH] [v2] ethtool: reduce stack usage with clang
To:     David Miller <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>, Wenwen Wang <wang6495@umn.edu>,
        Michal Kubecek <mkubecek@suse.cz>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 6:46 PM David Miller <davem@davemloft.net> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu,  7 Mar 2019 16:58:35 +0100
>
> > clang inlines the dev_ethtool() more aggressively than gcc does, leading
> > to a larger amount of used stack space:
> >
> > net/core/ethtool.c:2536:24: error: stack frame size of 1216 bytes in function 'dev_ethtool' [-Werror,-Wframe-larger-than=]
> >
> > Marking the sub-functions that require the most stack space as
> > noinline_for_stack gives us reasonable behavior on all compilers.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: don't annotate dev_ethtool itself, as pointed out by Michal Kubecek
>
> I'll apply this, but as Michal said this is just papering over the problem,
> the aggregate stack allocation is still the same and very large.

Thanks,

I looked at it again and found that ethtool_get_per_queue_coalesce()
and ethtool_set_per_queue_coalesce() in fact use the same stack slots
(as one would hope) when they are both inlined, so you are both right
that this doesn't change as much for the ethtool_set_per_queue()
function as I had hoped.

On the other hand, at least it helps reduce the stack usage for all
the other sub-functions of dev_ethtool(), which now don't pile
on top of the 1216 bytes for the combined function but only
on top of the 272 bytes for the rest of dev_ethtool.

     Arnd
