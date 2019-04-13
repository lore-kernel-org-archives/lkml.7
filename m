Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D922C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA74D208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2DKVFMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfDMPha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:37:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38482 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDMPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:37:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so11546158ljg.5;
        Sat, 13 Apr 2019 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Map9uX40q3UKqJy5l8fW1MSJCn9FtkX6GfRWx30rTcs=;
        b=u2DKVFMqx9+sVEbVKquoqyOoO6/dM2Nmo1Kcd79wy8DaNyEcURxGX4X3zFo8CyKThE
         60WAZda1azmA821xrdKAIBJ4C82bLkcjFmfBX/VQp6xN4rPCN/BwD2ohYXa5MFzFlhP4
         Jfn/4aB5RcuHjfv0ZizpzAwjEsJ75Cvhwj+heUEl2c66E5CUaKvh6hkCzvJWryX1uhjR
         7sAhb0QKEmtOTuMHK5+DHHewyV6gojIBfKgA/QvHkEgnp3AmK9yu+UUiTH1zm+FFCnsK
         IKoYpU5nmA9MAzqAHPpoHWQzs9ZaqGyJl3rYdXSNqEBDcRoDXcoPwDKD3HBrSAYa3X+C
         Nnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Map9uX40q3UKqJy5l8fW1MSJCn9FtkX6GfRWx30rTcs=;
        b=QGe5oUBsRDy9h/JBmFUdPqgPZAwHI8fjET244Ki/JX+5htyugPx9kNzliOdur4EQ8e
         U0NUuVvoHROHM14OS9HQcfs7mxRj3zGRpsC93w79D4HMfl9Pc17LmX/kQRPwyY6Cxlt5
         qN8Szt9upcaYbWrIjaN7/qchdagLEbqmx/6G39LmOf9FKObVYpUlEKOWjqohge2PV+/x
         T0c14kXcpn5WKdDK/S/tJ6UOK9w6IsjOCWTjnC9uwCJRigIT8tuDPhIy7rK6nK7Rd6hD
         iC22qKw46vLny/yvkAN2AlbbFp/Uyjf5pyNCq0rU/hIAqvPZs4IHnjvw2UmNjV1yvUHx
         tTgA==
X-Gm-Message-State: APjAAAUk4TPv164NZ4JrMJIIGfSStoUZxupRmsmS2kYDmhosw3/6rv2H
        5sw9ErEHisyhUssDQ9hl0IEiBF8NQozUn/VY2t8=
X-Google-Smtp-Source: APXvYqww0TD3yAll2gsLNLUyp5pBEY83A/7jUfcYhJM81jXoBsKuQd5XKLvGrHjVCm7yVxTC2+HJZ7mr7Fh8YH20Jqc=
X-Received: by 2002:a2e:b058:: with SMTP id d24mr6401432ljl.42.1555169847267;
 Sat, 13 Apr 2019 08:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-13-olteanv@gmail.com>
 <20190413152307.GD17901@lunn.ch>
In-Reply-To: <20190413152307.GD17901@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sat, 13 Apr 2019 18:37:16 +0300
Message-ID: <CA+h21hp1AKYKOKSumcWXPacB4C5=HCv3CasanS13AZG-sbwNJQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/24] net: dsa: Copy the vlan_filtering
 setting on the CPU port if it's global
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

On Sat, 13 Apr 2019 at 18:23, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Apr 13, 2019 at 04:28:10AM +0300, Vladimir Oltean wrote:
> > The current behavior is not as obvious as one would assume (which is
> > that, if the driver set vlan_filtering_is_global = 1, then checking any
> > dp->vlan_filtering would yield the same result). Only the ports which
> > are actively enslaved into a bridge would have vlan_filtering set.
> >
> > This makes it tricky for drivers to check what the global state is.
> > Moreover, the most obvious place to check for this setting, the CPU
> > port, is not populated since it's not being enslaved to the bridge.
> > So fix this and make the CPU port hold the global state of VLAN
> > filtering on this switch.
> >
> > Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> > ---
> > Changes in v3:
> > Patch is new.
> >
> >  net/dsa/port.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/net/dsa/port.c b/net/dsa/port.c
> > index c8eb2cbcea6e..acb4ed1f9929 100644
> > --- a/net/dsa/port.c
> > +++ b/net/dsa/port.c
> > @@ -190,6 +190,8 @@ static bool dsa_port_can_apply_vlan_filtering(struct dsa_port *dp,
> >  int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
> >                           struct switchdev_trans *trans)
> >  {
> > +     /* Violate a const pointer here */
> > +     struct dsa_port *cpu_dp = (struct dsa_port *)dp->cpu_dp;
>
> Hi Vladimir
>
> As compilers get more picky, i expect that is going to result in a
> warning.
>
> Since this is a switch global attribute, putting it in dsa_switch
> would be better, next to vlan_filteris_is_global.
>
>         Andrew

Hi Andrew,

Creating a bool ds->vlan_filtering wouldn't make a lot of sense for
the majority of drivers.
Additionally in my sja1105_filter() function, that would require me to
pass through one more pointer (dev->dsa_ptr->vlan_filtering vs
dev->dsa_ptr->*ds->*vlan_filtering) to reach the same information.
I don't think that keeping it in cpu_dp->vlan_filtering has any
semantical overlap with anything else that might appear in the future.
And I don't know why the cpu_dp pointer is const. In the
dsa_switch_tree it isn't.

Thanks,
-Vladimir
