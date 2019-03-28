Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652692075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVD0wPRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfC1BG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:06:29 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38065 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfC1BG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:06:29 -0400
Received: by mail-yw1-f66.google.com with SMTP id m207so4889440ywd.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 18:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UqAscVJjQY5uRXIwmL0bogWzapnjvJsqsbE7w+8Z35Q=;
        b=iVD0wPRKSHFjVwgMu7RJyXTxPop7FYBmp8dAyCwaIhbjw+6ypzbmyq61jlSFs8aJIB
         0e1bHoH7YKC4A1/ZJ5VtLuvXqnQxUjS8/D0ghMmIRj8PDlVIpUC0TPG5LrZYj/R6Xen2
         qBlWSMTPS4bl8Fa5nfXwdGLsrsbA7jpw+eRTyVn3WRn1vqtsBqn4wUZn9fpZpQ2sPBuB
         /02gN3DqT4uy4/t36YTrOGFMWzy1i/nw4QcWy7dHWaqRy5guLEcjwdmOM9imgsmJIxnO
         iHah+uY8xgq8SZU0AVUeEOJuiPVl3+YGKUSp3zKh5Dt2OUOTyRwFVzcER3cEq/+mGDuI
         AfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqAscVJjQY5uRXIwmL0bogWzapnjvJsqsbE7w+8Z35Q=;
        b=GBlIGSdncyPQnv3uhIc+pdZ8XBNA5IxurNtKfT5So5ljSbElkhQKgBJBJYqNnD6SWF
         OGZ5DUqfyoPYs/8dmEbVHuxUV3sWp2lhlfNR0/3kkGdesXGXpPVPtE4xFtYe1yI3wi8a
         PToa3/4WLvQrUtYJvpiY7DyI7SPKBuoADEIkv1t+vdOYhaGUHDttsC1nwOXwHMtsGT8d
         BpVF2So6NYDH2PqM65vVPfnI240s05wCvmNgz1SJhubFIng/vbXLzAA1O7f4n+kZCciN
         OTtC/L4w60eTTBhKgPQM1zvri7OMgF0NHot57gP+KoOWYy5FD09nprn+3JL2wiJ6u/H1
         K5NA==
X-Gm-Message-State: APjAAAXKiFGb4wCLx7k0bIONXe67+PRQ/VRj4oLYQKrTvgnfmaEgmFIe
        esoUJ6aIPJwoPC5D7nX55z4hG/8gxCzMCuXmGlg=
X-Google-Smtp-Source: APXvYqzldoRPM8SM0MN6SCtu1ovThO+Iy7igiiQDvmBW381DFqBHvmsKqBs9pjy7D9wj200tzv3CofCOJUTzWLEfjeY=
X-Received: by 2002:a81:118c:: with SMTP id 134mr32857349ywr.151.1553735188565;
 Wed, 27 Mar 2019 18:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190319020519.15209-1-tsu.yubo@gmail.com> <20190327171029.GA13738@kroah.com>
In-Reply-To: <20190327171029.GA13738@kroah.com>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Thu, 28 Mar 2019 09:06:17 +0800
Message-ID: <CAKq8=3+jjSLb3VznTrVQ47fcR-dMEpScUWN-DQGuKi+v4ik_fQ@mail.gmail.com>
Subject: Re: [PATCH] misc/fastrpc: add checked value for dma_set_mask
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5LqO5rOi?= <yuzibode@126.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 2:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 18, 2019 at 10:05:19PM -0400, Bo YU wrote:
> > There be should check return value from dma_set_mask to throw some infos
> > if fail to set dma mask.
> >
> > Detected by CoverityScan, CID# 1443983:  Error handling issues (CHECKED_RETURN)
> >
> > Fixes:f6f9279f2bf0 (misc: fastrpc: Add Qualcomm fastrpc basic driver model)
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > ---
> >  drivers/misc/fastrpc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
>
> This patch no longer applies to my tree due to other fastrpc fixes being
> sent before your patch :(
>
> Please rebase and resend.
Ok, will do.
Thank you.
>
> thanks,
> greg k-h
