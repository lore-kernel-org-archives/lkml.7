Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF3DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC5E2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="oeleUBPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfLQXIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:08:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35632 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfLQXIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 18:08:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so12870174lja.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 15:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=aGiB+hbSb9LA36NPoJtb7z2ChL7/cE8oaRzpEVpg4xY=;
        b=oeleUBPdDbOz5yUEadMq26sIIXeXyzMJVh5AKg+rfxxa6qrVXWpmVAuQsBbyY5l6pa
         VfbTQWrC3v1a9rfIm5Quejgv9tFi/+ert3ZMEyKp005+tyOC0XAEVcAMriz9gYl8/nJP
         DaOhA18cLXy18h4fZHDT/9cAJEPUOae43La46AE/vaHD0sidTb9gMb9FfPHRjpk1r/mK
         +TcZSmbzWyVwfNtrer+doj6A4kpUT6ScA4S7rzGIiJSbj2f4f/DjCdgZek0+/CIziilJ
         i6GJISoJUff7mOjry42NaefmsL5lCtNb7Yb+OzjH+fDHlegO+3i9U/s4xtEm5AMug85+
         gIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aGiB+hbSb9LA36NPoJtb7z2ChL7/cE8oaRzpEVpg4xY=;
        b=BaI/QvcRhl77P5ydqpXhlWxvVFXgQs7cds9FmX/fi/NkJ3Aoe7aPFsQg2VO1gIod2M
         lsQCLD6WwIip7+VBYvgFfqYdfBorvp+79nGUXw+p/jgdyD0gz+erB/umj1PP11FYBF4V
         Mekaj89l/5J0M4OomXSvfku5l3hYhWI2NKrntRRq6mIQ5R/YHzp/dCBr6D9h9vKYlaGg
         oJnV29k77zKNyNpzuT5au6fpKZ37TjZiKvM2gWlgbDaBp8DM3LpCkF9ULgqkHEtvPl53
         MUYuatbxRCEY22ZJiyjqSgJ4nQhk8kp8roIoPtsArwD2SI9GURM6mUaMQ4Gxp4tjlonC
         z03A==
X-Gm-Message-State: APjAAAVzxvL4vQRNIwilcfKchtbV2XFObxr7XNAXAlfbJHCGOR7udmTg
        JEo6cxeRxKMNbfYCY6sxtu6n6g==
X-Google-Smtp-Source: APXvYqxukD7cTbWUkQTWB6DyDuO/pcX3ri7d1UFgmbDdVl/nzx1L/sDaryeDQItlZCm2Yo/AF3Rtbg==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr203585ljk.238.1576624129615;
        Tue, 17 Dec 2019 15:08:49 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r125sm74526lff.70.2019.12.17.15.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 15:08:49 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:08:41 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/8] net: bcmgenet: use CHECKSUM_COMPLETE for
 NETIF_F_RXCSUM
Message-ID: <20191217150841.563d6fb9@cakuba.netronome.com>
In-Reply-To: <1576616549-39097-4-git-send-email-opendmb@gmail.com>
References: <1576616549-39097-1-git-send-email-opendmb@gmail.com>
        <1576616549-39097-4-git-send-email-opendmb@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 13:02:24 -0800, Doug Berger wrote:
> @@ -1793,6 +1792,10 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  
>  			status = (struct status_64 *)skb->data;
>  			dma_length_status = status->length_status;
> +			if (priv->desc_rxchk_en) {
> +				skb->csum = ntohs(status->rx_csum & 0xffff);

This adds a new warning for a W=1 C=1 build:

../drivers/net/ethernet/broadcom/genet/bcmgenet.c:1796:45: warning: cast to res\
tricted __be16                                                                  
../drivers/net/ethernet/broadcom/genet/bcmgenet.c:1796:45: warning: cast to res\
tricted __be16                                                                  
../drivers/net/ethernet/broadcom/genet/bcmgenet.c:1796:45: warning: cast to res\
tricted __be16                                                                  
../drivers/net/ethernet/broadcom/genet/bcmgenet.c:1796:45: warning: cast to res\
tricted __be16                                                                  
../drivers/net/ethernet/broadcom/genet/bcmgenet.c:1796:43: warning: incorrect t\
ype in assignment (different base types)                                        
../drivers/net/ethernet/broadcom/genet/bcmgenet.c:1796:43:    expected restrict\
ed __wsum [usertype] csum                                                       
../drivers/net/ethernet/broadcom/genet/bcmgenet.c:1796:43:    got int           
   
Could you perhaps consider a __force cast or such?

> +				skb->ip_summed = CHECKSUM_COMPLETE;
> +			}
>  		}
>  
>  		/* DMA flags and length are still valid no matter how

