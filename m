Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68443C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3609121897
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uph08Elt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfFSPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:45:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44189 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFSPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:45:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so19729605otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVhZkIpuqF80loACQlfA3nngRhiXTO/ETsZc8Vi9mck=;
        b=Uph08Elt4sY5M1gdp6uPHTfoYyfoI40fGabdUiaU5qKgq7fkz3GvMzVEQ3ctKK62tE
         wpt/Vaid9Vq9zvD/MUMuqWDTbTSTmAQSHqOgHQ9ybVTur9oq+IgnR7jfsM7ed76QrGwr
         OM3s8cZhE9SQEGAivymCmShm+Q1HrkYXA4XvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVhZkIpuqF80loACQlfA3nngRhiXTO/ETsZc8Vi9mck=;
        b=KqLbXi0Z8e4uGH1eO1baba10zEwTmpeNwnfUu+KPkABQk8uIsUmhJJE1l2I2fnEwjt
         H0U9wx9rnvqeWcLjbzDfRk5p7aq8hsv3vXPVX3q7bzj0Jr/Vaj4GqW03uE7Ir2Itxho4
         BLS4YCUvXmHLdYfsLOWtl4wiIQyO1KNwHQIvyqCPPuKZuvebKrLzkhTqu3smDOfFonpw
         CS+ONuVER5K1UIbPi/3kuh8Dl5LBg4vj+MorSSpQI8EQM1ahx0CYAIJylYbu6UnOBFt6
         M0XuMdBdXS9BUkg+3eEHJWVSJL3m+gwap0eDZK497+gxzGjA6Tr3uPKr2uqQvbmlfRQo
         9lRg==
X-Gm-Message-State: APjAAAV2aBqtwmAdy9S39Y03XVeZ6723/vcIKFlx/ghm4uFREWoGhhYN
        UALLwuwfM52dwCKrOiVqWPycymZb2iQ=
X-Google-Smtp-Source: APXvYqwXS/TNbpTgzC35OX/bAZiiKpFWJ3A+kTqSDXLoEW0XnYDyEUr3UjDxJYwuywRPla7I11nr9A==
X-Received: by 2002:a9d:6c17:: with SMTP id f23mr7231285otq.174.1560959104579;
        Wed, 19 Jun 2019 08:45:04 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id q20sm6603511otm.32.2019.06.19.08.45.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 08:45:03 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id w196so10929739oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:45:03 -0700 (PDT)
X-Received: by 2002:aca:e10a:: with SMTP id y10mr2978774oig.111.1560959102372;
 Wed, 19 Jun 2019 08:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153924.19491-1-colin.king@canonical.com> <20190619053012.GM28859@kadam>
In-Reply-To: <20190619053012.GM28859@kadam>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 19 Jun 2019 09:44:50 -0600
X-Gmail-Original-Message-ID: <CAHX4x85id5dwXrBSVHTZaRV43JGAxZwMkvnDN6yH5_Mg4UxRPg@mail.gmail.com>
Message-ID: <CAHX4x85id5dwXrBSVHTZaRV43JGAxZwMkvnDN6yH5_Mg4UxRPg@mail.gmail.com>
Subject: Re: [PATCH][next] platform/chrome: wilco_ec: fix null pointer
 dereference on failed kzalloc
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:30 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Jun 18, 2019 at 04:39:24PM +0100, Colin King wrote:
> > diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> > index c975b76e6255..e251a989b152 100644
> > --- a/drivers/platform/chrome/wilco_ec/event.c
> > +++ b/drivers/platform/chrome/wilco_ec/event.c
> > @@ -112,8 +112,11 @@ module_param(queue_size, int, 0644);
> >  static struct ec_event_queue *event_queue_new(int capacity)
> >  {
> >       size_t entries_size = sizeof(struct ec_event *) * capacity;
> > -     struct ec_event_queue *q = kzalloc(sizeof(*q) + entries_size,
> > -                                        GFP_KERNEL);
> > +     struct ec_event_queue *q;
> > +
> > +     q = kzalloc(sizeof(*q) + entries_size, GFP_KERNEL);
> > +     if (!q)
> > +             return NULL;
>
> We have a new struct_size() macro designed for these allocations.
>
>         q = kzalloc(struct_size(q, entries, capacity), GFP_KERNEL);
>
> The advantage is that it checks for integer overflows.
>
> regards,
> dan carpenter
>

Thanks Dan, I like that.

Dmitry Torokhov also had some thoughts on this patch at
https://crrev.com/c/1661053, I'll send a patch that adds this and
fixes his concerns in a bit.

Cheers,
Nick
