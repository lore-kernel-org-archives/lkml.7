Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A7C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C95520657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="fRzB1EbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfFSQCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:02:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37399 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFSQCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:02:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so3821172ljf.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2TZYFZlX9e62I/OKOgYgScEFw66m8yxPTXTWjgcCpk=;
        b=fRzB1EbE2KvLOrtDYcH6Bmx/ekekTfKr6UqmgWpisdXrEnoJmgdOSbNhSwH8IGWmJM
         x0zgMnRrBbm8rA19uw67e1raz3rUnXncZTKLdtnzrPqhu/AoNvA0EuxPb841QUtrhDz/
         CNSZNYYnZ99WL3xLojQwD6lDC1u35yUIjRoy8eenp+vvCZEKp+FtOgAPDYsT2WL9WZci
         wjH6KqBZUdsR/scmzhyDdh8SjbTY7eX0oy0Vti/mDgiwBRXrY+VzUZ2NRi3z8Yw215Z9
         Ayoj4uf7n8ccnFYMX1XSUVPQPQ72nzZGxstDzYWt/vUfXw/qybwEVOXjwNu8LYuSXd8u
         PLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2TZYFZlX9e62I/OKOgYgScEFw66m8yxPTXTWjgcCpk=;
        b=P+ACvnOaQ670WakvVZETF0yTGEvMSct2u50/s28CQ95zaPxrBhLDYyt3icpJqqZ/hM
         /i0vGBEuzhXNlXIOEX/gVyhibzjQmjwYXxOKHsv7NLzQQE5HnL0lMiQA5vbKB6aU1DlI
         /Xu1saFihvZz93TbSY+aF1buweUyCVGY7ehKQn06z0N2wsrW7RS0FQWApFrYDoZfo4Lx
         XULUonfL8ZOmP8TWgJipsURryu/UyOtuCpcFoJniKLF1U79DjGj7YRtiCCiRJci7ySis
         kk+WHNQXcvfPo8t0g0yt3QvlxHudbYy7v3XNrcRSlkzOrBl+qfX6P9A7L4/1Cs50cJKS
         8q6g==
X-Gm-Message-State: APjAAAVRP1eVJ0pttaKrEwGwoFJiZwSy6jMJkhVMdCD5WhUhIECy8UTp
        dKMwsrG/pUvkrf9YDq94PhF7chhDd2AiuxnZKCzFcg==
X-Google-Smtp-Source: APXvYqxiUARD7JkUyt9VKeDlYQDMGfcvoKTnLRUfAO3zrZVdUm5KJtR+u/L7XFzMK/jdLnA65048lF47M7mRlJIbDcU=
X-Received: by 2002:a2e:8847:: with SMTP id z7mr4510054ljj.51.1560960156976;
 Wed, 19 Jun 2019 09:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190617132636.72496-1-lifei.shirley@bytedance.com> <20190618.105548.2200622033433520074.davem@davemloft.net>
In-Reply-To: <20190618.105548.2200622033433520074.davem@davemloft.net>
From:   =?UTF-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Date:   Thu, 20 Jun 2019 00:02:26 +0800
Message-ID: <CA+=e4K42mM7-KprPbPjWvDbu8QOrv5=s4QxpWJieeUM73dfS_g@mail.gmail.com>
Subject: Re: [External Email] Re: [PATCH net v2] tun: wake up waitqueues after
 IFF_UP is set
To:     David Miller <davem@davemloft.net>
Cc:     Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengfeiran@bytedance.com,
        duanxiongchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

Have a nice day
Fei

On Wed, Jun 19, 2019 at 1:55 AM David Miller <davem@davemloft.net> wrote:
>
> From: Fei Li <lifei.shirley@bytedance.com>
> Date: Mon, 17 Jun 2019 21:26:36 +0800
>
> > Currently after setting tap0 link up, the tun code wakes tx/rx waited
> > queues up in tun_net_open() when .ndo_open() is called, however the
> > IFF_UP flag has not been set yet. If there's already a wait queue, it
> > would fail to transmit when checking the IFF_UP flag in tun_sendmsg().
> > Then the saving vhost_poll_start() will add the wq into wqh until it
> > is waken up again. Although this works when IFF_UP flag has been set
> > when tun_chr_poll detects; this is not true if IFF_UP flag has not
> > been set at that time. Sadly the latter case is a fatal error, as
> > the wq will never be waken up in future unless later manually
> > setting link up on purpose.
> >
> > Fix this by moving the wakeup process into the NETDEV_UP event
> > notifying process, this makes sure IFF_UP has been set before all
> > waited queues been waken up.
> >
> > Signed-off-by: Fei Li <lifei.shirley@bytedance.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> Applied and queued up for -stable, thanks.
