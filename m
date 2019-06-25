Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C23C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B8D204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I48yWJwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfFYMTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:19:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34836 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfFYMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:19:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so16059941ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jALhUuHnRMGGpmpdlDb0HIhW7kZ/qK9Mq/evTmTkD00=;
        b=I48yWJwGiioj2FgBHsgEqo+h9ie0rIphzW/pO7El8g0Ve0FckbkZNMUB367r5J1WCU
         /cp9KZzBY2nwMFG8rx5wAWI3vxwowVuqV3/DhgJsA/mAau+OXwxd52Z31Uo/CcD719oD
         ddSYF/1nj92zTIcEfhIDG6VdaKTFVkOLK70ziTnrdpYIUhIJ1xtv1Tign5rn2dAyJN/V
         n/uaJ9MMqHk0Zffw7LvtEWm60FzmpXVsPeqxEqH1IatZUK0UyjDSnMUbm7iXIQQcxioF
         Fp+ZtWzAYNpPGOy04scBl/bQPaBfMkr6h0ztFmvx3nacYkph9QHVVk5TbIhDP2ncAWDY
         Joaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jALhUuHnRMGGpmpdlDb0HIhW7kZ/qK9Mq/evTmTkD00=;
        b=tu6R6HNVyhXc1W19XcRjVzGbMEgkFcA2EXkXGp9UszJgIiGvSTpns0BUJgL1eY6dKG
         +4uU5Fti/I4L1XTqwI1OOtdin9wReTglvmT/wBgXY6PzoSoE3oL3Fc80UvLEkME26o3D
         xx7UkqAIvFQM1D0W7Eznw31cBaUCv4CoG49RkjSV4Uvb17kqKB2yWgqKlKkWyALvEZ6y
         0uy30NOQkZ83VJ2MmbBC4lAWSjR3Ly9fU24GNJp0ZJVO9ixWwdtqxesN6Kwd8h1p6P7i
         VTlFmUt9c60R6T/eiqg9mpgK8P7Zy6gukubdI8qHNwdG0QDpRhUm7EWwKmgSlHOMiBE9
         plgw==
X-Gm-Message-State: APjAAAWB5BhiVaMpCZSMImcXoCkRGkWlNXBuBoxGTR/CkQIoLN3WoxWS
        66quvaAUPxL8nIQTxxLvRqON6rqHJgJ/n3BBM4U0pA==
X-Google-Smtp-Source: APXvYqwJlShOUGzSJYy1EdHq8lnqlJ7DfvQSdzbDHyFXLiG7jgfjQp4H2cmef6cUs212VQhxBDPSZv9UmUqJAyI51+o=
X-Received: by 2002:a2e:81d8:: with SMTP id s24mr33236100ljg.37.1561465138557;
 Tue, 25 Jun 2019 05:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <1560764090-22740-1-git-send-email-neeraju@codeaurora.org>
 <CACRpkdZ4BoZzX7pVw4HYBzSMvhnyu_oVNoiiLk3ME05nnG1T3Q@mail.gmail.com> <c9eb6bfc-a8d1-75df-159b-3f2304fdb8ea@codeaurora.org>
In-Reply-To: <c9eb6bfc-a8d1-75df-159b-3f2304fdb8ea@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 14:18:46 +0200
Message-ID: <CACRpkdYMW8TiK3jBfgVhmST_S8CHuyY2rTD=ZZ37eckdrJ2uTw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: Add irq_enable callback for msm gpio
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:29 PM Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
> On 6/25/19 2:28 PM, Linus Walleij wrote:

> > Please don't name functions __like __that.
> >
> >> -static void msm_gpio_irq_unmask(struct irq_data *d)
> >> +static void __msm_gpio_irq_unmask(struct irq_data *d, bool status_clear)
> > Instead of __unclear __underscore __semantic use something
> > really descriptive like
> >
> > static void msm_gpio_irq_clear_irq()
> >
> > That is what it does, right?
>
> Is below ok? as it clears (if status_clear set) and then unmasks irq
>
> static void msm_gpio_irq_clear_unmask()

Sure thing! Thanks.

Yours,
Linus Walleij
