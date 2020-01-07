Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260DCC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED31B2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcsLpyzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgAGKCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:02:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43645 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:02:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so54056009ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1lyd87NrA9wszev9LfhXNOVXGOHKaNTISJStitwmE0=;
        b=RcsLpyzf4vpkgl1YtDBbxw7DrhqxljVZKHJNIgnY8WFsI2xhW5/VFY0y8i5JxrIFrm
         3dU+a+DRhxfuWJ1ObJ0YpoCu9EBMTH1+IKm/cguRoFxw9mYmPu4n2w0F79QtpSVE7Amk
         PP8fkpLmQ0QzYVgVbSuL14THdjjfsiP3LGB6PfJxROcaGxyt5zst8dFMS9hCj//ef0D/
         os4TMr+b1aTgvV5YmNOsZuip+7FgeyjxkLVXFT2xSj8QnjA8nu+sC8J8hwtKSyv796/j
         2MTvm27KcqviD+LI28aFCQvIESoYTzBCgKEOPBMPhoghKuuL6J/BPq7lwaq5QIs6y3hK
         GFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1lyd87NrA9wszev9LfhXNOVXGOHKaNTISJStitwmE0=;
        b=UP2ETfSfJaqeksqFH4UdVRnH3e8xswCSW9w2uTyOMj7b9KyFAn+Y53/1ujOX+QUmzc
         nyPzqNQ5eMVaulTJwNNmtTDv0JrNCMTnI++LwOIRf74qPEycDz6eUb5awebgiMoEFOLK
         cE216T+h5Ie6vhpmZ7QFgxVl8xoZM5XvCamKUJTIvZGUSFpTgNrcIui5flylIV0rZyJJ
         H7icmpOIXZ8ywvCOJ176S3WfhVXWAD0OU3bZkjIAagtU2pGpTJDCxKB5uLqwhRx/K7E5
         /ufaHzlEK0YnoSC4PDLKEgdTKsupWnoW17rEkjfqNfNcyxz3uNi/ngxUCy2jG9PPdpbN
         r45Q==
X-Gm-Message-State: APjAAAVxjcW7RzSx9QcqlOPQf6YK3YUcL6othYDo6LMOlRWGLENQrprK
        nYTRw6QcAi7og2oZkCmQUB05V8IuMPy/p+IgC0CC+Q==
X-Google-Smtp-Source: APXvYqxkz1mhDzGYtgHjh5ZxouFmO30ufEvf3Z8mCja4QVI64JVX3+/i+d51yrkb+Nl35bdRTF5XQbnV9kiF4kzwGDs=
X-Received: by 2002:a2e:86d6:: with SMTP id n22mr51896201ljj.77.1578391360561;
 Tue, 07 Jan 2020 02:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <20191224120709.18247-2-brgl@bgdev.pl>
In-Reply-To: <20191224120709.18247-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:02:29 +0100
Message-ID: <CACRpkdb96Atm7=N-Ku3Xvuz0ZC-KYKJ5p9sn4L31fE_a6tkPwA@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] gpiolib: use 'unsigned int' instead of
 'unsigned' in gpio_set_config()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 1:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Checkpatch complains about using 'unsigned' instead of 'unsigned int'.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
