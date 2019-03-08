Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D24FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A5520684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbqGKb5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCHK1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:27:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41262 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:27:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so15453290oia.8;
        Fri, 08 Mar 2019 02:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnXgkIir6mQEDlAELzrhBYxiysqDPa7CalQhi1AUXGk=;
        b=QbqGKb5UACgLl/hp937PG15juTq9X25pwXbNlQCGmdml96ghaj33mYCP0HvqmmKtRa
         oyDvnYIxVXtqlIxZOBqykvExHt5NRIRGHXlo/PTBcanL6axNoB5aLRJASNW5Vxfq4jFt
         nOqDnUrgN05XHQbpDBmsWfSHy/XePTSZ91ySwWqfIzg3kKvsU6p9xeu0OumJZf6W6eRV
         aumPBDBItEbw8DowxL0148z00saVp/unFdD9/h8OOTpNQcQg06bMfny7tFDp9AYIFQR+
         E/19LHGdirilu5RMteUpwY7Vz8vwvqzNLmlmpb4h+rEpvZfa+TvHr9rD1dWIXQXURcTi
         M1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnXgkIir6mQEDlAELzrhBYxiysqDPa7CalQhi1AUXGk=;
        b=rh1Akt+9jYb+Qnkc8xhMJAHFwlf6xXJTuvf9DOKNv8puMZV1PDXxhyBnGyrhYUu5wW
         QnbXJSY3i2u2ase9Yiny/PHdikszff7sxKSjoutMnAcgoLyhSpYxM4vap0Wpf1UyPtGs
         XYp4KyTftuacGc/qATRtuC2FH396IGM/JF+TVbAAxOjn/M8n02Ep2duBSwc8/ivxHE1A
         ljx6CmTQxylxujVyFMoN/nREFmGKizHvt2G2n+eDQRNGdXITso/iH8T6Dqwk4qxd3Kt4
         hxDrpMYtcTVdkJ6I99XJRXc/jB2UtmSc9c3a81fkiMqV9Cj6y41RRDGY2NenqUOPF+Zc
         DKqg==
X-Gm-Message-State: APjAAAXKmuIUpgU33vWCWscSOAoaMTMgx8hJKOfkRvQflCBZIgLMtW6z
        U9IAZe4coIlSq6aa1PlkyNW+jnnENa/I2CCytyU=
X-Google-Smtp-Source: APXvYqwMPgewsPFGGDsM6rGufTswo6qoSnA1UHfuu2r6vL6LooTiGt3dAN/5e6PLydOuvoq25x0iRDRx7lcHAcY58a8=
X-Received: by 2002:aca:ecd7:: with SMTP id k206mr8096395oih.67.1552040856818;
 Fri, 08 Mar 2019 02:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20190308010148.9000-1-aford173@gmail.com>
In-Reply-To: <20190308010148.9000-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 8 Mar 2019 07:27:37 -0300
Message-ID: <CAOMZO5BNxC4e9X0ZKk4sENa98KKf8_pvJnrMYnev9hrpCj3xUw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Enable fsl,sec-v4.0-pwrkey
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:02 PM Adam Ford <aford173@gmail.com> wrote:
>
> The imx6q Technical reference manual shows the interrupt is
> available to wake from sleep using the power button. The driver
> has been available for quite some time, and other variants of the
> i.MX6 have it enabled, so this implements it much like the others.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
