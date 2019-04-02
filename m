Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0BC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F0220830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554211519;
	bh=8P4i6Bu0rH//ReLxvdPoeaukhesEkQrl/4m74J+VgZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QBSO4NsUFIy7VclMbS/b4IXLYD1Fzf8u0ep/Z0o0Qg4FSJOErcFNojrFRG/sJnTO2
	 NpY8OpFn7uCWL41HgUt4gAmwo7nBC6gxvmk1iwbjj05mtfka9tqJuPJspvrDxNo4N5
	 HZTIZdtQ2Dp6qEMifEHaKoZ94yi6LAv7+vqxe86I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfDBNZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDBNZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:25:18 -0400
Received: from localhost (173-27-100-4.client.mchsi.com [173.27.100.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 570832133D;
        Tue,  2 Apr 2019 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554211516;
        bh=8P4i6Bu0rH//ReLxvdPoeaukhesEkQrl/4m74J+VgZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3ZnPHkagTMFpj2ohh6vbkggK5B+jLn7PdpTkZJLzbeygEd508ccA5wYcPNQLt5uV
         NrzzPzd8ub7PES9N2q1TBzojelMx6qxgpcs+tZ5QF0ZVasPCCdUGYToFcVKeOGMi/l
         StkpUY15Y7H1Hc8mAtw9ndWV+qH+uSZXje0mE6d8=
Date:   Tue, 2 Apr 2019 08:25:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     whiteheadm@acm.org
Cc:     linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        nic_swsd@realtek.com, linux-kernel@vger.kernel.org
Subject: Re: r8169 not being recognized by different chipsets
Message-ID: <20190402132514.GA10517@google.com>
References: <CAP8WD_YguzTJ=O6aR_wOGYQoc4_XEu4j_VM8DNrdALwTDrS+FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_YguzTJ=O6aR_wOGYQoc4_XEu4j_VM8DNrdALwTDrS+FA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc PHY and r8169 maintainers, LKML]

Hi Matthew,

On Wed, Mar 27, 2019 at 02:15:53PM -0400, tedheadster wrote:
> The r8169 driver is not recognizing my CardBus ethernet card depending
> on the chipset it has. It seems to be related to the PCI bus
> recognizing the card.  It works with some hardware and not with others
> on the same kernel.
> 
> This is with both the 5.1.0-rc2 and 5.0.4 kernels, so I am up to date
> with patches.

I assume this has never worked, i.e., it is not a regression?  If it
*is* a regression, bisection is a possible approach if nobody has a
better idea.

> I have been able to debug it down to  mdiobus_scan() returning
> returned -EIO, but that failure probably should not happen.

I can't connect this failure to PCI yet (at least, I don't know enough
to connect the dots).  Maybe the PHY or r8169 folks can shed more
light.

> Below is the relevant PCI information:
> 
> Failing systems:
> - The same 81801 bridge chip, different CardBus chips
> 
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
> [8086:2448] (rev 81)
> 02:00.0 CardBus bridge [0607]: Texas Instruments PCI4520 PC card
> Cardbus Controller [104c:ac46] (rev 01)
> 02:00.1 CardBus bridge [0607]: Texas Instruments PCI4520 PC card
> Cardbus Controller [104c:ac46] (rev 01)
> 07:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8169 PCI Gigabit Ethernet Controller [10ec:8169] (rev 10)
> 
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
> [8086:2448] (rev 81)
> 02:01.0 CardBus bridge [0607]: Texas Instruments PCI1520 PC card
> Cardbus Controller [104c:ac55] (rev 01)
> 02:01.1 CardBus bridge [0607]: Texas Instruments PCI1520 PC card
> Cardbus Controller [104c:ac55] (rev 01)
> 03:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8169 PCI Gigabit Ethernet Controller [10ec:8169] (rev 10)
> 
> Working systems:
> 
> 00:01.0 PCI bridge [0604]: Intel Corporation 440BX/ZX/DX -
> 82443BX/ZX/DX AGP bridge [8086:7191] (rev 02)
> 00:04.0 CardBus bridge [0607]: Texas Instruments PCI1220 [104c:ac17] (rev 02)
> 00:04.1 CardBus bridge [0607]: Texas Instruments PCI1220 [104c:ac17] (rev 02)
> 06:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8169 PCI Gigabit Ethernet Controller [10ec:8169] (rev 10)
> 
> 00:00.0 Host bridge [0600]: Cyrix Corporation PCI Master [1078:0001]
> 00:11.0 CardBus bridge [0607]: Texas Instruments PCI1221 [104c:ac19]
> 00:11.1 CardBus bridge [0607]: Texas Instruments PCI1221 [104c:ac19]
> 01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8169 PCI Gigabit Ethernet Controller [10ec:8169] (rev 10)
> 
> - Matthew Whitehead
