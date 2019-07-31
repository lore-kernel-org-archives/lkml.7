Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F21C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF60208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EyxO5+OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfGaRsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:48:41 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33886 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfGaRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:48:40 -0400
Received: by mail-yb1-f195.google.com with SMTP id q5so12585390ybp.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97bUgywrkt2JLU+RvFdPEdGzMFShn8org1G3e5S/uHM=;
        b=EyxO5+OX8TZl1lHQ7ArUfTEeg/B9wHPTVkLsGhzJstlJnK1W+6N48SSdYdzrlE27RQ
         M/zfJM0+YSC1HLuF70QQJgla+28Eowzm+UsAUW3STgo+9yjifAssY2lyPVq2e+Q5FyKM
         7SRhz9QqWLBiqNj5ktR/p1w1Gs/rtjbfM1HLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97bUgywrkt2JLU+RvFdPEdGzMFShn8org1G3e5S/uHM=;
        b=gY6foJ0UtdS9Y7bcH/dRbFdFAPLiSuKkRIZoW8NABGbnli0pSrVKSeZwSm34hhySXi
         yPgvBcznOGAHMMItsQjnusIwZ2J/ZCMKOHvTvqe9IuW+mTC1nlOKjpb/rPKqKflylTSA
         SMZkTpxFUrtijKpt5kV7m5bEHTFOwXmFTblrFQtfTQtVLryO5DBEkYoorSdgZSPEpogp
         +KjSP0XE7Vjy7D9ZWg+esc6JgWZn4tfhjGatxs7dbvctt7tsTRhI8bNQhc8NNDQuXBzL
         xDBlkQgsliSygvfLwfkVxziW7w+9CF61nFDT3kUwbL95vGmEWd5+ToHlo4SzG7fgRR2X
         JL8Q==
X-Gm-Message-State: APjAAAVENlzaQdTxMhplwzFeIhkCabHMOnhQpwGKjJY9F/4kiCMtq+4Z
        vNCx8X3nTGSGMuhF6QJAaYqVnmViVtXpSSnvJDgUJNaY
X-Google-Smtp-Source: APXvYqzXQczZLX2Bew/J2kuvcDgEfm2FR0tf65spj5enhPfjl43a39qr0JeVMwR/j0CztxWLiO38boqycs9qZsTXKo8=
X-Received: by 2002:a25:7782:: with SMTP id s124mr38432904ybc.80.1564595319728;
 Wed, 31 Jul 2019 10:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190731122203.948-1-hslester96@gmail.com> <CA+FuTScqD4bMpm6n13ETFVEvSKnk_rRUzspzs9HB6B5Un101Dw@mail.gmail.com>
In-Reply-To: <CA+FuTScqD4bMpm6n13ETFVEvSKnk_rRUzspzs9HB6B5Un101Dw@mail.gmail.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Wed, 31 Jul 2019 10:48:28 -0700
Message-ID: <CACKFLin6kXeHrCR_U8R+CYDWCW2c=N5m_0SNupO7rqZmaL3SGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bnxt_en: Use refcount_t for refcount
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 9:06 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Wed, Jul 31, 2019 at 8:22 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > refcount_t is better for reference counters since its
> > implementation can prevent overflows.
> > So convert atomic_t ref counters to refcount_t.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 8 ++++----
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> > index fc77caf0a076..eb7ed34639e2 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> > @@ -49,7 +49,7 @@ static int bnxt_register_dev(struct bnxt_en_dev *edev, int ulp_id,
> >                         return -ENOMEM;
> >         }
> >
> > -       atomic_set(&ulp->ref_count, 0);
> > +       refcount_set(&ulp->ref_count, 0);
>
> One feature of refcount_t is that it warns on refcount_inc from 0 to
> detect possible use-after_free. It appears that that can trigger here?
>

I think that's right.  We need to change the driver to start counting
from 1 instead of 0 if we convert to refcount.
