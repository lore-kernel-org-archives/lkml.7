Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A8DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E822084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjwu22iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDCJxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:53:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41442 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:53:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so20431238wrq.8;
        Wed, 03 Apr 2019 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IEDsUU/tcxOMIOUrX7vD3RhykmPAd4evXa2A+X+fm2U=;
        b=Kjwu22iLXhb/67QUQ0zYub815IrXknLSx/d6hopBNUmCCJUPJ2cY30oek9praQrwgC
         DvW7AHAmQScXvoBrJDoXy5Qzl0q1SgKUdmPSZH4P6LgywQAV1Xx6OfhSQRrSVe/3h3lv
         0j/2PxE+pHDS1dcys1YICu+kJeKWexDBscu3/OeCNOiJrS5dUHf0OZm/d/dwrOnbqdFx
         dgh/x36ln81WgxT56vRko8r5KNhoQSW3xQU9JMQLKs8gbY5aei07ncB4erYBfY9JQi0W
         gFmIgPtw8GcQkYDF+zKCZbYmlCxdMNrzuKAF1ckirZZbbpdDvjD3FW/jBxKp2Vx/AMXh
         u05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEDsUU/tcxOMIOUrX7vD3RhykmPAd4evXa2A+X+fm2U=;
        b=Ko2lyk6HgazzHU2AJHt3YFSr19f7SCQrgTc39giV3CtSUsDfDh4sQ3qymYQGb0dGe/
         zQW1pAnRsyOgNwRosksm2NpCIRKDXKrKTo5H+OFIieZ+Y/uyF279qK6+nMZk8pvjiO5Y
         rnAtITOMJ/5qJRDt4aXbNqLZy3lOaQJOS1/NwTIO3MDJmBabpRJBD5fnAxHnjurLc/Y7
         IcItsNyJwNsjUV9cnDangg0UULvWuiB5Aj4BfYKYVsBZMJ6XIuFRhaLvCi36TScB0Sak
         DwwVzKnq79Jc792qRfo+TBEG3zs9uUgb8P+PYD0Cl52hzeXw+dFFlTS0bGPEewiyPSlz
         kAqg==
X-Gm-Message-State: APjAAAVkEM187sUAhLmlVp39ZnjG+PuXGHESY3wuA52q4B/OhkcAqClQ
        ejAoEGC9MlMBwEmuQuaR+Es=
X-Google-Smtp-Source: APXvYqydyB0vKaBWXbgTN0CNdkJG94BMPKkH2UNomwhytWXFwHDZ1T41XQ5Ty/yhN6UIqhHd6gRp+A==
X-Received: by 2002:adf:ba81:: with SMTP id p1mr47293577wrg.192.1554285195873;
        Wed, 03 Apr 2019 02:53:15 -0700 (PDT)
Received: from [192.168.1.22] ([94.230.156.24])
        by smtp.gmail.com with ESMTPSA id o1sm17693312wmh.47.2019.04.03.02.53.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:53:15 -0700 (PDT)
Subject: Re: [PATCH net-next 17/17] dt-bindings: net: dsa: Add documentation
 for NXP SJA1105 driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        georg.waibel@sensor-technik.de
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-18-olteanv@gmail.com> <20190402213845.GI22349@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Message-ID: <f4fc6dc5-673d-2e69-3646-45e282dd9663@gmail.com>
Date:   Wed, 3 Apr 2019 12:53:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190402213845.GI22349@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 12:38 AM, Andrew Lunn wrote:
>> +Optional properties:
>> +
>> +- sja1105,mac-mode, sja1105,phy-mode: Boolean properties that can be assigned
>> +  under each port node that is MII or RMII (has no effect for RGMII).  By
>> +  default (unless otherwise specified) a port is configured as MAC if it is
>> +  driving a PHY (phy-handle is present) or as PHY if it is PHY-less (fixed-link
>> +  specified, presumably because it is connected to a MAC).  These properties
>> +  are required in the case where SJA1105 ports are at both ends of an MII/RMII
>> +  PHY-less setup. One end would need to have sja1105,mac-mode, while the other
>> +  sja1105,phy-mode.
> 
> Hi Vladimir
> 
> phy-mode has a well known meaning, indicating mii, gmii, sqmii, rmii,
> rxaud, etc.
> 
> The meaning here is quite different. To maybe avoid confusion, could
> we flip the name around?
> 
> sja1105,mode-mac and sja1105,mode-phy?
> 

