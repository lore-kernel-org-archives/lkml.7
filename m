Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD12C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517A5207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="tXBqx+JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441034AbfIXMzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:55:19 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38399 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395416AbfIXMzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:55:19 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fe1a5a4c;
        Tue, 24 Sep 2019 12:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=nnKmr2UXwyC1dIXONRla9eh1CAA=; b=tXBqx+
        JFLSsyq+fTHXe9H+LdahtsJkvf78IOt3LGZe4bYHGhA5yf3+51idwkrSJjFfy3MP
        hYKBK5MtZHty7s/rLg8sSKd2+0sJwHZcC6qXkVOya5gaJs5/Kmoc1ieDVQieOuqh
        5F7/uvIg0H72uie8qOW/N/l/xEvcOktJhR2QrA+BYnv3bVLEyKDPZ2dMR3yv23jr
        QcdzZR8kQpwehEBEX2ZT5fHhHLPuE//tYonrGjttcj6WgxxJKuYVNDy76k0Tao4/
        nps7qRSH1PJUo4OVGg9pROmkjL1MCEbnIgQXJAkaNKOa31Viy9uHTCQ2Is+bBFXT
        nIqNcBiFoaWCbe2w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d804a112 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 24 Sep 2019 12:09:39 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id y39so1342974ota.7;
        Tue, 24 Sep 2019 05:55:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXP0qeNmy2RSiTcKV+5pZ8wHGEzf/++kpuKj6/mhZgxV+qrWPxZ
        jYbVDYVGcB2wkClwgBUwEPfOQf4fERM0tWIqLAY=
X-Google-Smtp-Source: APXvYqwO7wdcCnhRb4E4JFMtnCNwjMLtSvDaazr6aOfYs4qzT8+CfaGmr6ubNvGo/2f1slLkhF9UeX9/dXCrWcmRYnk=
X-Received: by 2002:a9d:3476:: with SMTP id v109mr1687733otb.179.1569329716132;
 Tue, 24 Sep 2019 05:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190924073615.31704-1-Jason@zx2c4.com> <20190924.145257.2013712373872209531.davem@davemloft.net>
In-Reply-To: <20190924.145257.2013712373872209531.davem@davemloft.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 24 Sep 2019 14:55:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9oqRg9L+wdhOra=UO3ypuy9N82DHVrbDJDgLpxSmS-rHQ@mail.gmail.com>
Message-ID: <CAHmME9oqRg9L+wdhOra=UO3ypuy9N82DHVrbDJDgLpxSmS-rHQ@mail.gmail.com>
Subject: Re: [PATCH] ipv6: do not free rt if FIB_LOOKUP_NOREF is set on
 suppress rule
To:     David Miller <davem@davemloft.net>
Cc:     Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 2:53 PM David Miller <davem@davemloft.net> wrote:
> Please make such test cases integratabe into the selftests area for networking
> and submit it along with this fix.

That link is for a WireGuard test-case. When we get that upstream,
those will all live in selftests/ all the same as you'd like. For now,
it's running for every kernel on https://build.wireguard.com/ which in
turn runs for every new commit.
