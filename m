Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF2C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F55D207FD
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="moI3aNp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfLNUKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:10:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33449 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 15:10:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id y206so3369478pfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 12:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=wuX1wX7F3A4+ViJ/F0TGocQYp+UHpk0d54KJOh0KWqY=;
        b=moI3aNp2gAT6fiipm7VKPiy+ExbuP/KxOwHz1IvtGmHQpyBlujqY4lGo6og4s01Gws
         COU2gYcZ6Jap8JvjadlrRSn8S/33mTnO9RURXanWwir+y0Tsuo4HoczUlYHUr/8Jm597
         AGPgZE52gf9NtvdT2YMBmDPipmfP1Pe6DwgwIB8O41VmdOvsyEC/ELaxLf10l9/xtCDl
         yOZ9c0QPLMm8Fx+e4XfJIn/SbHihOD6YoBI/D6OVtv93VWXeb+gHNKGuOO7Lhbi5IwiO
         Ir7xCXz2QuYtYIu8IPu2YpqubPJgvxIHPJeE9p2ae1QoTxoLSbSMxfjAvSpmNqJRe3gd
         oCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wuX1wX7F3A4+ViJ/F0TGocQYp+UHpk0d54KJOh0KWqY=;
        b=YIIKGgy8MZmuGc+luadeD534XkNrvrT6XY31FTOQf99x/zq/XvtU0tCvVqDeT5HXZ6
         hazkhupt6M+3JK/kul5tBZnS1AUEUMUgPVdycGikX4u1imbjuqX7My0vgSMRbhMIT6/a
         6xFv1tiS2A7GN190YsplTT6dPzb67Yg1AiY+dSM+y7IIvkSi1aCtCWfWRNcTxqZHhAPS
         Bll4JcWSQWxNaoda50QzTx352CELQ2ktPap2zpeOqtmFjTC8oIQYulvJsOhGB0QIn0Jm
         FF3OKvOZV859Gf3dMa+sePIXmEhEkO4/jMxQext5sJbvpOLbx3/0upJplPqlo3VbDiT5
         nn9Q==
X-Gm-Message-State: APjAAAUCAGxnaFZGzo7XophF6+WgiXNKM4FFQpRq1A8pXKINivmtn7R3
        goZlJxk1VNFyiVTXw601Mhp5LQ==
X-Google-Smtp-Source: APXvYqyZIZpkQnsmmMbQQozox77o8oKzuyqEEgz/qPk80xmbgKB8F2SyKW2zohfp580A6GNPcxBONw==
X-Received: by 2002:aa7:9205:: with SMTP id 5mr7043338pfo.213.1576354253427;
        Sat, 14 Dec 2019 12:10:53 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id y22sm16280523pfn.122.2019.12.14.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 12:10:53 -0800 (PST)
Date:   Sat, 14 Dec 2019 12:10:49 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: platform: Remove unnecessary conditions
Message-ID: <20191214121049.266b656f@cakuba.netronome.com>
In-Reply-To: <1576060284-12371-1-git-send-email-vulab@iscas.ac.cn>
References: <1576060284-12371-1-git-send-email-vulab@iscas.ac.cn>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 10:31:24 +0000, Xu Wang wrote:
> Remove conditions where if and else branch are identical.
> This issue is detected by coccinelle.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index bedaff0..1d26691 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -229,8 +229,6 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
>  		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WFQ;
>  	else if (of_property_read_bool(tx_node, "snps,tx-sched-dwrr"))
>  		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_DWRR;
> -	else if (of_property_read_bool(tx_node, "snps,tx-sched-sp"))
> -		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_SP;
>  	else
>  		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_SP;
>  

Thanks for the patch but in this case it looks like this code is
intentionally written this way to enumerate all options. Maintainers -
please speak up if you prefer to have the patch applied, otherwise 
I'm dropping it.
