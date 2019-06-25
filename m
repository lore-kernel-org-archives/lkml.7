Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A8FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6BF2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylNDeQ28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfFYJKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:10:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45926 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731393AbfFYJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:10:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so15424933lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwr1PE/zFB5PKkIkGjbG3TZDF5+gr9ZCCNg1gu6crkg=;
        b=ylNDeQ28lqhCQJPI4uvHoSjA34OakWylFf2P26GwzKrxFa201i4sAW7N3CkA/0zcP0
         zNh4G+kxIquOY/fJx/emhD1a8A6/5lepubpMPn2SrNwNFr+9Rr36mPN8yODMxBHygeez
         sHdOBZSgPQ7fawG6i+uBPl/eo6UL6hL+zE/pdo2QEqjb0HgyFJodXnpF6v6mxlqp5Kno
         YOKpY0CY2qd9LsSOE6+vlrdwYnhJGvWqcZ+xeeyhActrLW0oOltqn6mCExn+RTPh0bny
         VIBC8y7w1GMsmoVcXIEzyB48cpvi1I8SDKWz9qYCoNjQgwLitn0F3gGMl/okq4Q1qpW3
         OcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwr1PE/zFB5PKkIkGjbG3TZDF5+gr9ZCCNg1gu6crkg=;
        b=c8TAuKKTzzxGSgQmysQZvjGHXgGS7UrBOOG2jyJlIvOS7wcfFFN1KhAJWwnmw8Tz19
         xK4lqRmpKJ0CXl2u7fBmXrgNlMyb/vXFk2Drpm7+h6UlhaqGqrQN5sJXbbeVcb0wbpce
         8y0tXjG/3FyQH01sx3xmM89nZnZINs7Hejw96E5IP9z69TSq3wbdFh14w3iwzjNEUdEY
         V5hxEm5jHoBlg9uRvW9jyst0y8wUDoNEC0gipbU6gRU6WFslEWg+beQWLHfuI+xRYriB
         oqmiZRVxwP1dZ4gRXr8MPMYvCbGt4xpNHt1LZBsSoflQbKmzqz9asPWcJH/WhE/KZLtq
         zfuQ==
X-Gm-Message-State: APjAAAUPTW2WxBEMB0O5Gy5NyGxDYxeiqXQJ69Rfw5n7HKJEWgS8Vz9l
        AFOfdEyfdiJkL+Y8jN7a9tLQ02r2IrKz2wna+N8yiQ==
X-Google-Smtp-Source: APXvYqxqYys/At0HjJBv2RiPjyTQ6OUMKPdUNvdTGIbYJLAeuDYXTCojyivNeO8CipAJE9OPWpzFP1pIpcU22QYZmwc=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr8483629ljm.180.1561453829057;
 Tue, 25 Jun 2019 02:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <1560790160-3372-1-git-send-email-info@metux.net> <1560790160-3372-7-git-send-email-info@metux.net>
In-Reply-To: <1560790160-3372-7-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:10:17 +0200
Message-ID: <CACRpkdaqEpsw4br_5+CPHdqcJOX0b8pO2OsjxztQ74jA=oPm7A@mail.gmail.com>
Subject: Re: [PATCH 7/7] drivers: gpio: vr41xx: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> this driver deserves a bit more cleanup, to get rid of the global
> variable giu_base, which makes it single-instance-only.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
