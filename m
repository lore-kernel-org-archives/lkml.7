Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355FAC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02318218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfDWPde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:33:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36247 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:33:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id c35so1832734qtk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BuzlWQrxLZpTYCGJcSfL6Vp4hYT19NXirRLq9fqWJo=;
        b=UGYY0oo4nUwT8KT3gThE7cGONBg2faAjavEPglxyVT76UGTMbRZ0QH6Z9ykFQjZJev
         eNbRE2Wi6zQ/GJI6Jzx6J/7ux7c5Gt/USJkGVxefHQGdeSAZE5D+GWkeLuz/kz2fqr1N
         ezskUe0vkHaqsXyVnCk+lcA6RIYwcfmMlu9KwRuP128hK+NRcn23Oa3SeZJUfU+pApJD
         UoaJ+rglkMt3StGvuqfFV/eeWwSgQxoAwjN1xbqar3Vw6Y9hnLAohZ3yMU0BS2vudLec
         Z5fp5TVbtz10xJBt9PO5wGGyR6yocu4tvMCbUwekHiSyI5FyIyk+ivGRJSPQerdNJrC7
         GSQw==
X-Gm-Message-State: APjAAAVJjRYF9anc5g0ManF/d5K8Zq5m1hUsuin/QxaUpAhOi9fUXhv2
        n5yIZZ4LnekopZ4IMYnLoOzZHvVVbbs+hxk6Q9ZRUi82
X-Google-Smtp-Source: APXvYqxMNOy3fwZLIdb2ZFoJ2ESm8z9WDh1g9vv9A3uS0dgJ2E3XlXf/epyqTzjBZNRdHYY7aXsSjknpUhUcf7vHkGM=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr21038724qto.343.1556033613451;
 Tue, 23 Apr 2019 08:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190422173838.182736-1-venture@google.com> <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
 <CAO=notxuYsBzWBnNran5jH0RujSBeti6-HsjasCRP6Sq0MwGNA@mail.gmail.com>
In-Reply-To: <CAO=notxuYsBzWBnNran5jH0RujSBeti6-HsjasCRP6Sq0MwGNA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Apr 2019 17:33:15 +0200
Message-ID: <CAK8P3a24h=0JLZnZWOmzRqM70uhw3QZ_HcYDXST7F6TgSuW6YA@mail.gmail.com>
Subject: Re: [PATCH] soc: add aspeed folder and misc drivers
To:     Patrick Venture <venture@google.com>
Cc:     gregkh <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 4:24 PM Patrick Venture <venture@google.com> wrote:
>
> On Tue, Apr 23, 2019 at 1:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Apr 22, 2019 at 7:38 PM Patrick Venture <venture@google.com> wrote:
> > >
> > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > currently present into this folder.  These drivers are not generic part
> > > drivers, but rather only apply to the ASPEED SoCs.
> > >
> > > Signed-off-by: Patrick Venture <venture@google.com>
> >
> > Looks ok, but please resend to arm@kernel.org or soc@kernel.org
> > so we can track the submission and make sure it gets applied if
> > you want this to go through the arm-soc tree.
>
> Thanks, I didn't see those come up in the get_maintainers output.
>
> I had a longer question related to this patch progression -- if I am
> moving the aspeed gpio driver to the soc folder, the soc tree may have
> the soc/aspeed folder in their next, but the gpio tree wouldn't
> necessarily.  I know the branches sync up when things are merged at
> the top, but I wasn't sure if there was another mechanism for this?

We can generally deal with merge conflicts like this, or you can ask
the respective maintainers about it and let us figure something out.

In this particular case, why would you move the gpio driver into
the soc folder? If there is a proper subsystem for a driver, it should
not be in drivers/misc or drivers/soc.

       Arnd
