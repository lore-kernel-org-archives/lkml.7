Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77085C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 02:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC332053B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 02:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c//0cKG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKYCLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:11:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54715 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKYCLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 21:11:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so4183850wmj.4;
        Sun, 24 Nov 2019 18:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XeMugYpkKobbybiI0I0oXL667ShpIIeNrq9CaYiRjik=;
        b=c//0cKG0TWAq3iryxvBdzR9JpVwdtLFCpnOpLRN1glatGXIIDnnVzIA5IHC1Rv2jL0
         T6NdpXkdDJ9Zhx2I28n7kYuqaJpOYIYuDKX3ykjn8jwZOg6MoSPzRBYlHerwHByD7LWA
         ravrJgHDNsxJrXyA29V4bAv/06/QcEyx5exLkEaRWSWpQC9AGLciv5hWjVj15zPDxbWK
         ulF9zudAL9+7RPGSHMdv71Q2n0aKjgRZuiUbnyJoOjP1Cr+jguiQNeVdW8FT6aM4g9yA
         zzLi8hymdO3Zd4KztDe4cXqBFOllPV7EejMqgrHSiPpCWTFsBys+dMZh1l7Mb52Yawav
         Kq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XeMugYpkKobbybiI0I0oXL667ShpIIeNrq9CaYiRjik=;
        b=ai1jaOLsJhSRgZeqgmTxFmTF2fU5swwpzKu36oBZEIaZG2sj7AJn8nB30AMRvFeaHM
         qt2wVJcl68AG6YLEaW40Yii7GoSK5Kx6zQp6DnZvZAD9LsanoD9USg5nFC4GkkTlNHZB
         7bf8f0W4dItKJhsybEn8P5KVxUeW1bG2LoKS+hbDRfkfeP7hH6OiEK1GoyFUzbcrzKye
         mo7fvcBMBhrennXPXbAPjQDtUOlFEFfH0pINij0LSEW8Lm/MVEUzp4QDfc3G86/8sJ/D
         fJDP90r/dek4rLMbeh/fF5e9ilBYqrAsPPN8qMl9j+L8p9IY4VyQ2xvXmQbqOIfPpqwg
         kUbQ==
X-Gm-Message-State: APjAAAXsG1lD+NvaS2rRoGkxPu1K9xw/9reV5haRWCn2kmqv7MvAE6Bj
        giV4WlrVmu3Ss9EVPGS/EmarzdS2oD5MxsAc/Tc=
X-Google-Smtp-Source: APXvYqyv/v4pr4T9z4Nx8zwt5nWu07zwlM5P/kk8Udc0hSfHJYk1qsCHMnKrpPFAeMtxxhO+sZ5xTD1RmkPaDdEo2+o=
X-Received: by 2002:a1c:6641:: with SMTP id a62mr25851841wmc.54.1574647894609;
 Sun, 24 Nov 2019 18:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
 <20191025111338.27324-6-chunyan.zhang@unisoc.com> <20191113221952.AD925206E3@mail.kernel.org>
 <CAAfSe-twxx4PyERHXuYcoehPoNYiVaOS4hZEK0KndoM2sL_5gQ@mail.gmail.com> <20191125013312.ACC2E2071A@mail.kernel.org>
In-Reply-To: <20191125013312.ACC2E2071A@mail.kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 25 Nov 2019 10:10:58 +0800
Message-ID: <CAAfSe-uwOvQSWUkOEw1m0C5wnKH1z0gSdjzAMTayKS3cphXMtA@mail.gmail.com>
Subject: Re: [PATCH 5/5] clk: sprd: add clocks support for SC9863A
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 at 09:33, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chunyan Zhang (2019-11-17 03:27:15)
> >
> > Not sure if I understand correctly - do you mean that switch to use a
> > reference to clk_parent_data.hw in the driver instead?
> > like:
> > https://elixir.bootlin.com/linux/v5.4-rc7/source/drivers/clk/qcom/gcc-sm8150.c#L136
> >
>
> Yes something like that.
>
> > Since if I have to define many clk_parent_data.fw_name strings
> > instead, it seems not able to reduce the code size, right?
>
> Ideally there are some internal only clks that can be linked to their

If the *internal* clks should be in the same base address, then we
have many external clks as parents, since most of our clks are not
located according to modules which clks serve, but according to clk
type.

> parent with a single clk_hw pointer. That will hopefully keep the size

Since all clks used for a chip are defined in the same driver file, I
actually can use clk_hw pointer directly, that will cut down the size
of this driver code, and also easier for users to look for parents for
one clk (only need to look at driver file).

But not sure if you aggree this way?

> down somewhat. And if there are any external clks, they can be described
> in DT and then only the .fw_name field can be used and the fallback
> field .name can be left assigned to NULL.

Yes, I noticed that. But I still need to add many .fw_name, that will
not be a small count.

Thanks,
Chunyan
