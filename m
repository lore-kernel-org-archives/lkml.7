Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B8E218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE1iTvF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCVTBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:01:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42133 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfCVTBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:01:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so3479836wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rcQyRQDzK04ZtP6ajwRLdrnI7q2ixPM5X5JNsniQqw=;
        b=GE1iTvF6z1nYYUX5YQW7FVm2B9R4gW0OiqzCr38w/xqYu8J5yFAAv9EZtVL/j7k5Xq
         5cY2UHepD/qjutIN8pa+n1cTKp8bbkn0SpqMBXFk1IXy+nJFGjXECbznwHtlsQGKz2GQ
         V8tTOm1Cv7EhwLd6w1DzsOs9S1nTtEsqEyOElTtyvfWMA+fQWXXWv/oHPJCoI9JUzIWF
         FVT41/v8A4JaK0PABOEs2jZMMQ9MqzGJsvOsmZJA69xH1TcWKNclchdIhb+7iKz6JIhb
         xKIlBm8nOqbvTWeXewQIRQkOou+1uGtknwjzBIDkYbwVegR8BnXW5wBi+zryXGUVHsuU
         d36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rcQyRQDzK04ZtP6ajwRLdrnI7q2ixPM5X5JNsniQqw=;
        b=FJWrma7dQ0BWj2eXkY5ZZk7d5U/YJmtHvAanQ2X5Wedn5uVIS3zPgO4jo1dpNfxTJ/
         bo0FW9fLD0ZgdxyYnB0q5/tHFi7QECL1pMTZYmbIX5sfj1oZrRyh2HbjElf3rHBty4gL
         O76k5jFtO7BPv7/Fq1Fikhjx20C5AGBH5BTlRAiyz0jVnaO4YJ3YSvDyvbmhmr41gW/t
         FQFpcR6stoDuV9DRFuOkugLL8B5YaTJECMokfS4JXBsZo1BbzI5PGPPTgVKijHjh2H+S
         JHk/NmcRnGGehe+ZsCY9dTnMuFIOKSceVfGe2EvmPRqWx0iax4L1svCRaqAJfdFWLQO0
         Qvdg==
X-Gm-Message-State: APjAAAXJDXIdw69Zb9wJ10LHYAvX6FWkCe7fjIl35FryvTUZ/dBWS2Ru
        orz4fz5ASNPV3wd54WarRZUfhyODZr0VGJT7Eu8=
X-Google-Smtp-Source: APXvYqzl1OUVAB1/n5sPihssIjeOfKJEd9026dXL4IDrGlTXBMo9po0JL42owyh2xA19mQfSWPiDh0+IRiXA+xMP/Ys=
X-Received: by 2002:adf:a382:: with SMTP id l2mr979352wrb.79.1553281278129;
 Fri, 22 Mar 2019 12:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
 <20190322032901.12045-9-andrew.smirnov@gmail.com> <7dbccf61-29fb-a6df-7f54-fd7c29bba57f@ti.com>
In-Reply-To: <7dbccf61-29fb-a6df-7f54-fd7c29bba57f@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 22 Mar 2019 12:01:07 -0700
Message-ID: <CAHQ1cqExqS7kRKBX=S1_Ki_etxMyi=XRHHh7bZ1ots4Z42zyrQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] drm/bridge: tc358767: Increase AUX transfer
 length limit
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 6:14 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 22/03/2019 05:28, Andrey Smirnov wrote:
> > According to the datasheet tc358767 can transfer up to 16 bytes via
> > its AUX channel, so the artificial limit of 8 apperas to be too
> > low. However only up to 15-bytes seem to be actually supported and
> > trying to use 16-byte transfers results in transfers failing
> > sporadically (with bogus status in case of I2C transfers), so limit it
> > to 15.
>
> 16 is the limit from the DP spec. I agree, 8 looks odd.
>
> 15 looks odd too, so I think it warrants a comment there in the code.
>

Crap, was going to add that, but forgot. Will do in v2.

> Does 15 byte transfers ever work? Or mostly works but sometimes fails?
>

15 bytes transfers work every time (at least to extent I tested it).
For 16 byte transfers it depends on the transfer type. AUX transfers
work for a while but then fail (as tested by dd'ing AUX chardev). I2C
transfers work intermittently and when they fail return completely
bogus status.

Thanks,
Andrey Smirnov
