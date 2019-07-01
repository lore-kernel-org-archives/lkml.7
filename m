Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8463CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530F620881
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfGAQOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:14:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33610 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfGAQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:14:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so9225091lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0U0YPTwJgVIJVRdYc6tYY8FIRvP636LwdBcXQglF9w0=;
        b=IQUTI4XZ3Q82yeW5G2g6aJi/+RXNjWJxHYSjkEsncEsS8yuPpQJl3Sa8ATmFqdLMga
         o6bZ1sr8wRmR0ZOJEXF6lQzUgVRxTCFGR28o3RD61ZdNBkbaJpq4e8DNgcDqRbv1qLdw
         J+jVrq3b59dP1Q8deX0BGOM6rlxCcJllBFeLXS4A2P0TORWRfsLEhE2MizuLOv75Xc9n
         E/3cvhBI12PBGjVGVhSAgP/2dETxV+4u8kJ5zcsFTJWvs8tHYlNMAGOnsKsjlV2g22Nm
         kJUIPWLMgytGXorUmMLN8noQHdtNmS9CoWqzcbFdWS482dpBBaBnnG0ksrLlniRTEY0J
         zRfw==
X-Gm-Message-State: APjAAAUfMBXG2q3iQBue+3qAAZmb1aXwHenMeOVfd5eJbYBJoEKCnSdt
        bsbdsyfqoMS7dv41tgMlrLUC23OKAOKZi9YWw+eDMaY161E=
X-Google-Smtp-Source: APXvYqzriltBqe9R7oQnUm+t1kiD/JXfO+P5w1S5DjKPm1jZ3LxfH1T50G3V+2i3+aAxPMfHqfVYaccEHxDlHv7SpJE=
X-Received: by 2002:ac2:4466:: with SMTP id y6mr6082599lfl.0.1561997648899;
 Mon, 01 Jul 2019 09:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190701160805.32404-1-mcroce@redhat.com> <42624f83da71354a5daef959a4749cb75516d37f.camel@perches.com>
In-Reply-To: <42624f83da71354a5daef959a4749cb75516d37f.camel@perches.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 1 Jul 2019 18:13:32 +0200
Message-ID: <CAGnkfhx9F1G8K6PjBdUnkCO07GR=ktWAnqOLTcOvg7VGwWb69Q@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: don't set IPv6 only flags to IPv4 addresses
To:     Joe Perches <joe@perches.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 6:10 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2019-07-01 at 18:08 +0200, Matteo Croce wrote:
> > Avoid the situation where an IPV6 only flag is applied to an IPv4 address:
> []
> > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> []
> > @@ -468,6 +473,9 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
> >       ifa->ifa_flags &= ~IFA_F_SECONDARY;
> >       last_primary = &in_dev->ifa_list;
> >
> > +     /* Don't set IPv6 only flags to IPv6 addresses */
>
> umm, IPv4 addresses?
>
>

Ouch, right.

/* Don't set IPv6 only flags to IPv4 addresses */

Can this be edidet on patchwork instead of spamming with a v2?

-- 
Matteo Croce
per aspera ad upstream
