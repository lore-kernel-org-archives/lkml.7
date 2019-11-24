Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228A0C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FFE2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="pfLTvoq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKXXD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:03:59 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:44261 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfKXXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:03:59 -0500
Received: by mail-pj1-f68.google.com with SMTP id w8so5542902pjh.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 15:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=i1qHwy+G9a0VSULNRaoms0tDekf8iU/51Ya/Xfrai40=;
        b=pfLTvoq6UuaicbxCNV7Fjs+l8+Gyt2W+YkaRQIm3yX8ESfgyWToe9ebcfObxRas8jp
         NhIYT1Mj52QiopTTftiyHo3iaeIEkST10vx4fV53IsisneDl8Yye6C2cChYpf+p/8Spt
         M1ukwMsODKTHcdh6Qd5jZnaop4Hp2kvTB+XWdJxdBwUimM66alr9aJ4n397ciEvjThKY
         roLEvdBQhUnIevVbfcboUXwuqIXU1ylt6p7tAVydBm0LuUSmw55aut/WC5ceDED4F5nf
         1OPXsmWUT/89mveM3Idz+o7AuCN/FCGpFESBFFnStjZwFqrgQBelB2aLOVPmgjPmmHBl
         JzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=i1qHwy+G9a0VSULNRaoms0tDekf8iU/51Ya/Xfrai40=;
        b=ThJCRGFrFHXPp79Y827mDZOsCe/D8D+u//yey6nVJT+0v7xMueBWPhXPsnLGmcCHkj
         FgKNpaRUGI69ZAcw2ktQUXXX8P/SNNxbVibBkTWjudzGa1LTuZZEFznRmmAshvojo6pA
         OcpoOly0Na6fRlBD81+IDh7iccGZ/YJWAI06dxI/MwG8M9zErcmjSW2ySsY73MubfHhN
         kJ/Npp1y2BPsvgBvHzEe4GpNfBb2if2oA39mmgPwHbEP42FtDlQ/JK0gHaNuBB1kMCQt
         UahQ61HiHG2W9A7MWOrh/6My/w7TFOZvgkz4jI7VyWzxCvTzefAjzxl4+Y6V+g7p5Ktc
         N/yg==
X-Gm-Message-State: APjAAAXmQUTmdcUQcB2SkJq+KL6qCbcfAmFVSoefQdX+qTMFmcHxhxZx
        giILMfUpCSbfxABAD9ump7GP7w==
X-Google-Smtp-Source: APXvYqxoORlmu7NvER9bWBQjpyIr5840UQFPogBmNb1dxXAhZ9CFlH832yGT792uTtGLND5sd3A32Q==
X-Received: by 2002:a17:90a:970a:: with SMTP id x10mr22772544pjo.39.1574636638757;
        Sun, 24 Nov 2019 15:03:58 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id w19sm5543817pga.83.2019.11.24.15.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 15:03:58 -0800 (PST)
Date:   Sun, 24 Nov 2019 15:03:52 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Julio Faracco <jcfaracco@gmail.com>, netdev@vger.kernel.org,
        Daiane Mendes <dnmendes76@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] drivers: net: virtio_net: Implement a
 dev_watchdog handler
Message-ID: <20191124150352.5cab3209@cakuba.netronome.com>
In-Reply-To: <20191124164411-mutt-send-email-mst@kernel.org>
References: <20191122013636.1041-1-jcfaracco@gmail.com>
        <20191122052506-mutt-send-email-mst@kernel.org>
        <CAENf94KX1XR4_KXz9KLZQ09Ngeaq2qzYY5OE68xJMXMu13SuEg@mail.gmail.com>
        <20191124100157-mutt-send-email-mst@kernel.org>
        <20191124164411-mutt-send-email-mst@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 16:48:35 -0500, Michael S. Tsirkin wrote:
> diff --git a/arch/m68k/emu/nfeth.c b/arch/m68k/emu/nfeth.c
> index a4ebd2445eda..8e06e7407854 100644
> --- a/arch/m68k/emu/nfeth.c
> +++ b/arch/m68k/emu/nfeth.c
> @@ -167,7 +167,7 @@ static int nfeth_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return 0;
>  }
>  
> -static void nfeth_tx_timeout(struct net_device *dev)
> +static void nfeth_tx_timeout(struct net_device *dev, int txqueue)

Given the recent vf ndo problems, I wonder if it's worth making the
queue id unsigned from the start? Since it's coming from the stack
there should be no range checking required, but also signed doesn't
help anything so why not?

>  {
>  	dev->stats.tx_errors++;
>  	netif_wake_queue(dev);

