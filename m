Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C63DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B79206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="mE9OADSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfDVVyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:54:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37174 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfDVVyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:54:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id z16so13865903qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=kTvA5Kmg+3HcCF2yD6g76qbiLSinUsBTi2zmCwQo+eU=;
        b=mE9OADSk7Pcwd3TLJ1zXHvja36Lr+xMve74Fs6czDBIaY1ZxTh1lQV8YRek2tx40z+
         W8g/Xju0X4GPbBOWK3IiI+wCxMIAR12cYP/NKO50Fbx2aMrdsQdGSVPzHl4dbPkTYPuR
         v5a9gwNQlc/us+HTKKPsGYsw5PpMArHHBH+oMluoqM6hb7o1jawVsrboLg08QNJu0U5m
         iUxz9PXn7LyRbFjIuNn4VJD/zXAhPkDnOEC6ZmtG6B1iQkHLpQpEDQ5lg0w5i1va5SnO
         /MavESFE1QxuuKbNWkXZY4Z9aneBaOAIU6yNw4OBsRDgFnn+8lu4GO2AMCKMHWssMNzB
         FA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=kTvA5Kmg+3HcCF2yD6g76qbiLSinUsBTi2zmCwQo+eU=;
        b=BEC+DeHi9DeNk8BGrQaizTZMAdOund21J+9Je8ZPJPTvvrAqrqjd2wMEyW3/PcUT80
         A8FbbDbgHwqwESZgEVNqfvDYpYb+EOVAgU7e2vz+XaF7rSTKLLx55+hzSH0fXjj5fE2S
         +Z3jyuTQJIxuD6BgxoiEkb5J+ngXR3BWLhQetJTOqrsNapXRaUJkZR3xEgg7AoYXMytS
         nWnaDmtbUjwIlM2pQc6jKlVktM3uIKyYk57kDysIhTqsir9A9dYyi8W34xw8I7ZfOhZq
         i2yKODnVbY5bErNDN9hEoPt4f5DbK8lM/GmA++avS14uI1OfCxMQckbx4y1OAUOOsdMw
         CGJw==
X-Gm-Message-State: APjAAAUiVjj9X5aWO/OAq9ihafyg1R5dlT8UYVqyURy8tHdQzbeMMAqv
        PWyh5S1FLhuRAPA1IvRCjBhAOugjCV8=
X-Google-Smtp-Source: APXvYqwuB3b1JbRgFtNOCcFHWud7XtM69Tk41Ids7cLqJ2nu2ueDsd8+G4Yxr9kWiKWsWBqE54WvQg==
X-Received: by 2002:aed:2307:: with SMTP id h7mr17582700qtc.87.1555970088440;
        Mon, 22 Apr 2019 14:54:48 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id f65sm6939392qkb.83.2019.04.22.14.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 14:54:48 -0700 (PDT)
Date:   Mon, 22 Apr 2019 14:54:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Tao Ren <taoren@fb.com>
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net] net/ncsi: handle overflow when incrementing mac
 address
Message-ID: <20190422145443.6391eaf8@cakuba.netronome.com>
In-Reply-To: <20190422172754.1011894-1-taoren@fb.com>
References: <20190422172754.1011894-1-taoren@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 10:27:54 -0700, Tao Ren wrote:
> Previously BMC's MAC address is calculated by simply adding 1 to the
> last byte of network controller's MAC address, and it produces incorrect
> result when network controller's MAC address ends with 0xFF.
> The problem is fixed by detecting integer overflow when incrementing MAC
> address and adding the carry bit (if any) to the next/left bytes of the
> MAC address.
> 

It'd be good to have a Fixes tag, if it's worth going to the net tree.

> Signed-off-by: Tao Ren <taoren@fb.com>
> ---
>  net/ncsi/ncsi-rsp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index dc07fcc7938e..eb42bbdb7501 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -658,7 +658,8 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
>  	const struct net_device_ops *ops = ndev->netdev_ops;
>  	struct ncsi_rsp_oem_pkt *rsp;
>  	struct sockaddr saddr;
> -	int ret = 0;
> +	int ret, offset;
> +	u16 carry = 1;
>  
>  	/* Get the response header */
>  	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
> @@ -667,7 +668,12 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
>  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
>  	/* Increase mac address by 1 for BMC's address */
> -	saddr.sa_data[ETH_ALEN - 1]++;
> +	offset = ETH_ALEN - 1;
> +	do {
> +		carry += (u8)saddr.sa_data[offset];
> +		saddr.sa_data[offset] = (char)carry;
> +		carry = carry >> 8;
> +	} while (carry != 0 && --offset >= 0);

We have eth_addr_dec(), perhaps it'd be good to add an eth_addr_inc()
equivalent?  (I'm not sure if it'd have to be in net-next, it's a tiny
function, and OK for net for my taste, but I had been wrong before).

If I'm allowed to be paranoid I'd also advise checking the resulting
MAC is a valid ethernet unicast addr.

>  	ret = ops->ndo_set_mac_address(ndev, &saddr);
>  	if (ret < 0)
>  		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");

