Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A77DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D808321019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNHn9oxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCNC07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:26:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37728 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNC06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:26:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id b3so3749284otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 19:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLfOoOWXZn/AMrTO7kHoHxaQuEeaJj4NN+VomR+w5X0=;
        b=eNHn9oxCEGbMqmfi7ln4r1vmYbjfDUMj3IkGEM2iIYVorlbb7AeiyAjnYJvlPMw8mu
         /DDd8/7wHlpmcKug0IIc70j+p4ZOoAYXUp5RKw5AOVzxPoE9IhdA0aSnHm4OYcRuqhaG
         c/0urWblwv+hbR7Q9L+BlwGbjQNkCiyupWCTM0Ye2Nk0u4HwYRhrUL9k16oaqJV54rk9
         H0Hoqvhv0p4Qr0zAFX7YUEIx8m+ngey1cbTxlDP1YHZa3YOGyfmtVmVJy92XwExi+YZ9
         ZFg1LK1GS6r1NhWYz1FBL6bh1UFRiku7iYmxqw+YaAHAzSFPBRqmQzgmdZTPOmTM6JRJ
         Duog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLfOoOWXZn/AMrTO7kHoHxaQuEeaJj4NN+VomR+w5X0=;
        b=KjeT+YDS5tyOK0ZwItPNfT4pfy9eMbJUnWX2jg/I9Op9FvZOPw4fGKMo2l/0/sen5i
         7Xb/B02qmEZzu5JGTl2LMpKQE5HreKFw8dEXI2GJsPHlDOFgG0xfolFIxMYqZ7yjQdX0
         I8gvPkcPQz6lqMqzQ7J2XWSsKzWboSKZg2J9RGKW7VNwmCMclyZRWM5Bvl4llcRC9RRF
         Odx1AAjr2VN/1MfdJRq/EV7GEhZH+yNkAT7nldyeWN/3V7YM4aPoxrIKWIHfWVpPjG7m
         IHq1iJjBn7qIl1IkyL734s5v9f8OdWAfkzPP2FuSHKtcdI2nuJTI5Sd6ymxOKq2sBdk5
         Ezew==
X-Gm-Message-State: APjAAAV8fGeyFu8z2ynPd74g+HO9nddn6vOVeeQpB5D3tjb3DSXAoq0r
        kHKnqeOVuDzk4fJQoFc1/6blJ1cKawQNjenfjG4=
X-Google-Smtp-Source: APXvYqz3Z0eYTeL7C2Lb15tFxlwo5rOJdluru6TNRLSNA2Zk9/0A/FCMZEiEVkfkbfPsA0HgK/w3VnHa/e/bVpASqx4=
X-Received: by 2002:a9d:5614:: with SMTP id e20mr28623885oti.348.1552530417971;
 Wed, 13 Mar 2019 19:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190313122403.248873-1-armax@google.com> <eb85ea17-babd-fe3a-f0ff-9c7f13498bd1@gmail.com>
 <CAJsYDVKF-3jZo4E3EMiYOqeWXVLu0hBra6Qp0sFoCz8y=BAjSw@mail.gmail.com>
 <4789d739-d2b5-357b-b9d8-bfaf587d33fc@gmail.com> <4172ce05-8dfc-c956-6af0-47c8367c215e@denx.de>
 <87y35ipgkt.fsf@notabene.neil.brown.name>
In-Reply-To: <87y35ipgkt.fsf@notabene.neil.brown.name>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 14 Mar 2019 10:26:47 +0800
Message-ID: <CAJsYDVKwJZmaLMkzYOeGnhnor7rXe21Xwvogx7aPfzfXOdqZAg@mail.gmail.com>
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in spi-mt7621.c
To:     NeilBrown <neil@brown.name>
Cc:     John Crispin <john@phrozen.org>, Stefan Roese <sr@denx.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Armando Miraglia <arma2ff0@gmail.com>,
        Armando Miraglia <armax@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sankalpnegi2310@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Thu, Mar 14, 2019 at 6:14 AM NeilBrown <neil@brown.name> wrote:
>
> [...]
> My only small concern is that this driver was backported to openwrt
> (4.14 based) and then reverted
>
> https://github.com/openwrt/openwrt/commit/749a29f76ca780d8df70a5163d43bbdc6f13ba3f
>
>  "This breaks some mt7621 devices."
>
> Possibly it was backported badly, or possibly there is a problem.
Last time I backported the version with broken SPI modes so it got
broken SPI CS1 support. There is one mt7621 router using SPI CS1 in
OpenWrt and the backported driver broke it.
It has been fixed by my two "drop broken spi modes" patches.
>
> John: do you have any more details of the problem other than what is in
> the commit message?
>
> Thanks,
> NeilBrown

Regards,
Chuanhong Guo
