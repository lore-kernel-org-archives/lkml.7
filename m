Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F508C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15FE20830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WfoccSvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfCZJ4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:56:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38623 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:56:21 -0400
Received: by mail-it1-f194.google.com with SMTP id m18so18880407ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgKLibJ/yJtYGJ1gBJqUUq1bLh+TBe+EMq/SQLfeGEI=;
        b=WfoccSvR3aDEtzUUPcVQr41klURF65S67fDQFrUKV7VKDAUO4BuVKLPqjUEp9PPj1B
         1eKFyil584W3zIUybTrV4GvMA1jzOMlASpL25L39oLdwYTmPdPmCuyXtkhAgep2XeeCH
         rsewBr0bkgVdvARA3kNo+HDG9BMfNSSRIealCYj6etn0GHEWReajNN4O5xiHHC5KWtfM
         qDq6iFPiyATf9XhE4m47AkOtZtKIJs0BjUK3Z2fzBCsgTFQMtaCBuV42ENRkKwsw2dAG
         TV+gCQoSDnEDaXz10GQhddY9GQAY6csF/P6oGbf/Z0ob1lpw8iNRtujjT/L43H+IBcI1
         klHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgKLibJ/yJtYGJ1gBJqUUq1bLh+TBe+EMq/SQLfeGEI=;
        b=KGWfukR5YfCduUDj8YsZm2TRN3PQQoVvMkdMthZIoNLr2hCtFHoXSmKHHktvM3MbWe
         Rv1z/7cTiOVuz7cTFbil0pC4p+JUGRFiWzXpMrC9HdesBwMUGrM0c1Vuvbwm0HXpyd04
         QDz+GJjihqpv7spX0vE9G7hiPOisIcdFU90nEZD+vJ3e0EWn0X0RocvY/ej3/8d5EVAQ
         5HVAnR0ngYvwA8lDTo8kae1R3ATIzJxp3EkrAkD9AKKsgKldlGYyJl6eG1S4tJXjMReX
         /v7fEunU+vDlRPc2FQ8vDjdpEjolW+IR4gWfLrtVWN2T+Mui/9DxelGXZ8XqseQypV5e
         ITdw==
X-Gm-Message-State: APjAAAXnQHBzeHngpZ8qlda/KiBSQ0LbOUs2S4s5Xc8ecOgTOPQYEki8
        tKlM8M0lGLKCINTAC9iBd4g1SmUkpxWFNxrVudoBrA==
X-Google-Smtp-Source: APXvYqxV6r5KHsENuMul9ych0mkWdDGlYL6Z7MOBFSJGu5r3f1jeKqjafSc8IFtG7TOmZEFMcRU3qVQ+EEVsCMnEFl8=
X-Received: by 2002:a05:6638:211:: with SMTP id e17mr20973287jaq.35.1553594180512;
 Tue, 26 Mar 2019 02:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001f5bce0584d5b095@google.com> <alpine.DEB.2.21.1903241419510.1798@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903241419510.1798@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Mar 2019 10:56:08 +0100
Message-ID: <CACT4Y+ZLkhCZv+x4Tf2y989JW79Ua9rpC1enmg+h4EXtXSJ0aw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in addr_handler
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        amritha.nambiar@intel.com, andrew@lunn.ch, avagin@gmail.com,
        danielj@mellanox.com, David Miller <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        gregory.clement@bootlin.com, jason@lakedaemon.net,
        jeffrey.t.kirsher@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Joe Perches <joe@perches.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>, miquel.raynal@bootlin.com,
        netdev <netdev@vger.kernel.org>, parav@mellanox.com,
        sebastian.hesselbarth@gmail.com, swise@opengridcomputing.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tyhicks@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 2:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, 24 Mar 2019, syzbot wrote:
>
> > syzbot has bisected this bug to:
> >
> > commit 4f4c867c91e644fc9d461c8c5cf2f09d6d5bcac2
> > Author: Miquel Raynal <miquel.raynal@bootlin.com>
> > Date:   Tue Oct 2 08:54:16 2018 +0000
> >
> >    irqchip/irq-mvebu-icu: Support ICU subnodes
>
> Yet another bogus bisect result. Why? That code is ARM only and cannot
> influence x86 by any means.

From the bisection log it seems the process diverged to a different
bug mid way ("WARNING: ODEBUG bug in netdev_freemem").
