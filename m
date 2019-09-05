Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA7EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D6421743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLRGUPdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfIEJg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:36:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36516 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbfIEJg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:36:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id l20so1736185ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WjrZVXpBMn10yxgscmgBI4SdhiVjTxRDrNvgJzshA88=;
        b=LLRGUPdnKhlpg+o5c9W+ASLEZjDachXniT1F7zFrkvSWQSp60pUZGdF0UTcj2Z+bbt
         xOE7Bpj/EFTegkq9X82s8NMzZe/8YMmORYaaXhSHdhSbEFmRlwFeun82EvB8HqTuqXth
         IxfWrC0lU538nPfB7iJdG3hczSG2W1Ly8hNQZskE0YVaP6o1t+Ab4FeScKRz+qyXYCI6
         jeggK9qT3c/C1XhC8h3hlZJ4QQ3Uh9gKehy9QS3uYtF9iNgQSmff48rkIDREnyQghQfU
         1N0jivZJDJYuVMJoUqRQmNxoz2sHV4plpOumEz5Ncqrx/N303TVjeefuDQCeLmoUs9R1
         uqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WjrZVXpBMn10yxgscmgBI4SdhiVjTxRDrNvgJzshA88=;
        b=r746TwGavH17kJr35ApYguQ6aemzSMdcFjkezzvibL+6oQBBzvDyRkLA/jGy0mLKiB
         zklyEa9sQsQZ1VsRwx/q6aB89ikwTzmk1BK6Fuja/8G1HY/gxO3tEB+TPFYV/IK8aagB
         1wLhWRFPmJ9Gzm4qhRPxSaW/v1vKSKBmj+ir9MWE/Hh6x10IvgxAfOxBEG5cTk7POPxP
         zAia3lW1fsQ7hucO5kmxAz3G/UwuHQehARcBahE6TYnYyUk9xVpEb/EFQ81i0lFRTc35
         ZjANmx62zufi5NL66IYyX9dV4AZ9eSRXHzUgIU/VUXUvOmRwUsC1DA0pnzE8UFCqSlAW
         r0VQ==
X-Gm-Message-State: APjAAAUvrG+khUfiA0YHUFcOry0xsJL8yRkRromWOB9k0bBZWrm1qBcF
        AgOEG94uQrzcgxbj5SFzuwfdNsCCeS2AJRC0sOy12g==
X-Google-Smtp-Source: APXvYqyxcTqxTe5Mu69BOuS+z06ub3fHMhrvJiSmDKBrpjyWT0LQOgcxig0dg8mMXrgS5SfsPc8F57SZC5w9EOErE0w=
X-Received: by 2002:a2e:9104:: with SMTP id m4mr1406983ljg.28.1567676185467;
 Thu, 05 Sep 2019 02:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190822031817.32888-1-yuehaibing@huawei.com> <CACRpkdapgDbkm3JjywtPv=5gYKQCCXzdabDumVukFv5Dn5pomA@mail.gmail.com>
 <20190904154631.kjegnsk6cf473nr6@flow> <23aeaa05-3a59-5f01-7a67-de1d1d1de547@huawei.com>
In-Reply-To: <23aeaa05-3a59-5f01-7a67-de1d1d1de547@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Sep 2019 11:36:14 +0200
Message-ID: <CACRpkdZcfRnvSGGfpiR=Kb6TDJQjtcQJ4ikhaFC4oB8ZP35+aQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Move gpiochip_.*lock_as_irq() to the proper ifdef
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I aldready fixed this up in my tree.

On Thu, Sep 5, 2019 at 4:04 AM Yuehaibing <yuehaibing@huawei.com> wrote:

> Interesting, my patch indeed do the correct thing=EF=BC=9A

It is a classic merge collision. Something fun for the subsystem
maintainer to deal with :D

Yours,
Linus Walleij
