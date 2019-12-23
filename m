Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E4C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EB0206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvJq3RZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLWMUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:20:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38573 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfLWMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 07:20:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so17535803ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 04:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6maFNccIr4FVjyCOffu4Z8M0jZ8asTN08k4BjiYMbgY=;
        b=mvJq3RZ5/SO08RF45Cl4hy811+yrHDwoEQjAneQaQEVZstNfZP7KOidREMLRqt8oAb
         lPq5feT+FUQiCdFKwGpdVuXWmBOFfbm9SEAmdnvaskLV2wy03xGcAh0aR+SC3BT//2TC
         Rd4/AyqnxvFS8ouYHAgY4wUEJ8BUiqNEYp9wDM3kfhGy2aDsKGQjxoWnJws/sb3VG85W
         KVzzp2GFYXa+WinThnUTD+RP99hXmHYiTtqNDApmbMj/Ww1UjZZpNM3V/agIA4gGdlOn
         I6S+TCTdVAB76SSZ9vwiPkkRe/D+ykxnaA7DXTCZVnyR50UfX/6udCPA6Axaf+Xx5ad/
         Hpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6maFNccIr4FVjyCOffu4Z8M0jZ8asTN08k4BjiYMbgY=;
        b=gzU0UHEwSPP0wui2I9lJxr1NO6vMDafAPAYm11BLKNIJf7ggC5GJk8qgxTYS+JGGBp
         HW50crxszWKRIG8k+wbzm9a55d1Xr63C+vCr7QPB/5QcfIRNbt18C5fX2WuEIPuU2+WV
         NTU404mt0WpIrenYbttbEJ4j5shOWArcGe229apu5HUMvdQvo86rMXEQa/qgbfHZaJL9
         WYKHTc8IMGvG0bqTaAt234c8OMpU8TTTMsTSPb3GmGqJjIuDLCofCg33VszD6JGGwi9s
         zyz9GQtA47o4HOL98jUwuCe5iqXIlwcHifgjhNo1t7Z5m08x7U0RaYDgi4AGulZLLED+
         txfQ==
X-Gm-Message-State: APjAAAUR6lYG8hTGYeKsdUQXDaPMBSgLqL4jrbWm7ZWuWH0e176aAfNo
        DH4hNWmQdIjwYkfWcFG0hSsKoJSTgv/GEDmXH7tYUg==
X-Google-Smtp-Source: APXvYqz6tEPq0Je/g2RvV/4JEMlHwxH5Lsaksz2cZf1nATKkAhAzRATNBacsWQl7vRCo0BaBd/u71PIfzDoEUQyFHDM=
X-Received: by 2002:a2e:97d9:: with SMTP id m25mr4441817ljj.146.1577103621011;
 Mon, 23 Dec 2019 04:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20191220160639.3406a5de@canb.auug.org.au> <CADYN=9JjqvNWEsHLW5+GgSvkUkuz_6iMpD=X4Vk6nLQXtXa2Dw@mail.gmail.com>
 <yq1tv5t7c25.fsf@oracle.com>
In-Reply-To: <yq1tv5t7c25.fsf@oracle.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 23 Dec 2019 13:20:09 +0100
Message-ID: <CADYN=9+FCsq-AaxCV9-qG0tFNZ2w=8cd87+pa2bP8p6LRgrxiw@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 20
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2019 at 19:45, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Anders,
>
> > ../drivers/scsi/ufs/ufs-mediatek.c: In function ufs_mtk_setup_ref_clk:
>
> This change was very briefly in my tree. It has since been dropped.

OK, thank you Martin then I know.

Cheers,
Anders
