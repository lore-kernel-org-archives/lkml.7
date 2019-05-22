Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE32C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239EE21019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtpAYJeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfEVRuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:50:10 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37056 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbfEVRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:50:09 -0400
Received: by mail-it1-f196.google.com with SMTP id m140so4437100itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJPxAPmrd2C4lX1coOIuzlgyV9VAK5JxLftwCKVxBHg=;
        b=XtpAYJeRmqcV2qahVe9bnVhLNmRBX+E8AvnMnWZdm34v5n5IxPxvYf3GdHVmIcM+dR
         G/bykiZ5qWgHHcx/cBLMSGZo4fPp6mgehuO3IycMm3Zvpa9kbWK7eSOGsW3UacnqmOxz
         v4wrca0Ge9mo4keTJwTJE4ECHtfFHR4C1F/2WCkELXTK3qjS4HAYF2tH0GYCFhLPjhVe
         +bLGHnf8PvzRHK3kRSpagZ95wEx2EndR4ufmQoqO0xBhv/l18nnE/9H7eJHnZ1N0jUvi
         Ta7YsAeCfwzvY4jCvernQpgQuZKE3WB1hJp95lLS1Ldiz40kFfXpj9qdqQ+mulY2yvhf
         fvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJPxAPmrd2C4lX1coOIuzlgyV9VAK5JxLftwCKVxBHg=;
        b=DRbtSqP5tzgifqE6m63lb+POPgF2Ahh3T2u16KWORpPfVYsOPQ0ZzRo/wsJse17oEw
         6lj+eYaualqPz4Lz/uECOAFCWSXOrAB2GU/qHEXN8k+FV6FvurZRGgFk6f48szTPRosF
         pf7rf/o7JXdDKPEhxAjhnWPIlN9FzLSC7NacmnukrMKg4/QrCZrs4yCPQrMKsuKAF4nD
         i0MlGGnFX7tS2kTJ8G3HvvugLdGUTUHjrMaA4qz5Mr6+mBBaM2uheLyjeKl4+9JSbpSS
         WWuV7DonyMvnsVwzygC8qplvTVMApUU7Yt5Qu6VRuWJqwZdBIceIwBs21rm2bFiLLOBG
         MrCg==
X-Gm-Message-State: APjAAAUx7SIbMDzH4Wgti227CL5Hv8n3yNJY8z+NmSYRjHmzo4bMww3g
        rgRTjMeWv8z4huFPBRzzPELWQxypiINccSGsmco=
X-Google-Smtp-Source: APXvYqxJR8aAkCSA3tmznR7qBXCq6yO1/12SPYPe5qh1go89kiAn+y4cSSRa+WH8WDBeqh+6GyQgwXeUumpzjizidug=
X-Received: by 2002:a24:d43:: with SMTP id 64mr2561513itx.114.1558547408444;
 Wed, 22 May 2019 10:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190522071227.31488-1-andrew.smirnov@gmail.com> <1558517848.2624.34.camel@pengutronix.de>
In-Reply-To: <1558517848.2624.34.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 22 May 2019 10:49:57 -0700
Message-ID: <CAHQ1cqHxhafgsnt6O9G6iVFjbh0+HNPKrFq6UO2hbXcU2t28aw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6: rdu2: Add node for UCS1002 USB
 charger chip
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 2:37 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Andrey,
>
> Am Mittwoch, den 22.05.2019, 00:12 -0700 schrieb Andrey Smirnov:
> > Add node for UCS1002 USB charger chip connected to front panel USB and
> > replace "regulator-fixed" previously used to control VBUS.
>
> I've had a similar version of this patch, but also added GPIO hogs for
> the UCS1002 configuration pins, so the device is put into the expected
> state even before driver load. Maybe something worth to consider?

Makes sense, will add in v2.

Thanks,
Andrey Smirnov
