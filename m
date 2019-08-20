Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0C3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222A02082F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="W2ZnE/px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfHTAFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:05:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36476 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfHTAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:05:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so4010523qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EqawCVMNR5ggkVvM3Y8TbC/GggOP05ogNA2z4zWjBzA=;
        b=W2ZnE/pxltTX4kXiXH96rp142zmXmi2sD4mi6KTNLHIp3seAnOcVlhN0dqf6iMWn4x
         RXqhV3hcByajFyP9UJKzVpbTZspbLawweQJWhwe3YVlJ9g6iW/KPDZSemRIltIlOeQd+
         D4/1LhNRdtgfjVEKONKun8bNqwtRTvgHPDMkXzVPA0J2HEQXzUN6X9+92PixFL6TLsS7
         w4BHqL/BJNcqkSmJdFS9cLDFS3btD9pC/aDz8ko6Nyg3I7POzUYsEM+U4ZGMWiJP0nM4
         8po2viFqcGLQLq9Y1lRGyNujerL0eRYMcYunMrGhW5kYC79Y93PRe8Kc2lL8EtKmxnM1
         MPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EqawCVMNR5ggkVvM3Y8TbC/GggOP05ogNA2z4zWjBzA=;
        b=RmVU7ufzQb1G2GVldfjwgf/ShyXDM8j4P/BOKVsJOeSQmEQlCz3WSOnMCS/SzL0P8J
         ICweONvWJbYbETDiyytJjl3m/fVI8u6WTAPSMlbzRce4t3fMttfE9JGfFDQf6Qa7zA8f
         EGNU+gbjsZC3M4lDbz0+UrVNJe22Sy8cc3yrMSKHF7cexc79SZXfroFPUW5N0Vbiojtv
         RFYpOeBaGz3a0K/Iei3IfAFWA3cxtZk/VuB9ukPh6L0N7Td39tgxO1dErHEFttQOyAnl
         3vdUxrsWnvFRMgCLgFSkXIIWKMzTaHqpw363ubKTZkoHyy4uCddzH4CZQ1snvcsjAh9r
         LeKw==
X-Gm-Message-State: APjAAAWYLoanjGpl84gE9pg2A5uddsJvR0q8dgMUEu4bzIsjGFTva6a9
        2d6DIfgobBAGAeRQ3S6Qq7uT/Q==
X-Google-Smtp-Source: APXvYqwSt09bYAD/GaUVUI3fSb7OlzA8CcLokwjOvHc1e2U7D7S/CCp818w1Esqb0twyjrhfoLDxUw==
X-Received: by 2002:a0c:b209:: with SMTP id x9mr2784510qvd.217.1566259502266;
        Mon, 19 Aug 2019 17:05:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o27sm7646908qkm.37.2019.08.19.17.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 17:05:02 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:04:53 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 11/17] net: sgi: ioc3-eth: no need to stop queue
 set_multicast_list
Message-ID: <20190819170440.37ff18d4@cakuba.netronome.com>
In-Reply-To: <20190819163144.3478-12-tbogendoerfer@suse.de>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
        <20190819163144.3478-12-tbogendoerfer@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 18:31:34 +0200, Thomas Bogendoerfer wrote:
> netif_stop_queue()/netif_wake_qeue() aren't needed for changing
> multicast filters. Use spinlocks instead for proper protection
> of private struct.
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/sgi/ioc3-eth.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/s=
gi/ioc3-eth.c
> index d862f28887f9..7f85a3bfef14 100644
> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
> @@ -1542,8 +1542,7 @@ static void ioc3_set_multicast_list(struct net_devi=
ce *dev)
>  	struct netdev_hw_addr *ha;
>  	u64 ehar =3D 0;
> =20
> -	netif_stop_queue(dev);				/* Lock out others. */
> -
> +	spin_lock_irq(&ip->ioc3_lock);

What does this lock protect? =F0=9F=A4=94 No question that stopping TX queu=
es
makes little sense, but this function is only called from
ndo_set_rx_mode(), so with rtnl_lock held.=20

I thought it may protect ip->emcr, but that one is accessed with no
locking from the ioc3_timer() -> ioc3_setup_duplex() path..

>  	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous.  */
>  		ip->emcr |=3D EMCR_PROMISC;
>  		writel(ip->emcr, &regs->emcr);
> @@ -1572,7 +1571,7 @@ static void ioc3_set_multicast_list(struct net_devi=
ce *dev)
>  		writel(ip->ehar_l, &regs->ehar_l);
>  	}
> =20
> -	netif_wake_queue(dev);			/* Let us get going again. */
> +	spin_unlock_irq(&ip->ioc3_lock);
>  }
> =20
>  module_pci_driver(ioc3_driver);

