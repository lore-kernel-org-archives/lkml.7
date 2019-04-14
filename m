Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5AC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 22:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EB22084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 22:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU8Vv70Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfDNWbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 18:31:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44150 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfDNWbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 18:31:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id h18so11492435lfj.11;
        Sun, 14 Apr 2019 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqqZr2kdHJ+mNgq3vg3qQYC4iJwX7twSOJ7XEBxmdIo=;
        b=fU8Vv70QG/njPSw7KSl5+nvayVjLOghsL995rQR4KYaU+BKZtp5i1PofxeSUJEHvr+
         RIQSM23AK4TVvFDW12MFJ262ULEp+UmZCbzuFpverdicgUbqaNWRrIuQZYE00KeO6rdK
         jLvaJfIFzEW1wnpga0OTfZIQdNCJ0m90c2Oh+gCc1+aZHBN60A5wi7vNbgJEXAs9xn7F
         ccWeM+6Xdmcr6nxt5FBCQLx9eGr72KfZzdRDxavHe/KFoUpKRwKJE85sOUNJH2ghll1g
         OEEqVy8YhCTA8wjB212nGJZhOXrKL1eI/E+rpwHQVEShck5jsKZBUt6v6TTevGBcE8rt
         8ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqqZr2kdHJ+mNgq3vg3qQYC4iJwX7twSOJ7XEBxmdIo=;
        b=aWYVI06raR28TVZ4gqAJECO09ghAbRFJUscSIV+xc2mThz5fB9tY3iWk35gdXFe57f
         Rc/0pQeUaKUPB8IzdMGr6SdUy/YrulGQU0EmdJXvoCgAySLiI/BBTNUuJ1ws3fSSZ45u
         kX8iP1g548bCpmpAX8bu8C7r1nju3YZFYCTcdm3/J3qHI0k9XQlXqVbAn9MScydVh5uJ
         F2uy6RD850uw5dPZGTTZ4rNQnzu2CQJ7LuF3EGZeh0V5pG4ebzoRgE407NOgnB1GPtVf
         mIekj1XpgtbBJUosizAlHuWBnrPEPkoxzDNckWOII2SKyOkF5nfEi6xNOJxC32AsMkWT
         9oVg==
X-Gm-Message-State: APjAAAWrUefZPMwEz/26/VoFiypTt347EHhcDu18VKH4W+TQFRvfRWq1
        d8XWyhLrRF6kfJOawSu/ZNvPHhuFfFjHnZl53Zw=
X-Google-Smtp-Source: APXvYqyzEbnutt6nluaztZVu7NiE5LhdbSaKbEXvF5/Ex9nO4JSsMQjCd1vePaGw4Xn/ZazNDCWjwIoBllV0dP0y3tc=
X-Received: by 2002:a19:f512:: with SMTP id j18mr31443063lfb.48.1555281058546;
 Sun, 14 Apr 2019 15:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-19-olteanv@gmail.com>
 <20190413163754.GG17901@lunn.ch> <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
 <CA+h21hp=_LrGDZo3Jmoe2hNKqx7nrdqRbK3UWYntN-9My-z5Hg@mail.gmail.com>
 <CA+h21hp47bOwvEdF5KCV0bAo01mv+K11JSuP9AzEoWHTjmVAtQ@mail.gmail.com>
 <20190414161757.GB10323@lunn.ch> <CA+h21ho9AKSmX=6CU1P_fddcYSGB-DN0T-XqVYg8GnTRfuShVw@mail.gmail.com>
 <20190414191318.GE10323@lunn.ch>
In-Reply-To: <20190414191318.GE10323@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 15 Apr 2019 01:30:46 +0300
Message-ID: <CA+h21hrGPfo4-QxMjG9hqitd6qBWEpcYHeqvyPzYMFpkSLbBQw@mail.gmail.com>
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

On Sun, 14 Apr 2019 at 22:13, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Apr 14, 2019 at 09:53:42PM +0300, Vladimir Oltean wrote:
> > On Sun, 14 Apr 2019 at 19:18, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > > > > > +             return dsa_8021q_xmit(skb, netdev, ETH_P_EDSA,
> > > > > > > > +                                  ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
> > > > > > >
> > > > > > > Please don't reuse ETH_P_EDSA. Define an ETH_P_SJA1105.
> > > > > > >
> > > >
> > > > I'm receiving contradictory advice on this. Why should I define a new
> > > > ethertype, and if I do, what scope should the definition have (local
> > > > to the driver and the tagger, local to DSA, UAPI)?
> > >
> > > ETH_P_EDSA has a well defined meaning. It is a true global EtherType,
> > > and means a Marvell EtherType DSA header follows.
> > >
> > > You are polluting this meaning of ETH_P_EDSA. Would you put ETH_P_IP
> > > or ETH_P_8021AD here?
> > >
> > >    Andrew
> >
> > You are putting an equality sign here between things that are not quite equal.
> > The MEDSA EtherType is used for the same purpose as what I'm using it for.
>
> I don't think it is. tcpdump will match on this EtherType and decode
> what follows as an EDSA header, just in the same way it matches a
> ETH_P_IP and decodes what comes next as an IP packet. I also have
> wireshark patches, which i never submitted, which do the same.
>
> Please run tcpdump on the master interface with your test system and
> see what it does.
>
>     Andrew

It fails to decode the frames, obviously. But so does any other EtherType.
Florian was hinting
(https://lwn.net/ml/netdev/b52f4cdf-edcf-0757-1d6e-d4a831ec7943@gmail.com/)
at the recent pull requests submitted to tcpdump and libpcap that make
it possible to decode based on the string in
/sys/class/net/${master}/dsa/tagging. I admit I haven't actually
tested or studied those closely yet (there are more important things
to focus on ATM), but since my driver returns "8021q" in sysfs and
yours returns "edsa", I would presume tcpdump could use that
information. Anyway, since you obviously know more on this topic than
I do, please make me understand what are the real problems in spoofing
the Ethertype as a Marvell one.

Thanks,
-Vladimir
