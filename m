Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D0AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FBD206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFpuR83N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEBAsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:48:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42078 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBAsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:48:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id w25so245686pfi.9;
        Wed, 01 May 2019 17:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgtlpUluE15XFZp7lLxAuNyJeOtodD5ENmV00jQLwaM=;
        b=OFpuR83Np2ZHuYo1i9jf55GwlEXwD5YoeeAHb/aWd/gPrHw3+t/QGBBpAYUT4zb84G
         daPs1WLFCwxlkBfTKAYTP/PSRkSpaBWe74oLbDl+bPHwetJipbwsnd0SaErnxmExuz7V
         vAPhvOK+ANONizglQKcKTlDFeG7Ik18eqPMYHkZ+z5pENqCRD3/hLiQS+skuTz/uskjb
         3kwwzM97v6/3QAzJ0A6lf2mZMpCXNvSUV8vod34LFB42eIkazL7LXW+9ea3vy+KXJahj
         kvzpIQYudeNE5pJ8fGhparkGFD21VuVC2Z79mEnOrCG9kywYC8HwbA5KJtlnxK+pD9S+
         45/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgtlpUluE15XFZp7lLxAuNyJeOtodD5ENmV00jQLwaM=;
        b=IMHw5shf5uRF8y0skGPBW7eRi+RRqoYgMWm7h8J9NniKvUfcchJ0kGj/FuwnY6r4pS
         W00ftadhjGD1/gKH8f4rECM+XnmoP8T9M1cOIBhFczvuPl7sSpGo5dnKFHPPfk6oQ/NT
         qyIAmwgZwjIlRkwZoybHY0XesCsl1jyBz8XYVux9L5lFeAGSrIZrtEt5u3OQJdes2HlT
         CWaITLF93ff22has9e8b8d3hwac+TH78zl8Vs/RxyrFntYNaEVl3Td3VRHHXU4Ll4tAP
         i3coQGEoNgsSBOghtf4TGbRU051wcb211gX4SjMDpdJTFVYx7tqp6KiAw7kdmN6aGmSp
         SxSA==
X-Gm-Message-State: APjAAAXC8qw30EyoaJMWBeZVoWHNi2xH37oA5MNBlDbb0wNQVo7/FKm1
        ftkgV6nrBSsyqf3a908PKTBMgDBnJ1ZOGAbS7/c=
X-Google-Smtp-Source: APXvYqxIwTfslovSe+KCRHjpGPm+5mhidqGqDoIQ2dE/oNSiN8BxyvQjlnafe/4HeLG6xg7nw+fmVAXbLny1nC9RxrY=
X-Received: by 2002:a62:e101:: with SMTP id q1mr965126pfh.160.1556758110283;
 Wed, 01 May 2019 17:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190429173805.4455-1-mcroce@redhat.com> <CAM_iQpXB83o+Nnbef8-h_8cg6rTVZn194uZvP1-VKPcJ+xMEjA@mail.gmail.com>
 <CAGnkfhzPZjqnemq+Sh=pAQPsoadYD2UYfdVf8UHt-Dd7gqhVOg@mail.gmail.com>
In-Reply-To: <CAGnkfhzPZjqnemq+Sh=pAQPsoadYD2UYfdVf8UHt-Dd7gqhVOg@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 1 May 2019 17:48:19 -0700
Message-ID: <CAM_iQpXNdZPAWiGuwRGhgX4WdRGEwVnax5VyMrXZ+hM9xhhzCQ@mail.gmail.com>
Subject: Re: [PATCH net] cls_matchall: avoid panic when receiving a packet
 before filter set
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 2:27 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Tue, Apr 30, 2019 at 11:25 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Mon, Apr 29, 2019 at 10:38 AM Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > When a matchall classifier is added, there is a small time interval in
> > > which tp->root is NULL. If we receive a packet in this small time slice
> > > a NULL pointer dereference will happen, leading to a kernel panic:
> >
> > Hmm, why not just check tp->root against NULL in mall_classify()?
> >
> > Also, which is the offending commit here? Please add a Fixes: tag.
> >
> > Thanks.
>
> Hi,
>
> I just want to avoid an extra check which would be made for every packet.
> Probably the benefit over a check is negligible, but it's still a
> per-packet thing.
> If you prefer a simple check, I can make a v2 that way.

Yeah, I think that is better, you can add an unlikely() for performance
concern, as NULL is a rare case.


>
> For the fixes tag, I didn't put it as I'm not really sure about the
> offending commit. I guess it's the following, what do you think?
>
> commit ed76f5edccc98fa66f2337f0b3b255d6e1a568b7
> Author: Vlad Buslov <vladbu@mellanox.com>
> Date:   Mon Feb 11 10:55:38 2019 +0200
>
>     net: sched: protect filter_chain list with filter_chain_lock mutex

I think you are right, this is the commit introduced the code
that inserts the tp before fully initializing it. Please Cc Vlad
for your v2, in case we blame a wrong commit here.


BTW, it looks like cls_cgroup needs a same fix. Please audit
other tc filters as well.

Thanks!
