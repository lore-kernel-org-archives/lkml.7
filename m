Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD34DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B110521848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBVXvdd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfHVMOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:14:05 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:35671 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbfHVMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:13:59 -0400
Received: by mail-ua1-f44.google.com with SMTP id j21so1913417uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoBmeUN23M8f6sfbc9hjllfgwqRgBk2+sJFpDr9LHV0=;
        b=fBVXvdd5bwH+sPQ0EwczYi7R6UmwhFeLh0tBrRFjzXX7IFfV2KnWfv8vwWiNuIBB8H
         NGGZv62Zk/qT4ZXkyI0BBvAYEl+xvjQK7SG7Tsj0MijJuSmyal+GioBCqP3LfHzD4+oY
         H4u7Wfgxm/ojS3Txbnuys36cWl+exdG4o4s0mesYIrVTF2ehlmDXzZqXpQFcEd+LatFA
         1zFeZZ+yHi8H7Dy4+/zq0XzTxf0XkUSK77ho1+CZNnHkMvgw6bTJmR1mvUE0A01KmHn2
         MdqHGzSDf7tD3eCbDAEt80tOupjxhBET+sk/uQ0Xjzk1P95B6OphlIfJrhjJs6r2lq83
         HQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoBmeUN23M8f6sfbc9hjllfgwqRgBk2+sJFpDr9LHV0=;
        b=MEIbjQF5seHadyt9W9OTljYc7yne+AxBCgUGBm8aRkNWG4X1Tr9nzFsMoUkazy/z5v
         jwPMgumJKQ0UFUi+pXl9Fsj0eQv6DZHKDqG9nfxhddme0nLslnUXHvfTeFhbO2Y0+WFl
         0U/AFc98z35Hqr+Nd30SX+i0QLlhZclYo8CBnuS89BPokFSuH7tdS4IQE9sfs47fRY1m
         L4TGANUcIJQs53GeCbBdQES23XGktSTw8Is6XUtMzI1hV+g4CzIODocFsJKM+B8ET8X+
         lW18ac/N9PuTsPdKpeiULJ/jyVuF73S08fyzl5XMDIcrEy2U7mTL0jDw3wSBkQ3NXQF1
         sAoQ==
X-Gm-Message-State: APjAAAUngG+Euk5lbcEP0iv4/vYUOkciCEv1NdQUz10/LYNsN5ydumE1
        tMjf6tg041dpErOhbzQ+VY7Bn1GeEZMojduVHqww4M+5
X-Google-Smtp-Source: APXvYqzXVsDy0ze4FRIDwywvutY/B4QAw3R64INVMx+0auCjLO0cktw5lNHc/YQDg6mDs7Vet6xKvfAPTB3hUQaHhXY=
X-Received: by 2002:ab0:210f:: with SMTP id d15mr5424470ual.129.1566476038016;
 Thu, 22 Aug 2019 05:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190822064741.11196-1-chaotian.jing@mediatek.com>
In-Reply-To: <20190822064741.11196-1-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:13:21 +0200
Message-ID: <CAPDyKFqEqF_ZHerbkTqqcVBceQvMr_A+-MkbzQJBByhCv9B0fg@mail.gmail.com>
Subject: Re: fix controller busy issue and add 24bits segment support
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 at 08:47, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> the below 2 patches fix controller busy issue when plug out SD card
> and add 24bits segment size support.
>
> Chaotian Jing (2):
>   mmc: mediatek: fix controller busy when plug out SD
>   mmc: mediatek: support 24bits segment size
>
>  drivers/mmc/host/mtk-sd.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
