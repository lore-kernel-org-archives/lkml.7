Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C2C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E322086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBnSROaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404605AbfIIMBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:01:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40957 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404591AbfIIMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:01:15 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so27918688iof.7;
        Mon, 09 Sep 2019 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjzSJy3NDD7sYggLday3lhixH+9SUC/EVeZUWoe2eU4=;
        b=sBnSROaYcwf48BNTZC63gADs6dyXJsKsfnm5pvlYuv5jzlMTu/aPSFTGhshJ5Ll2Ik
         vp3iKTlPbMgxE6XkoPHIJ/qTcKQQEIG5TxF+1nU1OVHAw1XATgur1o4zXdsj6Tl06D07
         IVt098D2fTUdr0zDTvJJNG6PS5KsBOW0c2GESGvGta4qvr3/oOGCkc7ZXFfuiHRI2eP+
         jNx5OyS14T4hjexE+g4JM9Ovu0yh/3y36DnCXdIPNEMImJM4bhEXEWUpxJnIOw2j0N8p
         VKfPXMRpbA4pqQXRi8/WFkUfYT9a3yEaV7KGTZAW27gtUxRfz210Ov9jSc972wldEYOe
         B8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjzSJy3NDD7sYggLday3lhixH+9SUC/EVeZUWoe2eU4=;
        b=Ytx/m/6deJw9J/03bD4bFRkoyB9eUyu1ObgdWMKsiPCvQ4zE3lXGdZbYOOhZ3HattU
         X/rLffcVU3BnCOqAzcIQKC7Gfry7/bFs/c5wLdaULfaCxW8cJW4uNWIEto1i2z/1DHEA
         RikvXeL6mkdRLSL+vwqHDrGC2hd36ouiQGWjXFWo7EI4LANk8+jGiIapC1zPxaEqPXEe
         kYG07MQtmfRDEyrJtXj9Fs5wGfy/P0TpsQa9ZB6PYcWG0/T+2FkxazI7iuhxW12NODbT
         c9z5cOvEF9h/zcr/Jk2yxsweJX5RmbFgEW+5y3sp9719O4zxczZZh80eZV6i3MM1seSF
         R8Pg==
X-Gm-Message-State: APjAAAU+v/4+kO4GGjY9yl/ugptv8AqoNCSSlpU4Xj3UazuzB15tB6t5
        HO0TIUqoN8DMIEQ5Xszy6IEX3ebrnj/2qR+El6Q=
X-Google-Smtp-Source: APXvYqyKrMcPIeFry4pmSxcirJ0sZlzv9BWvR/f7rXRlNraERjFdqJdXoc1ys7lbOzrlKqXMAIHEzvwlSjm0lpNwlDo=
X-Received: by 2002:a6b:e514:: with SMTP id y20mr18930982ioc.197.1568030472875;
 Mon, 09 Sep 2019 05:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <1566936978-28519-1-git-send-email-peng.fan@nxp.com> <20190906172044.B99FB20838@mail.kernel.org>
In-Reply-To: <20190906172044.B99FB20838@mail.kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 9 Sep 2019 19:51:12 +0800
Message-ID: <CAA+hA=To9B0H1z6Hh1eSZN9_rcextT_Oe-CTMmz9fC9CDNUBTQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 9:47 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Peng Fan (2019-08-27 01:17:50)
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There is hardware issue that:
> > The output clock the LPCG cell will not turn back on as expected,
> > even though a read of the IPG registers in the LPCG indicates that
> > the clock should be enabled.
> >
> > The software workaround is to write twice to enable the LPCG clock
> > output.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> Does this need a Fixes tag?

Not sure as it's not code logic issue but a hardware bug.
And 4.19 LTS still have not this driver support.

Regards
Aisheng

>
