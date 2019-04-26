Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302C1C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55BC212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n21DKcpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfDZRN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:13:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40396 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDZRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:13:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so1869774plr.7;
        Fri, 26 Apr 2019 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gc17CQ6FTRdjQ5C0cWLlqtto/MiFjSm/smNNQ0GtJCU=;
        b=n21DKcpU6bFtGAUzoinuLCUWHsPYNNJNaveZg7gNFYziDQuDkNunvmhaM+9K3Xb334
         9+yGck9m+MqFZVRNH7mQGtsTjP2L3BS2t8SEZq4jM6nuj2G0LgLPCcn5Q06/Yhk6pIVi
         4Q/sWL/QyfSH2I/Sw9MB/YhrJ9Mdru7BGZb3srakXX6aoBwxZZADXxj+buVsQ3GXiDWk
         jQ9VB/aqiR1X+dX0vlrdMfKi6rMYtyrl0sR/pkkhFIRydGlJQ7mgiJucfep4FD10y16N
         angAgKaDnl/ZIA48UxhXbcPRZWK1e73irHNDXzbCUZGZfeU0vHb7fqhymKmRmTyjL6WX
         nxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gc17CQ6FTRdjQ5C0cWLlqtto/MiFjSm/smNNQ0GtJCU=;
        b=R+3a15Y0bmo6z6Ou/BbM0TlTTy0WRJAPFOLC0ibW9Vcx35tvdMy/RJhqRgrYRODqtu
         /Gv619yRhGLkJBHNUraqomkkprSJUrkuPvZ61Vo7VFVxuiq0t1hZ+70/btf7jy5znQCB
         TWEMdL6RXJBsvGu1kU7G4oX/i51iu23anbkRyaQz/iIEcEiefn5GDQKoC+ma/CfRlAFZ
         eWMhnK47r1NzcN3c0LvksVtwg6nP3dWtAsHG71wEyqFpQpUhqqJyBJXvRaBlXygLkRqr
         AczbooqGzeCyuyoAF2kBpjNujG792m0i21/WMEv9pVchdnuMrTblEVVWsr3mnr/b/7e0
         weNA==
X-Gm-Message-State: APjAAAW4mdbOdDyQFkRm8+spwFIKxXVhoYU0Wdh+Le3vmAhpytTaYASW
        Fc2c07iTpUuUNhxd7S9Polstlf7lnBokwSxqbVo=
X-Google-Smtp-Source: APXvYqzs8eRuWVjCICHfUCdgGYcsiDeLtuSZ2M2WiSTDeifRfIPCeZN1uJ5nagft3rrORQ+VniMi5NXW+9KU0mNeolo=
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr9947362pll.87.1556298836280;
 Fri, 26 Apr 2019 10:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
 <CAHp75VddTO890=DMa8pQANBGMMaDtCGgVb_cxCHc_Y1hxNTHwg@mail.gmail.com> <28d2856b-7fe5-1b42-e1bc-1c3601265dd2@siemens.com>
In-Reply-To: <28d2856b-7fe5-1b42-e1bc-1c3601265dd2@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Apr 2019 20:13:44 +0300
Message-ID: <CAHp75VcENChz5BvZn9YdT3-rBZq4U9dkF-OtVm2rYprvpqXG6A@mail.gmail.com>
Subject: Re: [PATCH] stmmac: pci: Adjust IOT2000 matching
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        David Miller <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Su Bao Cheng <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 6:36 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 26.04.19 16:34, Andy Shevchenko wrote:
> > On Thu, Apr 18, 2019 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> >> +       /*
> >
> >> +        * There are 2 types of SIMATIC IOT2000: IOT20202 and IOT2040.
> >
> > 20202 ?
>
> 2020...
>
> I can send a fix-up or v2, whatever is preferred.

My understanding that if Dave applied, you need to send a fixup.

-- 
With Best Regards,
Andy Shevchenko
