Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB4FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B90E2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1JGHWp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfDZREl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:04:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38947 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:04:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so1911334pgj.6;
        Fri, 26 Apr 2019 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7zNlK1betosrFH/BCVaeqIioafWUd8DPdFnWt1Oy7GQ=;
        b=Q1JGHWp/6QJkmaxij4MEyeszUMRmP9c12l2fDn1WI9mZ2RS11GeOaqOyNkJlVCok2/
         YV58rkDQnJXin+xz7bDguh1oluWhSDr9w2Wd6/EdAkRorCOKVZN+hnXpmszA9X8KUwsV
         wOqfK2m40tVx4nnsw1d+CEM89xgf0Ql5SavNlWPbrNxNX93AKsf+Qm0gN1/PA42GIJLi
         eb3Y+JruVAtuaEVOa4dsLiWEON8e69/53YiTvA5Xll/jz63K7VrhEiCUttBYHR7uA8Nu
         /EZPl7uZBDq5JBn2x0Kptu3DLbOgHzt3OKPBinYQXXPUZ4Vv3IjvGgfOgT3xOYNP0g3D
         gwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7zNlK1betosrFH/BCVaeqIioafWUd8DPdFnWt1Oy7GQ=;
        b=htuiIvDbnWsgcO/j8zb/ojfpk9DNTl3dttOOlGNoE5xdcjQXYk7xPbF5/Js4cJBdRx
         VKcjQxipxLmhGdwb0aHxcOQYCIcs3Op5WauhXgvlPEwFzKTd4hLha9Vu8FmNuGwzKEh9
         9tuBJ6ywM7MninBvhDeth8rq9NMVvN//CZGmn4wmbrcjZREtbjAbA+U/grTxQHaxcaQP
         mE2m04dVUSvB9AgvObdA4NTAS06OaxYebkKy6TakdMObFo9ALsw2TiVATfZ6IfGW+DMJ
         TGHggh/CcZNNB41kxWJ+HDjqXBnwqPIFh78dn+ko93E9za2Kup8r9H+D1r8akKBztD6x
         qvMw==
X-Gm-Message-State: APjAAAWo9HlP4K/0LETRHvvhbFJtGvFgx78qD6qy5sxji2bhqYJ2z3rm
        kR9hGX9T9Kwnr5ISz4EZRKE=
X-Google-Smtp-Source: APXvYqysBR49sd/I3qpTj292b80UptiG2M/+wC1xYonyovDMjXV6NTGeQaw+1M/gxkAYKrdkbprzcg==
X-Received: by 2002:a62:4595:: with SMTP id n21mr48726359pfi.79.1556298279995;
        Fri, 26 Apr 2019 10:04:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6sm33834436pfj.95.2019.04.26.10.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 10:04:38 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:04:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Chris Health <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] power: supply: Add driver for Microchip UCS1002
Message-ID: <20190426170437.GA9087@roeck-us.net>
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
 <20190417084457.28747-3-andrew.smirnov@gmail.com>
 <CAFqH_53vo__70Xm5pOoLvqPG2iNN32VP5cbFCatDq=o0GLYzsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_53vo__70Xm5pOoLvqPG2iNN32VP5cbFCatDq=o0GLYzsA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 06:51:51PM +0200, Enric Balletbo Serra wrote:
> Hi Andrey,
> 
> Many thanks to push this upstream. Actually this the fifth version [1]
> of this patchset. I think that is interesting for the maintainers
> maintain the history and the changelog.
> 
> [1] https://lkml.org/lkml/2016/3/14/233
> 
> Missatge de Andrey Smirnov <andrew.smirnov@gmail.com> del dia dc., 17
> d’abr. 2019 a les 10:46:
> >
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Health <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---

...

> > +       static const int bit_weights_uAh[BITS_PER_TYPE(u32)] = {
> > +               0, 0, 0, 0, 0, 0, 3, 5,
> > +
> 
> nit: I personally don't like these empty lines here.
> 
I stumbled over those as well, but then I realized that they
split up the 32 bit into bytes, so it does make some sense. 

Guenter
