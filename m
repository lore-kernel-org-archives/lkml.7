Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AFEC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400BD2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9e9dUfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfIQMlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:41:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55905 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfIQMlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:41:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so3208850wmg.5;
        Tue, 17 Sep 2019 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hizZUkt1pzmfDFqDUimEMS3PJpFvJvmdnN9QD85tRVM=;
        b=X9e9dUfyzDIoV4U69QseZamZAgKxMmLIaoLCWyNx0hTzBrMyyTjMkMKurBqovIeNTS
         WX/oEaHYwaP8gfR9vIYmNYzwEjXsqPtlnycJGjwEYtYrTYtZlSw2SCR5hczHezThxAh9
         +u1L1QBvKxdiN2N1j/YZ6KkKeYij6iImID0xsU9pCL5FC5797qFOafPzymy3hq3t98eO
         658Gq1/kg2JeImRN8m4axwOpiz+hzqLbIkaPfh8bj+yrlzeL3jdy5RNbSnk4UAJYym7f
         U7wR81GHO4mmeyYr4VQdle/WpnrfI9hS0wfUUEmaz2ITlS2NpKttj6742dNnPwQu/xQC
         fTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hizZUkt1pzmfDFqDUimEMS3PJpFvJvmdnN9QD85tRVM=;
        b=Nk464mcaoIwnkbQvILEyEe2UWCp80bnO9RnU71aWCRVibimzeA89t0G85c1fGSg9tD
         9WJA/OLm/YaFv+feRRv1zTIwa9L7mTk0FqrX2Uz07TZFIiJYVesTyw3wWfDuwDFxSnvm
         N7EY5xsRlx3Jf0zklsitk/NljsOAcgSnJbq9DWqDG47uI9zxBfet+4pNqTb7JgFIbmoz
         qtQRIMsmrtCNEKhKficVX3Iv5ze06WIaefH1gm5B9SsaFeauigMnMZuLybT8ZAj4gRYB
         QnZbNj75PKM3bM2aE3A5zTh6xG3CNZUkbKBFCdkFK6CrUK8ALsXpianXE7n0HDgCVOrX
         QgZQ==
X-Gm-Message-State: APjAAAU8nw2C5+I0kL/ztGxEUIu3061/fxbAIHr6jTflFhPM8RpbjHVM
        CQZxg6PbwtvHrnMsLaifWjw=
X-Google-Smtp-Source: APXvYqy/b7DVG3Z9S8Z/BN1kZJ9gToybyr+XK7b/m/1rgoyXfsEG2M/d2AwWBfbbiwWDWG8H/T4Fqg==
X-Received: by 2002:a1c:e916:: with SMTP id q22mr3480658wmc.15.1568724067177;
        Tue, 17 Sep 2019 05:41:07 -0700 (PDT)
Received: from arch-dsk-01 ([77.126.41.65])
        by smtp.gmail.com with ESMTPSA id u10sm4513324wrg.55.2019.09.17.05.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:41:06 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:41:01 +0300
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
Message-ID: <20190917124101.GA1200564@arch-dsk-01>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915135652.GC3427@lunn.ch>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 03:56:52PM +0200, Andrew Lunn wrote:
> > Tinywrkb confirmed to me in private communication that revert of
> > 5502b218e001 fixes Ethernet for him on effected system.
> > 
> > He also referred me to an old Cubox-i spec that lists 10/100 Ethernet
> > only for i.MX6 Solo/DualLite variants of Cubox-i. It turns out that
> > there was a plan to use a different 10/100 PHY for Solo/DualLite
> > SOMs. This plan never materialized. All SolidRun i.MX6 SOMs use the same
> > AR8035 PHY that supports 1Gb.
> > 
> > Commit 5502b218e001 might be triggering a hardware issue on the affected
> > Cubox-i. I could not reproduce the issue here with Cubox-i and a Dual
> > SOM variant running v5.3-rc8. I have no Solo/DualLite variant handy at
> > the moment.
> 
> Could somebody with an affected device show us the output of ethtool
> with and without 5502b218e001. Does one show 1G has been negotiated,
> and the other 100Mbps? If this is true, how does it get 100Mbps
> without that patch? We are missing a piece of the puzzle.
> 
> 	Andrew

linux-test-5.1rc1-a2703de70942-without_bad_commit

Settings for eth0:
	Supported ports: [ TP MII ]
	Supported link modes:   10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Full
	Supported pause frame use: Symmetric
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Full
	Advertised pause frame use: Symmetric
	Advertised auto-negotiation: Yes
	Advertised FEC modes: Not reported
	Link partner advertised link modes:  10baseT/Half 10baseT/Full
	                                     100baseT/Half 100baseT/Full
	                                     1000baseT/Full
	Link partner advertised pause frame use: Symmetric
	Link partner advertised auto-negotiation: Yes
	Link partner advertised FEC modes: Not reported
	Speed: 100Mb/s
	Duplex: Full
	Port: MII
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: on
	Supports Wake-on: d
	Wake-on: d
	Link detected: yes

journalctl -b | egrep -i 'phy|eth|fec'|grep -v usb
kernel: Booting Linux on physical CPU 0x0
kernel: libphy: Fixed MDIO Bus: probed
kernel: libphy: fec_enet_mii_bus: probed
kernel: fec 2188000.ethernet eth0: registered PHC device 0
kernel: dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
kernel: Generic PHY 2188000.ethernet-1:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
kernel: fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
systemd-networkd[243]: eth0: Gained carrier
systemd-networkd[243]: eth0: DHCPv4 address 192.168.15.101/24 via 192.168.15.1
systemd-networkd[243]: eth0: Gained IPv6LL
systemd-networkd[243]: eth0: Configured

######################################################################

linux-test-5.1rc1-5502b218e001-with_bad_commit

Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Full
        Link partner advertised pause frame use: Symmetric
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: d
        Wake-on: d
        Link detected: yes

journalctl -b | egrep -i 'phy|eth|fec'|grep -v usb
kernel: Booting Linux on physical CPU 0x0
kernel: libphy: Fixed MDIO Bus: probed
kernel: libphy: fec_enet_mii_bus: probed
kernel: fec 2188000.ethernet eth0: registered PHC device 0
kernel: dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
kernel: Generic PHY 2188000.ethernet-1:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
kernel: fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
systemd-networkd[239]: eth0: Gained carrier
systemd-networkd[239]: eth0: Gained IPv6LL

