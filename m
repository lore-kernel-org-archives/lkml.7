Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA5C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96CC2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDuC7Y26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDJCPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:15:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42444 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJCPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:15:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id cv12so372719plb.9;
        Tue, 09 Apr 2019 19:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4FMeREQiYQBeyhAm/pZK/Gm3ScuXzp2X9qUeLgr6KLo=;
        b=SDuC7Y26rMRiAffbdBIP+aQaHl6ljLrSw7hJ1h4UF/gf6I3JM7QBeWyvvxUKLlcUiL
         KAuX4Vfp65vhP3qBwwlxPWTWh9IBIeLWmmhIkyas0qjR1zbcFBl9GM32PHCLYotnrwkT
         nNwy+4ADDbtsZfpgiHU8JFiTDycF2nqN3NOVc2cB+uC7M9W5FoPUpzD3JtY+lWHym4EF
         yN2lUQw/0HzDvSKK50QXcsgELoYfTRVnmNAWY2/+QQ7p9PtkM23Hq3ZOEmOu7zEIm93t
         E+G7jbfzT+vS9P+z2k0+QQTkhFV/VQ99qrcdfWlHtEHXsKLaXjDOatWkltXyJBLhoTgc
         KsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4FMeREQiYQBeyhAm/pZK/Gm3ScuXzp2X9qUeLgr6KLo=;
        b=nL2s2B4+g1RptmFAUwE+3GPh9kTo/p1Vf6oaPwkVaPqCampHsTH5ZQvhHV9jTmY891
         G1BZ1nTUcTvv4mm2a9D0uiuiBu1vKv0bh9jEcex4YHILWI01W23bL4V1q8fnKotUAizp
         mbH4SamqqF/AjIxb21AI7/3LoKsikgvxRw53EH6DymQqC10tyUGGr2EfPW/eNnZOWA1d
         F7oOYb+YOvQF3HEpvAM7zWJ2QFenknsDKv2jZgYQz7qTBw+uycYlOHrSELSZH7e5JriW
         ralPdlgYMs/JFLowFTLj4CJ9TfVtDgm22Eopcu07KG5Iil0SOaW92KikCkv8QX4F/NnA
         eDAQ==
X-Gm-Message-State: APjAAAVb3vouNoInDSbNEcHew8SjQsCema9/gheT8Q5N7Dmwd7qwDCO6
        zMEEVWZlcESDRVuapy4Ptq+uBolk
X-Google-Smtp-Source: APXvYqx1lpzg5tLyTMSuF9d6vBkP8qGQsRIWZYclgR9Dwdmo4npMClfaU41mOGnscbClU3Oxgxakcw==
X-Received: by 2002:a17:902:7043:: with SMTP id h3mr41592099plt.228.1554862515007;
        Tue, 09 Apr 2019 19:15:15 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id p17sm44955827pfn.157.2019.04.09.19.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:15:14 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 18/22] net: dsa: sja1105: Error out if RGMII
 delays are requested in DT
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-19-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d9826cea-1e7f-3ae7-4ff9-0e7d644bc743@gmail.com>
Date:   Tue, 9 Apr 2019 19:15:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410005700.31582-19-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
> Documentation/devicetree/bindings/net/ethernet.txt is confusing because
> it says what the MAC should not do, but not what it *should* do:
> 
>   * "rgmii-rxid" (RGMII with internal RX delay provided by the PHY, the MAC
>      should not add an RX delay in this case)
> 
> The gap in semantics is threefold:
> 1. Is it illegal for the MAC to apply the Rx internal delay by itself,
>    and simplify the phy_mode (mask off "rgmii-rxid" into "rgmii") before
>    passing it to of_phy_connect? The documentation would suggest yes.

I would agree with that statement.

> 1. For "rgmii-rxid", while the situation with the Rx clock skew is more
>    or less clear (needs to be added by the PHY), what should the MAC
>    driver do about the Tx delays? Is it an implicit wild card for the
>    MAC to apply delays in the Tx direction if it can? What if those were
>    already added as serpentine PCB traces, how could that be made more
>    obvious through DT bindings so that the MAC doesn't attempt to add
>    them twice and again potentially break the link?

I would say it can be either the MAC adding the TX delay, or the PCB
traces doing that, in that case you would have to change the property to
"rgmii-id" to account for that. Which is still ambiguous I agree...

> 3. If the interface is a fixed-link and therefore the PHY object is
>    fixed (a purely software entity that obviously cannot add clock
>    skew), what is the meaning of the above property?

fixed-link really should denote a MAC to MAC connection so if you have
"rgmii-id" on one side, you would expect "rgmii" on the other side
(unless PCB traces account for delays, grrr).

> 
> So an interpretation of the RGMII bindings was chosen that hopefully
> does not contradict their intention but also makes them more applied.
> The SJA1105 driver understands to act upon "rgmii-*id" phy-mode bindings
> if the port is in the PHY role (either explicitly, or if it is a
> fixed-link). Otherwise it always passes the duty of setting up delays to
> the PHY driver.
> 
> The error behavior that this patch adds is required on SJA1105E/T where
> the MAC really cannot apply internal delays. If the other end of the
> fixed-link cannot apply RGMII delays either (this would be specified
> through its own DT bindings), then the situation requires PCB delays.
> 
> For SJA1105P/Q/R/S, this is however hardware supported and the error is
> thus only temporary. I created a stub function pointer for configuring
> delays per-port on RXC and TXC, and will implement it when I have access
> to a board with this hardware setup.
> 
> Meanwhile do not allow the user to select an invalid configuration.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
