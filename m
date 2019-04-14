Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62271C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9B214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRYnPitv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfDNSx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:53:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41049 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNSx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:53:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so13530588lja.8;
        Sun, 14 Apr 2019 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxjyeB1LSQos7vOkEHmatqoX1K2e2gubuxnRIAUnHNs=;
        b=GRYnPitvxhTHMUx1cEJJdM9IhwPFON8ozbFxeFP0nXMXKZv56suzSz5Ql508XvxdDW
         d6wxqzAXxJN6d8ego97XD7lFW6gPAQh4j1I083k86ZVajvX5lo3cb4LoklRQ/+m0VTVO
         Q43boz2+X2CWfqilAJRc/+nvZPDVuUQyO6wRocMjLWlVB2504ZwCgkYKv8ZMyqNIiNj+
         cGSgL/cXOsFO8Rs5U8ZrTBWxkpeL1Pwcop7874da69IGe+wshJi3oidCEhEwqtLFyMC9
         Sa7KzLRr7FWfHJS153rywnowNBTub7wUigQPj3YRNkGThG/M8AGLrc1Uptp+5d8P0pmE
         VjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxjyeB1LSQos7vOkEHmatqoX1K2e2gubuxnRIAUnHNs=;
        b=dEzbzPa8GZ88VLLQ6GhClV6JHTfAcQg+ShEeLPhrC6S6nIyF3COsphp4Zy5d99DyLK
         TQcIo1Valbzbb0TG104KB0Hw+oS68Le/o8z/yI3pP3B0LWAcQBWJ1FmQ04Zcggpmai3u
         ZGPNxH07jbng53gVt79D7CHWcXlOAhjeIgHvrs9RMkitVG4aQKsKkuU5AYpcBNitkRk+
         mZE9muu5Hp3VWaPW5oRuEY3Os8CUG0d/AG79wnTNYU8EfKcMRku4Wro+ExUVYfi+2tNr
         HiaWCHf1hhtEOVcjclP8Hb7tTBkb2hjH7/pue8ixcfVA8rFm0wOSwurRjnqizYRpdXut
         7vvw==
X-Gm-Message-State: APjAAAW4z9kQUr9gcJQ6Hqvv33tUkzdzvCt8s4TPtstYfE3cl9kQ5HaO
        AP25RQ+aEG9g3++bWP5aKPugaNCCaSj/wG3/Flk=
X-Google-Smtp-Source: APXvYqzKxvbq1Q0lT+8wT3ihz1i3UedNxRiPKivLQ+plApwbALJKqw2p3oJ2yPgltGvPigkCVP2F93kwLdKnTAq4sG4=
X-Received: by 2002:a2e:6e14:: with SMTP id j20mr20340005ljc.172.1555268033852;
 Sun, 14 Apr 2019 11:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-19-olteanv@gmail.com>
 <20190413163754.GG17901@lunn.ch> <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
 <CA+h21hp=_LrGDZo3Jmoe2hNKqx7nrdqRbK3UWYntN-9My-z5Hg@mail.gmail.com>
 <CA+h21hp47bOwvEdF5KCV0bAo01mv+K11JSuP9AzEoWHTjmVAtQ@mail.gmail.com> <20190414161757.GB10323@lunn.ch>
In-Reply-To: <20190414161757.GB10323@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sun, 14 Apr 2019 21:53:42 +0300
Message-ID: <CA+h21ho9AKSmX=6CU1P_fddcYSGB-DN0T-XqVYg8GnTRfuShVw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
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

On Sun, 14 Apr 2019 at 19:18, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > > > +             return dsa_8021q_xmit(skb, netdev, ETH_P_EDSA,
> > > > > > +                                  ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
> > > > >
> > > > > Please don't reuse ETH_P_EDSA. Define an ETH_P_SJA1105.
> > > > >
> >
> > I'm receiving contradictory advice on this. Why should I define a new
> > ethertype, and if I do, what scope should the definition have (local
> > to the driver and the tagger, local to DSA, UAPI)?
>
> ETH_P_EDSA has a well defined meaning. It is a true global EtherType,
> and means a Marvell EtherType DSA header follows.
>
> You are polluting this meaning of ETH_P_EDSA. Would you put ETH_P_IP
> or ETH_P_8021AD here?
>
>    Andrew

You are putting an equality sign here between things that are not quite equal.
The MEDSA EtherType is used for the same purpose as what I'm using it for.
The only situation when I can receive ETH_P_EDSA frames is if somebody
designed a system with a cascaded SJA1105 and a MV88E6xx. I think
that's unlikely but I might be wrong.
Don't get me wrong, I could use literally any EtherType and that's
exactly why I'm reluctant to define a new one.
The only thing is that if I pick an EtherType smaller than 1500
(LLC/SNAP) like ETH_P_XDSA (or even zero works), then I get the
hardware incrementing the n_sizeerr counter for each received tagged
frame (it doesn't drop it, though).

-Vladimir
