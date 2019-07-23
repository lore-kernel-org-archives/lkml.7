Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0242CC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C077921BF6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ia1JfK+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfGWIYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:24:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36869 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733201AbfGWIYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:24:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so28659560lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4oiDNheB7tcp4OlfdwdNJixiwjQ7CN/OqrZSF2BQl4=;
        b=ia1JfK+7eINBofKtKO04fnLG2c/ORhlen9wzZsM3f9jtvacXw9wzVipd/IKpZyIvt1
         lHiZytrgcytx8wNSN/KWkpGTYd2Pc+5F6WztnIV747hg4bWIFwcLpBrgxDIQPi9bxm9k
         yaKEWcLo7Avc1KZD51rYRu3VdD8EC4p5AMW4LA4gJyumXz3WtvcQJO/qcDAmSCxTsQvb
         NJ00x/3dUoIP8iWdxEHFbjRzvM1VietYOAkDZd/S2iPkneOyqH6ZyCMENQyxWanGeVlv
         gmGyqfEwS9tNOy4P5+KQlY4JIBwPnHXOAayXHOoVjd0w5Ea5vTo5b5AamT0F0Q+RTEeK
         Kuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4oiDNheB7tcp4OlfdwdNJixiwjQ7CN/OqrZSF2BQl4=;
        b=FUKjzxUHi1MhV3oLBjJX/0c/VXb1esDiZzR8NJpQ45Bbtbltoaxhv1moi5QGXBT8e9
         yxvR+yl2r9PWdEEB+a1kX607vTfPNt47DteJx+qgH/CE+dEsZbq3YEYZE6uxMMLMKjoU
         ksWKseLLukIacPKU/Rxky6hnYrVymD1QUJ0J1B4Ilxe0sro9v8yVr61+3padL+brueNP
         zUOyjsCXYT4h20Toa5gWv7+4y6SZG3qEc5AUs0OWTcCqe+ldhfzuBGqDXeerikJrZfKD
         uaV4he+HnP3Sq+TYNgQQ0ZoXucFMdaYQ18dLRn0QA4bZn/UBuKC43HP10JiaAZ8EcyJC
         m00w==
X-Gm-Message-State: APjAAAWF7zxVxpWt5l1qZ1jLmtXRG2NXQmmv37JlzDXx8DRNek6ai31r
        /mXF0ZoZV3bC3D9HweKkt4ivBGSvAfR1U/zg3uawOw==
X-Google-Smtp-Source: APXvYqxRHlls9XsJdn6N1L6aNp6XRxRHchgvWi1x+4y2L86sh1FPQdZY43ccO4gdutnunaw+n+p1U04JRza21fs1hSg=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr34253339lfu.141.1563870248944;
 Tue, 23 Jul 2019 01:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190722191304.164929-1-arnd@arndb.de>
In-Reply-To: <20190722191304.164929-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Jul 2019 10:23:57 +0200
Message-ID: <CACRpkdZMRmF_CEhXJYyeNEThwHc-ihEReLgU2pvJWjWiBnNFWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] [net-next] net: remove netx ethernet driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, linux-serial@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 9:13 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The ARM netx platform got removed in 5.3, so this driver
> is now useless.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I thought I sent a patch like this yesterday but it apparently
never left the mailserver as I can't find it in the archives.

Linus Walleij
