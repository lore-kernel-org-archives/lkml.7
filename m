Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A998BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666C9214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVrh+AiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDMPrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:47:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDMPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:47:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so11549764ljg.11;
        Sat, 13 Apr 2019 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97En/1yvmSzr0IDFlyDYuW05+KyWcS8Yc7Pu2w4LKrA=;
        b=WVrh+AiZVqG70GUHRHNnuzvXTEeboILt9JZnT27SCYX7qCoG3DdzDPW0PuG12pNt5N
         f74PpomgSEdWNPnUw9OFXz52ERPxjFm5z8vEMZq0vwq+KQKwvhJXNWR2Sp6C0Iu9higj
         KxNbJbGm2t3u2xeUGXeSyuvnzaJUNArj3/zTWOdIRdrUS6adNCgMr9BmpuYMrqXHlBVh
         2cXjZ5FS0oW2Krh5y0wHe8QNm/UdnEg1PRgbRoA9npvGgaTyBw7Wadtb3AKaegsKIrzq
         dXethmLrP9JrnfQ2Wr/N66+GoyJ+9OBdI6DDADcRFr4jCaXnNwUApjkH/LGMRoixdlhK
         2M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97En/1yvmSzr0IDFlyDYuW05+KyWcS8Yc7Pu2w4LKrA=;
        b=IzGXPj/JWSPuKggu70eK9rNg5h/XyJv6X16BA+Uun2gv9DYmNYndQB+dttSvB6jg47
         7qrSBIQLMvJRAYHo7UV0iJmpuxZf+9sLWMJkz74I2jX8mEba0vb4koJq8QWj00mhU8DP
         MXZDYYk5iT0SMENHsyL+Onoi/QHzhSes2R8A41bmQLMlel7eGjm/cLL4VKPVr+nOJ/BC
         vi9KNBfk7xnjhz4ptiGQz5yIRU9e3CQnes1sMHkX+Qq0CawkTNFSsNzn0cqvODdGUwb5
         18k2wHa9oXgfMnWsmqPXeFZ9Ijhug8Wdgto7SuSJO9qqjm0W35y2w3fJrnyqFpBGhSKy
         35UA==
X-Gm-Message-State: APjAAAWZWBM5veDI1VH41O3vfpUUQnwvbYSd5ZSL/CnF2WESfFiRerNH
        mPjlwRlimWNGR5CzLPmpPoZJmlVtJXe9EKkroB8=
X-Google-Smtp-Source: APXvYqyYaz5jRFeKKj2I9yD33xd0MNqkAWb75jGRDdc0/3iL9tyFQmq9VPCGMlBjmaqqeAoNMi6Bh0ucPH5SxyK/jkk=
X-Received: by 2002:a2e:6e14:: with SMTP id j20mr17310479ljc.172.1555170429280;
 Sat, 13 Apr 2019 08:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-15-olteanv@gmail.com>
 <20190413154245.GF17901@lunn.ch>
In-Reply-To: <20190413154245.GF17901@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sat, 13 Apr 2019 18:46:57 +0300
Message-ID: <CA+h21hrPHmzxAqdcd455qvzv0KqO93Tf-Cagy7BxMXW9DsH0CQ@mail.gmail.com>
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

Hi Andrew,

All I'm saying is that at this point in time (patch 14/24), the driver
is being introduced with DSA_TAG_PROTO_NONE. Then support for traffic
and switch tagging is added later on (18/24). I was just explaining
what can be done with the driver up to this point in the patchset.

Thanks,
-Vladimir


On Sat, 13 Apr 2019 at 18:43, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Apr 13, 2019 at 04:28:12AM +0300, Vladimir Oltean wrote:
> > At this moment the following is supported:
> > * Link state management through phylib
> > * Autonomous L2 forwarding managed through iproute2 bridge commands. The
> >   switch ports are initialized in a mode where they can only talk to the
> >   CPU port. However, IP termination must be done currently through the
> >   master netdevice.
>
> Please could you explain that last sentence in more detail. Normally
> the master device is just a dumb pipe. Nothing, except tcpdump,
> uses it.
>
> Thanks
>
>      Andrew
