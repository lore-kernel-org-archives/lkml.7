Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D541CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D6F20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wu/lDZ+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfKDPVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:21:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43556 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfKDPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:21:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id j5so12529876lfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmqHJfKrHEuo8+nq0y5509yDW9+rTv0+ADIVFj4pe+o=;
        b=Wu/lDZ+WeUXXOX/13FqsU02HMEMgYvvB+EJ0LPqhTBPaOHLQT0fOaNd06zxDhbFciz
         +s1Tr2bvcFcTXAKFDo4sXqML9cn7Aj+b7WLcRtz8bPtLAK7XRUULMzjSibVZRIS2psZI
         mnYqdJndH0YktK4xeQ9C6a0HdlGGoGQjueJfHW5OwGQO3Y3CPSDtSgeubfVwq8uTJOf/
         0j4Av/a0R79S6GWb44T+HcJmI7cYybJNtYvru4SJbtvFWL9HhJxmRqpWmdC+iZl4d20f
         OhRSjsAsz71rzoRUgUMjmnkmujYF/Bf/DCMRxLBAxGNmF1ktLntxofpezkBtqYEVviq4
         TNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmqHJfKrHEuo8+nq0y5509yDW9+rTv0+ADIVFj4pe+o=;
        b=rvk41b3dCWsDZRFHQDIgqzrv93pIv3vvM+wHgtsQM0FliF4sWkHmU61h2Gdv3PgNKB
         OGXy08WJ6VdLoboQ9WeUtvrw8CEJcBz6Y6YK+bJuyts0iRQejuSL6hzrvgx1SNyvTc+j
         NbUeBJmGSC0FQMI9eGZQHfFAAMJGFz7K5c9lB5VgRFadnmFz9bDfFUk9kjMnyLqqleJ8
         PF+Yf441FacazvQQpB6Y8aqsMezxuhN8+x6PG9RRK3vHLcDLEk+uGlAjtCXdhi7yxh0/
         7t9Ib0geIjNg103bkYraN1zIv6CKlNZZVaX9UB+2ZF2Wd9Xnx1vtr/BE+iwIeIXPI355
         47Jw==
X-Gm-Message-State: APjAAAW72HiXNaTQXXTQZJDEpCQ1PEh8lHNLE5P83fUbk1CHz0lF5Ayu
        uon7c0HAKvNktAnrt4uJBvpjPeItaiyoUFyoXOnmFg==
X-Google-Smtp-Source: APXvYqyb7sOTS3sJnVKALeqMLINw0jckqgVt+EfzBugF2XKADxqvI03Ya1086CmdBNeJEP74ox3oPirCl8Kl0+Qe9+Q=
X-Received: by 2002:a19:651b:: with SMTP id z27mr16940144lfb.117.1572880871163;
 Mon, 04 Nov 2019 07:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20191104001819.2300-1-chris.packham@alliedtelesis.co.nz> <20191104001819.2300-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20191104001819.2300-3-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:20:59 +0100
Message-ID: <CACRpkda_5iB_nejfpOS9_f4w1E_-60DMVRJX+uzv40w5jNwDcw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: bcm: nsp: implement get_direction
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 1:18 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> The get_direction api is strongly recommended to be implemented. In fact
> if it is not implemented gpio-hogs will not get the correct direction.
> Add an implementation of get_direction for the nsp-gpio driver.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>
> Notes:
>     Changes in v3:
>     - add revew from Florian
>     Changes in v2:
>     - New

Patch applied.

Yours,
Linus Walleij
