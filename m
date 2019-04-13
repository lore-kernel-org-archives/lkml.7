Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A60C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708952147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVZGMPA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfDMV35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:29:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46036 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfDMV34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:29:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so11986219ljd.12;
        Sat, 13 Apr 2019 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7J+P7Uf8Unba2Uj5IG/VoFHvERRDNoRAJeURaqcEVAU=;
        b=lVZGMPA4VhVTer5pR3EnKSKb1D5tB/dq5dUwo7DAL3CV6PNqK+y0XQeSnCj3n8u0Xp
         KlHUfX3Ejp3vvOThlKw+sfy2Kih80tld1Wf3S6Svsdar+logNK93qaqR9ZmzUbpL0xI4
         LnBGFD0jTZN8p7JLVLFh31DUu+NIwYfkmQ0z/p4khW2Rj4JI23kMHFSCqfEGK4BG5rar
         rWoKGVng5rmianX9mcG7Aacy5qlb4g9PCmUdAAf7Y9If/GtWNcX5989tP9515Z/1BxbT
         2NjMF4YtOYVdw/VU5tdKo8eEZqjO3NXUMQ/8fwztv/Z5stQeyIaEmOvoRzyJIGhjIWjX
         tTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7J+P7Uf8Unba2Uj5IG/VoFHvERRDNoRAJeURaqcEVAU=;
        b=N4haTckfUfxWEPfRZxHjGH6L9YMtaQNORp+MuTFoNwSJXTFZsYF43cxFP12aGOKWFb
         byEwxGLeHdaDgXrVGvzCjRrFRffNLDTE7Yj/J/AV3UE/DaF9anPzpo7itxYmw4gfOUvx
         alAU3O5SwTy7wOHYLp6LtplJH59bYWSz7SPzRm4130GDI9cw9SjlQR3bBjR91xb1V36w
         O4m2L8otsNROaAknqsx5NdMZnOVQoacuqA7azJgQdmHW4esKIiUs6FmGYG5gJhAnJTPm
         BiST4382c0GoUAvNwotGpBPiEA+07NFMDabYegWQ2mza4vnN8mCbhnDxm2k5lS6E9rTW
         /g9w==
X-Gm-Message-State: APjAAAX7AFL/Fdiwst0lXcH8WLseIfjHCuUbnYeGC0sz1bOJW9EZyXib
        8zMpvrfIZo6GazLaABx7l6W1sC5BBa41jrUN4NI=
X-Google-Smtp-Source: APXvYqxYDw5lZakXUzxhfzZy7bxXvRaAoIx17u6dOr7f6y1AWS2QaQbgECnTnbiq/Ebh45nVC4sXL8gw5RycZlE+2xc=
X-Received: by 2002:a2e:96cb:: with SMTP id d11mr34087352ljj.157.1555190994701;
 Sat, 13 Apr 2019 14:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-15-olteanv@gmail.com>
 <20190413154245.GF17901@lunn.ch> <CA+h21hrPHmzxAqdcd455qvzv0KqO93Tf-Cagy7BxMXW9DsH0CQ@mail.gmail.com>
 <20190413164443.GI17901@lunn.ch>
In-Reply-To: <20190413164443.GI17901@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sun, 14 Apr 2019 00:29:43 +0300
Message-ID: <CA+h21hq9FN5M7J36wq5V3TbV_uaKKZfTqQvuLWmGXPGxd7R37A@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 14/24] net: dsa: Introduce driver for NXP
 SJA1105 5-port L2 switch
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019 at 19:45, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Apr 13, 2019 at 06:46:57PM +0300, Vladimir Oltean wrote:
> > Hi Andrew,
> >
> > All I'm saying is that at this point in time (patch 14/24), the driver
> > is being introduced with DSA_TAG_PROTO_NONE. Then support for traffic
> > and switch tagging is added later on (18/24). I was just explaining
> > what can be done with the driver up to this point in the patchset.
>
> O.K. So at this point in time, the driver is unusable. Too much other
> stuff is missing. So i don't see any point in mentioning this.
>
>       Andrew

At this point the driver sees an unmanaged switch. Whether you
consider that unusable or not is debatable.

Thanks,
-Vladimir
