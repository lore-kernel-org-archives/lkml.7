Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB487ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5C02086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="iei9S1oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbfJJCn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:43:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40227 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732447AbfJJCnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:43:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so2896888pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 19:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=QWteHAhBVt9oVGOsOtKHsCiYKtX8kIzt6852sk1FamE=;
        b=iei9S1oj45k0ZQgMqH7H0heioINFqEVoK5QQNnLJC6ig340LF/7lvfzuHdeKQlFK9x
         6Hkzh1+TJ0ShL8YMEXjqTIzqQykuK+7tNtk94vJ4PDCbixkpd/CwsT+tJo73VoTzALs/
         3YWHZQoNIZeLzmRb9W51aeEcULryqpcGxo8kCATCoMkcLHktP/FKv3Ju9PHc7WdcrGqO
         qhS24uqCCsyYuoV3mYvlcqYnea4e3PZbAMiwtrKuLXasFUvy0aiVsLwKeg0yUmpUQano
         OxYzAZwBbkwSmqpihYxzEX7I6XbxUNWZtxCAn7mGV3WyXxBTngz3tgAri5pGzUmpS68u
         GvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QWteHAhBVt9oVGOsOtKHsCiYKtX8kIzt6852sk1FamE=;
        b=WANW40sd3R4yBZzgy5yxc+htll/pQOPUzGvly57Pyd8ueECxjiy0O5cmbeQVvo12Mg
         2yRZJgAOIsvO1J4avNSqVWKfQpEyoJdfZyRz533Y8aEnW47/F6Ri6XsP4h8vHQuqEYhq
         20Cj5U+5ADLccLRSebNpfdYPkdpVAXcd0otl3W2jFxdVdY3mtlKvuLXTVH6v2vRoNVsS
         03itxRfeCe80T+ArTDNE12V995LvzACVdh91hmC8BGFpBfoMA421cNbT6wU57StW58Mj
         t+O31GcDQpJeoqohU1HIa6pedObibI3xrxjXeeeQxYfq7ltMfqk7MkkSsFq1fmusYpTi
         sTeA==
X-Gm-Message-State: APjAAAUW79Ef7jTQaF2F+NhFIqeHZd2K902qULwse91GDmpddrwtfZrm
        aqLV7h3LMTLLSSSzlgpm/85DXw==
X-Google-Smtp-Source: APXvYqwanEd1qtiJMg/JVqFKEiqK+wQJaWOvm1tyP8JvAOqtrzd2OgCokg0CQcOtJoVJeVXoP6I4vw==
X-Received: by 2002:aa7:9e8d:: with SMTP id p13mr7146028pfq.171.1570675405027;
        Wed, 09 Oct 2019 19:43:25 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id a16sm4961578pfa.53.2019.10.09.19.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 19:43:24 -0700 (PDT)
Date:   Wed, 9 Oct 2019 19:43:11 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     <davem@davemloft.net>, Jose Abreu <joabreu@synopsys.com>,
        <andrew@lunn.ch>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <jianguo.zhang@mediatek.com>, <boon.leong.ong@intel.com>
Subject: Re: [RESEND,PATCH] net: stmmac: dwmac-mediatek: fix wrong delay
 value issue when resume back
Message-ID: <20191009194311.55c8cf6e@cakuba.netronome.com>
In-Reply-To: <20191009073348.5503-1-biao.huang@mediatek.com>
References: <20191009073348.5503-1-biao.huang@mediatek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 15:33:48 +0800, Biao Huang wrote:
> mac_delay value will be divided by 550/170 in mt2712_delay_ps2stage(),
> which is invoked at the beginning of mt2712_set_delay(), and the value
> should be restored at the end of mt2712_set_delay().
> Or, mac_delay will be divided again when invoking mt2712_set_delay()
> when resume back.
> So, add mt2712_delay_stage2ps() to mt2712_set_delay() to recovery the
> original mac_delay value.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

Applied, thanks.
