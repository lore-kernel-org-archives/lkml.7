Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E3C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11C120B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDO7rWwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfHEIuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:50:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45482 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfHEIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:50:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so78517924lje.12;
        Mon, 05 Aug 2019 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j77aWO89YBBrQiF5nLMwAuKVLY6Hltyq6r1Y6Ez6irA=;
        b=uDO7rWwm3RmbIMzKPQhefFvFaGAFGOftNOKzZnOSFjxhzmFywzlFXqUgSJGBm0hpkT
         wcPTJDGqzV7TUvlqmam4VD2PGaraZ2hq/u7U2Xfn8f5H4L0sGYNmFOas0GuxtSYkPQJG
         kcv1w++cCedsnI/Zq81PJRq1wy8EY36MuDoA9xKBtzS5rik3XYI8ChaAmtDsA4ZGmWWy
         eIABCJwGjaIHhqxVYZuTAS4lsesjmAFYv4Ys4dewhbjzk93z+t36TJn9fBvgWLQu/489
         jAfWVlRFZBe58SI7Qzwh9fa7jx7K7Lh4acAHUdMpjEBkwV2C26kdZ6a0c8cu/PR/yuIL
         3+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j77aWO89YBBrQiF5nLMwAuKVLY6Hltyq6r1Y6Ez6irA=;
        b=dUUYrZJlDyHbPLOYbU3F9OG7svRgV5grjNPYBVTSZ3sJXCYp9KtSBbIWKIck291XEH
         NenSljtK6DyOd88XJJrtx5k3km0Q+34Dd4m8sLNEqc3vusDcDQ7qLEralW+d1gyNiknj
         084vwaDXsE8EY/Mb6HZYQXBrtiqGP0z4DcdEj8asBRFPXq/ClAdzIlKNqxzeYgBXTz1F
         DhjWC4w3TXLiXHXvtmlnhfqSO/8/ewD6h4NwnH2+LbcqPSSugm11gy/RRixf/Yek9v1K
         AvEs2+7qYvkjS9OCtg9G8Cn4MsJqNTJyquNIq4rYvN7LP6rrmEKxGhO89taZkHeDglv9
         c19w==
X-Gm-Message-State: APjAAAUjMoytnu7ms7XqlfHcfGfIQisV7dWVdLPo7h/ffokvRcqJlyau
        G6bs381ZLGPsJ+iJFA2ZSopDNLw50BU6fdwE9ec=
X-Google-Smtp-Source: APXvYqyikxBqcAHiPB+7AXbUlnymHwkgT11qqKqtKvfNP9S5RBVNP+YRNeitlIaT5y5lcx9Yei0ajgxn9KBAuaYzZII=
X-Received: by 2002:a2e:8696:: with SMTP id l22mr13738709lji.201.1564995002727;
 Mon, 05 Aug 2019 01:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190731154239.19270-1-h.feurstein@gmail.com> <20190804151013.GD6800@lunn.ch>
In-Reply-To: <20190804151013.GD6800@lunn.ch>
From:   Hubert Feurstein <h.feurstein@gmail.com>
Date:   Mon, 5 Aug 2019 10:49:51 +0200
Message-ID: <CAFfN3gX6_dvAkRqRuXdR_+nfsFyBd2UNSzYo1H3am49xyb-hBQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: drop adjust_link to enabled phylink
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

It looks like some work is still needed in b53_phylink_mac_config to
take over the
functionality of the current adjust_link implementation.

Hubert

Am So., 4. Aug. 2019 um 17:10 Uhr schrieb Andrew Lunn <andrew@lunn.ch>:
>
> On Wed, Jul 31, 2019 at 05:42:39PM +0200, Hubert Feurstein wrote:
> > We have to drop the adjust_link callback in order to finally migrate to
> > phylink.
> >
> > Otherwise we get the following warning during startup:
> >   "mv88e6xxx 2188000.ethernet-1:10: Using legacy PHYLIB callbacks. Please
> >    migrate to PHYLINK!"
>
> Hi Hubert
>
> Do we need the same patch for the b53 driver?
>
>    Andrew
