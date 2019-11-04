Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF0ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65D620842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1TIVkFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfKDPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:25:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45949 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfKDPZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:25:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so4444089ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vaEPIoS2t8hUZV5j+rbrQAWA68wAJcFqrHD13iQZNVQ=;
        b=s1TIVkFrUgUqgiD/eCRPacD4FbkSkrQplNYQ/fhkXZtJHcKc0SOQG/Uqx1uWBOWTIk
         wGjwq+fupT6LcupwghxWtbONfk4yQpKCtZexO2I/4c1nESvOL6MUcxGXqA20Y9hZjAsj
         yKavZOz+rt+j7ocQUbzsnqU9SoPZb/b0kojChjUxJ1nJaOfzn+9ssmC9a8WlEP9L6c/u
         ossTO6WbRm6o4ZbJSRi+E+g+Q2oh4wyvy2uzYOMCmT2xcIhm9Nft9IAUjWzNRpXTtI7Z
         NGguI0b+9fDPYA8DPF17kXRvQG3BfLAT9xYJnRA+IAdq+pfwkg9FE0tmVObk8z98ptkd
         NfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaEPIoS2t8hUZV5j+rbrQAWA68wAJcFqrHD13iQZNVQ=;
        b=t3uZ0LAuHGxzxn54HjRmDIUMQcDin4Wt8uDMxnJyt/bLgc25iRsYTq5jg0yFnYyBPl
         dWSBNhkJ9dcMqj+F8A/K8EhTeIuWPJbCgRKpM7j/BkxlY41yXggJ02Ug1dUwFQ7hNdEq
         QO00NO0zCYFPWKG994yT6+IUDFW77etTZ6/gRB1igI/K3b8heqNTXPSF4g1vTofhiO9r
         Byg32Ugzn/knOH/Z2ZPjgIzkewWmQaAC2xCIkbzbGtQztvTLMzdzXAHthzZrvw2pvs7V
         XrqLtI3gB6H/SLeAzQRwOmrRJGW7A0m7Mg0nCVWl+np6NGdGTz6yRwaiv9ga09QDudcD
         EnQA==
X-Gm-Message-State: APjAAAXvw1cVc9neeLfiNBr2P5SVaKfwQ+R3rJ2mfo6d5s8ajfzijaGP
        jd8FAxuMiLIyDgjI9jVd9B0GAWG1JIXaRozaDR6Sfw==
X-Google-Smtp-Source: APXvYqxzvhxQEC2lVXS9XLU/+X6UlgEVhaZM82+Iw9teO/FERLxOvAN0X//SI7N3tlH1MqOFaHplMyQGcIb96hV7Nrw=
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr19270245lja.218.1572881103566;
 Mon, 04 Nov 2019 07:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20191104001819.2300-1-chris.packham@alliedtelesis.co.nz> <20191104001819.2300-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20191104001819.2300-3-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:24:52 +0100
Message-ID: <CACRpkdb530Do3BnVBA6Q7TWOQ0_QfytqaPHPXCPoZP_742Rvzw@mail.gmail.com>
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

BTW I think it looks like this the GPIO part of this driver can be
converted to use GPIO_GENERIC. Compare to other
drivers such as drivers/gpio/gpio-ftgpio010.c.

It's a fun way to cut down lines if you have time to check
and test!

Yours,
Linus Walleij
