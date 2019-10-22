Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3459CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDBA21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="hTrtaAgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbfJVUIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:08:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32893 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387487AbfJVUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:08:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so18557918ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Jepvi8++4KHG9zardrX3M8QtVwArs/duyX7iXwqTssk=;
        b=hTrtaAgEvhNL0YSN4U/x7Ca1+Q6F/DEsj55rl49kx51S9+p2NR+6PM81lRfoDLK9lf
         837MSmEeURh7Y/sXwPp0y3bYNslB1HEp3ToeLTT/chG/obKoJSZ2HtUZ/95uMt8rfPlO
         g5nHV5XCj1IWeIaftr1vFN4QXb3uFltJs783fwOHs0A0QJVcWT41VJeZoThHcK7t2iJT
         f9dWzOIX6OwZbaeBacSubKeCVZyS7/HHK0k9xK87b027TFPMjLffxioec+lQTYQE/8PV
         qWcFyjAUZk4OiY1Dq2jGS60GfL0ll2hI/SOnQ+u9g7uJDfvuPFk7hvNwJDAWTBjFvi5/
         XHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Jepvi8++4KHG9zardrX3M8QtVwArs/duyX7iXwqTssk=;
        b=dT3SjLSkPEEYX20mhd7PBRXPcyxCKlaGZQdLmTPAimmoMm32PRi5fav9OQCiUPGSQ+
         Ns2Wd67MawxXUOQ81NULBqAzo5aqzucA/+FkO61Ro6NvDekBNu49PMzrMKQlh/JCoxpa
         ud0dIZPlVHD3tKQPnfwCh9Q7fCUExQKPGDZnvfS6rxawKuQeS+T3vHRXzzK8rB1iH3x1
         TR0OYU1unQQ40Muln9SHu95k6PhyXO7cJ+iOf+t0iXWzUWCbxffuAvWXc5PpMhD3uREx
         ULn9+CMEJGJ70zHyUQ0A5PNlT5gN8NlS6l2KNT9f+yiGRN36hXbiHFe5nWQjaSPfOPhL
         J6rw==
X-Gm-Message-State: APjAAAVT2FRT9BL6jfR3aoYHtNB6Lwu+h0+7LdgzdPL5DeWL76rYDQgm
        Y15QVnvXsByzq9Pjjj5KPyLIlQ==
X-Google-Smtp-Source: APXvYqzHW17dZfehUbHroL+khGtd2o684rg84WG/ysl2SL0ML5ulZOe6aNdkECAkJAUfz3BKic2dBA==
X-Received: by 2002:a2e:9a99:: with SMTP id p25mr19086167lji.171.1571774881729;
        Tue, 22 Oct 2019 13:08:01 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q16sm7027794lfo.7.2019.10.22.13.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:08:01 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:07:53 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, yuqi jin <jinyuqi@huawei.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2] net: stmmac: Fix the problem of tso_xmit
Message-ID: <20191022130753.70c12b55@cakuba.netronome.com>
In-Reply-To: <1571628454-29550-1-git-send-email-zhangshaokun@hisilicon.com>
References: <0b6b3394-f9f0-2804-0665-fe914ad2cdea@gmail.com>
        <1571628454-29550-1-git-send-email-zhangshaokun@hisilicon.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 11:27:34 +0800, Shaokun Zhang wrote:
> From: yuqi jin <jinyuqi@huawei.com>
> 
> When the address width of DMA is greater than 32, the packet header occupies
> a BD descriptor. The starting address of the data should be added to the
> header length.
> 
> Fixes: a993db88d17d ("net: stmmac: Enable support for > 32 Bits addressing in XGMAC")
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Jose Abreu <joabreu@synopsys.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: yuqi jin <jinyuqi@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
> Changes in v2: 
>     -- Address Eric's comment: add the Fixes tag

Applied and queued for 5.3, thanks!
