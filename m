Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45BC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78C3207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2kX3Wsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfLWGbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:31:51 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37290 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfLWGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:31:50 -0500
Received: by mail-qv1-f68.google.com with SMTP id f16so6000988qvi.4;
        Sun, 22 Dec 2019 22:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0u/selZHRAKMuMtzGRibhyFzFMFVLvQHBitgdz4nJrU=;
        b=R2kX3WsqB86AVthCGDGDTrzyS04TAiQG8EjCB/UBe/6MhGxm2pBvDR0gTx3BGX/uXW
         icxQeUlD/OWETOnGTC6SUeEM0nvEqkxPNeyZ68SQXgnSAbKnpMVId9pCbOr01/+j0aXP
         P7u1rbrrdLjndYyubbfvfZbfXOo76X7/Qyj8VjPy7/QoYJ/djrdqkqPNMOc4DqFOSIzJ
         zNHwiCsmrRnPB/PQ7dzILJw+cdv97CDHQaq2v7jITmP7U9CEdhfxu7ynG83KUuNKF6TQ
         CKVaPPjLvHU3prr3I7UlbPkD5qcxTCO5I7wip0DavtSSjKLe4ok2ZCphXyCx6CYeKExO
         yQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0u/selZHRAKMuMtzGRibhyFzFMFVLvQHBitgdz4nJrU=;
        b=L1Z2CgyKeo5Zer7utATjVY2IvQTohrd2LCs3rQiNKLcCm03ZDc1MNMoish0Pjlfo+5
         lkinYmuRb0k/jlJXzYv4fwgDHacpFaeXxbCFjy6ekkroEJEiVWwFPTYpqgReZjztydA7
         4Ib34dfiXTvcmy/589dLccDcnydb5BngJUegrAPINiEVSiYlBvcwA4wAD0SrAdKMVBfq
         DqOEcUM+WlKuayIrdZHMa3Zf8ziLTj57Kp9FJuoIPd/KEgMFqfkpLhn3/YhQZA8XTY77
         eZyIsc5Ghypg+3nrfUTmTkNcRMfcadB/EP/qpZ7aEfr/6NrJ5x/sJG5QV+0MSzYu92O2
         Q4dA==
X-Gm-Message-State: APjAAAWSvvxed4OoOY6h+hWCb45gAOhWAgjRz5H1n0IYzIobZ8fgsfea
        k0sQgvd9qEybmuMrtBItgjDZ20Jv/eG82f69YSA=
X-Google-Smtp-Source: APXvYqy1c4lNMwEtojGH+rLqPbtcCpn+VduJPdBVPkitGnArJIEH+fjJPYrO2+Sgu47HBZMq4G2MZS/Jf4PkSHrZbdk=
X-Received: by 2002:a0c:9e6d:: with SMTP id z45mr23429005qve.65.1577082709618;
 Sun, 22 Dec 2019 22:31:49 -0800 (PST)
MIME-Version: 1.0
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
 <dd3303a956e7dd5c065ac2b92b1dea7ee5d1df17.1575978484.git.baolin.wang7@gmail.com>
In-Reply-To: <dd3303a956e7dd5c065ac2b92b1dea7ee5d1df17.1575978484.git.baolin.wang7@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 23 Dec 2019 14:31:38 +0800
Message-ID: <CADBw62o3vW_hdFwcMdQFJqx2HpNhCEHOxADQO9LztzpqCVQBpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: sprd: Add Spreadtrum thermal driver support
To:     rui.zhang@intel.com, edubezval@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>, freeman.liu@unisoc.com,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui and Daniel,

On Tue, Dec 10, 2019 at 8:08 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> From: Freeman Liu <freeman.liu@unisoc.com>
>
> This patch adds the support for Spreadtrum thermal sensor controller,
> which can support maximum 8 sensors.
>
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
> Changes from v1:
>  - None.
> ---

Any comments for this patch? Thanks.
