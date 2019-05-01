Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC8C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BEC21734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEAJ1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:27:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37882 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEAJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:27:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id b12so13884457lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 02:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqKy8I+a4T0E223MovLI7JFFmULW34ElM/2ZaJcNK4s=;
        b=LYhMI5vLpRHz68NOMUWcxkGWSAGJEWLFrgDotSkbjv/kmqM4jLoPPgE5OTaXAwI1Rq
         cCXHS0qPZZKvQNBZw9FdEx4CuUf6tvi7iOyKfHbqjRDmZfdVkJC1vE1Kwo2yPMUPCKg5
         G1Z7O8+fECsA64MO2vdz01Tim6IbuTn4aqimrpDAaRv9rP9fIB5NRXoaivaFs13PP3zy
         T4LYI7xkVQ6TuhMhBAlxFmwZITrhSpZZYt5Kwu91n7ob0t/9m5kZQTjgZ5D50hSiDVXj
         kTVjHVZDbwqr+0H6RSEauq3PVQ0PqS2sfH+MSwb0fq+RwnPtLNLFPz6YDv40XMNzHhMy
         8KBg==
X-Gm-Message-State: APjAAAWZhZu7H9bzWMXTXucKfiplqnh1NAfXtdLm7ypjXuiXXAzETxTP
        kxnq9mnhTTiOh+QsgwdzMUvsuTf6spYorYlyAppwjg==
X-Google-Smtp-Source: APXvYqyfcdKdmTzQ8IDTm8A6KvrZpfBsYY5e4SzYQbGiU178aoFr95yoxbDZs5+rGpEjE6DYrQH5+YnXMs0fV9fhFn4=
X-Received: by 2002:a2e:9f53:: with SMTP id v19mr6467840ljk.0.1556702868264;
 Wed, 01 May 2019 02:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190429173805.4455-1-mcroce@redhat.com> <CAM_iQpXB83o+Nnbef8-h_8cg6rTVZn194uZvP1-VKPcJ+xMEjA@mail.gmail.com>
In-Reply-To: <CAM_iQpXB83o+Nnbef8-h_8cg6rTVZn194uZvP1-VKPcJ+xMEjA@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 1 May 2019 11:27:12 +0200
Message-ID: <CAGnkfhzPZjqnemq+Sh=pAQPsoadYD2UYfdVf8UHt-Dd7gqhVOg@mail.gmail.com>
Subject: Re: [PATCH net] cls_matchall: avoid panic when receiving a packet
 before filter set
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:25 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Mon, Apr 29, 2019 at 10:38 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > When a matchall classifier is added, there is a small time interval in
> > which tp->root is NULL. If we receive a packet in this small time slice
> > a NULL pointer dereference will happen, leading to a kernel panic:
>
> Hmm, why not just check tp->root against NULL in mall_classify()?
>
> Also, which is the offending commit here? Please add a Fixes: tag.
>
> Thanks.

Hi,

I just want to avoid an extra check which would be made for every packet.
Probably the benefit over a check is negligible, but it's still a
per-packet thing.
If you prefer a simple check, I can make a v2 that way.

For the fixes tag, I didn't put it as I'm not really sure about the
offending commit. I guess it's the following, what do you think?

commit ed76f5edccc98fa66f2337f0b3b255d6e1a568b7
Author: Vlad Buslov <vladbu@mellanox.com>
Date:   Mon Feb 11 10:55:38 2019 +0200

    net: sched: protect filter_chain list with filter_chain_lock mutex

-- 
Matteo Croce
per aspera ad upstream
