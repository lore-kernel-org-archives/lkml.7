Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077F0C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB5D21E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SUVFbX7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbfHGSZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:25:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43836 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbfHGSZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:25:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so2311520qkd.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=TDeetVQl8Zpt3dJx1+9iczrZhKUuc7lJYaOnvp76iac=;
        b=SUVFbX7RJz/ZgxpQ863QUGypJ9/huxAmIuBnzrsOJpv1SL1xbwfi9Zd2VozLJW3Uio
         uCwMRK7sZEQ3t6VoAgN84Iy0o8SDuH8q3txZl9MgYuz/4ZUqlLuhg1RKYveIk84n7q0n
         upRlQKf/hHgbdlulfQeAjgB3iLLzXCy6Y8tumKekScLiyUMkjJPaU458UX2KDt3PFkah
         Z1dR8Ar96BldSUPTGJfh6Gmt082ymwzyl1STQASMdeaTJItISeIa8mX6UJVeP+cWEz/t
         6X4G0KmLSGBta25tz/MEO5SNWBgonj57LHck7qr8q5cgTGSXc3sGmCwogUtijs2p/WQR
         zCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=TDeetVQl8Zpt3dJx1+9iczrZhKUuc7lJYaOnvp76iac=;
        b=AqE6m8+T4y2RGp8ZwDFezJVduWP8kB2mvHr51OSuGfMyChbHN6cpZk0EVByfSswyMv
         kboyELKR9lAMd4gDNemAH1iVRht+lDi6UUCM4mXXTqLXurfweXrRjZ3P6ikzZ+G8l3Fr
         Zafqbp4aPRcsKUQNLwnTDyVUungjIe98bVZA7SQSldp187s/rCXD9wOxHYYMVhK4ODsD
         NVJgAh/0Olp4NSOoS3pYUH7CwRr+iT0Ch0cEfnFRxIHALG1wYxPJTExfSfxReUwd1sIf
         oprAPxiHOlPkz/+NTSf0/cZ8blynPXqgdaac+HiDS8zfqYu86Bo3DcdLre6JaGkaKKZf
         6waQ==
X-Gm-Message-State: APjAAAXW2FCS1lc9Ayt8Zm585RsyUmX33EAZ6S3JKgpuNSjdNet3U26z
        a58LoVQTPuGtt256fhu7hs9inA==
X-Google-Smtp-Source: APXvYqwge9tEfeNHYTyIZEosm8L30NJ+ROpOAKEqB/tFI7o2HeICjm4+gULkNh8U/mTvR7vn4DGQjQ==
X-Received: by 2002:a37:8081:: with SMTP id b123mr9760497qkd.62.1565202346375;
        Wed, 07 Aug 2019 11:25:46 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m8sm34744362qkg.104.2019.08.07.11.25.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 11:25:46 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:25:18 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Tao Ren <taoren@fb.com>
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        William Kennington <wak@google.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next] net/ncsi: allow to customize BMC MAC Address
 offset
Message-ID: <20190807112518.644a21a2@cakuba.netronome.com>
In-Reply-To: <20190807002118.164360-1-taoren@fb.com>
References: <20190807002118.164360-1-taoren@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 17:21:18 -0700, Tao Ren wrote:
> Currently BMC's MAC address is calculated by adding 1 to NCSI NIC's base
> MAC address when CONFIG_NCSI_OEM_CMD_GET_MAC option is enabled. The logic
> doesn't work for platforms with different BMC MAC offset: for example,
> Facebook Yamp BMC's MAC address is calculated by adding 2 to NIC's base
> MAC address ("BaseMAC + 1" is reserved for Host use).
> 
> This patch adds NET_NCSI_MC_MAC_OFFSET config option to customize offset
> between NIC's Base MAC address and BMC's MAC address. Its default value is
> set to 1 to avoid breaking existing users.
> 
> Signed-off-by: Tao Ren <taoren@fb.com>

Maybe someone more knowledgeable like Andrew has an opinion here, 
but to me it seems a bit strange to encode what seems to be platfrom
information in the kernel config :(

> diff --git a/net/ncsi/Kconfig b/net/ncsi/Kconfig
> index 2f1e5756c03a..be8efe1ed99e 100644
> --- a/net/ncsi/Kconfig
> +++ b/net/ncsi/Kconfig
> @@ -17,3 +17,11 @@ config NCSI_OEM_CMD_GET_MAC
>  	---help---
>  	  This allows to get MAC address from NCSI firmware and set them back to
>  		controller.
> +config NET_NCSI_MC_MAC_OFFSET
> +	int
> +	prompt "Offset of Management Controller's MAC Address"
> +	depends on NCSI_OEM_CMD_GET_MAC
> +	default 1
> +	help
> +	  This defines the offset between Network Controller's (base) MAC
> +	  address and Management Controller's MAC address.
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index 7581bf919885..24a791f9ebf5 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -656,6 +656,11 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
>  	struct ncsi_rsp_oem_pkt *rsp;
>  	struct sockaddr saddr;
>  	int ret = 0;
> +#ifdef CONFIG_NET_NCSI_MC_MAC_OFFSET
> +	int mac_offset = CONFIG_NET_NCSI_MC_MAC_OFFSET;
> +#else
> +	int mac_offset = 1;
> +#endif
>  
>  	/* Get the response header */
>  	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
> @@ -663,8 +668,14 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
>  	saddr.sa_family = ndev->type;
>  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
> -	/* Increase mac address by 1 for BMC's address */
> -	eth_addr_inc((u8 *)saddr.sa_data);
> +
> +	/* Management Controller's MAC address is calculated by adding
> +	 * the offset to Network Controller's (base) MAC address.
> +	 * Note: negative offset is "ignored", and BMC will use the Base
> +	 * MAC address in this case.
> +	 */
> +	while (mac_offset-- > 0)
> +		eth_addr_inc((u8 *)saddr.sa_data);
>  	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
>  		return -ENXIO;
>  

