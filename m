Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB320C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FD0218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhGHCbNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGDNGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:06:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36752 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfGDNGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:06:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so6114108wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0G7rBJyorAv/Go9XW+5KlxgxsrwAo4Lw8h4E0AK/9g=;
        b=MhGHCbNxmBGEX9gNxaF9U5CCJT+qFuz/qiepbdulPX4tk3cpmHk4Nr1cvq+wO4v/6O
         +ybPFIWjxCRzO1VplawtIKym3JIWT6EL6KCC/kXweTg1xEDf6xWNuutL6xnTVP49ECPa
         2IkTuBaIC5U5cDvAdCksqgV+emWw2anAu4XaajfBHQH+ALVYgz1c6h+ms+nDnaWgQOva
         rqS7dM0i2zAeunc7L6TMtRFiWjbF3j2AT0T4kRNj/OsD5XYRsUZqdy268I4EZYTBHRYU
         uIRnNbFdGgRz8D3Ch5iqC9sB+WrvfT8Jn9Q1LiX+atRzygQnXvRv4EHdOsgMgxoxXFdA
         tX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0G7rBJyorAv/Go9XW+5KlxgxsrwAo4Lw8h4E0AK/9g=;
        b=MLwkvX3BYr/+D6as1aRWgc7rG5ZzbDuQWe8WVCOleHSlvl/bfQCl2mBjuFEWefDLfi
         s7D4dxndsEIUxy4CyeXzoF6DQ5Bbh9cVLGBdhkUriaen6Fq5kTo8/XCZHg+GqvXHUYuW
         gmqa/neysG+tV+YkUN722xcLO6ef2BY/Qa3wZ0CkrNpXJ8VpZMoGZsMXfAAyA0D5CNV9
         SS+y+Mp4YSnR62KNzccQKJmiIWWKF9Ndo4WAcz9y6OeonRkg6Q3smbr7+1feUj3pyb4E
         NKtGWc0746BlvW1DBlhbAXElbK4OQhN9tWBmODJde8sK9RkpG6cErho8ZgRrrOzgh4Ew
         wrew==
X-Gm-Message-State: APjAAAUw4ztYZAYK20ul0uxLS50gNEzLAhjd05r59UpkQOLHZVkfHcx/
        RHvt+VgIdG6kDRgzifo18P/LPA==
X-Google-Smtp-Source: APXvYqwpVkbCltdiX25gOjc+VVQOWtlzTko4TXdJA9hHxN3MnWxEKL9t/rTxGIvJpQMJWxILKQIjYA==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr11648016wmc.22.1562245599046;
        Thu, 04 Jul 2019 06:06:39 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id p4sm4889734wrs.35.2019.07.04.06.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 06:06:38 -0700 (PDT)
Date:   Thu, 4 Jul 2019 16:06:35 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Introducing support for Page
 Pool
Message-ID: <20190704130635.GA10412@apalos>
References: <cover.1562149883.git.joabreu@synopsys.com>
 <1b254bb7fc6044c5e6e2fdd9e00088d1d13a808b.1562149883.git.joabreu@synopsys.com>
 <20190704120018.4523a119@carbon>
 <BN8PR12MB3266BC5322AADFAC49D9BAFAD3FA0@BN8PR12MB3266.namprd12.prod.outlook.com>
 <20190704135414.0dd5df76@carbon>
 <20190704120441.GA6866@apalos>
 <BYAPR12MB3269D4FAAC5307A224D60A08D3FA0@BYAPR12MB3269.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3269D4FAAC5307A224D60A08D3FA0@BYAPR12MB3269.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose, 

> Thank you all for your review comments !
> 
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> > That's why i was concerned on what will happen on > 1000b frames and what the
> > memory pressure is going to be. 
> > The trade off here is copying vs mapping/unmapping.
> 
> Well, the performance numbers I mentioned are for TSO with default MTU 
> (1500) and using iperf3 with zero-copy. Here follows netperf:
> 

Ok i guess this should be fine. Here's why.
You'll allocate an extra memory from page pool API which equals
the number of descriptors * 1 page.
You also allocate SKB's to copy the data and recycle the page pool buffers.
So page_pool won't add any significant memory pressure since we expect *all*
it's buffers to be recycled. 
The SKBs are allocated anyway in the current driver so bottom line you trade off
some memory (the page_pool buffers) + a memcpy per packet and skip the dma
map/unmap which is the bottleneck in your hardware. 
I think it's fine

Cheers
/Ilias
