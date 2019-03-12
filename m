Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1614C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961C42147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWGqmlRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfCLUcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:32:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40042 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfCLUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:32:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id w6so3525246ljd.7;
        Tue, 12 Mar 2019 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfIjYxHBvbuUQHpqxad4WlYpbS3+zRJUhvLI/xTMs8w=;
        b=bWGqmlRc1cuwQ+owBbVFhNRREw1dsGQI383z9GJmHO83mqBmql2y2NYPgxewQ/TVBS
         ib88Mhq1X6EIEHMtyJO+Ky+MtR20AElsH7LSeXbEGRQn9ys9paTHXQeOuk31awJFiGVM
         w1oE0t+C/ieBefSMDYZ9tXP6mAyBKxzrFZer5lE5EsSYhCO5TwF/+YohlUGjsc6LOdif
         qUSs66SHjA3b0GiQFHY+3j7RUHeNRlvEWJaVxW4IZ4q1198NYg2Pd+cFpqry26qT/gzK
         kUzwpQRAn6O343zJlHbPzMErx53r/w9ucr05SjqI+5E0zO5DNX0jTXiwkSEDiobVEhM2
         8c7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfIjYxHBvbuUQHpqxad4WlYpbS3+zRJUhvLI/xTMs8w=;
        b=Y76zBmT71gEAkkdCOWnT3bfmNJbnK4lWnq8fvwD6d8NMXqXYMjnSMD1Cl0TXRhpue2
         7dmulu6+xP/+0Wog8UbjuvMqRCcrJ++sTOysAlFFXJ9pY8gw2Az1HYM3DNFp0yg/txgM
         evFhwGqxwxlzLm/sronnib/gE4/PU5XRbspQK1Qg/Qgv6Rd8yJKPtnMZWpNHrXzlgcmh
         aidOH7jLIGvYH5e+RliqgYLZdtkIjiJwPH9Cs77BuTLUAtKixishssghNqUkBlGlEaw1
         I+BnwRc5gvlqg3nf+Z2274Z6rqAvUadrbj+F/efzlXmpJNFapR4u77rwq0SFFMERKKD/
         mutQ==
X-Gm-Message-State: APjAAAVAJDxs7D2/km6RAxF0OEpI99IDVWHTaPwaFlT19PsFh6B3Y5sc
        iRZNcAVaLnxh6x0AqLKLRxuwzoqiNapMdfoEvDQ=
X-Google-Smtp-Source: APXvYqw7aGXRJbBP48H/ZtW/Etax0zRLIspRoWe/+kjjpOe8jfQ+K1svf8cXiFm7Rlg/q/FvW5plSnqGMBip2MDngBs=
X-Received: by 2002:a2e:8908:: with SMTP id d8mr681831lji.174.1552422732884;
 Tue, 12 Mar 2019 13:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190311213124.29325-1-angus@akkea.ca> <CAHQ1cqEHr1mB2EH3-fJPrYa+nkcWPPjmCTjSt-XsDnJp-SCf+w@mail.gmail.com>
 <9f25fb1a0acb35539dcd802502c49058@www.akkea.ca>
In-Reply-To: <9f25fb1a0acb35539dcd802502c49058@www.akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Mar 2019 17:32:23 -0300
Message-ID: <CAOMZO5B3DohJ73wdnp2qm+-6b_B3hw38YOi=52dHA9NzUFVEnw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq: enable the thermal management
 unit (TMU)
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

On Tue, Mar 12, 2019 at 5:19 PM Angus Ainslie <angus@akkea.ca> wrote:

> I tried applying those to linux-next. They don't apply very cleanly
> there so I gave up.

You need to apply this commit first:
https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/patch/?id=7797ff424818c975b59c35880dbc90fe08350204
