Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40863C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074982077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564001185;
	bh=vhlqT6Lm1gxVRGH6eG7xdd4jdLEP79HRLf+8nRCqZoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1xglwbduv0b6xYEujPEcW1GMAt2HbmLenRAVxNqkxXFav3g6RvWrVebnbg5jpMq/L
	 8DVGoJ59cuLAFiFZlgszp4rhmVcOhu2P7uEI6smobe1oSdtwMWRRIBN9mZS6yPkFSG
	 I66fIq5DfBK0G55GOhUFcASlzrmRFyAEoywlZPbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfGXUqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:46:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44194 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfGXUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:46:23 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so92377884iob.11;
        Wed, 24 Jul 2019 13:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i/sPIhXsS6XIgPtbsRxAmrculmKk8MrSIf4t2TOmssc=;
        b=uRzCyI0eHXSVobS0LTK5gAihSqpebCvjN+GrL80qhI5/0Z+P5/r7PcoLxHyO3XPQ6O
         LFAf0Vc+C0ooSeXk67M+DMA44nPcxKcBmHDYHjNnP2lz9EiuCgpDTx5Bif8Ccoxo1ayJ
         4hi1W7QKmHrUivOcM2pz8wH9fsH+LOHfgLcYmJvBM5aTxwG6XxAQDs/o9UXq0WDbtIhB
         U06lxHcPv9U3uSoo5mm3ffx2rMisFMER+r7WyYahirTsReheYS3FVK8E7TSyWJlKwTSO
         pB2G1vcIevX/Z4gO3dn9nH6nGHjGyacqX6oJ24yU8arSQyDI83oFMfWNkjlUC7BUwDoq
         3f8Q==
X-Gm-Message-State: APjAAAX2V5Fjdbr8J6/+aY5VnhNpI1bn7/RN7itf6PuBXjFMCwyIahYD
        e+cTeWrfEhsX3sug0sTLRw==
X-Google-Smtp-Source: APXvYqw9E2+Xf5qC0L6WngTKBG5qk+vwpnwnE3u6JWu5EifnJzjQKu0ViuEr6sIw7lDkl19v0HzYpQ==
X-Received: by 2002:a02:b90e:: with SMTP id v14mr49286701jan.122.1564001182328;
        Wed, 24 Jul 2019 13:46:22 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id x13sm35133832ioj.18.2019.07.24.13.46.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:46:21 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:46:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org,
        Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v6 4/8] clk: mediatek: add mt6765 clock IDs
Message-ID: <20190724204621.GA13063@bogus>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
 <1562924653-10056-5-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562924653-10056-5-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 17:43:40 +0800, Macpaul Lin wrote:
> From: Mars Cheng <mars.cheng@mediatek.com>
> 
> Add MT6765 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, mcucfg and subsystem clocks.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  include/dt-bindings/clock/mt6765-clk.h | 313 +++++++++++++++++++++++++
>  1 file changed, 313 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt6765-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
