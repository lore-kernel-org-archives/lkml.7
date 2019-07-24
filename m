Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17113C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8612083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ijet24iF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfGXIyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:54:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40699 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfGXIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:54:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so40862573wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AxqsUQ9ydrbktURKrd3ST6ajH38XaMBsfLuUUxN1ep8=;
        b=Ijet24iFgEAcUFy4oNncn1QCmXqFqnMwKUvJmypA9g9ZUOTrpsLOw5etR1uVg7ATTp
         YAn2QdqOdk2Kva+Ac9H9mVP2TawOeadELXg1L+AtWlZQolQbvvLD7AgT4OdZ3YNUSDsI
         jFGOygNEhoA2cFVA+GlXwksPVGI8AuuJ7HjKsxBAlYRVJLSpUgIuNw2yUeIoqglwjsmA
         ZwFk9wWF7qaq2kRvZ8PmI5EsggSOEdTrvlqB9FtAOC1WGr25mgL0HSEk+8yKIdZOG41q
         G/BmZD06mgeO3Ar8E9X99SyEaURO2d1z2bUGuVsopZIGN1Vor0+HIUC2KKGPIIvdmsV1
         Fk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AxqsUQ9ydrbktURKrd3ST6ajH38XaMBsfLuUUxN1ep8=;
        b=PyvTQ1fOeSXM+swCHtG9ploaZ0X+bEIhgb7hB5eMoXnPE24eKZdDYXLWCybfGZeqUI
         tVT08OgyhBh2Z4pWlxken37GanQcknCz9M5Mdri94P7/y8YqderlbpFNCi2j94mk3Mug
         TPayZbpb1LUBeDOjC5hGyZQeMY2lAkTDmsyA6wPzKnTOgTrLljj9TWXeGRs2CYq0wzII
         Q2yitq3Qk3S+iLmDAgVvrIyAZUiHsEwgPG4+TkNEdgqyVy70GX+LGfgy4P8v6WQOQvq9
         7gTVvYS/QRY19POmEltfLf5belfvY5c3GK/AD6XHdgVd9ShzLzW3GysvBcZ0NrcebOBJ
         GeAw==
X-Gm-Message-State: APjAAAXY5wdOf69sklmOuKh3Qtyh5WF5a33N+xsXiqYmmMdUU+yOXJl3
        W0LuwK/xKLPgBb4cnoSS9eqoiA==
X-Google-Smtp-Source: APXvYqwKIfUp/OjDiKIW3yUhz1A3lTcNVQMvMoMH8vowJ8g0DRAQsyJ5Lf4T9NdyDaRbrUzSg97b6Q==
X-Received: by 2002:a1c:6454:: with SMTP id y81mr48189531wmb.105.1563958471195;
        Wed, 24 Jul 2019 01:54:31 -0700 (PDT)
Received: from apalos (athedsl-373703.home.otenet.gr. [79.131.11.197])
        by smtp.gmail.com with ESMTPSA id x16sm33903820wmj.4.2019.07.24.01.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 01:54:30 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:54:27 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     David Miller <davem@davemloft.net>
Cc:     jonathanh@nvidia.com, robin.murphy@arm.com,
        Jose.Abreu@synopsys.com, lists@bofh.nu, Joao.Pinto@synopsys.com,
        alexandre.torgue@st.com, maxime.ripard@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, wens@csie.org,
        mcoquelin.stm32@gmail.com, linux-tegra@vger.kernel.org,
        peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 3/3] net: stmmac: Introducing support for Page
 Pool
Message-ID: <20190724085427.GA10736@apalos>
References: <BYAPR12MB32692AF2BA127C5DA5B74804D3C70@BYAPR12MB3269.namprd12.prod.outlook.com>
 <6c769226-bdd9-6fe0-b96b-5a0d800fed24@arm.com>
 <8756d681-e167-fe4a-c6f0-47ae2dcbb100@nvidia.com>
 <20190723.115112.1824255524103179323.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723.115112.1824255524103179323.davem@davemloft.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, 

> From: Jon Hunter <jonathanh@nvidia.com>
> Date: Tue, 23 Jul 2019 13:09:00 +0100
> 
> > Setting "iommu.passthrough=1" works for me. However, I am not sure where
> > to go from here, so any ideas you have would be great.
> 
> Then definitely we are accessing outside of a valid IOMMU mapping due
> to the page pool support changes.

Yes. On the netsec driver i did test with and without SMMU to make sure i am not
breaking anything.
Since we map the whole page on the API i think some offset on the driver causes
that. In any case i'll have another look on page_pool to make sure we are not
missing anything. 

> 
> Such a problem should be spotted with swiommu enabled with debugging.

Thanks
/Ilias
