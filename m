Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E790C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B157218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScI87bkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfCTXIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:08:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38752 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:08:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so855325wmf.3;
        Wed, 20 Mar 2019 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kl/zkaDmMNddb/y4ZhmL5z0WXrYrkcgozvT4AL73VAE=;
        b=ScI87bkJoWYcCu8IoP45zs+kz8N8aIH62EHvV4ATSKC45iT6i77uKC8agWb24u+jhP
         5DsguAGuqqzRd+t3H6ZP07iijGwOoaIdu42S4+nIyPoVbP8Yc3H9QQ13ItoYCms6qhls
         KGPoTOyLnRNvf6pz6+PsxElgVNjOOyvPKcMccmzvSldtuKlTzr7cnhcwfePFivEP6szS
         zF/SzoU47/eXOEuPLxIpCOvU2+g75GYRmxstmJyRE1FkdwfFwlU/zR+GPg2FJq4Z+bXh
         isxvjNzmaM/3jV7gv0iqMZcvDGXnlZHNfJsxykGlvNBN9N6RYZETlqh5+e/Z28BmDJ1H
         gCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kl/zkaDmMNddb/y4ZhmL5z0WXrYrkcgozvT4AL73VAE=;
        b=CyLlyqcF3J8pnPAjDsOA2Nryx8YEUf2f+BnaiSbF+UUk2lENQzmZAiTPgwMUJUbS0j
         7gdPaopxmmHYA25Q3L2ewv3ciT/MaNPV5FmbBrO8sAF/y2BFFvnBeCvWNIApJOsAkjp9
         6iOVRbokzf/9g4QA1a9swM9Q4IRav7ltpkgAl3oDahwhQp/ROaEJc9XnsGxPZVfwfYk0
         40GSjqljumBofn5VwzRXPz27A021WJ3FWynNiCjDKrVddwYkixETQaAmYg5fFxhVcywM
         /vQzj8COSc4NExg56XIrNoKjKSjaAkRDv1TeSuudWKn0Sxq61YbBA3IQEUvCiRD6HOVA
         dcTw==
X-Gm-Message-State: APjAAAXoSMmfOWW/fh/9R1AcTvNbNA80EroaILMjln7Vc3k8cgyz2XbP
        87wAQ8vdySqp26xL1QfG6WKCp90i+lvn5bygACY=
X-Google-Smtp-Source: APXvYqzlfghDIIYOSRnvztq7qo/NJlNWjBHMT1wrxWx+Jy39kYwafNrkf8TRsYSwy3nCGCCtniEL6i6f1UvzqeTEu+w=
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr440710wmi.144.1553123328180;
 Wed, 20 Mar 2019 16:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190208025828.30901-1-andrew.smirnov@gmail.com>
 <3E87E315-0F39-49BA-BD65-2EB0C3A9A782@holtmann.org> <CAHQ1cqH+TCrU+7NE7iiiUwUsCQjfHs8hjKe24b7bj9A3R5GNWw@mail.gmail.com>
In-Reply-To: <CAHQ1cqH+TCrU+7NE7iiiUwUsCQjfHs8hjKe24b7bj9A3R5GNWw@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 20 Mar 2019 16:08:36 -0700
Message-ID: <CAHQ1cqHL+CjXhp4TadAQ5fZNbcxpnkNSxC+TaZ=Be_-giP_60A@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Retry configure request if result is L2CAP_CONF_UNKNOWN
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 8:57 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 4:58 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Andrey,
> >
> > > Due to:
> > >
> > > - current implementation of l2cap_config_rsp() dropping BT
> > >   connection if sender of configuration response replied with unknown
> > >   option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)
> > >
> > > - current implementation of l2cap_build_conf_req() adding
> > >   L2CAP_CONF_RFC(0x04) option to initial configure request sent by
> > >   the Linux host.
> > >
> > > devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
> > > controllers, will get stuck in endless connect -> configure ->
> > > disconnect loop, never connect and be generaly unusable.
> > >
> > > To avoid this problem add code to do the following:
> > >
> > > 1. Store a mask of supported conf option types per connection
> > >
> > > 2. Parse the body of response L2CAP_CONF_UNKNOWN and adjust
> > >    connection's supported conf option types mask
> > >
> > > 3. Retry configuration step the same way it's done for
> > >    L2CAP_CONF_UNACCEPT
> > >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> > > Cc: Florian Dollinger <dollinger.florian@gmx.de>
> > > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > > Cc: linux-bluetooth@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >
> > > Everyone:
> > >
> > > I marked this as an RFC, since I don't have a lot of experience with
> > > Bluetooth subsystem and don't have hight degree of confidence about
> > > choices made in this patch. I do, however, thins is is good enough to
> > > start a discussion about the problem.
> >
> > can you take a btmon -w trace.log protocol trace so that I can see where it fails. This seems a really odd behavior of the Xbox controller. We have to be careful in not breaking Bluetooth qualification to just workaround some buggy remote device.
> >
>
> Sure, n/p, both "failure" (behavior before this patch) and "success"
> (behavior with the patch) cases on my machine are available here:
>
> https://gist.github.com/ndreys/2b74094933601978e200af1ff0a55372
>
> Let me know if that's not accessible to you.
>

Marcel, did you have a chance to look at the logs?

Thanks,
Andrey Smirnov
