Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE57C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18B32086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfGJPn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:43:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42879 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:43:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so2226162qkm.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JU70Xhorkz/9nSX68Nz4bdgo5t1jvNBanZiWta0qAk=;
        b=O7jLW/87DkipYIR7qQy87en9iuC9Rb8WEAMlQx9Mjah52Vy90X/ID0iB7/OescDK0s
         XfRZ7sV3/9MTiSjqAp1z7fhUxdmnkncDBXqrAZiigs9S74g11ccLEgG2zzErnXIyNuJS
         SXRkX5ZCVKi1CltWIwAZCKwKWqF+2qb/ol9AeH0G/oQXM5wy3HBQD3pg5FVFExN4meg9
         s2gP0EAWyqeC50xfq+x2AZbgSu93x3+lOXZNgMsw69Sv8zSpc4lA9IjY0j/hiSXUSl4i
         tCbinlFzs6KBjxQeR7jYf+eVOyul3rtH0omUuSqqtHhOJZpZ/YNsTT1Jx0UFU7dNi1Qb
         HpUw==
X-Gm-Message-State: APjAAAUlwUYuUzZelEAkS7bcVzUjbZsmo+quF7rICNmf4fFEK0Rjf++b
        xyhRI8X+c8eN71Ei1d7o2dpygpwxaWbdXMmmreQ=
X-Google-Smtp-Source: APXvYqxvv+X1WjTvAaAhnP56CTMaRm5w2bZy/XUOkPaEjPRcyfFg+HNVF+75W+swCoo8JP7EwD/lPEc3W5qz371Rlx4=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr23416047qkm.3.1562773435494;
 Wed, 10 Jul 2019 08:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190710130703.1857586-1-arnd@arndb.de>
In-Reply-To: <20190710130703.1857586-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Jul 2019 17:43:38 +0200
Message-ID: <CAK8P3a0hraaJJ8dfPZMXA-NBVuff9HVxsHhpj0n_apFZyyAvbw@mail.gmail.com>
Subject: Re: [PATCH] mic: avoid statically declaring a 'struct device'.
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nikhil Rao <nikhil.rao@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 3:07 PM Arnd Bergmann <arnd@arndb.de> wrote:

> A slightly better way here is to create the platform device from
> a platform_device_info. This avoids the warning and some other problems,
> but is still not ideal because the device creation should really be
> separated from the driver.
>
> Fixes: dd8d8d44df64 ("misc: mic: MIC card driver specific changes to enable SCIF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Please ignore this version, it is completely broken, I'll send a
replacement after
more build testing.

       Arnd
