Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B66BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5366A206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx7wIAPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfIQNdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:33:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39386 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfIQNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:33:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so3193205wml.4;
        Tue, 17 Sep 2019 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZVgKnBHXrCapFMh+Z2Qyzmz08ZgElhJ/PjWus/3se+Q=;
        b=cx7wIAPPbkZwjitPfhwfpYd32Nm6ooxcoW8VNle3eGxiFuPCSZnNuod2vCvra6267S
         9o76RnwMcjgP7mSptOk2MZF84XYOwQ/IGYFPsmKyaXmdy0WRO8EL1VzhdvmZc2X5bqjR
         80zV2BHKgL9Y52+Yo/Peo1aQegn36yezGozJ87Af+/TDgB9lfV3Z0IPitzGJUvpcyzQA
         9qB77hcfnovKQKcAVnf6TTyph3wZ3rjwKZvEVARrGE3koGesEDGCQOFCqKmLoPmPGGOW
         dANYI/Ywt3AetD//HUWPe2x0qndAfvoM1/8gtWpPRPzARQmgbnlw2N/u3C623Rz4X3pV
         MohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZVgKnBHXrCapFMh+Z2Qyzmz08ZgElhJ/PjWus/3se+Q=;
        b=DlNtLheiHpkhxCkn4NtV8ouHMORZWvOrY1TEFJnwYsrYDUYVl42kEbKQks+ttHKZN1
         MKmjl/HC8d/9iRV76Mq01q5WAPHOhlBdAv6UZISAcDdNFp/k/OUQE5EsXMdzTj56YP+a
         y9Xzyn4XRyh8wRzRoo/PFyI89PoUJ8MYGHjLozzyonSN8wCm2sjprQYlrIrET/2iK9nV
         WYC57hJG0wmig75ygD83RRRTnqavLHAoXO6sFJC68+b1fzlXPVjZvZmHBw8VebtRPoz3
         DZfO6CMasA3cygWXLqJdb7q4/j8FzuUgXPLLrUKbWvkyBl/3579bNK3Gg0aAWLlNeoYJ
         7I4g==
X-Gm-Message-State: APjAAAXGCGcJZiGzTVxtZVXE0vmuM3QaLsfhpAq3/IjWF378dEh6zk1j
        UDIQYzz6HPGuqfGm2nlFef0=
X-Google-Smtp-Source: APXvYqyEgxKzW2vpA5Wj3noahECRn2sB6UkfO12EaBTE+oNhBh9T0Y5DZ1LHA4+4ATlFTZBcW2NdVg==
X-Received: by 2002:a1c:99cd:: with SMTP id b196mr3529756wme.83.1568727180060;
        Tue, 17 Sep 2019 06:33:00 -0700 (PDT)
Received: from arch-dsk-01 ([77.126.41.65])
        by smtp.gmail.com with ESMTPSA id q124sm4222816wma.5.2019.09.17.06.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 06:32:59 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:32:53 +0300
From:   tinywrkb <tinywrkb@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190917133253.GA1210141@arch-dsk-01>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
 <20190917124101.GA1200564@arch-dsk-01>
 <20190917125434.GH20778@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917125434.GH20778@lunn.ch>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:54:34PM +0200, Andrew Lunn wrote:
> On Tue, Sep 17, 2019 at 03:41:01PM +0300, tinywrkb wrote:
> > On Sun, Sep 15, 2019 at 03:56:52PM +0200, Andrew Lunn wrote:
> > > > Tinywrkb confirmed to me in private communication that revert of
> > > > 5502b218e001 fixes Ethernet for him on effected system.
> > > > 
> > > > He also referred me to an old Cubox-i spec that lists 10/100 Ethernet
> > > > only for i.MX6 Solo/DualLite variants of Cubox-i. It turns out that
> > > > there was a plan to use a different 10/100 PHY for Solo/DualLite
> > > > SOMs. This plan never materialized. All SolidRun i.MX6 SOMs use the same
> > > > AR8035 PHY that supports 1Gb.
> > > > 
> > > > Commit 5502b218e001 might be triggering a hardware issue on the affected
> > > > Cubox-i. I could not reproduce the issue here with Cubox-i and a Dual
> > > > SOM variant running v5.3-rc8. I have no Solo/DualLite variant handy at
> > > > the moment.
> > > 
> > > Could somebody with an affected device show us the output of ethtool
> > > with and without 5502b218e001. Does one show 1G has been negotiated,
> > > and the other 100Mbps? If this is true, how does it get 100Mbps
> > > without that patch? We are missing a piece of the puzzle.
> > > 
> > > 	Andrew
> > 
> > linux-test-5.1rc1-a2703de70942-without_bad_commit
> > 
> > Settings for eth0:
> > 	Supported ports: [ TP MII ]
> > 	Supported link modes:   10baseT/Half 10baseT/Full
> > 	                        100baseT/Half 100baseT/Full
> > 	                        1000baseT/Full
> 
> So this means the local device says it can do 1000Mbps.
> 
> 
> > 	Supported pause frame use: Symmetric
> > 	Supports auto-negotiation: Yes
> > 	Supported FEC modes: Not reported
> > 	Advertised link modes:  10baseT/Half 10baseT/Full
> > 	                        100baseT/Half 100baseT/Full
> > 	                        1000baseT/Full
> 
> The link peer can also do 1000Mbps.
> 
> 
> > 	Advertised pause frame use: Symmetric
> > 	Advertised auto-negotiation: Yes
> > 	Advertised FEC modes: Not reported
> > 	Link partner advertised link modes:  10baseT/Half 10baseT/Full
> > 	                                     100baseT/Half 100baseT/Full
> > 	                                     1000baseT/Full
> > 	Link partner advertised pause frame use: Symmetric
> > 	Link partner advertised auto-negotiation: Yes
> > 	Link partner advertised FEC modes: Not reported
> > 	Speed: 100Mb/s
> 
> Yet they have decided to do 100Mbps. 
> 
> We need to understand Why? The generic PHY driver would not do this on
> its own. So i'm thinking something has poked a PHY register with some
> value, and this patch is causing it to be over written.
> 
> Please can you use mii-tool -v -v to dump the PHY registers in each
> case.
> 
> Thanks
> 	Andrew

Here's the output of # mii-tool -v -v eth0 

* linux-test-5.1rc1-a2703de70942-without_bad_commit

Using SIOCGMIIPHY=0x8947
eth0: negotiated 100baseTx-FD flow-control, link ok
  registers for MII PHY 0:
    3100 796d 004d d072 15e1 c5e1 000f 0000
    0000 0000 0800 0000 0000 0000 0000 a000
    0000 0000 0000 f420 082c 0000 04e8 0000
    3200 3000 0000 063d 0000 0000 0000 0000
  product info: vendor 00:13:74, model 7 rev 2
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control


* linux-test-5.1rc1-5502b218e001-with_bad_commit

Using SIOCGMIIPHY=0x8947
eth0: negotiated 100baseTx-FD flow-control, link ok
  registers for MII PHY 0:
    3100 796d 004d d072 15e1 c5e1 000d 0000
    0000 0000 0800 0000 0000 0000 0000 a000
    0000 0000 0000 0000 082c 0000 04e8 0000
    3200 3000 0000 063d 0000 0000 0000 0000
  product info: vendor 00:13:74, model 7 rev 2
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control

Thanks for helping Andrew.
