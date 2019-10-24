Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E6CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE2B2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVwK2wzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437565AbfJXF1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:27:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32970 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437533AbfJXF1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:27:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so1158902wmf.0;
        Wed, 23 Oct 2019 22:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/3m8yVlp3IftHGnBzL00thvcpnAHjKPgAOc8BVz5Sg=;
        b=NVwK2wzK46s5iSwY1pkocCVDUpy16wHtNDM3k55829LrMyzIxfpy86cs25faBZ8KxN
         SrfLFOnx3uKmwg+NwmbPnzkb75BSGFMkGIjNItM5JLxRyQixKg/EUMzRnlriNCIC5z23
         f111b/IOeFrpG8HF1KUlqO2wlZVSo6ebv723pehGTVsGZBessbNv9ygIlpvkbrpyApJG
         CX0lIFN8BuFgoahyzJXtoLoePrOopzMtPJlSvHjgobYHONEDqkL9LlxbQadC2GnnLhrj
         zby0adr2oy9AnFJaDznKe0CrbxFwbnR8zxBUqW0Q2o9iGLIdKJ2yEiRX/DUec7AVo8Bm
         COug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/3m8yVlp3IftHGnBzL00thvcpnAHjKPgAOc8BVz5Sg=;
        b=OGkIIm3i7fPXExJnekKvu4nlkS5Gz0mXTvjpYuv1qtUfmSBBCmAj60fz68mm8VuHzQ
         UUfg1pOF7AfbbkMP10kbeoU9EpkbYBFOrY/cx/0FtqWHQsZHRs5vrkrjv8C6SGpYmKr8
         kX8hP4zIXdUUdFo9INr7CbA89QqWjuhbSBWM8JfSYoYDATi7qVUaY4JAmP/ndCqhkhy9
         P+pwWciGlQjzkikXP2OqyhWw1I9DmkoZb0OGRl9A1H8EGxza0uSK0WC+kY5jyIaS2THp
         FZLI/1EMZJeYO8GHRmZRDEGlyafoqWklLqdpab9RoQyExgnhaEa60Mf2I80G4trHmu6k
         FV5A==
X-Gm-Message-State: APjAAAUDjfbBAUUWMi7tYgB/Py5BdBsxhWSHQ5KMssgusFxSECmS4WKd
        ucZADJw2GyQMGebKhoNTl43ZiDkIFiyFpVAfciM=
X-Google-Smtp-Source: APXvYqyfkOklb/dFvpi6Ox2Z5lrSld4jw/eIg/nPcRza21UouP4LLzRgN1Ih2hzPCOxUH/hpj0T13/RtR8YA0yI8uJw=
X-Received: by 2002:a1c:4456:: with SMTP id r83mr2924831wma.2.1571894864264;
 Wed, 23 Oct 2019 22:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <1571222654-12315-1-git-send-email-chunyan.zhang@unisoc.com>
In-Reply-To: <1571222654-12315-1-git-send-email-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 24 Oct 2019 13:27:08 +0800
Message-ID: <CAAfSe-uu4gW5sGfQruCGWzJeANYnqq6Kc5kQZJbztmRsK3uKJw@mail.gmail.com>
Subject: Re: [PATCH] clk: sprd: change to implement .prepare instead of .enable
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Xiaolong Zhang <xiaolong.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this patch, and sorry for the noise.
I will resend this along with another patch.

Thanks,
Chunyan

On Wed, 16 Oct 2019 at 18:44, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
>
> From: Xiaolong Zhang <xiaolong.zhang@unisoc.com>
>
> Some pll_sc_gate clocks need to wait a certain long time for being stable
> after enabled, for this reason enabling this kind of clocks shouldn't be
> done in clk_ops.enable() which would be called at interrupt context. So
> we move the operation to .prepare(), and also hooks to .unprepare() with
> disabling pll_sc_gate clocks.
>
> Signed-off-by: Xiaolong Zhang <xiaolong.zhang@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/clk/sprd/gate.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/sprd/gate.c b/drivers/clk/sprd/gate.c
> index 1491c00575fa..d8b480f852f3 100644
> --- a/drivers/clk/sprd/gate.c
> +++ b/drivers/clk/sprd/gate.c
> @@ -80,7 +80,7 @@ static int sprd_sc_gate_enable(struct clk_hw *hw)
>         return 0;
>  }
>
> -static int sprd_pll_sc_gate_enable(struct clk_hw *hw)
> +static int sprd_pll_sc_gate_prepare(struct clk_hw *hw)
>  {
>         struct sprd_gate *sg = hw_to_sprd_gate(hw);
>
> @@ -120,9 +120,11 @@ const struct clk_ops sprd_sc_gate_ops = {
>  };
>  EXPORT_SYMBOL_GPL(sprd_sc_gate_ops);
>
> +#define sprd_pll_sc_gate_unprepare sprd_sc_gate_disable
> +
>  const struct clk_ops sprd_pll_sc_gate_ops = {
> -       .disable        = sprd_sc_gate_disable,
> -       .enable         = sprd_pll_sc_gate_enable,
> +       .unprepare      = sprd_pll_sc_gate_unprepare,
> +       .prepare        = sprd_pll_sc_gate_prepare,
>         .is_enabled     = sprd_gate_is_enabled,
>  };
>  EXPORT_SYMBOL_GPL(sprd_pll_sc_gate_ops);
> --
> 2.20.1
>
>
