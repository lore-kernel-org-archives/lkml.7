Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C9221019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr6gh8r6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440214AbfFLQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:22:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54812 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440150AbfFLQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:22:40 -0400
Received: by mail-it1-f194.google.com with SMTP id m138so11764930ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VQVkJNfEyEKYicf2dfqO23vhFLeo5KbOT0Pge8qD5k=;
        b=Dr6gh8r6rHt2ovOQ17NVfETX5nAu6deuvULXQJMdqjzr7EjnhjYqwZoxKFwwkT4fuY
         xfv4j1I+6MKhbF0s0WKeU6Et+/+WQtZe2OLPsh6lABzCsrOfbbEn1klyezkXcEzuBrBJ
         eCQuj1vCDq4ezpiVllUz06Iav7AVt5WR+1CI7DCc6yBdMvI4ULqFnV6Kgdlnm/LTqu1o
         o6uipJCmYhAQBAIkQd9xb0a6e12eUyOXZ2DyggVLFmSV8jn7UQIJ9ORlyG0Gw6cIy3Aq
         XUGr7sr5QpIa5M8AbT8WauHAtAxd0uq1gE/LAlfq+npJ/79Pfd28ddMF2DILbshU3Kk/
         W4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VQVkJNfEyEKYicf2dfqO23vhFLeo5KbOT0Pge8qD5k=;
        b=Tqya6nE+ebHgNCFYw5QmI/xaeWjM69R7bebTBTbFTOuqDVfCxazKe8WMxawBULNkMn
         Ze0O9IpMv/8O7F00Sd52pli6mv3KOJ/vhMHTGoXtQJ56xqlt43pdJkev6wEgmzlq5WCB
         PBXMX8+RI42bwYJ2dPINubnjoqUYbBAx7oa2EEPr9++8ms0zyFIiHJotgLkarX+X+gDz
         DsATjguMx4O+MMxYXvudhaRhbBMuxKb7/WgYhSu4EhM0S11GJgLNo28Ya+NUqHUeJxi4
         UGNahz5lZVXY1sHNfgLqxliW5DL8lYn7zIENYAnv0AgGvcg2ZePcLlBep7BqFI5+nyY5
         x7vA==
X-Gm-Message-State: APjAAAU0AcVxMUMs93y0/kafntJdMJ2FcLA9TWVyv5zAgrR96xnTrMSf
        VZs4hS5OfZlO2VplZqQMYUKWcAOLKUpZZ86Ts+M=
X-Google-Smtp-Source: APXvYqwJ0MYlKH9ylDg0uGfTVYrhpe5COb1pxSEhCro/xeeSsds/sB0chvu2MbiYoozMHJiPzGWSlb/fcIQn+jkSkRM=
X-Received: by 2002:a02:5b05:: with SMTP id g5mr51762515jab.114.1560356559206;
 Wed, 12 Jun 2019 09:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
 <20190612083252.15321-11-andrew.smirnov@gmail.com> <a1c125d2-1c7a-c190-8b7e-845a2ec1d2ea@ti.com>
In-Reply-To: <a1c125d2-1c7a-c190-8b7e-845a2ec1d2ea@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 12 Jun 2019 09:22:27 -0700
Message-ID: <CAHQ1cqG7dPFarphmBWSSqYAuO=6Kev4eFsBM09zUDJFek3UaOg@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] drm/bridge: tc358767: Add support for
 address-only I2C transfers
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 5:48 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> Hi,
>
> On 12/06/2019 11:32, Andrey Smirnov wrote:
> > Transfer size of zero means a request to do an address-only
> > transfer. Since the HW support this, we probably shouldn't be just
> > ignoring such requests. While at it allow DP_AUX_I2C_MOT flag to pass
> > through, since it is supported by the HW as well.
>
> I bisected the EDID read issue to this patch...
>

I don't think I've had any problems on my end with this. I'll double
check. It might be the case that yours is the only setup where the
problem can be repro'd, though. We can drop this patch if you don't
have time/would rather not dig into this.

Thanks,
Andrey Smirnov
