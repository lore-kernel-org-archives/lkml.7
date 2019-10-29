Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C20CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740C321734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNLtnlmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfJ2VCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:02:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43583 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfJ2VCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:02:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id l24so10467238pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xRrKgwXdsmpjinuBDfuaLVGRyFAxJUz5gD94L89fPI=;
        b=vNLtnlmdsA7PaAhCvchomclNhYC1/dWNQk40LZe45aHTxOTQ4KsQcnzQbCnVQ3ztXK
         HnFyQrXTk2ZJT3k/NIwPhd3BHe43Z6mufbfaxl4t2+14jRfgRK25QLo7npW1YtE5haEM
         eV3erMc6ny4p8uBuJL+400GBAVdGUWZx6j5AWCT+dc2J3lIH4BuQVGI57ABmsRpgNA/h
         hzjPCS+QcosGZGat8Sz7WkBE1puZfs7OEE+EiUy87klxkj26Y7YdSmisvE7mwLphyVjy
         QJhBG3KyfZs836A+VaUmmNgxHdNQACzT4kVI+OyghD40HkS19ecfgVra+pGfzv3zmKq2
         Qnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xRrKgwXdsmpjinuBDfuaLVGRyFAxJUz5gD94L89fPI=;
        b=SBJUVmoPanTzWyl0FGY5UQ75ldPLTU7uCCfWxmaEHPXgZFxUvEMIb4RVOu2kOz0fML
         pFVqobOQPDQyAQ/Hxia3QW1ov8cYnvTJUb9AZ91pxWfxX56KTMF+4D4nx3iz0lOKFksl
         To/GF9xyRho4QMil5EBb8nl9MG2Y9ryjYajABE1+0sVFfxpg7jnGYSqmS14fy784T8nw
         ZAYwxVPfM0vplahBG+AvM5GcGpyn0gTLgxeOKvJBcb5adk6sMqshYnQu+42JVU/r/ibD
         q9QQeYQe60g5BQfZdDB9EaBcPMARiM1SCQSNzJi9ymURVQDwwMHBOLgwfTyS6dcADHiJ
         98Tw==
X-Gm-Message-State: APjAAAXnvaH/hH+/KzHAFAWzwSAyxrcaCpX8hmdx/0+bAuThdd7G+Ukw
        xEnlaM0K6lZ6ELJsN+LX9gPC2wPpTgT6mdXPKItLuQ==
X-Google-Smtp-Source: APXvYqx5ypoKVeh+p1v42clF+cG0vqBqmVXwUTA7EkbmfXj/0qUXK7K8JIXAaN7XkxUlda3YEu9lME5MWnRfhrnTLlo=
X-Received: by 2002:a6b:fb0c:: with SMTP id h12mr5986548iog.239.1572382934731;
 Tue, 29 Oct 2019 14:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <1564980742-19124-1-git-send-email-hongxing.zhu@nxp.com>
 <1564980742-19124-5-git-send-email-hongxing.zhu@nxp.com> <CAEnQRZDk4TjU0nWgGXEV06ZygvSyuPHc61_uT7KRu0j2Aaxj7w@mail.gmail.com>
In-Reply-To: <CAEnQRZDk4TjU0nWgGXEV06ZygvSyuPHc61_uT7KRu0j2Aaxj7w@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 29 Oct 2019 16:02:03 -0500
Message-ID: <CABb+yY1-PrmT_Qp6M1+WTnVAKizVqJLYJcip4KfqcAjcuN3GCg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 4/4] mailbox: imx: add support for imx v1 mu
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 4:07 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> Since we got no answer from Jassi in 4 months I think it is safe
> to assume that we can get this through Shawn's tree.
>
Please don't top post.
This patchset doesn't lack my love. It contains support for a new
platform and was sent after last merge window. I send new
features/support only for next release. If you want some urgent
bugfixes picked , please send them separately.

Cheers!
