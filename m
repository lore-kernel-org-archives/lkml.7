Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E79CC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D252077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Snday90r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfLJR02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:26:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37377 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLJR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:26:28 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so3505300qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bZ4iYKfwZdWAmbEps1YLYJxpwzBmE/Ua4Er+AzBivSw=;
        b=Snday90riIjUjSn4sACV5INwLN29wOAy1GCAXwGkGywMoEMjw+85QfrOer2oFdyUwQ
         nDIKyto7VGUHxjP5aRDdyGSKT2ORgjrFR0a8C37+1RNivUZKeG5h10sotqIjg6Him+Sl
         ZZb4r2064YmYfo8MUcCybaWe5LI53zCLmvkRv2KfzqlzMYNW348bPH+ebKLhXTLKmU7L
         XytJQjyjmZg7v0pMhTHplxF/4Och2r5DGsdNrT6MEDdRMBVpyUQ9558WpfI5CMTALVaC
         ycJ0jTWqB2/gzpRGyQcbFbMvytmai4Ru1OvJPPo6qLu8+w+peD236xgmToxSgbBAQfUs
         d+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bZ4iYKfwZdWAmbEps1YLYJxpwzBmE/Ua4Er+AzBivSw=;
        b=qCk11LMagb3k+rKzCVHktaXdZqqzjLH5sOi+SWTbCziGkfYlh03dQIqzS0oNWLj/qZ
         kwY5wQw0HmNXHn4yRKV1/yv85jfTBpK63RuokrFbYjoek/hqJjWiWQRuEJritlPuWDW5
         Clx9XV7i17KStE/kJsl+d9UCxF0WDhCupgPMyLzeVuRGsAwMvUMS5tMsMGWCpaR++wqe
         LC3wW4GH7GT7FxdRK9PPQ+0oWEcACcpX65KRZtwcsQgExFzptAFdReNMBZIt0b1Vvwc/
         YtMa4YY1lBlqAOzJeEsn2l7AGeG84OqkbbBcixdcgdf4exN4BSYW078k+FJP0n3Psity
         rCqQ==
X-Gm-Message-State: APjAAAV9l23kevetXt85IDGZnXnYxwKHjvlEOUYz8SMrWTDNPZIhUvso
        jqgcg4SBvlfetxAk6zVZGnSSLnUbZjgQB8MBA/eFVQUs
X-Google-Smtp-Source: APXvYqz3UD2DbVFh78UTlfksCL1QA32QrUYjKUu86Io+DrDwKkv+TfJDWnyqxxyD8WHNqSXyXuYHOdhLGCe/KgxzTf8=
X-Received: by 2002:ac8:6784:: with SMTP id b4mr13959932qtp.27.1575998787259;
 Tue, 10 Dec 2019 09:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20191210021525.13455-1-warthog618@gmail.com>
In-Reply-To: <20191210021525.13455-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 10 Dec 2019 18:26:16 +0100
Message-ID: <CAMpxmJUisWGH7ERySj_iMEiSxjKyKgcCu6oD1Uw-r0CmU4pZAQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-mockup: Fix usage of new GPIO_LINE_DIRECTION
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 03:15 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Restore the external behavior of gpio-mockup to what it was prior to the
> change to using GPIO_LINE_DIRECTION.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Please add the Fixes: tag with the commit this patch fixes. See other
commits that Cc the stable branch.

Bart

> ---
