Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EC1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 04:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9980420B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 04:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1fb8tsw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfHFEev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 00:34:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47015 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfHFEev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 00:34:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so17636556pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 21:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=37e73pgeUst/e32No0I5VlF96GbX2bnFea6wHE9lo0U=;
        b=1fb8tsw+IDfyYebA8NHR9PDMJAuQesOzz/4+8c6F3puynzPajSonryQyPh0Kuobou9
         vyzPLWjKg2Fx4Z/XCdhQBxhV15xnBVPYb5qyzq3gF4MyDhFnA8n4OIB/E1FPhX841kIl
         ZZRI4i5Yr7S2qvgCkRnCrH+lNfb/9gZOK2yiFoFwhuakHZs3bcsjDdamB7yiOqXLD2l1
         ITwCcZ31Ka5Fyw1tDzbF7JZkncEq4tjxcR9LPjGPdKpouDu0By6wTdr7c64bk8a23cV/
         C/IGopUF0QO5fDkgNxiaS7O1q7YW+qU8yiDbLTEY5N5c805gudzKLpmeZV1jWfH5OmEx
         ni/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=37e73pgeUst/e32No0I5VlF96GbX2bnFea6wHE9lo0U=;
        b=HBphC5zpSxh6HuxOFpox/TH/kA0NhHjmxRFEG3CQHK1muBEFsCNWtumj99yW5KEY0D
         AsXvZUE7OSxOuk+su8XLq3/6Wk/Qgb7wPDHzkW5ZktnDV5gWMFsdQK2VqyPogD/xJnfg
         Bclj4fPkNOr2Shc0sloYCSdygW8M7da+I7VQKowabd2Ub1RamAHYoffiB9JXN7IkGRQE
         /XRQHHf1cJanCUl2JS+Fm6j3l4rh9T0yHPxh+YX4030EFvkcd/LuicpFhMi9gzX5YZev
         CBdvt1AvGMoivKr4nD9kr4PWqPI9znbl1ku80vgoi9nXpfSiQafJakgnBakNxEqPAxra
         xFlg==
X-Gm-Message-State: APjAAAUno24+F7bgWT9BmgOxqRl4FreT2LCTgXq9lai1aLumaeRv7e4g
        wO8gda4tae7z2kAbyfKKdTiVZQ==
X-Google-Smtp-Source: APXvYqxSbFtO3Q8AmtiweeWMVTX404S5ZZBWpaWkpDDNXsVITjS2rpZBN1xFskUAblQd3Ye+zshvsQ==
X-Received: by 2002:aa7:9513:: with SMTP id b19mr1660078pfp.30.1565066090291;
        Mon, 05 Aug 2019 21:34:50 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id 10sm104956416pfb.30.2019.08.05.21.34.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 21:34:49 -0700 (PDT)
Date:   Mon, 5 Aug 2019 21:34:25 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] net: stmmac: Fix issues when number of
 Queues >= 4
Message-ID: <20190805213425.3fce1d42@cakuba.netronome.com>
In-Reply-To: <5e95bb1761f9438361f198d744640685a34790ea.1565027782.git.joabreu@synopsys.com>
References: <cover.1565027782.git.joabreu@synopsys.com>
        <5e95bb1761f9438361f198d744640685a34790ea.1565027782.git.joabreu@synopsys.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Aug 2019 20:01:16 +0200, Jose Abreu wrote:
> When queues >= 4 we use different registers but we were not subtracting
> the offset of 4. Fix this.
> 
> Found out by Coverity.
> 
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>

Should this be a bug fix for the net tree?
