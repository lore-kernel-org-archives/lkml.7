Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC63C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301302064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2YLXXBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfHPGWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:22:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42235 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfHPGWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:22:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so4295746ljj.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 23:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v14OzUMjNE/HZfmgpIMBDvJqOK1CswJ2VwtCDJGNi9A=;
        b=d2YLXXBOzD77vCmyMvNMNkLFQOk7NUI1qpgaDcil7EdRabwka633i5xOEC3ejL7pYY
         Wh44in0bgl21+YBTpijwOL92QY34JVSDRu48ytxYYkABfv4odbonMAnA3Nxe2cRjAWVA
         yl16HvY4gjb4mXLnUmMC5DWAnMQEtvU8s9mub2TsrRAslQfWbxFfvTEo4byXrIT7U/BU
         ddujW/xmZ1w5/dXspnNrvQFag4c+3/qm7lAw7hQVJr0nkWCCYYr6CSFfwB4KV5OX4KOi
         P0UmbrAsOQtYPm2DQ1mzBdxRoOL8UWH79mJ2rHUYPJphWQifjjlUBMBHOd0c/75WvAdQ
         Ithg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v14OzUMjNE/HZfmgpIMBDvJqOK1CswJ2VwtCDJGNi9A=;
        b=CYUYsVCTry8G55KFbDKyuAU0DQr8oxEQUbJjy/0YJwreLZCc8OB3I3WkSbKWV6RMwM
         +/bRzgIwr1Wxsp84KrrigOPmEgZYHk3r5JGOLHd3fES6VOGbAkhDcpH3ClDZGYvTiOfH
         B3F35wfDpyP6zzEWzgdqlspmz8HPEnWcaE83fZ/OpcSGRbzqMyPhuEnc9oDBJno8uu9P
         pKqWqC4Mqg65SsaW/CgR7thRqR3FWnzPUd+YWhohyQJ2lk2gcv0/QUiM9lCaDzEmNmwT
         8/uKuIkwvO8pBtOpfgNlrmiPhWlxUMcAQjgiQ/h8DS+c1obWdb7+gEhqIAB+OeJl/4Sn
         TODw==
X-Gm-Message-State: APjAAAUyD2v8ofIIFC6Xq/tOsjo8FyQ9mCGkwmQBT9wmWVOlWry4II7y
        8HsX9DyKnKD2Az3JqFO5dzeJl/DbxkWqPAHLmvlxBkh3
X-Google-Smtp-Source: APXvYqwhioniLpZMMBXNvBmmi5v2yWJBAdLohCrRL1i0nxn3uIqNq01gaFdnIoMaSgfpTsi8KzDMhjIp1PuPqIbAlHw=
X-Received: by 2002:a2e:978e:: with SMTP id y14mr4692405lji.10.1565936551522;
 Thu, 15 Aug 2019 23:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-3-codekipper@gmail.com>
 <20190814093011.GD4640@sirena.co.uk>
In-Reply-To: <20190814093011.GD4640@sirena.co.uk>
From:   Code Kipper <codekipper@gmail.com>
Date:   Fri, 16 Aug 2019 08:22:20 +0200
Message-ID: <CAEKpxBkbuQZ9-XLCOcWxV5gzyXPbASmBgYVJ6fL5yj98GE0f9w@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] ASoC: sun4i-i2s: Add set_tdm_slot functionality
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 11:30, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 14, 2019 at 08:08:41AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Codecs without a control connection such as i2s based HDMI audio and
> > the Pine64 DAC require a different amount of bit clocks per frame than
>
> This isn't a universal property of CODECs without a control, and it's
> something that CODECs with control can require too.

ACK
>
> >       return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> > -                                   params_width(params));
> > +                                   i2s->tdm_slots ?
> > +                                   i2s->slot_width : params_width(params));
>
> Please write normal conditional statements unless there's a strong
> reason to do otherwise, it makes things more legible.
ACK
>
> > +static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
> > +                                   unsigned int tx_mask,
> > +                                   unsigned int rx_mask,
> > +                                   int slots, int width)
> > +{
> > +     struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > +
> > +     i2s->tdm_slots = slots;
> > +
> > +     i2s->slot_width = width;
> > +
> > +     return 0;
> > +}
>
> No validation of the parameters here?
ACK
Thanks,
CK
