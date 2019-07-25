Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C01FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A952238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2YxyJZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfGYQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:00:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38165 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387874AbfGYQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:00:38 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so23173470ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=th3QGwA5K0Aod/hrhTKzXbdEWqw5GM7JKiuVFRg5Xpk=;
        b=u2YxyJZJnPugr5UyAeZSSPQSyKumnK2fNlAhVccfH/AhV/Vq38llxZhgI4Bi2x0pNp
         EnhLr/xJAMwZcuoe+5hEVhhjpzIdWkEotLd0wAVzzVA/ZBEwPeppTrBSmkf6VSZ0SJGH
         yOR2v0t0taqYu6a0uGIbVdts0kiwtd2FrtOrp12uH39YiIJpfgbIetCuK+kiMQrgrosz
         A2fZ04DB5h9guj+1E7Oqu9++XlTqwlH1Pq67jsaW53j3gfl2saHHQy3HqpSS34hBw42r
         sXnB1IhvR2l5kIfS9caL2cTLHNIIA1t3KF7kaW92V8lolMKzxBubTyJAHb9Y0RNWlPyV
         KLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=th3QGwA5K0Aod/hrhTKzXbdEWqw5GM7JKiuVFRg5Xpk=;
        b=SvVOQcESb8PkTRBh/hWSXQQbu0Orf+F7t4BKy0YySVKdIJkPf0O4gTgaxd6YCagdEj
         30C5WXVuet1NTS75IsPi9NltcWxLHq7G+h0JUFWuiaO49R5CudUQbMVVWIPFGXBsQ3m7
         O2SZV5Ku8nc/xt3ol0MEiQbw3/ot1krQ5iWNlL9+eRKNOgSJwTCOZKo4459F3ER1AbJD
         8fuv2c1e4m+afqflhVBAycBwFLqPsiw2l4/TrxxfMTnOKIHTd4/h3NJCz89CfdTQLIcx
         pLUI8g6NyRJplynObsIuXwHQ4GfCxN94d3xfX5PV9ATKEzN8TkgLjST9oIWfUtqQam02
         MBnQ==
X-Gm-Message-State: APjAAAUkHodRIL1cjtCchRORF/Lqi5UGDQpNAvCfvHpzpe/bwsqjBUIz
        BorqwhliziMvEB1T8eVm8BmZdbqRjeXsz3LjfIEaPVxb
X-Google-Smtp-Source: APXvYqxUNTmUuiAovNvrsLe2yyXqtmRhi5HmhYqJVBw60hM/15ck/+2S2SFKumpxpCa2QMzDo2mkg1I1LsqZi80kuzQ=
X-Received: by 2002:a5d:8e08:: with SMTP id e8mr2820469iod.139.1564070437210;
 Thu, 25 Jul 2019 09:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190719140000.31694-1-juri.lelli@redhat.com> <20190719140000.31694-4-juri.lelli@redhat.com>
 <20190725135351.GA108579@gmail.com> <20190725135615.GB108579@gmail.com>
In-Reply-To: <20190725135615.GB108579@gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 25 Jul 2019 10:00:26 -0600
Message-ID: <CANLsYkzd1Vt5L+tcmtnC+gm6MCe2yYWNi3WEif+4dN2DmcMijA@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting information
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "luca.abeni" <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Li Zefan <lizefan@huawei.com>, longman@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 at 07:56, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> >
> > * Juri Lelli <juri.lelli@redhat.com> wrote:
> >
> > > When the topology of root domains is modified by CPUset or CPUhotplug
> > > operations information about the current deadline bandwidth held in the
> > > root domain is lost.
> > >
> > > This patch addresses the issue by recalculating the lost deadline
> > > bandwidth information by circling through the deadline tasks held in
> > > CPUsets and adding their current load to the root domain they are
> > > associated with.
> > >
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> >
> > Was this commit written by Mathieu? If yes then it's missing a From line.
> > If not then the Signed-off-by should probably be changed to Acked-by or
> > Reviewed-by?
>
> So for now I'm assuming that the original patch was written by Mathieu,
> with modifications by you. So I added his From line and extended the SOB
> chain with the additional information that you modified the patch:
>
>     Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>     Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>     [ Various additional modifications. ]
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
> Let me know if that's not accurate!

You are correct - thanks,
Mathieu

>
> Thanks,
>
>         Ingo
