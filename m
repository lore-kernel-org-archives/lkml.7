Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E6C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB2F27751
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWJCdoQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfFARom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 13:44:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36441 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFARom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:44:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so10466644lfc.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=19BA31i5trcVG0iExuaBgIWsHZ5o1qSn5nq4u3sMUZ0=;
        b=CWJCdoQvmYppqIwGxNQ56CW/rG/WRxA9vbqyJD/45MJEQGyXGhQIFRWphYZSzdu60Z
         TaNKjHMLUkVRusle1wRuXshEtFqk4u+7gLO5F2X37xNe335qN6ydcTFBtjp4WX41vrsb
         TJcOs621jsrgvWScBTc77KyStbiVxYSxfpO5VrxsPDfWnwHK08OtpP1n/JBy83sNytle
         pZQjWrFtvBacyq3yBCDx67WFbTAmIxP7zjCRSoXLeX/6QGsEYJf5XvGGj2qgK15JgNPB
         tE6UT84NHyXmIC6gRDdXmGdMhXR9iJkuzywNtsr+w0qfXAXtJ8NHa4B4L4ifo0vMMiIT
         XKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=19BA31i5trcVG0iExuaBgIWsHZ5o1qSn5nq4u3sMUZ0=;
        b=dDVpZLZ6a53CQdU8FlS1Okeb+gGzXgfLmysYautCiTgcHK9Ke1FxJm6b/7zbi8/P53
         7DhVbp+fxVH6jD/L2onFVfiQjnCNozmhSjwM1Pl/90whIb25Rg+oGBlmXHuQZ2uIaYGO
         XJuzdbDXISFCLCC7B34ZzIW9K2MoEzPJ6bfA0nR5l/M3iuS6QEyb86LLLB04zdDR0TUq
         KTqcT1BZHvLzQbu8mJ2rxac9RTz/asGbIX6qYIeFwMg4ewoWhQfDv1fZATqkkLjvNd5L
         JDPaRxWSGbQkjXsbZK5cjov+xzeIZ4dZs3JxXaDnLmabsJbKox4XOipVYvBMyN2kpBTG
         zaCg==
X-Gm-Message-State: APjAAAUQbfdrZWxp99wlexyfarMllWZnh/9VnZMR7KLQoSfK3dSwhqPE
        k3J6B2DwFgdemDz5AL0ygh9rfwuZh8qSwI2SHyrcIw==
X-Google-Smtp-Source: APXvYqy21uDuDi2B6fWM6ZKQYs7NA0XB3bUhxRM3FJqBmsm7UAxYO8wSl7Aab26iAsUg9e9Bnqipq/CrQLqa5fCO83s=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr9016431lfh.92.1559411079951;
 Sat, 01 Jun 2019 10:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190521090306.28113-1-brgl@bgdev.pl> <CAMRc=MdJoO602kLfP_Hw9-0pB25CeUMxfqBUYhC7CB3Aw+5O4A@mail.gmail.com>
In-Reply-To: <CAMRc=MdJoO602kLfP_Hw9-0pB25CeUMxfqBUYhC7CB3Aw+5O4A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:44:28 +0200
Message-ID: <CACRpkdYaeD4=T=uux_tKwJpgKzyRcZnKFW2EwhNPzpkHNe3-QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: max732x: use i2c_new_dummy_device()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 5:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> wt., 21 maj 2019 o 11:03 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82=
(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We now have a resource managed version of i2c_new_dummy_device() that
> > also returns an actual error code instead of a NULL-pointer. Use it
> > in the max732x GPIO driver and simplify code in the process.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
>
> If there are no objections I'll apply it by the end of this week.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Just include it in some pull request to me!

Yours,
Linus Walleij
