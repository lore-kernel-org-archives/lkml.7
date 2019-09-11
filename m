Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973DC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CB62067B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVd794B/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfIKJol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:44:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45075 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfIKJok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:44:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so8804497ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfO4HK/WGXxXK4b73oCZUUTA55lR9Dm1uUKXZY75m1g=;
        b=FVd794B/Kh/woVfXGPNZCcWRpdvtsO7FEOFvVWWsDu9CYn3LPtCumsPuml8fSoKw+e
         KnKQ1OQBqXFQg6aAxPWZ9HUGhtvWVXE2oMkqx/P0c4YZ5Dr+VfmnJTgVQP/TupXCVAgd
         PSXqaZfRWqeyTLoKB2ClqNXo0wsisp9NfhfloqBp6KpkJstC4JydH0EqgRt0bq0sqtGb
         UtIxjI9Qxd/S9sWFfStjHiOq9R0mDh75ID1sH9qF6T9BmL7AkK+TJsEKb9iUw2WSAj2X
         ky1GT9TVT4NlNp7nUobvtpK89c2PzAxwlBYSGimYJTckgwGmIvYBAvMsoseCkdXWoyUJ
         GvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfO4HK/WGXxXK4b73oCZUUTA55lR9Dm1uUKXZY75m1g=;
        b=RNuKHNh1XG1M+fNO8OZimTG+lgm4IInbppC3k+UKkCxYueGvQI/vLFKd4SkeC4BWH4
         8PPELY+nir5YKndIKzUTd0HtNGQQW1vAYrsQ88fHt9JcAvT5NCOib0qxUn13yGvz86u4
         X79VDZ5EkGbl1xz8B4kN8730M1Hl/LPEIGSV+/3Eiy2j0gp8afiD1nTN4esPmYVn74i7
         ah1xMtVg1+vSMZcNjgxsWzNAB8sAWId9/hc6EPzknd1Ym8ck5TSzeac8opbwxd7B+LYp
         GXTXfqKknlDkHk7c0aou5Z1/7p9HXgRGpEGZ4muTEdAqvAfG5HCFJsBr8pmZdTyZ7ZrJ
         e2sw==
X-Gm-Message-State: APjAAAVxTJ52vFFcC17+VlYc9lsyXHtS1HUxXdSFsT9BoxeYpopHNGxH
        wSfDqzlXwZIeHTl5upqMP8ImudHhjgixUKrYXWxaGQ==
X-Google-Smtp-Source: APXvYqyeJkEnPdU1nrHqRvNcYPbtI5tOlybw7foaIzX3I439oYmaNxLFkKhZDLyK6wH/rgo0lItiJsUi9kMI/EVGZhQ=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr17545242ljg.69.1568195078811;
 Wed, 11 Sep 2019 02:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <1568178685-30738-1-git-send-email-rayagonda.kokatanur@broadcom.com>
In-Reply-To: <1568178685-30738-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 10:44:27 +0100
Message-ID: <CACRpkdYSHnt3WMjpukHKq0kygxZbxHt8tipkQ-UHdXWYr0L5yg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: iproc: Add 'get_direction' support
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 6:16 AM Rayagonda Kokatanur
<rayagonda.kokatanur@broadcom.com> wrote:

> Add 'get_direction' support to the iProc GPIO driver.
>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Patch applied, thanks for doing this!

Yours,
Linus Walleij
