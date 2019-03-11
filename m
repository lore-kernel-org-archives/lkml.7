Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDC9C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BE205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+Z6+xtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfCKQim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:38:42 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:45168 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:38:42 -0400
Received: by mail-lf1-f52.google.com with SMTP id f16so3918292lfk.12;
        Mon, 11 Mar 2019 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0PGXCmXKrlnoxNSGHMhNSQJzWWUf0FMutLRxeeIwAk=;
        b=n+Z6+xtA1KbfksxIjPLR2AjxlSwITPMEuHLhJbSJpOeEkcyId6YYZP3VyygzyKczpm
         UxCu3rPxwEfk60yk8ToblYl5Laba7NVw2W+xPxUKszs8xl0qOKFAvxE6uRBkeDCvXWzk
         ixeGnHnB/uQJeliWs9AjBJcerKyOh9ykn8yrZvZ1uZyV/RpDn7FKJgVawUajLRxjCH7m
         oLgHGCcoUEEV9NhkoPDLT3fiwHI7xgVAIMbvD/GuGQGxii/71+EIHJA9ARgZelvodQ18
         2nTTp6gDfh5AHbdqE2mGAPBBy7wp+xeoEHmOn2IkYKYkYmhAczrgFO9BzUzumuxeCZG2
         fDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0PGXCmXKrlnoxNSGHMhNSQJzWWUf0FMutLRxeeIwAk=;
        b=eYxURN44b/o2QrkJTrgRodxMXFHNd0z5v5nMnJtndIoX5XqvmJMJCu81SCgsRxsMY3
         XpTJm8M5JmB1qqxgq+e7t7pT+d8yZcOBy13oHuqqi8HJLy/9w3PYaRVmj7s6dzL6XWBf
         x6Czd1jlNbaIXwTE7l0TB2snMXnX8beJRC/sDztlWajfTm8zDmSHIzel0X9MtVlVYMET
         2T0U/AtlRXbRmv82VlgnGKV+4TflrWMHFP4XDS4vmcqpwQCZZjaHG+xfjArpVRO/ZqFc
         ae9bQ7Qskq8fVmILr7/5XcOZA0FJJ9mCC1yF2ysHmdqyLMCs8hYvDAxCnqhpSyJhxnkg
         lAaQ==
X-Gm-Message-State: APjAAAVghIj8XwpFeJaBcpo/7WDC6m5+Ru/xVKiAWjZ7NhPYDR7RT/fL
        GmJGvDYlzaUQXK1CbPm5J1qFbS9w6INgtTou6dP7RA==
X-Google-Smtp-Source: APXvYqyxZqSeaKPgibFTDzDst1aulkW4CTahSoEnezCr24hgz+tvn7QbqSO1trKXfukQoo4YRGA2N+YqQ4VedAHOp+c=
X-Received: by 2002:ac2:5506:: with SMTP id j6mr17954593lfk.95.1552322319493;
 Mon, 11 Mar 2019 09:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <1552304271.2453.12.camel@pengutronix.de> <1552319997-24622-1-git-send-email-eric@nelint.com>
 <1552319997-24622-2-git-send-email-eric@nelint.com>
In-Reply-To: <1552319997-24622-2-git-send-email-eric@nelint.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Mar 2019 13:38:48 -0300
Message-ID: <CAOMZO5B9rYwRu=xa4W1+oB=zbjyMOuqrKxRDqwcviCF_94ebXA@mail.gmail.com>
Subject: Re: [V2 1/2] clk: imx6q: remove unsupported pll4_audio_div
To:     Eric Nelson <eric@nelint.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Yongcai Huang <anson.huang@nxp.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, tiny.windzz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:02 PM Eric Nelson <eric@nelint.com> wrote:
>
> The pll4_audio_div attempted to reflect one bit of a two-bit
> divisor (AUDIO_DIV_LSB) in the CCM_ANALOG_MISC2 register.
>
> Unfortunately, this divisor is non-functional at least on the
> latest silicon revisions and has been removed from the reference
> manual.
>
> This is discussed in this NXP Community thread:
>
>     https://community.nxp.com/thread/462806
>
> Remove the definition of pll4_audio_div to reflect this and
> reparent the ssi, cko1, and ESAI/ASRC/SPDIF clocks to the
> pll4_post_div clock.
>
> Signed-off-by: Eric Nelson <eric@nelint.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