Hi Andrew,

I agree the clash of words is confusing.
Which one of "sja1105,mode-phy", "sja1105,type-phy", "sja1105,role-phy" 
sounds easier to digest?

>> +			port@4 {
>> +				/* Internal port connected to eth2 */
>> +				ethernet = <&enet2>;
>> +				phy-mode = "rgmii";
>> +				reg = <4>;
>> +				/* Implicit "sja1105,phy-mode;" */
>> +				fixed-link {
>> +					speed = <1000>;
>> +					full-duplex;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
> 
> 
>> +&enet2 {
>> +	phy-connection-type = "rgmii";
> 
> You don't see this used much, phy-mode is preferred. Do you have a
> reason for this?

No particular reason for using phy-connection-type. It is just a 
copy-pasta from the (not yet submitted) ls1021a-tsn.dts that I'm using 
to test the driver on.
The other LS1021A DTS files were already using this notation, so that's 
how it got there. But the gianfar driver works just as well with 
phy-mode, so maybe I will send another patch for converting the existing 
notations when I submit the new board DTS too.

> 
> Also, you have the MAC using RGMII and the port using RGMII. Neither
> is inserting delays. That implies the delays are added by the track
> layout of the PCB. It would be good to add a comment about
> this. Anybody copying this using a design without the delays via PCB
> are probably going to get it wrong to start with and not realise they
> need to change one end to RGMII-ID.
> 

You've hit the nail on the head with this excellent comment.
So the second-generation switches (P/Q/R/S) have addressed this hardware 
limitation and do provide some tunable delay lines for RGMII.
But on the LS1021A-TSN, which is using a first-generation T chip, the 
RGMII delays for correct sample/hold times are obtained through ~50cm 
copper wires, since the LS1021 cannot apply them internally either.

> https://www.nxp.com/docs/en/data-sheet/SJA1105.pdf
> 
> Section 6.2.3 RGMII signaling and encoding
> 
> Note that RGMII requires an external delay of between 1.5 ns and 2 ns
> on TXC and RXC.
> 
> So it sounds like the switch only supports PHY_INTERFACE_MODE_RGMII.
> 
> If the port is in MAC mode, you should pass this phy-mode to the PHY
> when you connect to it. The PHY can then add the delay if needed.
> 
> If however, the port is in PHY mode, and it is asked to do RGMII other
> than PHY_INTERFACE_MODE_RGMII, you should report an error. It cannot
> do it.

I expect that next week I will be able to get a reworked LS1021A-TSN 
board with a second-generation switch, and the delay wires removed.
Using that, I can at least add support for the tunable delay lines in a 
fashion similar to what you're suggesting.

But since you brought this up, let me point out some complications I see:
* I think the way this works is that phy_attach_direct populates 
phydev->interface based on the MAC's DT bindings. Then the PHY driver is 
supposed to apply internal delays based on that. But this shadows the 
MAC's own ability to add internal delays based on the same DT bindings. 
You told me to pass the internal delay settings to the PHY if 
"sja1105,mode-mac" is (implicitly or explicitly) specified, or otherwise 
("sja1105,mode-phy"), take the internal delay settings and apply them 
myself (if the switch revision supports this). But in the latter case, 
should I mask off the RGMII_*ID modes and convert everything to RGMII 
when doing the of_phy_connect (to ensure that at the other end nobody 
will add the internal delays twice)? I know the theory but I have never 
actually seen a MAC driver apply the internal delay settings. And even 
in my case I'm a bit surprised that there isn't a more generic mechanism 
to specify this and that I have to rely on custom DT bindings.
* The 2 groups of devices (E, T, P, Q) and (R, S) are pin-compatible 
with one another, and in principle hot-swappable. Initially I had 
explicit "compatible" properties for each device model, but with the 
code for device_id detection, this became a bit redundant so I just made 
everything "nxp,sja1105". But with the different RGMII internal delay 
capabilities, and later on with SGMII support (R, S), some differences 
at the DT level will become apparent. For example my T -> Q swap on the 
LS1021A-TSN board will require a DT change for the internal delay 
settings. How should I handle the "compatible" property for this driver?

> Thanks
>       Andrew
> 

Thank you,
-Vladimir
