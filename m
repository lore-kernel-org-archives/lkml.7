Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9EEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CAC20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL6VWfhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfEMMPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:15:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41362 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfEMMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:15:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so10698248lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rOr3Gsm0mGb0WDhqm48mOPhgHOZnryd/bgzELt3x9Zw=;
        b=rL6VWfhYLeCehu+qqHfXaxlLofb6OIzVuacutGXxmBDVxcTJLbAxLzCkyfg+dzVnXT
         Yn3r+z6YtjDmiHRyVfhDJUUfhLy+mHI245UAy5ckCz6MxawNAISUWGLVppEKZQHxo68C
         rJ9RnEhFuQ1lVl0z0xUMpHyFN8XwYS/1yEG592yqm+P6x935Qys5OvObBxQwpZz2pFyP
         BltkTnBwFYbDsgsa32gqF66ot32DkXNTw+IETeecxZMZVr6CR7eSfdip7s+DVRX1LmEN
         hwm6FXZox2QXVjeai8RV5sUfrNVWXtfzrb/DnhGy84qJMNnCjXoIJt+6W8KqnUfuE/6V
         oCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rOr3Gsm0mGb0WDhqm48mOPhgHOZnryd/bgzELt3x9Zw=;
        b=ldEjEiguLOpUGL20WPNy/99t/mG2Mkys7+dfGdNh3POI6c/BYXFAxJxNXi1bKl6Vn8
         v52R+Ftr+MnlhPlpH3aF+mub7ld9jd+eiZPYxgqi3UAzdYP6y5/kRNRjQY8asjqW3sQA
         nmUiA7oyvnfu46vh/aouzpZz4CEB/p2Qno8NvyVk42TKf/vuDNjjiFpTa8XP0Z/2LPWv
         1YgXK1NWj+NSQNKUw3+R81JAwQkqfQ4HktlKQ0bt4oA/gwexR9lqU0T/usniNYCvBxhj
         DCc60cmRP9Jdq+s/314risy7nr6ct7FwcXl5599Zwb37nHNcS3xf9b/HBV9UQ3dqa+Yj
         J9CA==
X-Gm-Message-State: APjAAAWirXPq/4K5IqUijP/+ico77TwEF0Yyj9RkP3QsntWoc4ysaL5R
        +w7LMbpat4EgigOTktdi/mTlvZhsQ2M7k/W2zyo=
X-Google-Smtp-Source: APXvYqzp3sCYD8FYbrq+GHcnJ3/WobHowbkpbM/6uE98nh/hVVi05mnNbb26eUlPIVGuL87m2aTILeIqG1+5k4AAfqI=
X-Received: by 2002:a2e:994:: with SMTP id 142mr5345716ljj.192.1557749710047;
 Mon, 13 May 2019 05:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190513035909.30460-1-andrew.smirnov@gmail.com> <20190513035909.30460-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190513035909.30460-2-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 13 May 2019 09:15:05 -0300
Message-ID: <CAOMZO5Dkv_g-+GjYfrRP8h0bmRMws1iETRJiGmTBx7tfM_HwyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: vf610-zii-dev: Add QSPI node
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Mon, May 13, 2019 at 12:59 AM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> +&qspi0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_qspi0>;
> +       status =3D "okay";
> +
> +       /*
> +        * Attached MT25QL02 can go up to 90Mhz in DTR and 166 in SDR
> +        * modes, so we limit spi-max-frequency to 90Mhz

Nit: It is MHz, not Mhz.

MT25QL02 datasheet refers to DTR and STR (not SDR).

Also, the public datasheet I can see online lists these limits differently:

"=E2=80=A2 Clock frequency =E2=80=93 133 MHz (MAX) for all protocols in STR=
 =E2=80=93 66 MHz
(MAX) for all protocols in DTR"
