Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA575C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F43D222D1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPWEuKlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfJDVyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:54:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37069 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfJDVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:54:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so5476394lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoPNMzdQSsaX6T9xeXeKifKMZMvmutkXru6+TSI0b7Y=;
        b=wPWEuKlFUYzqdz4qs+FuWOkgujk6xQg4W88Gbwdt69yuCS4wF7jXBJ4GRPkZgyv8Kn
         gK3sYtTACAkkDIUWPIZxxu/0w1Eg23rseLUrwOcuHfzFts5eaU2ossk8ApAjQMalVPBh
         v/j+CjSbylx2eql609qx6b5pr/aMdpGxO+GwWP5fJlJL0YOCSX+tr4e5YbT0x/k5AWzK
         SwQVCCveut9k7OqNDYdHhgBL00/dvo11ApelQlPEGNEN2wE56jYEVWfGecor/prMr+fw
         blM71t5HKQTpeN7ZQUyQfoi0MuHKD/nGja/CpKC9T8UldLJFGLerfT0g3clJhEkHa6Uq
         tB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoPNMzdQSsaX6T9xeXeKifKMZMvmutkXru6+TSI0b7Y=;
        b=kG3dfPK2Bs4ATWO/QrWVsFeAPo/D4wahpdqJE7LALYPYle+8ilqXc0ZQKX8QguOYfj
         spJPN1R0Pvdh6mmYQmWzUW/z9AnvQN1K7TMmsFtpIsEU4SMJCCVrE98NKENwPFJF8VVp
         uHK3uBCpUtcBz99jl1WMr0mi2GB4VcE3g0WSnGfx9Dj7GDvzPQLlO4cmHU4fbppK70Vl
         qAO4MMtZAwaZCC0uJpn5hADKVBpyRFr9cDAK1yKaeh3WGtfTsg6vuovXfTpX4NVLV5Lb
         aBKVc/xUuFM8yl5QoWeo+GpGP1VVEFHGMJE8M3CDs/5mFPAp/EM+ixsxEZk2kiXhf7Gx
         fIKw==
X-Gm-Message-State: APjAAAWGy0201LEekvJUm3QtP5JySc3NRK/E8MGKyp/tfeXKDXa2KMIJ
        C+f+uh+61sr3to8HrIS83w5C/jim6paiXkoS3EeAV9iogjc=
X-Google-Smtp-Source: APXvYqws72vP4SKYhJ249ciHl03mUZyS9feS1uY1gUxq8IxgZYM6e4vR28Xp5ay5FGaGgDRYYJMV4A6rfFLyAwnEyp4=
X-Received: by 2002:a19:117:: with SMTP id 23mr10232144lfb.115.1570226062105;
 Fri, 04 Oct 2019 14:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190618160105.26343-3-alpawi@amazon.com> <20191001154634.96165-1-alpawi@amazon.com>
In-Reply-To: <20191001154634.96165-1-alpawi@amazon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:54:10 +0200
Message-ID: <CACRpkdY7bYBytGq-AnMrRVWn=-ASz=xTA-_-5wCfsymch4qW9A@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: armada-37xx: fix control of pins 32 and up
To:     Patrick Williams <alpawi@amazon.com>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        stable <stable@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:49 PM Patrick Williams <alpawi@amazon.com> wrote:

> The 37xx configuration registers are only 32 bits long, so
> pins 32-35 spill over into the next register.  The calculation
> for the register address was done, but the bitmask was not, so
> any configuration to pin 32 or above resulted in a bitmask that
> overflowed and performed no action.
>
> Fix the register / offset calculation to also adjust the offset.
>
> Fixes: 5715092a458c ("pinctrl: armada-37xx: Add gpio support")
> Signed-off-by: Patrick Williams <alpawi@amazon.com>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: <stable@vger.kernel.org>

Patch applied for fixes.

Yours,
Linus Walleij
