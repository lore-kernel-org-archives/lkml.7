Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD6B20879
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553626305;
	bh=Q/C09uc1ekZo2nnOz4l58AoXC9iY1UCQzxzHbgR2rbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zKd1FWP7Bs9uR6mWklHcEnI5FjQmOla3LMF4rTF9mtVr1T/TawbUOS8/RmfWbU9ZK
	 eLzO7J4zoR3JSnOZYWeeSRl/hwbiZJSCyRbCJGcEdEHju1UR2CUyc5NZpyhx1SH7xT
	 ER73aQeqO9zR7IA5jJw0KtDYIJt4Rf079RYPiS5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbfCZSvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732320AbfCZSvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:51:43 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 252DF2087E;
        Tue, 26 Mar 2019 18:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553626303;
        bh=Q/C09uc1ekZo2nnOz4l58AoXC9iY1UCQzxzHbgR2rbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aVoxrRSfYfFOha8OlEFURLGvyOS5sdELBJ2uvnbh32SIsLJR8v5Six212O8KZunO9
         7DHTTDDhjHOpBNtQzH93+RDxWCAK2DKunQVKUh3J2MiAX/AIeTWpuYKSQzlExYKl/2
         he6l8G6aXkMyg7+qRipZr1wqcbKu+KaAE13yHgxs=
Received: by mail-qt1-f176.google.com with SMTP id k14so15930982qtb.0;
        Tue, 26 Mar 2019 11:51:43 -0700 (PDT)
X-Gm-Message-State: APjAAAVH9ZNOYNmXqaMxuPsBcl8Sf5ko/IpwnuQZ86uuY7MTdTLXLjY8
        lsSTUWG5GlSl+AfvixcQvAXs1bd+wTecU8qDoA==
X-Google-Smtp-Source: APXvYqzRgH0mlnfkdrhm8ZNXZ0cULWwchNaBzlAD94kd7hlvTG70fZ2tKOIoGIlNV1e3clz4Ti4OJVdm6Pu+Nw+yANY=
X-Received: by 2002:a0c:b107:: with SMTP id q7mr8281300qvc.77.1553626302346;
 Tue, 26 Mar 2019 11:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <1553218974-20464-1-git-send-email-Anson.Huang@nxp.com>
 <1553218974-20464-2-git-send-email-Anson.Huang@nxp.com> <20190325204137.GA19824@bogus>
 <20190325205914.4gd5tzfyryvbthea@pengutronix.de>
In-Reply-To: <20190325205914.4gd5tzfyryvbthea@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Mar 2019 13:51:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGVY3PN6rsM7LSFfLWOR8h62hpt3wn9UkQZo0eNepiNA@mail.gmail.com>
Message-ID: <CAL_JsqJGVY3PN6rsM7LSFfLWOR8h62hpt3wn9UkQZo0eNepiNA@mail.gmail.com>
Subject: Re: [PATCH V9 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Anson Huang <anson.huang@nxp.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 3:59 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Mar 25, 2019 at 03:41:37PM -0500, Rob Herring wrote:
> > On Fri, Mar 22, 2019 at 01:48:05AM +0000, Anson Huang wrote:
> > > Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM bindi=
ng.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > No changes.
> >
> > v9? I don't recall seeing any previous versions.
>
> Not sure it actually matters, but you were on Cc: for v7 and v8 at
> least:
>
> https://www.spinics.net/lists/linux-pwm/msg09300.html
> https://www.spinics.net/lists/linux-pwm/msg09321.html

10 versions now in 2 weeks is why. Reviewers do get busy and/or go on
vacation. Please slow down your pace and give people time to review.

Rob
